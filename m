Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C23A4C0D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiBWHNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiBWHNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:13:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB259A43
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:13:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 422A8B81E7E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67540C340E7;
        Wed, 23 Feb 2022 07:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645600390;
        bh=+DGzvPHAQ6IbmlzSXeG2hbFfqt/5MKzb+1UR8+c8x2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVRpKs37RLe7EKJJcUhi6ISAKPOxEM8zefmXwVShM7O73mfcBh9LQqz6pArS3RpDS
         os5uNQroDZSb899RphtEMb/lex5UYTuHcWUHeXr/yUWGxDCA+qjE7AqAliHh1tqh5F
         4sphX46ismj2+0I02g4s7iDedivUz/hOx5e6hXzs=
Date:   Wed, 23 Feb 2022 08:13:08 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <YhXehCLx9LVwCIO6@kroah.com>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB5880C431590170767B4BACFEDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880C431590170767B4BACFEDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 06:51:10AM +0000, Zhang, Qiang1 wrote:
> 
> HEAD commit:    4f12b742eb2b Merge tag 'nfs-for-5.17-3' of git://git.linux..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=110a6df2700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6a069ed94a1ed1d
> dashboard link: https://syzkaller.appspot.com/bug?extid=348b571beb5eeb70a582
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12377296700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in dev_uevent+0x712/0x780 drivers/base/core.c:2320 Read of size 8 at addr ffff88802b934098 by task udevd/3689
> 
> CPU: 2 PID: 3689 Comm: udevd Not tainted 5.17.0-rc4-syzkaller-00229-g4f12b742eb2b #0 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014 Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description.constprop.0.cold+0x8d/0x303 mm/kasan/report.c:255  __kasan_report mm/kasan/report.c:442 [inline]  kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
>  dev_uevent+0x712/0x780 drivers/base/core.c:2320
>  uevent_show+0x1b8/0x380 drivers/base/core.c:2391
>  dev_attr_show+0x4b/0x90 drivers/base/core.c:2094
>  sysfs_kf_seq_show+0x219/0x3d0 fs/sysfs/file.c:59
>  seq_read_iter+0x4f5/0x1280 fs/seq_file.c:230
>  kernfs_fop_read_iter+0x514/0x6f0 fs/kernfs/file.c:241  call_read_iter include/linux/fs.h:2068 [inline]
>  new_sync_read+0x429/0x6e0 fs/read_write.c:400
>  vfs_read+0x35c/0x600 fs/read_write.c:481
>  ksys_read+0x12d/0x250 fs/read_write.c:619
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f964cc558fe
> Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> RSP: 002b:00007ffc0133d258 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000056497b21a140 RCX: 00007f964cc558fe
> RDX: 0000000000001000 RSI: 000056497b218650 RDI: 0000000000000008
> RBP: 00007f964cd22380 R08: 0000000000000008 R09: 00007f964cd25a60
> R10: 0000000000000008 R11: 0000000000000246 R12: 000056497b21a140
> R13: 0000000000000d68 R14: 00007f964cd21780 R15: 0000000000000d68  </TASK>
> 
> 
> Hi All 
> 
> This should be because when the raw_dev is released, the 'driver' address has expired,
> although the usb_gadget_remove_driver() empty 'dev.driver ' NULL, but UAF cannot be avoided.
> 
> static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env) {
> .....
>          if (dev->driver)
> 2320                 add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> .....
> }
> 
> Whether protection can be added when operating 'dev->driver'?

When the driver structure is unbound, this should be set to NULL.  Why
isn't that happening?

thanks,

greg k-h
