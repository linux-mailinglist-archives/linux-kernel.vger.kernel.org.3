Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FDE4C4111
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiBYJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiBYJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:15:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912B1B60B1;
        Fri, 25 Feb 2022 01:15:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 302E121155;
        Fri, 25 Feb 2022 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645780525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NSRQsaAXBkkQ7QnYKZsVjo6Tv1AR1HG9C9oaCm+FUTo=;
        b=Fi07jr963eCnzwOP+idIXoBeSCZAbV/nbTAkq5P35KMZIQlc005TS5kB2sWplxE4hHJK5C
        tUm0JyL1PYx5i+YDmXhhk3NgDMydZPhyKIiNnMFp1RbTbh5YYgIrfD+gO8Axu4eObWsU0i
        nJBlym/qGUzRbD4ByYRWIa/oJ0qD9Hs=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B5C7FA3B83;
        Fri, 25 Feb 2022 09:15:24 +0000 (UTC)
Date:   Fri, 25 Feb 2022 10:15:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Message-ID: <YhieKf9EcS3GQSXG@alley>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-10-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222141303.1392190-10-atomlin@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-22 14:12:59, Aaron Tomlin wrote:
> No functional change.

The patch adds rcu_dereference_sched() into several locations.
It triggers lockdep warnings, see below.

It is good example why avoid any hidden changes when shuffling
code. The changes in the code should be done in a preparatory
patch or not at all.

This patch is even worse because these changes were not
mentioned in the commit message. It should describe what
is done and why.

I wonder how many other changes are hidden in this patchset
and if anyone really checked them.

> This patch migrates kallsyms code out of core module
> code kernel/module/kallsyms.c

> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> new file mode 100644
> index 000000000000..b6d49bb5afed
> --- /dev/null
> +++ b/kernel/module/kallsyms.c
[...]
> +/*
> + * We use the full symtab and strtab which layout_symtab arranged to
> + * be appended to the init section.  Later we switch to the cut-down
> + * core-only ones.
> + */
> +void add_kallsyms(struct module *mod, const struct load_info *info)
> +{
> +	unsigned int i, ndst;
> +	const Elf_Sym *src;
> +	Elf_Sym *dst;
> +	char *s;
> +	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
> +
> +	/* Set up to point into init section. */
> +	mod->kallsyms = (void __rcu *)mod->init_layout.base +
> +		info->mod_kallsyms_init_off;
> +
> +	/* The following is safe since this pointer cannot change */
> +	rcu_dereference_sched(mod->kallsyms)->symtab = (void *)symsec->sh_addr;

I have got the following warning in livepatch self-test:

[  372.740779] ===== TEST: basic function patching =====
[  372.760921] % modprobe test_klp_livepatch
[  372.766361] test_klp_livepatch: tainting kernel with TAINT_LIVEPATCH
[  372.767319] test_klp_livepatch: module verification failed: signature and/or required key missing - tainting kernel

[  372.769132] =============================
[  372.769771] WARNING: suspicious RCU usage
[  372.770392] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.770396] -----------------------------
[  372.770397] kernel/module/kallsyms.c:178 suspicious rcu_dereference_check() usage!
[  372.770400] 
               other info that might help us debug this:

[  372.770401] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.770403] no locks held by modprobe/1760.
[  372.770405] 
               stack backtrace:
[  372.770409] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.770412] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.770413] Call Trace:
[  372.770415]  <TASK>
[  372.770417]  dump_stack_lvl+0x58/0x71
[  372.770424]  add_kallsyms+0x477/0x5c0
[  372.770434]  load_module+0x107c/0x19c0
[  372.770446]  ? kernel_read_file+0x2a3/0x2d0
[  372.782403]  ? __do_sys_finit_module+0xaf/0x120
[  372.783019]  __do_sys_finit_module+0xaf/0x120
[  372.783038]  do_syscall_64+0x37/0x80
[  372.783042]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.783045] RIP: 0033:0x7f13f53992a9
[  372.783048] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.783050] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.783052] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.783054] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.783055] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.783056] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.783057] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.783070]  </TASK>


> +	rcu_dereference_sched(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);

[  372.793150] =============================
[  372.793151] WARNING: suspicious RCU usage
[  372.793153] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.793155] -----------------------------
[  372.793156] kernel/module/kallsyms.c:179 suspicious rcu_dereference_check() usage!
[  372.793158] 
               other info that might help us debug this:

[  372.797266] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.797268] no locks held by modprobe/1760.
[  372.797270] 
               stack backtrace:
[  372.797271] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.797274] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.797275] Call Trace:
[  372.797277]  <TASK>
[  372.797278]  dump_stack_lvl+0x58/0x71
[  372.802579]  add_kallsyms+0x56f/0x5c0
[  372.802605]  load_module+0x107c/0x19c0
[  372.803525]  ? kernel_read_file+0x2a3/0x2d0
[  372.803538]  ? __do_sys_finit_module+0xaf/0x120
[  372.803540]  __do_sys_finit_module+0xaf/0x120
[  372.803555]  do_syscall_64+0x37/0x80
[  372.803558]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.803561] RIP: 0033:0x7f13f53992a9
[  372.803563] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.803565] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.803567] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.803568] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.811447] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.811465] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.811467] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.811479]  </TASK>


> +	/* Make sure we get permanent strtab: don't use info->strtab. */
> +	rcu_dereference_sched(mod->kallsyms)->strtab =
> +		(void *)info->sechdrs[info->index.str].sh_addr;

[  372.814541] =============================
[  372.815091] WARNING: suspicious RCU usage
[  372.815093] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.815094] -----------------------------
[  372.815095] kernel/module/kallsyms.c:181 suspicious rcu_dereference_check() usage!
[  372.815096] 
               other info that might help us debug this:

[  372.815097] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.815099] no locks held by modprobe/1760.
[  372.815100] 
               stack backtrace:
[  372.815101] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.815102] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.815103] Call Trace:
[  372.815105]  <TASK>
[  372.815106]  dump_stack_lvl+0x58/0x71
[  372.815111]  add_kallsyms+0x531/0x5c0
[  372.815119]  load_module+0x107c/0x19c0
[  372.815129]  ? kernel_read_file+0x2a3/0x2d0
[  372.815140]  ? __do_sys_finit_module+0xaf/0x120
[  372.815143]  __do_sys_finit_module+0xaf/0x120
[  372.815157]  do_syscall_64+0x37/0x80
[  372.815160]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.828879] RIP: 0033:0x7f13f53992a9
[  372.828885] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.828889] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.828892] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.828893] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.828894] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.828895] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.836097] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.836115]  </TASK>


> +	rcu_dereference_sched(mod->kallsyms)->typetab =
> +		mod->init_layout.base + info->init_typeoffs;

[  372.837224] =============================
[  372.837224] WARNING: suspicious RCU usage
[  372.837225] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.837227] -----------------------------
[  372.837227] kernel/module/kallsyms.c:183 suspicious rcu_dereference_check() usage!
[  372.837229] 
               other info that might help us debug this:

[  372.837230] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.837231] no locks held by modprobe/1760.
[  372.837232] 
               stack backtrace:
[  372.837233] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.837235] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.837236] Call Trace:
[  372.837237]  <TASK>
[  372.837239]  dump_stack_lvl+0x58/0x71
[  372.837243]  add_kallsyms+0x4f3/0x5c0
[  372.837251]  load_module+0x107c/0x19c0
[  372.849013]  ? kernel_read_file+0x2a3/0x2d0
[  372.849026]  ? __do_sys_finit_module+0xaf/0x120
[  372.849930]  __do_sys_finit_module+0xaf/0x120
[  372.849946]  do_syscall_64+0x37/0x80
[  372.850772]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.850775] RIP: 0033:0x7f13f53992a9
[  372.850778] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.850780] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.854028] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.854030] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.854031] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.854033] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.854034] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.854048]  </TASK>

> +
> +	/*
> +	 * Now populate the cut down core kallsyms for after init
> +	 * and set types up while we still have access to sections.
> +	 */
> +	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
> +	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
> +	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
> +	src = rcu_dereference_sched(mod->kallsyms)->symtab;

[  372.854081] =============================
[  372.854083] WARNING: suspicious RCU usage
[  372.854084] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.854087] -----------------------------
[  372.854089] kernel/module/kallsyms.c:193 suspicious rcu_dereference_check() usage!
[  372.854091] 
               other info that might help us debug this:

[  372.854093] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.854095] no locks held by modprobe/1760.
[  372.854097] 
               stack backtrace:
[  372.854099] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.854102] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.854104] Call Trace:
[  372.854106]  <TASK>
[  372.854109]  dump_stack_lvl+0x58/0x71
[  372.854126]  add_kallsyms+0x4b5/0x5c0
[  372.854139]  load_module+0x107c/0x19c0
[  372.866967]  ? kernel_read_file+0x2a3/0x2d0
[  372.866980]  ? __do_sys_finit_module+0xaf/0x120
[  372.867921]  __do_sys_finit_module+0xaf/0x120
[  372.867937]  do_syscall_64+0x37/0x80
[  372.868823]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.868826] RIP: 0033:0x7f13f53992a9
[  372.868828] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.868830] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.871419] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.871420] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.871422] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.871423] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.871424] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.871438]  </TASK>

> +	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {

[  372.871464] =============================
[  372.871466] WARNING: suspicious RCU usage
[  372.871467] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.871470] -----------------------------
[  372.871471] kernel/module/kallsyms.c:194 suspicious rcu_dereference_check() usage!
[  372.878748] 
               other info that might help us debug this:

[  372.878749] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.878751] no locks held by modprobe/1760.
[  372.878752] 
               stack backtrace:
[  372.878753] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.878756] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.878757] Call Trace:
[  372.878758]  <TASK>
[  372.878760]  dump_stack_lvl+0x58/0x71
[  372.878765]  add_kallsyms+0x296/0x5c0
[  372.878774]  load_module+0x107c/0x19c0
[  372.878785]  ? kernel_read_file+0x2a3/0x2d0
[  372.878797]  ? __do_sys_finit_module+0xaf/0x120
[  372.878800]  __do_sys_finit_module+0xaf/0x120
[  372.878815]  do_syscall_64+0x37/0x80
[  372.886420]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.886423] RIP: 0033:0x7f13f53992a9
[  372.886425] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.886427] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.886429] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.886431] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.886432] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.886433] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.886435] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.886448]  </TASK>

> +		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);

[  372.886474] =============================
[  372.886476] WARNING: suspicious RCU usage
[  372.886477] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.886480] -----------------------------
[  372.886481] kernel/module/kallsyms.c:195 suspicious rcu_dereference_check() usage!
[  372.886484] 
               other info that might help us debug this:

[  372.886485] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.886487] no locks held by modprobe/1760.
[  372.886489] 
               stack backtrace:
[  372.886491] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.886494] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.900968] Call Trace:
[  372.900970]  <TASK>
[  372.900972]  dump_stack_lvl+0x58/0x71
[  372.900977]  add_kallsyms+0x3c1/0x5c0
[  372.900986]  load_module+0x107c/0x19c0
[  372.900997]  ? kernel_read_file+0x2a3/0x2d0
[  372.901009]  ? __do_sys_finit_module+0xaf/0x120
[  372.901012]  __do_sys_finit_module+0xaf/0x120
[  372.901027]  do_syscall_64+0x37/0x80
[  372.904379]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.904382] RIP: 0033:0x7f13f53992a9
[  372.904384] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.904386] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.904389] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.904390] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.904391] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.904392] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.904394] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.904407]  </TASK>

> +		if (i == 0 || is_livepatch_module(mod) ||
> +		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
> +				   info->index.pcpu)) {
> +			mod->core_kallsyms.typetab[ndst] =
> +			    rcu_dereference_sched(mod->kallsyms)->typetab[i];

[  372.904436] =============================
[  372.904438] WARNING: suspicious RCU usage
[  372.904440] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.904442] -----------------------------
[  372.904444] kernel/module/kallsyms.c:200 suspicious rcu_dereference_check() usage!
[  372.904446] 
               other info that might help us debug this:

[  372.904448] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.904450] no locks held by modprobe/1760.
[  372.904452] 
               stack backtrace:
[  372.904454] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.904457] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.904459] Call Trace:
[  372.904461]  <TASK>
[  372.904464]  dump_stack_lvl+0x58/0x71
[  372.904470]  add_kallsyms+0x439/0x5c0
[  372.904485]  load_module+0x107c/0x19c0
[  372.904504]  ? kernel_read_file+0x2a3/0x2d0
[  372.921165]  ? __do_sys_finit_module+0xaf/0x120
[  372.921171]  __do_sys_finit_module+0xaf/0x120
[  372.921187]  do_syscall_64+0x37/0x80
[  372.922455]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.922458] RIP: 0033:0x7f13f53992a9
[  372.922461] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.922463] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.922466] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.922467] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.922469] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.922470] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.922472] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.922485]  </TASK>

> +			dst[ndst] = src[i];
> +			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
> +			s += strscpy(s,
> +				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],

[  372.929324] =============================
[  372.929325] WARNING: suspicious RCU usage
[  372.929327] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  372.929330] -----------------------------
[  372.929331] kernel/module/kallsyms.c:204 suspicious rcu_dereference_check() usage!
[  372.929334] 
               other info that might help us debug this:

[  372.929335] 
               rcu_scheduler_active = 2, debug_locks = 1
[  372.929338] no locks held by modprobe/1760.
[  372.929340] 
               stack backtrace:
[  372.929342] CPU: 3 PID: 1760 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  372.929345] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  372.929347] Call Trace:
[  372.929349]  <TASK>
[  372.929352]  dump_stack_lvl+0x58/0x71
[  372.929360]  add_kallsyms+0x3fb/0x5c0
[  372.929374]  load_module+0x107c/0x19c0
[  372.929392]  ? kernel_read_file+0x2a3/0x2d0
[  372.939163]  ? __do_sys_finit_module+0xaf/0x120
[  372.939167]  __do_sys_finit_module+0xaf/0x120
[  372.939182]  do_syscall_64+0x37/0x80
[  372.939186]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  372.939188] RIP: 0033:0x7f13f53992a9
[  372.939190] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  372.939192] RSP: 002b:00007ffca746bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  372.939195] RAX: ffffffffffffffda RBX: 000055bc9b8b8880 RCX: 00007f13f53992a9
[  372.939196] RDX: 0000000000000000 RSI: 000055bc99c31688 RDI: 0000000000000005
[  372.939197] RBP: 000055bc99c31688 R08: 0000000000000000 R09: 000055bc9b8b8410
[  372.939199] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  372.939200] R13: 000055bc9b8b87a0 R14: 0000000000000000 R15: 000055bc9b8b8880
[  372.939213]  </TASK>

> +				     KSYM_NAME_LEN) + 1;
> +		}
> +	}
> +	mod->core_kallsyms.num_symtab = ndst;
> +}

[...]

> +#ifdef CONFIG_LIVEPATCH
> +int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
> +					     struct module *, unsigned long),
> +				   void *data)
> +{
> +	struct module *mod;
> +	unsigned int i;
> +	int ret = 0;
> +
> +	mutex_lock(&module_mutex);
> +	list_for_each_entry(mod, &modules, list) {
> +		/* Still use rcu_dereference_sched to remain compliant with sparse */
> +		struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);

I got the following warning when running livepatch selftest:

[  403.430393] ===== TEST: multiple target modules =====
[  403.452359] % modprobe test_klp_callbacks_busy block_transition=N
[  403.458735] test_klp_callbacks_busy: test_klp_callbacks_busy_init
[  403.459544] test_klp_callbacks_busy: busymod_work_func enter
[  403.460274] test_klp_callbacks_busy: busymod_work_func exit
[  403.476999] % modprobe test_klp_callbacks_demo

[  403.483742] =============================
[  403.484446] WARNING: suspicious RCU usage
[  403.485158] 5.17.0-rc5-default+ #335 Tainted: G            E K  
[  403.486490] -----------------------------
[  403.486496] kernel/module/kallsyms.c:486 suspicious rcu_dereference_check() usage!
[  403.486499] 
               other info that might help us debug this:

[  403.486500] 
               rcu_scheduler_active = 2, debug_locks = 1
[  403.486502] 2 locks held by modprobe/2479:
[  403.486504]  #0: ffffffff94c4f770 (klp_mutex){+.+.}-{3:3}, at: klp_enable_patch.part.12+0x24/0x910
[  403.486517]  #1: ffffffff94c50a50 (module_mutex){+.+.}-{3:3}, at: module_kallsyms_on_each_symbol+0x27/0x110
[  403.486527] 
               stack backtrace:
[  403.486529] CPU: 3 PID: 2479 Comm: modprobe Tainted: G            E K   5.17.0-rc5-default+ #335
[  403.486532] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  403.486535] Call Trace:
[  403.486536]  <TASK>
[  403.486539]  dump_stack_lvl+0x58/0x71
[  403.486546]  module_kallsyms_on_each_symbol+0x101/0x110
[  403.486549]  ? kobject_add_internal+0x1ca/0x2c0
[  403.501245]  klp_find_object_symbol+0x5f/0x110
[  403.501255]  klp_init_object_loaded+0xca/0x140
[  403.501261]  klp_enable_patch.part.12+0x5b6/0x910
[  403.501266]  ? pre_patch_callback+0x20/0x20 [test_klp_callbacks_demo]
[  403.501271]  ? pre_patch_callback+0x20/0x20 [test_klp_callbacks_demo]
[  403.501276]  do_one_initcall+0x58/0x300
[  403.501286]  do_init_module+0x4b/0x1f1
[  403.501291]  load_module+0x1862/0x19c0
[  403.506243]  ? __do_sys_finit_module+0xaf/0x120
[  403.506247]  __do_sys_finit_module+0xaf/0x120
[  403.506261]  do_syscall_64+0x37/0x80
[  403.506264]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  403.506267] RIP: 0033:0x7f8e5f5f12a9
[  403.506270] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bf 0b 2c 00 f7 d8 64 89 01 48
[  403.510723] RSP: 002b:00007ffc725cfe48 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  403.510727] RAX: ffffffffffffffda RBX: 000055ddd32938d0 RCX: 00007f8e5f5f12a9
[  403.510729] RDX: 0000000000000000 RSI: 000055ddd2231688 RDI: 0000000000000005
[  403.510731] RBP: 000055ddd2231688 R08: 0000000000000000 R09: 000055ddd3293410
[  403.510733] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000040000
[  403.510734] R13: 000055ddd32937a0 R14: 0000000000000000 R15: 000055ddd32938d0
[  403.510750]  </TASK>

> +
> +		if (mod->state == MODULE_STATE_UNFORMED)
> +			continue;
> +		for (i = 0; i < kallsyms->num_symtab; i++) {
> +			const Elf_Sym *sym = &kallsyms->symtab[i];
> +
> +			if (sym->st_shndx == SHN_UNDEF)
> +				continue;
> +
> +			ret = fn(data, kallsyms_symbol_name(kallsyms, i),
> +				 mod, kallsyms_symbol_value(sym));
> +			if (ret != 0)
> +				goto out;
> +		}
> +	}
> +out:
> +	mutex_unlock(&module_mutex);
> +	return ret;
> +}
