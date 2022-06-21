Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A864E553486
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351613AbiFUObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiFUObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:31:10 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64F24087
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:31:09 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:51110)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o3euK-001zA5-Bs; Tue, 21 Jun 2022 08:31:08 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57160 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o3euG-00BtHi-66; Tue, 21 Jun 2022 08:31:06 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     syzbot <syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
References: <000000000000f5004705e1db8bad@google.com>
        <YrGVYfPINRobj+cF@example.org>
Date:   Tue, 21 Jun 2022 09:30:57 -0500
In-Reply-To: <YrGVYfPINRobj+cF@example.org> (Alexey Gladkov's message of "Tue,
        21 Jun 2022 11:54:41 +0200")
Message-ID: <8735fyhyvy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o3euG-00BtHi-66;;;mid=<8735fyhyvy.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/uoU+c9If2ketZ50xb66X+wuYr48P6qLs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,GB_FAKE_RF_SHORT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1027 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (1.1%), b_tie_ro: 10 (1.0%), parse: 1.39
        (0.1%), extract_message_metadata: 26 (2.5%), get_uri_detail_list: 6
        (0.6%), tests_pri_-1000: 24 (2.4%), tests_pri_-950: 1.92 (0.2%),
        tests_pri_-900: 1.51 (0.1%), tests_pri_-90: 149 (14.5%), check_bayes:
        147 (14.3%), b_tokenize: 21 (2.1%), b_tok_get_all: 12 (1.2%),
        b_comp_prob: 4.9 (0.5%), b_tok_touch_all: 105 (10.2%), b_finish: 0.96
        (0.1%), tests_pri_0: 792 (77.1%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 2.9 (0.3%), poll_dns_idle: 1.12 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 13 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [syzbot] memory leak in setup_mq_sysctls
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Sun, Jun 19, 2022 at 11:52:25PM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    979086f5e006 Merge tag 'fs.fixes.v5.19-rc3' of git://git.k..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1284331bf00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c696a83383a77f81
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b4b0d1b35442afbf6fd2
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e740ff00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b758bf00000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com
>
> I'm working on a fix that will remove this memory allocation entirely.

Hmm. The memory should be freed when the corresponding namespace exits.
I see retire_mq_sysctls is being called to free this memory.  Alex do
you see any leaks when you read that code?

So it looks like either someone broke this in linux-next or there
is a bug in the memory leak detector, or something truly strange
like a memory stop is going on.

I don't see any changes to the ipc subdirectory since v5.19-rc1 in
commit 979086f5e006 ("Merge tag 'fs.fixes.v5.19-rc3' of git://git.k.." )
so the idea that the code is broken in linux-next is out.

Which leaves the memory leak detector having trouble with this,
or something like a memory stomp is causing problems.

Catalin is it possible that the clever use of ctl_table_arg to hold the
reference to the table before it is freed is confusing the memory leak
detector?  The idiom is old enough I don't expect so, but I have seen
bugs lurk for a long time.

Which leaves just a memory stomp or something even stranger in the code.
syzkaller can you reproduce this on Linus's branch?

Eric

>> executing program
>> BUG: memory leak
>> unreferenced object 0xffff888112fc9200 (size 512):
>>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>>   hex dump (first 32 bytes):
>>     ef d3 60 85 ff ff ff ff 0c 9b d2 12 81 88 ff ff  ..`.............
>>     04 00 00 00 a4 01 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff814b6eb3>] kmemdup+0x23/0x50 mm/util.c:129
>>     [<ffffffff82219a9b>] kmemdup include/linux/fortify-string.h:456 [inline]
>>     [<ffffffff82219a9b>] setup_mq_sysctls+0x4b/0x1c0 ipc/mq_sysctl.c:89
>>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> 
>> BUG: memory leak
>> unreferenced object 0xffff888112fd5f00 (size 256):
>>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>>   hex dump (first 32 bytes):
>>     00 92 fc 12 81 88 ff ff 00 00 00 00 01 00 00 00  ................
>>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff816fea1b>] kmalloc include/linux/slab.h:605 [inline]
>>     [<ffffffff816fea1b>] kzalloc include/linux/slab.h:733 [inline]
>>     [<ffffffff816fea1b>] __register_sysctl_table+0x7b/0x7f0 fs/proc/proc_sysctl.c:1344
>>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> 
>> BUG: memory leak
>> unreferenced object 0xffff888112fbba00 (size 256):
>>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>>   hex dump (first 32 bytes):
>>     78 ba fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
>>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
>>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
>>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
>>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
>>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
>>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> 
>> BUG: memory leak
>> unreferenced object 0xffff888112fbb900 (size 256):
>>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>>   hex dump (first 32 bytes):
>>     78 b9 fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
>>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
>>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
>>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
>>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
>>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
>>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> 
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>> 
