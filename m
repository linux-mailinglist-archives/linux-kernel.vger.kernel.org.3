Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97E4AA293
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbiBDVsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiBDVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:48:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBAEC061714;
        Fri,  4 Feb 2022 13:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9SYfsWFzOeb2t2NENOBafiesrt6p/JNoCmuAqtMpJAg=; b=bClA98KAJMM6GWkA04NvL6lMLs
        5R/oagRcsrlwoKvHitnHDU36SqDiBSGUAjMXvJ3vkOIRvEF3ZErEa/BArBHgrk4K59XavAZp1kfdi
        JPTNqFU1FGsjnluIGWLFfRX77wbXMe74POx2jNJ7ly9wxkW2tiNpOFokkImRnZFPYRfJzu90eymC2
        1LhbRTD6KnBNF76eMoIcJPPbqLIQVjW7cdVBC5/N+Zycse2fU3KIYAwJWH/IdIeehbBjy4Js+AMoi
        osU4WJcYbjbZzgXo31dSCyt14LeSB9pvNfU1DVTVKKuV1V6NKRJBBbGqcPV7uoWZm50heOWs5KM9X
        FpDBPp+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6Qp-005Ua8-BS; Fri, 04 Feb 2022 21:47:51 +0000
Date:   Fri, 4 Feb 2022 13:47:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vimal Agrawal <avimalin@gmail.com>
Cc:     hch@infradead.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, JBeulich@suse.com, jeffm@suse.com,
        sam@ravnborg.org, linux-kbuild@vger.kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, nishit.shah@sophos.com,
        Vimal Agrawal <vimal.agrawal@sophos.com>,
        Dirk VanDerMerwe <Dirk.VanDerMerwe@sophos.com>
Subject: Re: [PATCH v5] modules: add heuristic when stripping unneeded symbols
Message-ID: <Yf2fB4mzdLiWtoki@bombadil.infradead.org>
References: <20220203060641.119522-1-vimal.agrawal@sophos.com>
 <20220204083933.136096-1-vimal.agrawal@sophos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204083933.136096-1-vimal.agrawal@sophos.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:09:32PM +0530, Vimal Agrawal wrote:
> If kernel modules are stripped off symbols for some reason then stack
> traces in dmesg do not show symbol name for address. It just prints
> absolute address sometimes (if there is no good match with any symbol)
> 
> This was seen with OpenWrt which uses option INSTALL_MOD_STRIP=
> "--strip-unneeded" at kernel/module build/install time, and so modules
> are stripped off unneeded symbols.
> 
> [245864.699580]  do_nmi+0x12f/0x370
> [245864.699583]  end_repeat_nmi+0x16/0x50
> [245864.699585] RIP: 0010:0xffffffffc06b67ec                           <<<<<<<<
> [245864.699585] RSP: 0000:ffffaaa540cffe48 EFLAGS: 00000097
> [245864.699586] RAX: 0000000000000001 RBX: ffff93357a729000 RCX: 0000000000000001
> [245864.699587] RDX: ffff93357a729050 RSI: 0000000000000000 RDI: ffff93357a729000
> [245864.699588] RBP: ffff9335cf521300 R08: 0000000000000001 R09: 0000000000000004
> [245864.699588] R10: ffffaaa545b23ed0 R11: 0000000000000001 R12: ffffffffc06b61a0
> [245864.699589] R13: ffffaaa540cffe60 R14: ffff9335c77fa3c0 R15: ffff9335cf51d7c0
> [245864.699590]  ? 0xffffffffc06b61a0
> [245864.699592]  ? 0xffffffffc06b67ec                                  <<<<<<<<
> [245864.699593]  ? 0xffffffffc06b67ec
> [245864.699594]  </NMI>
> 
> Note RIP: 0010:0xffffffffc06b67ec and 0xffffffffc06b67ec printed in above
> stack trace as absolute address. There is no easy way in case box crashes
> as we loose information on load address of specific module.
> 
> This changes the symbol decoding (in kernel/module.c) such that it can
> print offset from start of section (.text or .init.text) in case there
> is no good match with any symbol.
> 
> It will now decode address in such cases to [module]+ offset/size or
> [module __init]+offset/size depending on where the address lies (in
> core/.text or init/.init.text section of module).
> 
> One can use objdump/readelf/nm to find symbols with offset from .init.text
> and .text sections.
> 
> steps to reproduce the problem:
> -------------------------------
> 1. Add WARN_ON_ONCE(1) in module e.g. test_module.c
> 2. Build and strip the module using --strip-unneeded option
> 3. Load the module and check RIP in dmesg
> 
> tests done:
> -----------
> 1. Added WARN_ON_ONE(1) in functions of a module for testing
> -------------------------------------------------------------
> [  407.934085] CPU: 0 PID: 2956 Comm: insmod Tainted: G        W   E     5.16.0-rc5-next-20211220+ #2
> [  407.934087] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [  407.934088] RIP: 0010:[module __init]+0x4/0x7 [test_module]
> [  407.934097] Code: Unable to access opcode bytes at RIP 0xffffffffc07edfda.
> [  407.934098] RSP: 0018:ffffb21440487c20 EFLAGS: 00010202
> [  407.934100] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  407.934101] RDX: 0000000000000000 RSI: ffffffff9c38e5e1 RDI: 0000000000000001
> [  407.934102] RBP: ffffb21440487c28 R08: 0000000000000000 R09: ffffb21440487a20
> [  407.934103] R10: ffffb21440487a18 R11: ffffffff9c755248 R12: ffffffffc07ee007
> [  407.934104] R13: ffff92a0f1e260b0 R14: 0000000000000000 R15: 0000000000000000
> [  407.934105] FS:  00007f578ebc4400(0000) GS:ffff92a1c0e00000(0000) knlGS:0000000000000000
> [  407.934107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  407.934108] CR2: ffffffffc07edfda CR3: 00000000063ea006 CR4: 00000000000706f0
> [  407.934113] Call Trace:
> [  407.934114]  <TASK>
> [  407.934116]  ? init_module+0x55/0xff9 [test_module]
> ...
> [  407.934232] CPU: 0 PID: 2956 Comm: insmod Tainted: G        W   E     5.16.0-rc5-next-20211220+ #2
> [  407.934234] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [  407.934242] RIP: 0010:[module]+0x4/0x7 [test_module]
> [  407.934248] Code: Unable to access opcode bytes at RIP 0xffffffffc07e1fda.
> [  407.934249] RSP: 0018:ffffb21440487c20 EFLAGS: 00010202
> [  407.934251] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  407.934252] RDX: 0000000000000000 RSI: ffffffff9c38e5e1 RDI: 0000000000000001
> [  407.934253] RBP: ffffb21440487c28 R08: 0000000000000000 R09: ffffb21440487a20
> [  407.934254] R10: ffffb21440487a18 R11: ffffffff9c755248 R12: ffffffffc07ee007
> [  407.934255] R13: ffff92a0f1e260b0 R14: 0000000000000000 R15: 0000000000000000
> [  407.934256] FS:  00007f578ebc4400(0000) GS:ffff92a1c0e00000(0000) knlGS:0000000000000000
> [  407.934257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  407.934258] CR2: ffffffffc07e1fda CR3: 00000000063ea006 CR4: 00000000000706f0
> [  407.934260] Call Trace:
> [  407.934260]  <TASK>
> [  407.934261]  ? init_module+0x5a/0xff9 [test_module]
> 
> note that it is able to decode RIP to an offset from module start or
> init start now.
> 
> tested on linux->next (tag next-20211220)
> 
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> Acked-by: Nishit Shah <nishit.shah@sophos.com>
> Suggested-by: Dirk VanDerMerwe <Dirk.VanDerMerwe@Sophos.com>
> ---
>  kernel/module.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 24dab046e16c..4de15c06e760 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -4270,14 +4270,21 @@ static const char *find_kallsyms_symbol(struct module *mod,
>  					unsigned long *offset)
>  {
>  	unsigned int i, best = 0;
> -	unsigned long nextval, bestval;
> +	unsigned long baseval, nextval, bestval;
>  	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
> +	char *module_base_name;
>  
>  	/* At worse, next value is at end of module */
> -	if (within_module_init(addr, mod))
> +	if (within_module_init(addr, mod)) {
> +		baseval = (unsigned long)mod->init_layout.base;
>  		nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
> -	else
> +		module_base_name = "[module __init]";
> +
> +	} else {
> +		baseval = (unsigned long)mod->core_layout.base;
>  		nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
> +		module_base_name = "[module]";
> +	}
>  
>  	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
>  
> @@ -4308,6 +4315,19 @@ static const char *find_kallsyms_symbol(struct module *mod,
>  			nextval = thisval;
>  	}
>  
> +	if ((is_module_text_address(addr) &&
> +		(bestval < baseval || bestval > nextval))) {
> +		/*
> +		 * return MODULE base and offset if we could not find
> +		 * any best match for text address
> +		 */
> +		if (size)
> +			*size = nextval - baseval;
> +		if (offset)
> +			*offset = addr - baseval;
> +		return module_base_name;
> +	}
> +

You did not explain why you change your code to not use the below
(!best) branch. I'd much prefer it there as that is when we know
for sure we have no real symbol defined.

  Luis
