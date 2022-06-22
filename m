Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA389556EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359510AbiFVW4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiFVW4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:56:02 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E144CD3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:56:00 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:60862)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o49GR-00BAi3-O6; Wed, 22 Jun 2022 16:55:59 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57402 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o49GP-002YCq-FP; Wed, 22 Jun 2022 16:55:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com
References: <8735fyhyvy.fsf@email.froward.int.ebiederm.org>
        <20220622200729.2639663-1-legion@kernel.org>
Date:   Wed, 22 Jun 2022 17:55:22 -0500
In-Reply-To: <20220622200729.2639663-1-legion@kernel.org> (Alexey Gladkov's
        message of "Wed, 22 Jun 2022 22:07:29 +0200")
Message-ID: <87y1xob95x.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o49GP-002YCq-FP;;;mid=<87y1xob95x.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/26elwTItBzsE3kqrhYEqvZh6qW4CuuxM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 
X-Spam-Combo: ****;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1733 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 13 (0.7%), b_tie_ro: 11 (0.6%), parse: 1.67
        (0.1%), extract_message_metadata: 17 (1.0%), get_uri_detail_list: 5
        (0.3%), tests_pri_-1000: 17 (1.0%), tests_pri_-950: 1.35 (0.1%),
        tests_pri_-900: 1.07 (0.1%), tests_pri_-90: 143 (8.3%), check_bayes:
        141 (8.1%), b_tokenize: 18 (1.0%), b_tok_get_all: 9 (0.5%),
        b_comp_prob: 2.8 (0.2%), b_tok_touch_all: 108 (6.2%), b_finish: 0.96
        (0.1%), tests_pri_0: 1521 (87.8%), check_dkim_signature: 0.76 (0.0%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 0.86 (0.0%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 11 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ipc: Free mq_sysctls if ipc namespace creation failed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> The problem that Dmitry Vyukov pointed out is that if setup_ipc_sysctls fails,
> mq_sysctls must be freed before return.

Can we get a tested-by from syzbot?

It would be nice to confirm that this bug is the one syzbot was seeing.

Thank you,
Eric



> executing program
> BUG: memory leak
> unreferenced object 0xffff888112fc9200 (size 512):
>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>   hex dump (first 32 bytes):
>     ef d3 60 85 ff ff ff ff 0c 9b d2 12 81 88 ff ff  ..`.............
>     04 00 00 00 a4 01 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814b6eb3>] kmemdup+0x23/0x50 mm/util.c:129
>     [<ffffffff82219a9b>] kmemdup include/linux/fortify-string.h:456 [inline]
>     [<ffffffff82219a9b>] setup_mq_sysctls+0x4b/0x1c0 ipc/mq_sysctl.c:89
>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> BUG: memory leak
> unreferenced object 0xffff888112fd5f00 (size 256):
>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>   hex dump (first 32 bytes):
>     00 92 fc 12 81 88 ff ff 00 00 00 00 01 00 00 00  ................
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff816fea1b>] kmalloc include/linux/slab.h:605 [inline]
>     [<ffffffff816fea1b>] kzalloc include/linux/slab.h:733 [inline]
>     [<ffffffff816fea1b>] __register_sysctl_table+0x7b/0x7f0 fs/proc/proc_sysctl.c:1344
>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> BUG: memory leak
> unreferenced object 0xffff888112fbba00 (size 256):
>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>   hex dump (first 32 bytes):
>     78 ba fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> BUG: memory leak
> unreferenced object 0xffff888112fbb900 (size 256):
>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>   hex dump (first 32 bytes):
>     78 b9 fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> Reported-by: syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  ipc/namespace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 754f3237194a..e1fcaedba4fa 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -64,7 +64,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  		goto fail_put;
>  
>  	if (!setup_ipc_sysctls(ns))
> -		goto fail_put;
> +		goto fail_mq;
>  
>  	sem_init_ns(ns);
>  	msg_init_ns(ns);
> @@ -72,6 +72,9 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  
>  	return ns;
>  
> +fail_mq:
> +	retire_mq_sysctls(ns);
> +
>  fail_put:
>  	put_user_ns(ns->user_ns);
>  	ns_free_inum(&ns->ns);
