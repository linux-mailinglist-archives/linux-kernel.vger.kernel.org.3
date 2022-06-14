Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41154A728
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbiFNC4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345546AbiFNC4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:56:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38B36681
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C2D7B816E4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200BDC3411B;
        Tue, 14 Jun 2022 02:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655174519;
        bh=gWe+KkJwuLLPm5nqlarCynBBxq9KjWwVfU86evVXDXo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gWehKC4lyTVWGSKwresgCKUT9QBxroyStB17pZV6pEl8YgLUIapSjxxg5tFIF3w79
         VUFj2QJxLVRDdJ5sLCIquS+qoXb/bBzkSnivNCPEigJzYqDPiUA/q2zN93qPPMyRWR
         96XMhtRLLkZy2HE/JpC21v4Bia54Pz6Nk505oLuqrtMf6ly+pI9r0IOoxqiVsU2zol
         D7fwV91pI8YqTERX517lynL0vzzJ/Ak/nGbpdqZ+UpvkldMrg7WxDNjFt9WxU1KlW+
         3xZh+WkE0FhJN71ma607eB2n2xIisLLbacJpOlfdmcEvo5WZN9QpFZMejtuTsgdmNr
         Wi+b4hpbUAaRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BB6D85C02F9; Mon, 13 Jun 2022 19:41:58 -0700 (PDT)
Date:   Mon, 13 Jun 2022 19:41:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
Message-ID: <20220614024158.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <202206131639.DBA0A8D@keescook>
 <20220614000329.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880C6814BA88CD660610344DAAA9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880C6814BA88CD660610344DAAA9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:52:23AM +0000, Zhang, Qiang1 wrote:
> On Mon, Jun 13, 2022 at 04:42:07PM -0700, Kees Cook wrote:
> > On Mon, Jun 13, 2022 at 10:36:07AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> > > 
> > > Reported-and-tested-by: 
> > > syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> > 
> > Looks like the patch solved the reproducer. :)
> 
> >For one of the two possible ways to make the bug happen.  ;-)
> >
> >Still, good on Qiang for identifying one of the paths!  Not just anyone can do that.
> 
> Thanks Paul, yes this patch can solved the reproducer and I also test it.
> 
> I compiled "bpf_test" according to the c file in the following link
> 
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148207bff00000
> 
> Not apply this patch, this calltrace reproduce
> 
> root@qemux86-64:/# ./bpf_test
> ^C
> root@qemux86-64:/# dmesg
> [  147.017232] ------------[ cut here ]------------
> [  147.017234] WARNING: CPU: 3 PID: 21586 at kernel/rcu/tasks.h:1664 exit_tasks_rcu_finish+0xbf/0x100
> [  147.017245] Modules linked in:
> [  147.017249] CPU: 3 PID: 21586 Comm: bpf_test Not tainted 5.19.0-rc1-next-20220610-yoctodev-standard #204
> [  147.017253] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [  147.017256] RIP: 0010:exit_tasks_rcu_finish+0xbf/0x100
> [  147.017261] Code: 03 00 00 85 c0 75 59 f0 83 44 24 fc 00 49 8d bc 24 41 03 00 00 e8 21 09 2b 00 41 0f b6 84 24 41 03 00 00 83 e0 01 08 d8 74 11 <0f> 8
> [  147.017264] RSP: 0018:ffff88810ccd7af0 EFLAGS: 00010202
> [  147.017268] RAX: 0000000000000001 RBX: 0000000000000201 RCX: ffffffff897ab52f
> [  147.017271] RDX: 1ffff1102181d7c8 RSI: 0000000000000000 RDI: ffff88810c0ebe41
> [  147.017274] RBP: ffff88810ccd7b08 R08: ffffffff897ab510 R09: 0000000000000000
> [  147.017277] R10: ffffffff8c407bbf R11: 0000000000000000 R12: ffff88810c0ebb00
> [  147.017279] R13: ffff88810c0ebe38 R14: ffff88810ccd7b78 R15: ffff88810ccd76b0
> [  147.017282] FS:  0000000000000000(0000) GS:ffff88815a000000(0000) knlGS:0000000000000000
> [  147.017287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  147.017289] CR2: 0000000000000000 CR3: 000000011ac16000 CR4: 00000000001506e0
> [  147.017292] Call Trace:
> [  147.017294]  <TASK>
> [  147.017297]  do_exit+0xe9a/0x13a0
> [  147.017305]  ? mm_update_next_owner+0x450/0x450
> [  147.017309]  ? lock_downgrade+0x410/0x410
> [  147.017313]  ? lock_contended+0x790/0x790
> [  147.017317]  ? rcu_read_lock_held_common+0x1e/0x60
> [  147.017324]  do_group_exit+0x71/0x150
> [  147.017329]  get_signal+0x1319/0x1340
> [  147.017334]  ? futex_wait_setup+0x180/0x180
> [  147.017341]  ? exit_signals+0x4c0/0x4c0
> [  147.017345]  ? futex_wake+0x29e/0x2e0
> [  147.017351]  arch_do_signal_or_restart+0x9c/0xc60
> [  147.017357]  ? rcu_read_lock_sched_held+0x60/0xd0
> [  147.017361]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [  147.017367]  ? get_sigframe_size+0x20/0x20
> [  147.017371]  ? do_futex+0x1a2/0x240
> [  147.017375]  ? __ia32_sys_get_robust_list+0x240/0x240
> [  147.017378]  ? __context_tracking_exit+0x91/0xa0
> [  147.017385]  ? lock_downgrade+0x410/0x410
> [  147.017390]  ? __x64_sys_futex+0x125/0x2b0
> [  147.017393]  ? rcu_read_lock_held_common+0x1e/0x60
> [  147.017399]  ? lockdep_hardirqs_on_prepare+0x13/0x230
> [  147.017403]  ? exit_to_user_mode_prepare+0x151/0x240
> [  147.017409]  exit_to_user_mode_prepare+0x16c/0x240
> [  147.017415]  syscall_exit_to_user_mode+0x1e/0x70
> [  147.017419]  do_syscall_64+0x50/0x90
> [  147.017423]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  147.017427] RIP: 0033:0x7f780e668fbd
> [  147.017431] Code: Unable to access opcode bytes at RIP 0x7f780e668f93.
> [  147.017433] RSP: 002b:00007f780e55bd48 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> [  147.017437] RAX: fffffffffffffe00 RBX: 00007f780e55c640 RCX: 00007f780e668fbd
> [  147.017440] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000055ed9f3a8088
> [  147.017442] RBP: 00007f780e55bd60 R08: 0000000100000001 R09: 0000000100000001
> [  147.017445] R10: 0000000000000000 R11: 0000000000000246 R12: fffffffffffffeb0
> [  147.017447] R13: 0000000000000000 R14: 00007ffe5dcf20a0 R15: 00007f780e53c000
> [  147.017455]  </TASK>
> [  147.017458] irq event stamp: 0
> [  147.017460] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  147.017463] hardirqs last disabled at (0): [<ffffffff896b5990>] copy_process+0xe30/0x35f0
> [  147.017467] softirqs last  enabled at (0): [<ffffffff896b5990>] copy_process+0xe30/0x35f0
> [  147.017470] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  147.017473] ---[ end trace 0000000000000000 ]---
> 
> Apply this patch , this problem not reproduce.

Thank you very much!  May I apply your Tested-by?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >							Thanx, Paul
> >
> > > Tested on:
> > > 
> > > commit:         6d0c8068 Add linux-next specific files for 20220610
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20220610
> > > console output: 
> > > https://syzkaller.appspot.com/x/log.txt?x=12d068eff00000
> > > kernel config:  
> > > https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=147f47c8080000
> > > 
> > > Note: testing is done by a robot and is best-effort only.
> > 
> > You can see the dashboard link above for testing details...
> > 
> > --
> > Kees Cook
