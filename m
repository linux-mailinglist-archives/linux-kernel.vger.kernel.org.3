Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCAE4CEC38
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 17:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiCFQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 11:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiCFQTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 11:19:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA827143;
        Sun,  6 Mar 2022 08:18:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F6DB60EA9;
        Sun,  6 Mar 2022 16:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA61C340EC;
        Sun,  6 Mar 2022 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646583534;
        bh=kOCpLPMeKx6btbtkAxuflj8Zx9UJum6VwZbdJ7WeSlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+6JgA927oSdPWroQOKsnWLFD0U2LTzEcpwRMQ0rBtcDZ9mhKmWrJs8IVM4JskX3D
         X4/F7sTWM8KMhKo0oH7iFmEGK6Gin2hdPRrJgMo5rzxvtvVjAn8w0CgjfOr9sDjQ52
         KW6eJDolkYz1P217nTUYyvqQWtxBzip6oVr7rdlEfpZEoIO1JkAw77Mb4qPvt9I4kv
         rYNvlJwvWO+9h7l1+9wXHHuh9lH0XcJvc3dlBqUKLNzIpqqD7KoZ3ciQlYdMjm1jPi
         CrUH/r07kJWOvPrPKDKDi01zApjwURgRscmgQRXzs/WxaKdd5Z0uNIBX7e5uaKhyu5
         CVZ4w3zvp1tww==
Date:   Sun, 6 Mar 2022 18:18:13 +0200
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
Message-ID: <YiTexZ9ob7Xtd8LG@iki.fi>
References: <20220304122852.563475-1-jarkko@kernel.org>
 <op.1iilcwhywjvjmi@hhuan26-mobl1.mshome.net>
 <YiK8NEnvgPerEdFB@iki.fi>
 <op.1il2uqzhwjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1il2uqzhwjvjmi@hhuan26-mobl1.mshome.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 07:38:40AM -0600, Haitao Huang wrote:
> On Fri, 04 Mar 2022 19:26:12 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > On Fri, Mar 04, 2022 at 10:27:58AM -0600, Haitao Huang wrote:
> > > On Fri, 04 Mar 2022 06:28:52 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> > > wrote:
> > > 
> > > > With SGX1 an enclave needs to be created with its maximum memory
> > > demands
> > > > allocated. Pages cannot be added to an enclave after it is
> > > initialized.
> > > > SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
> > > > pages
> > > > to an initialized enclave. With SGX2 the enclave still needs to
> > > set aside
> > > > address space for its maximum memory demands during enclave
> > > creation, but
> > > > all pages need not be added before enclave initialization. Pages
> > > can be
> > > > added during enclave runtime.
> > > >
> > > > Add support for dynamically adding pages to an initialized enclave
> > > with
> > > > SGX_IOC_ENCLAVE_AUGMENT_PAGES, which performs EAUG's to a given
> > > range of
> > > > pages. Do not enforce any particular permissions from kernel, like is
> > > > done
> > > > for the pages added during the pre-initialization phase, as enclave
> > > > controls the final permissions and content for these pages by issuing
> > > > either ENCLU[EACCEPT] (empty RW) or ENCLU[EACCEPTCOPY] (arbitrary data
> > > > and
> > > > permissions).
> > > >
> > > > Explicit EAUG ioctl is a better choice than an implicit EAUG from
> > > a page
> > > > fault handler because it allows to have O(1) number of kernel-enclave
> > > > round
> > > > trips for EAUG-EACCEPT{COPY} process, instead of O(n), as it is in the
> > > > case
> > > > when a page fault handler EAUG single page at a time.
> > > >
> > > > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > > > Cc: Nathaniel McCallum <nathaniel@profian.com>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > > Is contained in sgx2-v2.1 branch of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git
> > > > ---
> > > >  arch/x86/include/uapi/asm/sgx.h |  14 +++
> > > >  arch/x86/kernel/cpu/sgx/ioctl.c | 159
> > > ++++++++++++++++++++++++++++++++
> > > >  2 files changed, 173 insertions(+)
> > > >
> > > > diff --git a/arch/x86/include/uapi/asm/sgx.h
> > > > b/arch/x86/include/uapi/asm/sgx.h
> > > > index c4e0326d281d..2b3a606e78fe 100644
> > > > --- a/arch/x86/include/uapi/asm/sgx.h
> > > > +++ b/arch/x86/include/uapi/asm/sgx.h
> > > > @@ -35,6 +35,8 @@ enum sgx_page_flags {
> > > >  	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modt)
> > > >  #define SGX_IOC_ENCLAVE_REMOVE_PAGES \
> > > >  	_IOWR(SGX_MAGIC, 0x08, struct sgx_enclave_remove_pages)
> > > > +#define SGX_IOC_ENCLAVE_AUGMENT_PAGES \
> > > > +	_IOWR(SGX_MAGIC, 0x09, struct sgx_enclave_augment_pages)
> > > > /**
> > > >   * struct sgx_enclave_create - parameter structure for the
> > > > @@ -138,6 +140,18 @@ struct sgx_enclave_remove_pages {
> > > >  	__u64 count;
> > > >  };
> > > > +/**
> > > > + * struct sgx_enclave_augment_pages - parameter structure for the
> > > > %SGX_IOC_ENCLAVE_ADD_PAGE ioctl
> > > > + * @offset:	starting page offset
> > > > + * @length:	length of the data (multiple of the page size)
> > > > + * @count:	number of bytes added (multiple of the page size)
> > > > + */
> > > > +struct sgx_enclave_augment_pages {
> > > > +	__u64 offset;
> > > > +	__u64 length;
> > > > +	__u64 count;
> > > > +};
> > > > +
> > > 
> > > As I stated in another thread, we need a mechanism to allow EAUG page
> > > lazily, e.g., on #PF. Can we add a field here to indicate that?
> > 
> > ioctl *does not* prevent lazy behaviour where, or if, it makes sense.
> > 
> > For growing memory (e.g. MAP_GROWSDOWN) you should just take advantage of
> > the vDSO's exception handling mechanism and call the ioctl on demand.
> > 
> > For a high-performance user space you still want to be also do minimum
> > round trip "batch jobs" where they are possible.
> > 
> 
> Looks like you are pursuing MAP_POPULATE to optimize out the O(N) trips.
> Just for my understanding of your proposal in case this ever comes back. For
> the on-demand case,  this ioctl is required for for each #PF. That's extra
> round trip compared to automatic kernel EAUG on #PF.

Point taken.

I think we could have both. It would then work quite a lot like for
normal memory.

BR, Jarkko
