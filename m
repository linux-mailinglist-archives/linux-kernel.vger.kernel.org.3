Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE29F4B87D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiBPMks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:40:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiBPMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:40:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C5B5F;
        Wed, 16 Feb 2022 04:40:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC0961185;
        Wed, 16 Feb 2022 12:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9619C004E1;
        Wed, 16 Feb 2022 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645015233;
        bh=xGdNsHoDlmOQOrcDtO26R6cUWN1PwV5N2e2tKKGP+lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0Vsvya8ijnezxxkG4Smz+Ph+3sSYkI9W8xELnINECI6BRQ+cUmuEJUFmJT3DR7Wt
         EUvbuR7SiiTydVLStJtyny4SXowcz7NkuaGpeINaUpaiD2oTI5oKnV+uCkLlHpjF0y
         hWiogXpjzuZ4XeATpsocfb0UR0lc7yGZYRW9lFRp2g1cWNOtl0GlDDqvMRhxLbpYK3
         pDOazcrBQ1uPX1i0J3aC5R1v4YEfZQS7djwyhG1o53Cm3yP2MAnsWyUyackTwnA+rK
         itw5KQvhW0JPZaARAhLXXDL/cIYJj4BIGYCevI7x9SddUCzvYtGE4cm1T46TVp4pyk
         AMgzjg88fFRaQ==
Date:   Wed, 16 Feb 2022 12:40:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zwang@amperecomputing.com,
        patches@amperecomputing.com, darren@os.amperecomputing.com
Subject: Re: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
Message-ID: <20220216124026.GB9949@willie-the-truck>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
 <20220215164423.GB8458@willie-the-truck>
 <YgzD0ZfZF34u6whJ@hsj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgzD0ZfZF34u6whJ@hsj>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 09:28:49AM +0000, Huang Shijie wrote:
> Hi Will,
> On Tue, Feb 15, 2022 at 04:44:23PM +0000, Will Deacon wrote:
> > On Wed, Feb 09, 2022 at 09:26:42AM +0000, Huang Shijie wrote:
> > > The following interrelated ranges are needed by the kdump crash tool:
> > > 	MODULES_VADDR ~ MODULES_END,
> > > 	VMALLOC_START ~ VMALLOC_END,
> > > 	VMEMMAP_START ~ VMEMMAP_END
> > > 
> > > Since these values change from time to time, it is preferable to export
> > > them via vmcoreinfo than to change the crash's code frequently.
> > 
> > Please can you explain _why_ they are needed?
> 
> The current Crash code is still based at kernel v4.9.
>    The virtual memory layout looks like this:
>    +--------------------------------------------------------------------+
>    |    KASAN     |   MODULE   |   VMALLOC   | .... |     VMEMMAP       |
>    +--------------------------------------------------------------------+
> 
> The Crash uses MODULES range to set the VMALLOC ranges.
> If the ranges are wrong, Crash will _NOT_ works well for some latest kernel
> ,such as v5.11 later. (Please correct me if I am wrong).
> It seems the VMEMMAP range is less important.

[...]

> 5.) In the kernel v5.16, after the patch
>       "b89ddf4cca43 arm64/bpf: Remove 128MB limit for BPF JIT programs"
>     the virtual memory layout looks like this:
> 
>    +--------------------------------------------------------------------+
>    |      MODULE     |   VMALLOC   |     ....     |      VMEMMAP        |
>    +--------------------------------------------------------------------+
> 
>     The macros are:
>     #define MODULES_VADDR	(_PAGE_END(VA_BITS_MIN))
>     #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
> 
>     #define VMALLOC_START	(MODULES_END)
>     #define VMALLOC_END		(VMEMMAP_START - SZ_256M)
> 
>     #define VMEMMAP_START	(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
>     #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
> 
> 
> BTW:I am currently coding a patch for the Crash to update all the ranges to
> the latest kernel version v5.17-rc4.

Thanks for digging up all of the kernel memory map changes and taking the
time to explain the macros. However, all I'm really after is something in
the commit message of the patch which explains what is broken without this
patch. What does crash use this information for, and what doesn't work at
the moment?

Cheers,

Will
