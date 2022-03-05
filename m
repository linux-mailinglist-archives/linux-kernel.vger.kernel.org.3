Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E224CE231
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 03:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiCECTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 21:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCECTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 21:19:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F56C1F7;
        Fri,  4 Mar 2022 18:18:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC79F61F31;
        Sat,  5 Mar 2022 02:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D35C340E9;
        Sat,  5 Mar 2022 02:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646446711;
        bh=XrvS+TOjelc3/LO7U6AZ8fUaGlZzWhC2FIQPoYCGeIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbhcH7y0ckTqo1Yt6+BsMODPDJjXiRurWenok+Qy9kjJzyiigrRHSjYm3le22mbN+
         zmlGuY/I3RtTQsb/Q2QvpawD/m/9HwcZO+bAztuN0CoDOrSregpQuylpcjkBF74tkb
         dUdRRaA8thpEOD+056fl1dG3t1WBmIotsMJllnjFQjPTNYS13KPDM3TDC+ZkPTu+cQ
         ZVZtfkExHmGjeuweB4g9qsqX0dsfqTbRoCI85EveyFZfzBwd2Ol7wN96Zx//o7Pm3V
         sFXV3+Ge2Ds+skbVtyS32Dsser1aXCQFP6aml+Hl9Ztb7/I4uA+i54hlu6ySe2L4iL
         Ivf/xNnyFBfKA==
Date:   Sat, 5 Mar 2022 04:17:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
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
Message-ID: <YiLISeGl1mpzY/09@kernel.org>
References: <20220304122852.563475-1-jarkko@kernel.org>
 <94c4b8e2-1bf8-5a2a-7e76-6b8cad3c6b21@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94c4b8e2-1bf8-5a2a-7e76-6b8cad3c6b21@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:08:20AM -0800, Dave Hansen wrote:
> On 3/4/22 04:28, Jarkko Sakkinen wrote:
> > Explicit EAUG ioctl is a better choice than an implicit EAUG from a page
> > fault handler because it allows to have O(1) number of kernel-enclave round
> > trips for EAUG-EACCEPT{COPY} process, instead of O(n), as it is in the case
> > when a page fault handler EAUG single page at a time.
> 
> So this is basically an optimization?  It's MADV_WILLNEED or
> MAP_POPULATE to the cost of avoid future faults?

Yes.

So the idea would be that based on these the #PF handler would have more
smartness, and it would do a batch of EAUG's?

That could be possibly acceptable but I also had other concern.

I would like to see this:

1. Removal of vm_run_prot_bits.
2. Use RWX vm_max_prot_bits for EAUG'd pages.

During run-time kernel controls PTE's, and enclave has full control of the
EPCM (EACCEPT, EACCEPTCOPY, EMODPE). By creating artificial limitations how
to operate with these, it can limit various optimizations in the user space
code. E.g. a syscall shim can require clever co-operation between in-enclave
opcodes and what you do with the kernel in various situations.

RWX sounds provocative yes, but here it means only the limits where kernel
can set its PTE's and nothing else, not that page table is filled with RWX
pages, and enclave dictates what is in EPCM, and that's how it actually
should be (e.g. you can sometimes deliver mmap() without ever going out
of the enclave with EMODPE).

If MADV_WILLNEED/MAP_POPULATE approach is combined with this what I
discussed here, then I think we could have solution to write an efficient
memory management shims.

BR, Jarkko
