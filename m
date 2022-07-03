Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E62564562
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiGCGZN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Jul 2022 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCGZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 02:25:11 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6747AE6C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 23:25:08 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id o11-20020a6bcf0b000000b0067328c4275bso3953482ioa.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 23:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=c2W3iFFLUiMj06wBAE+U0iUv4uveO7u70g/ONx5s5OQ=;
        b=BeuIFF7f4VOPNJS7fneWK0QdTrMSEyCOj1pOnPlUIMZCQXaYZXMc/TS5yZgoOMud4w
         TnvxBJDK4aG/oI6+cNbxfiU9cN5x9UF6h5y5zdLm5pkr3szmN7zv98jWp61QnD9l5Wym
         t8RR0Fcl09Kt4trXtBU0K0CZ1hFqEo1wBAXwQSumKUXVBBZECOsY7RbUeIp7pSZbSinI
         6gybR8dgbKPhsf7XwgFVxeQqs7wUx4P61TkX7ONEvIz0sVJiwRJ8pKhO0zpZUXjE7o5p
         yFVc7oevBKUKKwnTQzhlt2cq11YtR4jV4QlwcxZcUQxN/uEXW0SoRRdAzdp0waHyqDAa
         pKMA==
X-Gm-Message-State: AJIora/4FYMLghOhTsi2mnGhvtZN7Fu5lV/ye8aKx7rTOlozlW6q2NU5
        kkFUy+DD4223bPR4MnQJ5lt7JWxzFGMGziTH6wouQ2ap2fxl
X-Google-Smtp-Source: AGRyM1sZ1T9zS4C+1dDF8QeHv4gC8sLn+siD7Fj8xix6000cFMQy4gjUaCPUIyQEgQtC9JOsqFw52CCYs/VVfTVSJj6wb/SlB0Vj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:388e:b0:33c:b603:516 with SMTP id
 b14-20020a056638388e00b0033cb6030516mr13903007jav.133.1656829508046; Sat, 02
 Jul 2022 23:25:08 -0700 (PDT)
Date:   Sat, 02 Jul 2022 23:25:08 -0700
In-Reply-To: <20220703003956.965-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047d5ea05e2e0aede@google.com>
Subject: Re: [syzbot] INFO: task hung in do_read_cache_folio
From:   syzbot <syzbot+be946efe33b2d9664348@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

77][    T1] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    2.362158][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.364873][    T1] RPC: Registered named UNIX socket transport module.
[    2.365877][    T1] RPC: Registered udp transport module.
[    2.366631][    T1] RPC: Registered tcp transport module.
[    2.367410][    T1] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.370320][    T1] NET: Registered PF_XDP protocol family
[    2.371131][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.372238][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.373216][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.374290][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfefff window]
[    2.376304][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    2.377453][    T1] PCI: CLS 0 bytes, default 64
[    2.383304][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.384474][    T1] software IO TLB: mapped [mem 0x00000000b5a00000-0x00000000b9a00000] (64MB)
[    2.385755][    T1] ACPI: bus type thunderbolt registered
[    2.394707][    T1] kvm: no hardware support for 'kvm_intel'
[    2.395523][    T1] has_svm: svm not available
[    2.396210][    T1] kvm: no hardware support for 'kvm_amd'
[    2.397006][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x206eb2111f5, max_idle_ns: 440795222471 ns
[    2.399479][   T56] kworker/u4:1 (56) used greatest stack depth: 27744 bytes left
[    2.401142][    T1] clocksource: Switched to clocksource tsc
[    2.414938][   T61] kworker/u4:1 (61) used greatest stack depth: 26920 bytes left
[    5.312580][    T1] Initialise system trusted keyrings
[    5.314897][    T1] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    5.348172][    T1] zbud: loaded
[    5.355655][    T1] DLM installed
[    5.361452][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    5.370982][    T1] NFS: Registering the id_resolver key type
[    5.372080][    T1] Key type id_resolver registered
[    5.372815][    T1] Key type id_legacy registered
[    5.373771][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    5.374910][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    5.376045][    T1] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    5.383700][    T1] Key type cifs.spnego registered
[    5.384564][    T1] Key type cifs.idmap registered
[    5.385712][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[    5.387534][    T1] ntfs3: Max link count 4000
[    5.388172][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    5.388984][    T1] ntfs3: Read-only LZX/Xpress compression included
[    5.391202][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[    5.392215][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    5.396546][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    5.397834][    T1] QNX4 filesystem 0.2.3 registered.
[    5.398847][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    5.400490][    T1] fuse: init (API version 7.36)
[    5.404181][    T1] orangefs_debugfs_init: called with debug mask: :none: :0:
[    5.405575][    T1] orangefs_init: module version upstream loaded
[    5.407203][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[    5.419901][    T1] SGI XFS with ACLs, security attributes, realtime, quota, fatal assert, debug enabled
[    5.431399][    T1] 9p: Installing v9fs 9p2000 file system support
[    5.433445][    T1] NILFS version 2 loaded
[    5.434036][    T1] befs: version: 0.9.3
[    5.436837][    T1] ocfs2: Registered cluster interface o2cb
[    5.437963][    T1] ocfs2: Registered cluster interface user
[    5.439235][    T1] OCFS2 User DLM kernel interface loaded
[    5.448869][    T1] gfs2: GFS2 installed
[    5.460150][    T1] ceph: loaded (mds proto 32)
[    5.471273][    T1] NET: Registered PF_ALG protocol family
[    5.472216][    T1] xor: automatically using best checksumming function   avx       
[    5.473484][    T1] async_tx: api initialized (async)
[    5.474262][    T1] Key type asymmetric registered
[    5.475158][    T1] Asymmetric key parser 'x509' registered
[    5.475957][    T1] Asymmetric key parser 'pkcs8' registered
[    5.476750][    T1] Key type pkcs7_test registered
[    5.480210][    T1] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    5.483969][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
[    5.484917][  T137] kworker/u4:2 (137) used greatest stack depth: 26816 bytes left
[    5.486472][    T1] io scheduler mq-deadline registered
[    5.489234][    T1] io scheduler kyber registered
[    5.490614][    T1] io scheduler bfq registered
[    5.503834][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    5.545233][    T1] ACPI: button: Power Button [PWRF]
[    5.546867][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    5.548614][    T1] ACPI: button: Sleep Button [SLPF]
[    5.566119][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    5.566992][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
[    5.579637][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[    5.580460][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
[    5.593843][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    5.595120][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
[    5.887643][    T1] N_HDLC line discipline registered with maxframe=4096
[    5.888706][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    5.890475][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    5.896315][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    5.900856][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
[    5.906084][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
[    5.920797][    T1] Non-volatile memory driver v1.3
[    5.930201][    T1] Linux agpgart interface v0.103
[    5.933661][    T1] ACPI: bus type drm_connector registered
[    5.937360][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[    5.941912][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
[    5.997414][    T1] Console: switching to colour frame buffer device 128x48
[    6.015050][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
[    6.016246][    T1] usbcore: registered new interface driver udl
[    6.025204][    T1] page:ffffea0000736380 refcount:4 mapcount:0 mapping:ffff888140c812f8 index:0x0 pfn:0x1cd8e
[    6.026731][    T1] memcg:ffff888140150000
[    6.027762][    T1] aops:def_blk_aops ino:100000
[    6.029614][    T1] flags: 0xfff00000002004(uptodate|private|node=0|zone=1|lastcpupid=0x7ff)
[    6.031393][    T1] raw: 00fff00000002004 0000000000000000 dead000000000122 ffff888140c812f8
[    6.032603][    T1] raw: 0000000000000000 ffff888011fae000 00000004ffffffff ffff888140150000
[    6.033757][    T1] page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
[    6.035031][    T1] page_owner tracks the page as allocated
[    6.035852][    T1] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x140cc0(GFP_USER|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 6025000746, free_ts 5976256083
[    6.037962][    T1]  get_page_from_freelist+0x1290/0x3b70
[    6.038738][    T1]  __alloc_pages+0x1c7/0x510
[    6.039361][    T1]  alloc_page_interleave+0x1e/0x200
[    6.040066][    T1]  alloc_pages+0x2b1/0x310
[    6.040709][    T1]  folio_alloc+0x1c/0x70
[    6.041292][    T1]  do_read_cache_folio+0x3e6/0x800
[    6.042022][    T1]  read_cache_page+0x59/0x2a0
[    6.042703][    T1]  read_part_sector+0xf6/0x920
[    6.043380][    T1]  adfspart_check_ICS+0x9a/0x690
[    6.044052][    T1]  bdev_disk_changed+0x629/0xf60
[    6.044790][    T1]  blkdev_get_whole+0x18a/0x2d0
[    6.045456][    T1]  blkdev_get_by_dev.part.0+0x5ec/0xb90
[    6.046205][    T1]  blkdev_get_by_dev+0x6b/0x80
[    6.046854][    T1]  disk_scan_partitions+0x16a/0x200
[    6.047561][    T1]  device_add_disk+0xc3e/0xe20
[    6.048211][    T1]  brd_alloc.part.0+0x4db/0x7a0
[    6.048884][    T1] page last free stack trace:
[    6.049552][    T1]  free_pcp_prepare+0x549/0xd20
[    6.050208][    T1]  free_unref_page+0x19/0x6a0
[    6.050881][    T1]  __vunmap+0x85d/0xd30
[    6.051451][    T1]  free_work+0x58/0x70
[    6.052008][    T1]  process_one_work+0x996/0x1610
[    6.052690][    T1]  worker_thread+0x665/0x1080
[    6.053325][    T1]  kthread+0x2e9/0x3a0
[    6.053882][    T1]  ret_from_fork+0x1f/0x30
[    6.054558][    T1] ------------[ cut here ]------------
[    6.055297][    T1] kernel BUG at mm/filemap.c:1557!
[    6.055992][    T1] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[    6.056802][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428-dirty #0
[    6.058413][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
[    6.059746][    T1] RIP: 0010:folio_unlock+0xae/0xc0
[    6.060438][    T1] Code: e8 e7 38 d9 ff 48 89 ef 31 f6 e8 0d f9 ff ff 5b 5d e9 d6 38 d9 ff e8 d1 38 d9 ff 48 c7 c6 20 75 d6 89 48 89 ef e8 72 69 0f 00 <0f> 0b 48 89 df e8 b8 fd 25 00 e9 7c ff ff ff 0f 1f 00 41 57 41 56
[    6.063239][    T1] RSP: 0018:ffffc900000678e0 EFLAGS: 00010293
[    6.064086][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    6.064499][    T1] RDX: ffff888140170000 RSI: ffffffff81a12dee RDI: 0000000000000003
[    6.064499][    T1] RBP: ffffea0000736380 R08: 0000000000000003 R09: 000000000000ffff
[    6.064499][    T1] R10: 000000000000ffff R11: 0000000000000001 R12: 0000000000000000
[    6.064499][    T1] R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88801cdbc180
[    6.064499][    T1] FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
[    6.064499][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.064499][    T1] CR2: ffff88823ffff000 CR3: 000000000ba8e000 CR4: 0000000000350ef0
[    6.064499][    T1] Call Trace:
[    6.064499][    T1]  <TASK>
[    6.064499][    T1]  do_read_cache_folio+0x2f7/0x800
[    6.064499][    T1]  ? blkdev_writepages+0x20/0x20
[    6.064499][    T1]  read_cache_page+0x59/0x2a0
[    6.064499][    T1]  read_part_sector+0xf6/0x920
[    6.064499][    T1]  ? adfspart_check_ADFS+0x410/0x410
[    6.064499][    T1]  adfspart_check_ICS+0x9a/0x690
[    6.064499][    T1]  ? __alloc_pages_slowpath.constprop.0+0x2160/0x2160
[    6.064499][    T1]  ? adfspart_check_ADFS+0x410/0x410
[    6.064499][    T1]  ? snprintf+0xbb/0xf0
[    6.064499][    T1]  ? vsprintf+0x30/0x30
[    6.064499][    T1]  ? preempt_count_add+0x74/0x140
[    6.064499][    T1]  ? alloc_page_interleave+0x89/0x200
[    6.064499][    T1]  ? alloc_pages+0x1b2/0x310
[    6.064499][    T1]  ? adfspart_check_ADFS+0x410/0x410
[    6.064499][    T1]  bdev_disk_changed+0x629/0xf60
[    6.064499][    T1]  ? iput.part.0+0x73/0x820
[    6.064499][    T1]  blkdev_get_whole+0x18a/0x2d0
[    6.064499][    T1]  blkdev_get_by_dev.part.0+0x5ec/0xb90
[    6.064499][    T1]  ? devcgroup_check_permission+0x1ab/0x440
[    6.064499][    T1]  blkdev_get_by_dev+0x6b/0x80
[    6.064499][    T1]  disk_scan_partitions+0x16a/0x200
[    6.064499][    T1]  device_add_disk+0xc3e/0xe20
[    6.064499][    T1]  brd_alloc.part.0+0x4db/0x7a0
[    6.064499][    T1]  ? brd_lookup_page+0x1d0/0x1d0
[    6.064499][    T1]  ? up_write+0x148/0x470
[    6.064499][    T1]  ? ramdisk_size+0x23/0x23
[    6.064499][    T1]  brd_init+0x1b8/0x24b
[    6.064499][    T1]  ? ramdisk_size+0x23/0x23
[    6.064499][    T1]  do_one_initcall+0x103/0x650
[    6.064499][    T1]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[    6.064499][    T1]  ? parameq+0xe0/0x170
[    6.064499][    T1]  kernel_init_freeable+0x6b1/0x73a
[    6.064499][    T1]  ? rest_init+0x270/0x270
[    6.064499][    T1]  kernel_init+0x1a/0x1d0
[    6.064499][    T1]  ? rest_init+0x270/0x270
[    6.064499][    T1]  ret_from_fork+0x1f/0x30
[    6.064499][    T1]  </TASK>
[    6.064499][    T1] Modules linked in:
[    6.064499][    C0] vkms_vblank_simulate: vblank timer overrun
[    6.103289][    T1] ---[ end trace 0000000000000000 ]---
[    6.104053][    T1] RIP: 0010:folio_unlock+0xae/0xc0
[    6.104844][    T1] Code: e8 e7 38 d9 ff 48 89 ef 31 f6 e8 0d f9 ff ff 5b 5d e9 d6 38 d9 ff e8 d1 38 d9 ff 48 c7 c6 20 75 d6 89 48 89 ef e8 72 69 0f 00 <0f> 0b 48 89 df e8 b8 fd 25 00 e9 7c ff ff ff 0f 1f 00 41 57 41 56
[    6.107744][    T1] RSP: 0018:ffffc900000678e0 EFLAGS: 00010293
[    6.108625][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    6.109722][    T1] RDX: ffff888140170000 RSI: ffffffff81a12dee RDI: 0000000000000003
[    6.110787][    T1] RBP: ffffea0000736380 R08: 0000000000000003 R09: 000000000000ffff
[    6.111842][    T1] R10: 000000000000ffff R11: 0000000000000001 R12: 0000000000000000
[    6.112892][    T1] R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88801cdbc180
[    6.113946][    T1] FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
[    6.115160][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.116058][    T1] CR2: ffff88823ffff000 CR3: 000000000ba8e000 CR4: 0000000000350ef0
[    6.117115][    T1] Kernel panic - not syncing: Fatal exception
[    6.118428][    T1] Kernel Offset: disabled
[    6.119019][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2307476033=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 1434eec0b
nothing to commit, working tree clean


go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1434eec0b84075b7246560cfa89f20cdb3d8077f -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220629-111539'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1434eec0b84075b7246560cfa89f20cdb3d8077f -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220629-111539'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1434eec0b84075b7246560cfa89f20cdb3d8077f -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220629-111539'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"1434eec0b84075b7246560cfa89f20cdb3d8077f\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=1523de50080000


Tested on:

commit:         08986606 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13810a58080000

