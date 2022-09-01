Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB195A8B41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiIACMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIACMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:12:52 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091CD11F1A5;
        Wed, 31 Aug 2022 19:12:51 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id u1so5926468uan.3;
        Wed, 31 Aug 2022 19:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Akz+2VmmE5UeMJb+HQKTbFKSagxwqLAyt2M0BgMRLog=;
        b=lN3cSAwujUk8vWyR+cosQo6rXFqYF9gKoqQAmSzCyfRFTkkjbGgjAQWSqeFV5qPcLb
         oBsKHK/2zNPg37WW1ebHIIvrS0blctAgwZ1grGLJEF9hj6dA/PuMc1iV75HcsVfY6sUF
         JXxMOEMFFQ/n8Bgz73sbqZPjdLS+Fznzeqt7mrLAOMtksJqKjywtzKPJzQ4DlnpaPZbu
         QrLUUlCQ9iUocYmNWrDqqDJnhGR8XPtkFmMsHtdHkfkC6qi74k7UeAai81I/s7ropH8m
         OlF3fkthooH8mN4h/UgwqUV/1gBLYDGJP5CKPpDQekf6uiLw9AORzhOpz/6uQ7cqWMRW
         ea9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Akz+2VmmE5UeMJb+HQKTbFKSagxwqLAyt2M0BgMRLog=;
        b=WyWKvGK+Tfzywote/swCL2pO1aNTRuLAGQXxCZCgsmqtU0K0vSGAlVVu+cn5v3EXmO
         1rw6knsSYIRlcSboFzp2UedV6PPOhBwEj5f9P7DSpu91S3RIRdrKfGclvSgrLlTj+n/t
         Q1smVDJI6xTZHzw5ujjHR2xBucqsPWamNx+p8r6ibc0gdjuxX62/MTrCbLsfTC67mxc+
         88uxPgAw3vEonE03h+IxeWmvyPvA4x4rTo7yxsPhrz7TG6E5tat9vlLV9BgeCVDZCeu9
         qp5Ui6hWQI6Gn7dNkhSOg6dnh5M4AdmrdToLTRmRHXnQsWwbU9IeyeBquNnthkcInCO4
         vSeQ==
X-Gm-Message-State: ACgBeo3FBp6AiNGund4oIrqrZFjXy/PpiCEPmcqKtQJNCgsbpsduUDo5
        8yhDaIGK3pRk+GZ7pbKvXjXhQBayUgldZYSwTxY1uEa2EXaG2g==
X-Google-Smtp-Source: AA6agR55HPTrN+1hL/zL34x3eTA9sltowggGUhfVdx/hasBfH+PVMGGKAbSx+0JuuxZrwMkUrKXAeoogl6V4DvloB70=
X-Received: by 2002:ab0:6609:0:b0:39f:64d0:2b6d with SMTP id
 r9-20020ab06609000000b0039f64d02b6dmr7860646uam.16.1661998369913; Wed, 31 Aug
 2022 19:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexLHN1gn2QPdo1_PF70sPbo2cA8skwG17oZb7+J1DQ+J1Q@mail.gmail.com>
In-Reply-To: <CAB7eexLHN1gn2QPdo1_PF70sPbo2cA8skwG17oZb7+J1DQ+J1Q@mail.gmail.com>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 1 Sep 2022 10:12:38 +0800
Message-ID: <CAB7eexKGRgDWBLiRs=U70OPLREESi+bCgwt=7wWCESBDZDM=zQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in configfs_composite_bind
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry forget to sent to lkml earlier

Rondreis <linhaoguo86@gmail.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=89 16:08=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> When fuzzing the Linux kernel driver v5.18.0, the following crash was tri=
ggered.
>
> HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> git tree: upstream
>
> kernel config: https://pastebin.com/h9YFR4Vq
> C reproducer: https://pastebin.com/VKAKLfNd
> console output: https://pastebin.com/Kqck7YEH
>
> Basically, in the c reproducer, we use the gadget module to emulate
> the process of attaching a usb device (vendor id: 0x6a3, product id:
> 0xff04, with function: ms and net).
> To reproduce this crash, we utilize a third-party library to emulate
> the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> Just clone this repository, make install it, and compile the c
> reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
> the trick.
>
> It would appreciate if you have any ideal how to solve this bug.
>
> The crash report is as follow:
>
> ```
> using random host ethernet address
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in copy_gadget_strings
> drivers/usb/gadget/composite.c:1363 [inline]
> BUG: KASAN: use-after-free in usb_gstrings_attach+0x770/0x890
> drivers/usb/gadget/composite.c:1417
> Read of size 2 at addr ffff888106455b00 by task syz-executor170/9457
>
> CPU: 3 PID: 9457 Comm: syz-executor170 Not tainted 5.18.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:313 [inline]
> print_report.cold+0xe5/0x659 mm/kasan/report.c:429
> kasan_report+0x8a/0x1b0 mm/kasan/report.c:491
> copy_gadget_strings drivers/usb/gadget/composite.c:1363 [inline]
> usb_gstrings_attach+0x770/0x890 drivers/usb/gadget/composite.c:1417
> configfs_composite_bind+0xd0b/0x11b0 drivers/usb/gadget/configfs.c:1382
> udc_bind_to_driver+0x1f4/0x7b0 drivers/usb/gadget/udc/core.c:1504
> usb_gadget_probe_driver+0x335/0x410 drivers/usb/gadget/udc/core.c:1571
> gadget_dev_desc_UDC_store+0x17b/0x220 drivers/usb/gadget/configfs.c:287
> flush_write_buffer fs/configfs/file.c:207 [inline]
> configfs_write_iter+0x2ea/0x480 fs/configfs/file.c:229
> call_write_iter include/linux/fs.h:2050 [inline]
> new_sync_write+0x393/0x570 fs/read_write.c:504
> vfs_write+0x7c4/0xab0 fs/read_write.c:591
> ksys_write+0x127/0x250 fs/read_write.c:644
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f37a0bd5a37
> Code: 89 c7 48 8b 43 08 eb c9 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
> 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff4
> RSP: 002b:00007fffba5008d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f37a0bd5a37
> RDX: 000000000000000b RSI: 0000555555f123f0 RDI: 0000000000000003
> RBP: 0000555555f123f0 R08: 0000000000000000 R09: 00007f37a0cc6c00
> R10: 00007f37a0cc6500 R11: 0000000000000246 R12: 000000000000000b
> R13: 0000555555f11e10 R14: 00007f37a0cc7c20 R15: 00007f37a0cc77a0
> </TASK>
>
> Allocated by task 9457:
> kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> kasan_set_track mm/kasan/common.c:45 [inline]
> set_alloc_info mm/kasan/common.c:436 [inline]
> ____kasan_kmalloc mm/kasan/common.c:515 [inline]
> ____kasan_kmalloc mm/kasan/common.c:474 [inline]
> __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
> kasan_kmalloc include/linux/kasan.h:234 [inline]
> kmem_cache_alloc_trace+0x1f4/0x460 mm/slub.c:3258
> kmalloc include/linux/slab.h:581 [inline]
> kzalloc include/linux/slab.h:714 [inline]
> gadget_config_name_strings_make+0x50/0x370 drivers/usb/gadget/configfs.c:=
673
> configfs_mkdir+0x46a/0xb90 fs/configfs/dir.c:1327
> vfs_mkdir+0x620/0x980 fs/namei.c:3931
> do_mkdirat+0x242/0x2b0 fs/namei.c:3957
> __do_sys_mkdir fs/namei.c:3977 [inline]
> __se_sys_mkdir fs/namei.c:3975 [inline]
> __x64_sys_mkdir+0x61/0x80 fs/namei.c:3975
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Freed by task 9467:
> kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> kasan_set_track+0x21/0x30 mm/kasan/common.c:45
> kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
> ____kasan_slab_free mm/kasan/common.c:366 [inline]
> ____kasan_slab_free mm/kasan/common.c:328 [inline]
> __kasan_slab_free+0x11d/0x190 mm/kasan/common.c:374
> kasan_slab_free include/linux/kasan.h:200 [inline]
> slab_free_hook mm/slub.c:1728 [inline]
> slab_free_freelist_hook mm/slub.c:1754 [inline]
> slab_free mm/slub.c:3510 [inline]
> kfree+0xec/0x4b0 mm/slub.c:4552
> config_item_cleanup fs/configfs/item.c:128 [inline]
> config_item_release+0x11d/0x2f0 fs/configfs/item.c:137
> kref_put include/linux/kref.h:65 [inline]
> config_item_put+0x7c/0xa0 fs/configfs/item.c:149
> configfs_rmdir+0x69f/0xa70 fs/configfs/dir.c:1538
> vfs_rmdir fs/namei.c:4017 [inline]
> vfs_rmdir+0x2a0/0x640 fs/namei.c:3994
> do_rmdir+0x328/0x390 fs/namei.c:4078
> __do_sys_rmdir fs/namei.c:4097 [inline]
> __se_sys_rmdir fs/namei.c:4095 [inline]
> __x64_sys_rmdir+0x3e/0x50 fs/namei.c:4095
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Last potentially related work creation:
> kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
> insert_work+0x4a/0x390 kernel/workqueue.c:1358
> __queue_work+0x4dd/0x1140 kernel/workqueue.c:1517
> queue_work_on+0xee/0x110 kernel/workqueue.c:1545
> queue_work include/linux/workqueue.h:502 [inline]
> call_usermodehelper_exec+0x1cc/0x490 kernel/umh.c:435
> kobject_uevent_env+0xf28/0x1660 lib/kobject_uevent.c:618
> rx_queue_add_kobject net/core/net-sysfs.c:1061 [inline]
> net_rx_queue_update_kobjects+0xf8/0x500 net/core/net-sysfs.c:1101
> register_queue_kobjects net/core/net-sysfs.c:1761 [inline]
> netdev_register_kobject+0x278/0x430 net/core/net-sysfs.c:2012
> register_netdevice+0xb60/0x1290 net/core/dev.c:9961
> register_netdev+0x2d/0x50 net/core/dev.c:10087
> gether_register_netdev+0xc6/0x150 drivers/usb/gadget/function/u_ether.c:8=
77
> rndis_bind+0x218/0x1060 drivers/usb/gadget/function/f_rndis.c:706
> usb_add_function+0x217/0x930 drivers/usb/gadget/composite.c:337
> configfs_composite_bind+0x8b6/0x11b0 drivers/usb/gadget/configfs.c:1392
> udc_bind_to_driver+0x1f4/0x7b0 drivers/usb/gadget/udc/core.c:1504
> usb_gadget_probe_driver+0x335/0x410 drivers/usb/gadget/udc/core.c:1571
> gadget_dev_desc_UDC_store+0x17b/0x220 drivers/usb/gadget/configfs.c:287
> flush_write_buffer fs/configfs/file.c:207 [inline]
> configfs_write_iter+0x2ea/0x480 fs/configfs/file.c:229
> call_write_iter include/linux/fs.h:2050 [inline]
> new_sync_write+0x393/0x570 fs/read_write.c:504
> vfs_write+0x7c4/0xab0 fs/read_write.c:591
> ksys_write+0x127/0x250 fs/read_write.c:644
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Second to last potentially related work creation:
> kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
> insert_work+0x4a/0x390 kernel/workqueue.c:1358
> __queue_work+0x4dd/0x1140 kernel/workqueue.c:1517
> queue_work_on+0xee/0x110 kernel/workqueue.c:1545
> queue_work include/linux/workqueue.h:502 [inline]
> call_usermodehelper_exec+0x1cc/0x490 kernel/umh.c:435
> kobject_uevent_env+0xf28/0x1660 lib/kobject_uevent.c:618
> netdev_queue_add_kobject net/core/net-sysfs.c:1664 [inline]
> netdev_queue_update_kobjects+0x3ba/0x4d0 net/core/net-sysfs.c:1705
> register_queue_kobjects net/core/net-sysfs.c:1766 [inline]
> netdev_register_kobject+0x35d/0x430 net/core/net-sysfs.c:2012
> register_netdevice+0xb60/0x1290 net/core/dev.c:9961
> register_netdev+0x2d/0x50 net/core/dev.c:10087
> gether_register_netdev+0xc6/0x150 drivers/usb/gadget/function/u_ether.c:8=
77
> rndis_bind+0x218/0x1060 drivers/usb/gadget/function/f_rndis.c:706
> usb_add_function+0x217/0x930 drivers/usb/gadget/composite.c:337
> configfs_composite_bind+0x8b6/0x11b0 drivers/usb/gadget/configfs.c:1392
> udc_bind_to_driver+0x1f4/0x7b0 drivers/usb/gadget/udc/core.c:1504
> usb_gadget_probe_driver+0x335/0x410 drivers/usb/gadget/udc/core.c:1571
> gadget_dev_desc_UDC_store+0x17b/0x220 drivers/usb/gadget/configfs.c:287
> flush_write_buffer fs/configfs/file.c:207 [inline]
> configfs_write_iter+0x2ea/0x480 fs/configfs/file.c:229
> call_write_iter include/linux/fs.h:2050 [inline]
> new_sync_write+0x393/0x570 fs/read_write.c:504
> vfs_write+0x7c4/0xab0 fs/read_write.c:591
> ksys_write+0x127/0x250 fs/read_write.c:644
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> The buggy address belongs to the object at ffff888106455b00
> which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 0 bytes inside of
> 192-byte region [ffff888106455b00, ffff888106455bc0)
>
> The buggy address belongs to the physical page:
> page:ffffea0004191540 refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x106455
> flags: 0x57ff00000000200(slab|node=3D1|zone=3D2|lastcpupid=3D0x7ff)
> raw: 057ff00000000200 0000000000000000 dead000000000001 ffff888011842a00
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask
> 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1
> (swapper/0), ts 187410560
> set_page_owner include/linux/page_owner.h:31 [inline]
> post_alloc_hook mm/page_alloc.c:2434 [inline]
> prep_new_page+0x297/0x330 mm/page_alloc.c:2441
> get_page_from_freelist+0x210e/0x3ab0 mm/page_alloc.c:4182
> __alloc_pages+0x30c/0x6e0 mm/page_alloc.c:5408
> alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2104
> alloc_pages+0x1f4/0x250 mm/mempolicy.c:2267
> alloc_slab_page mm/slub.c:1799 [inline]
> allocate_slab mm/slub.c:1944 [inline]
> new_slab+0x2a9/0x3f0 mm/slub.c:2004
> ___slab_alloc+0xc62/0x1080 mm/slub.c:3005
> __slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3092
> slab_alloc_node mm/slub.c:3183 [inline]
> slab_alloc mm/slub.c:3225 [inline]
> kmem_cache_alloc_trace+0x383/0x460 mm/slub.c:3256
> kmalloc include/linux/slab.h:581 [inline]
> kzalloc include/linux/slab.h:714 [inline]
> call_usermodehelper_setup+0x97/0x340 kernel/umh.c:365
> kobject_uevent_env+0xf09/0x1660 lib/kobject_uevent.c:614
> tty_register_device_attr+0x467/0x6f0 drivers/tty/tty_io.c:3274
> tty_register_device drivers/tty/tty_io.c:3188 [inline]
> tty_register_driver+0x42e/0x800 drivers/tty/tty_io.c:3453
> legacy_pty_init drivers/tty/pty.c:589 [inline]
> pty_init+0x675/0xe56 drivers/tty/pty.c:953
> do_one_initcall+0x103/0x650 init/main.c:1298
> do_initcall_level init/main.c:1371 [inline]
> do_initcalls init/main.c:1387 [inline]
> do_basic_setup init/main.c:1406 [inline]
> kernel_init_freeable+0x6c3/0x74c init/main.c:1613
> page_owner free stack trace missing
>
> Memory state around the buggy address:
> ffff888106455a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff888106455a80: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff888106455b00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ^
> ffff888106455b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff888106455c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ```
