Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95144CEC3C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 17:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiCFQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 11:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiCFQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 11:32:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873A61CB0E;
        Sun,  6 Mar 2022 08:31:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19A2BB80EB6;
        Sun,  6 Mar 2022 16:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05079C340EC;
        Sun,  6 Mar 2022 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646584269;
        bh=mAjG7+BiIqoRd5IOoAhab8ycnY4sTbYJ/QdO4tj4SjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WmV8h7JgeyJG8ZGSc8iKGqEaUtEI3Q0JalKZI+CUbjht76gXmgZJMktdkjs15wetl
         wEMC69veZDMnQp4t1lzDWXm/Ai0QAhIxBOaD/BdzAFALkh59VEkVVXTkex0O95bw1V
         rLuCowg8Rc6Xu+2ElH6/sn/KaIbX3RcnGKjKiW5gcFH5w4it4MOricd7h+yiq+2Ax8
         TdfhIzs/8x1gik5pc4W1hmMasnm13nxBb6hGeigkmv0PmLywC8F0u1cEHUIgVgLwGG
         cPW/fVpoPMwiHS0OquvhXj9i9UxFWd+A05o2AZjGTmEzGLFuI0kyXGvAN2ssT9QQRu
         2iOSFmvSPeYsA==
Date:   Sun, 6 Mar 2022 18:30:28 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86: Add SGX_IOC_ENCLAVE_AUGMENT_PAGES
Message-ID: <YiThpJ9Jvu0brr4f@iki.fi>
References: <20220304122852.563475-1-jarkko@kernel.org>
 <13e0c364328ed822c5d358416bb13aa5faea3195.camel@kernel.org>
 <op.1il7jxj8wjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1il7jxj8wjvjmi@hhuan26-mobl1.mshome.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 09:20:11AM -0600, Haitao Huang wrote:
> On Fri, 04 Mar 2022 07:50:43 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > On Fri, 2022-03-04 at 14:28 +0200, Jarkko Sakkinen wrote:
> > > With SGX1 an enclave needs to be created with its maximum memory demands
> > > allocated. Pages cannot be added to an enclave after it is initialized.
> > > SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
> > > pages
> > > to an initialized enclave. With SGX2 the enclave still needs to set
> > > aside
> > > address space for its maximum memory demands during enclave
> > > creation, but
> > > all pages need not be added before enclave initialization. Pages can be
> > > added during enclave runtime.
> > > 
> > > Add support for dynamically adding pages to an initialized enclave with
> > > SGX_IOC_ENCLAVE_AUGMENT_PAGES, which performs EAUG's to a given range of
> > > pages. Do not enforce any particular permissions from kernel, like
> > > is done
> > > for the pages added during the pre-initialization phase, as enclave
> > > controls the final permissions and content for these pages by issuing
> > > either ENCLU[EACCEPT] (empty RW) or ENCLU[EACCEPTCOPY] (arbitrary
> > > data and
> > > permissions).
> > > 
> > > Explicit EAUG ioctl is a better choice than an implicit EAUG from a page
> > > fault handler because it allows to have O(1) number of
> > > kernel-enclave round
> > > trips for EAUG-EACCEPT{COPY} process, instead of O(n), as it is in
> > > the case
> > > when a page fault handler EAUG single page at a time.
> > > 
> > > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > > Cc: Nathaniel McCallum <nathaniel@profian.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > Is contained in sgx2-v2.1 branch of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git
> > 
> > I created sgx2-v2.2 branch, which has #PF EAUG removed. I
> > also moved selftests to the tail in the patch sets so that
> > it is easier to update them reflecting these and future
> > changes. Having them intervened makes things just complicated.
> > 
> > I focus now to implement mmap() for Enarx with this, so no
> > kselftest update just yet.
> > 
> > Roughly the sequence in Enarx is:
> > 
> > 1. Enclave traps on syscall (opcode).
> > 2. Host jumps to shim expection handler.
> > 3. Enclave copies the mmap() arguments to a buffer outside
> >    the enclave.
> > 4. Enclave exists back to the host.
> > 5. Host performs EAUG to the mmap range.
> > 6. Host performs mmap() to the mmap range, which succeeds
> >    given that vm_max_prot_bits is RWX (i.e. disabled for
> >    dynamic pages).
> > 7. Host jumps back to the enclave and execution continues
> >    there in the mmap handler.
> > 8. mmap handler does a series of EACCEPTCOPY operations for
> >    the range with given permissions and empty page as the
> >    input data.
> > 
> EACCEPTCOPY will require target pages with RW in PTE. So you would need to
> make mprotect to change PTE permissions afterwards depending on your target
> permissions.

EACCEPTCOPY afaik does depend on EPCM permissions, not PTE permissions.

> Without knowing much your context, if your intent is to
> EACCEPTCOPY(EPCM.RX/EPCM.R, EPCM.pending), then I don't see how the page can
> be used later without making it RW again first, and copy real data into it.
> So these empty EACCEPTCOPYs may be better just EACCEPTs(EPCM.RW,
> EPCM.pending). Then after copy real data into the pages, you do
> EMODPE/EMODPR as needed.

I take this point other than we could potentially use EACCEPTCOPY to
implement semantics for e.g. a mapped file. But yes sometimes you will
need take W out bit EMODPR, you're right.

The key problem in the SGX2 patch set is not EPCM side but PTE side.
In order to effectively adjust PTE permissions, vm_max_prot_bits
should be RWX. They make sense only for the static signed content
at most.

If that is changed in the current patch set, then it should be fairly
easy to tune both PTE and EPCM permissions based on situation.

BR, Jarkko
