Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3103F563BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiGAVXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiGAVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:23:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1937A10;
        Fri,  1 Jul 2022 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R1q5UrG3cvoya5AOA/7NpRAVj1mgsomo7+FzxeOMlVY=; b=mIrtwHl1cJE/Kj5/8/O0ntriEJ
        vH1isf8cQCAgXG7njs6nVt6zo2mhbRYJNp6Q2QdVBNh6Zzrx6iUjv3bXLAalQGenGlOMej1T5v/BY
        /pg9mS6FZhcZJQOOrXg/vkSWSTseyHAUF9wC4oaiUh0slrMk/hrwRSMejTvUS63Q971zdpoVX44Nj
        NRidynAsNy3sCJ0xc/CoNzi2iIutGpWGj7sQ1F9FYeOwQapQSU010PgzYyGbp9gI6HHbO7q0eYsjT
        SRQB82xtn4o/f0Xoq7so3lgdM10JA7vzYcp7ev1n92U2b/HsI3xM4+iWE1eTmiy/W6+z/O/1QbbLX
        XYskewkQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7O71-00703B-K2; Fri, 01 Jul 2022 21:23:39 +0000
Date:   Fri, 1 Jul 2022 14:23:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     jeyu@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2] modules: Ensure natural alignment for
 .altinstructions and __bug_table sections
Message-ID: <Yr9l24rvCAPJvuJQ@bombadil.infradead.org>
References: <Yr8/gr8e8I7tVX4d@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr8/gr8e8I7tVX4d@p100>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 08:40:02PM +0200, Helge Deller wrote:
> In the kernel image vmlinux.lds.S linker scripts the .altinstructions
> and __bug_table sections are 32- or 64-bit aligned because they hold 32-
> and/or 64-bit values.
> 
> But for modules the module.lds.S linker script doesn't define a default
> alignment yet, so the linker chooses the default byte alignment, which
> then leads to unnecessary unaligned memory accesses at runtime.
> 
> Usually such unaligned accesses are unnoticed, because either the
> hardware (as on x86 CPUs) or in-kernel exception handlers (e.g. on hppa
> or sparc) emulate and fix them up at runtime.
> 
> On hppa the 32-bit unalignment exception handler was temporarily broken
> due another bad commit, and as such wrong values were returned on
> unaligned accesses to the altinstructions table.

OK so some bad commit broke something which caused bad alignment access
on altinstructions... But why on modules?!

I am not aware of modules using alternatives, given that alternatives
are hacks to help with bootup. For modules we can use other things
like jump labels, static keys.

So I don't understand still how this happened yet.

> This then led to
> undefined behaviour because wrong kernel addresses were patched and we
> suddenly faced lots of unrelated bugs, as can be seen in this mail
> thread:
> https://lore.kernel.org/all/07d91863-dacc-a503-aa2b-05c3b92a1e39@bell.net/T/#mab602dfa32be5e229d5e192ab012af196d04d75d
> 
> This patch adds the missing natural alignment for kernel modules to
> avoid unnecessary (hard- or software-based) fixups.

Is it correct to infer that issue you found through a bad commit was
then through code inspection after the bad commit made the kernel do
something stupid with unaligned access to some module altinstructions
section ? Ie, that should not have happened.

I'd like to determine if this is a stable fix, a regression, etc. And
this is not yet clear.

  Luis

> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  scripts/module.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> --
> v2: updated commit message
> 
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 1d0e1e4dc3d2..3a3aa2354ed8 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -27,6 +27,8 @@ SECTIONS {
>  	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
>  	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
> 
> +	.altinstructions	0 : ALIGN(8) { KEEP(*(.altinstructions)) }
> +	__bug_table		0 : ALIGN(8) { KEEP(*(__bug_table)) }
>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
> 
>  	__patchable_function_entries : { *(__patchable_function_entries) }
