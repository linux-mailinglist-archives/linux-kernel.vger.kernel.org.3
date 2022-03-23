Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1A4E5647
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbiCWQZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbiCWQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF604DF1E;
        Wed, 23 Mar 2022 09:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5B06183D;
        Wed, 23 Mar 2022 16:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5A3C340E8;
        Wed, 23 Mar 2022 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052617;
        bh=/oM1pD0jgiRaDdLSHbtlmH9OMdqllLyxQPTkXCeCfqw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LZbUzKe9NX9Zoc8lRxX9FEl2JPdtKxoV5gOErpyhbox5y4zzz6VEYm05Z1ATIHD9J
         PrFrl7hRxSfvhKEJBFYUbHUa7m2I9EOKb2lo7/d6MMpQPOMRVqrefz5c53KSzynSiY
         NdEyaYecjRzQQnqV+65I+KIyqLTs7Rrc9y25LmOu/CnXl5DmmjOLUIwVJWb7i1ARJ2
         zBMgsyiVFC0MCa7eLg0X1mkzwuYtTMzsHQS5QB5rIPOKrbJjUGrra0JD/Lv4GLnBkp
         6CDiLT1I8JJKFn7TkMNVOx352bfW3RdwpFCAwzkJ+9cAMWcMn9Tpml7DoYRn5daz6d
         xtesr5O3oOg7w==
Date:   Wed, 23 Mar 2022 17:23:33 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
cc:     syzbot <syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com>,
        benjamin.tissoires@redhat.com, dvyukov@google.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in hidraw_release
In-Reply-To: <20220204054708.2335-1-hdanton@sina.com>
Message-ID: <nycvar.YFH.7.76.2203231723100.24795@cbobk.fhfr.pm>
References: <0000000000007b73a605d71c201b@google.com> <20220204054708.2335-1-hdanton@sina.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022, Hillf Danton wrote:

> > ------------[ cut here ]------------
> > kernel BUG at drivers/hid/hidraw.c:335!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 5036 Comm: syz-executor223 Not tainted 5.17.0-rc2-syzkaller-00039-g9f7fb8de5d9b-dirty #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:drop_ref+0x375/0x3e0 drivers/hid/hidraw.c:335
> > Code: fb e9 a9 fd ff ff 48 89 ef 89 74 24 04 e8 43 61 04 fb 8b 74 24 04 e9 64 fd ff ff e8 a5 61 04 fb e9 13 fd ff ff e8 8b 1f bd fa <0f> 0b 48 89 df e8 31 61 04 fb e9 5a fe ff ff 48 89 de 48 c7 c7 a0
> > RSP: 0018:ffffc90005da7ac8 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffff88801deef9b0 RCX: 0000000000000000
> > RDX: ffff888072660000 RSI: ffffffff86bb4ef5 RDI: ffffffff90869f60
> > RBP: ffff88801deef900 R08: 0000000000000000 R09: ffffffff8ffbda7f
> > R10: ffffffff86bb4cd2 R11: 0000000000000000 R12: 0000000000000001
> > R13: ffff88801deef908 R14: ffff88807f1e98e0 R15: ffff88807f1e8000
> > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > CR2: 00007f229e36a600 CR3: 0000000079b38000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  hidraw_disconnect+0x48/0x60 drivers/hid/hidraw.c:600
> >  hid_disconnect+0x130/0x1a0 drivers/hid/hid-core.c:2036
> >  hid_hw_stop drivers/hid/hid-core.c:2079 [inline]
> >  hid_device_remove+0x15d/0x200 drivers/hid/hid-core.c:2411
> >  __device_release_driver+0x3bd/0x700 drivers/base/dd.c:1204
> >  device_release_driver_internal drivers/base/dd.c:1237 [inline]
> >  device_release_driver+0x26/0x40 drivers/base/dd.c:1260
> >  bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
> >  device_del+0x502/0xd50 drivers/base/core.c:3592
> >  hid_remove_device drivers/hid/hid-core.c:2578 [inline]
> >  hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2597
> >  uhid_dev_destroy drivers/hid/uhid.c:587 [inline]
> >  uhid_char_release+0xed/0x210 drivers/hid/uhid.c:663
> >  __fput+0x286/0x9f0 fs/file_table.c:311
> >  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
> >  exit_task_work include/linux/task_work.h:32 [inline]
> >  do_exit+0xb29/0x2a30 kernel/exit.c:806
> >  do_group_exit+0xd2/0x2f0 kernel/exit.c:935
> >  __do_sys_exit_group kernel/exit.c:946 [inline]
> >  __se_sys_exit_group kernel/exit.c:944 [inline]
> >  __ia32_sys_exit_group+0x3a/0x50 kernel/exit.c:944
> >  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> >  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> >  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > RIP: 0023:0xf7ee8549
> > Code: Unable to access opcode bytes at RIP 0xf7ee851f.
> > RSP: 002b:00000000ff8aaf4c EFLAGS: 00000292 ORIG_RAX: 00000000000000fc
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 00000000f7f94fa0 RSI: 00000000f7f953b8 RDI: 00000000f7f953b8
> > RBP: 00000000f7f95928 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:drop_ref+0x375/0x3e0 drivers/hid/hidraw.c:335
> > Code: fb e9 a9 fd ff ff 48 89 ef 89 74 24 04 e8 43 61 04 fb 8b 74 24 04 e9 64 fd ff ff e8 a5 61 04 fb e9 13 fd ff ff e8 8b 1f bd fa <0f> 0b 48 89 df e8 31 61 04 fb e9 5a fe ff ff 48 89 de 48 c7 c7 a0
> > RSP: 0018:ffffc90005da7ac8 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffff88801deef9b0 RCX: 0000000000000000
> > RDX: ffff888072660000 RSI: ffffffff86bb4ef5 RDI: ffffffff90869f60
> > RBP: ffff88801deef900 R08: 0000000000000000 R09: ffffffff8ffbda7f
> > R10: ffffffff86bb4cd2 R11: 0000000000000000 R12: 0000000000000001
> > R13: ffff88801deef908 R14: ffff88807f1e98e0 R15: ffff88807f1e8000
> > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > CR2: 00007f64971d1018 CR3: 000000007f5e0000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 
> > 
> > Tested on:
> > 
> > commit:         9f7fb8de Merge tag 'spi-fix-v5.17-rc2' of git://git.ke..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15e029cc700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b4a89edfcc8f7c74
> > dashboard link: https://syzkaller.appspot.com/bug?extid=953a33deaf38c66a915e
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: i386
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=12571934700000
> 
> This proves what Dmitry explained, given minor M, hidrawA == hidraw_table[M]
> was freed with someone dangling on the hidrawA->list because of zero open
> count, then another opener put hidrawB in hidraw_table[M].
> 
> TBH no evidence of leak in open count spotted, see what will come up with
> parallel openers disabled.
> 
> Hillf
> 
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/  9f7fb8de5d9b 
> 
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -272,7 +272,7 @@ static int hidraw_open(struct inode *ino
>  		goto out;
>  	}
>  
> -	down_read(&minors_rwsem);
> +	down_write(&minors_rwsem);
>  	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
>  		err = -ENODEV;
>  		goto out_unlock;
> @@ -301,7 +301,7 @@ static int hidraw_open(struct inode *ino
>  	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
>  	file->private_data = list;
>  out_unlock:
> -	up_read(&minors_rwsem);
> +	up_write(&minors_rwsem);
>  out:
>  	if (err < 0)
>  		kfree(list);
> @@ -332,6 +332,7 @@ static void drop_ref(struct hidraw *hidr
>  	if (!hidraw->open) {
>  		if (!hidraw->exist) {
>  			hidraw_table[hidraw->minor] = NULL;
> +			BUG_ON(!list_empty(&hidraw->list));
>  			kfree(hidraw);
>  		} else {
>  			/* close device for last reader */

Hillf,

could you please submit this properly with a full changelog, 
signed-off-by: line, etc?

Thanks,

-- 
Jiri Kosina
SUSE Labs

