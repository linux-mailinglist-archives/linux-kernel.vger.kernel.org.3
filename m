Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A59564605
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiGCIun convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Jul 2022 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiGCIuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:50:12 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3DB497
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:49:14 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id p123-20020a6bbf81000000b00674f66cf13aso4166618iof.23
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 01:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=jKQqHQitM6E9KViDwj3AUPfz5nrF8dPLCuOf+fhmId0=;
        b=epYXplCbSkaXJgypFGXYIVPoRkertGvEhZFjTW/p+Vdc7Udm4SDAzDUcqt95QU37Of
         k9+ES5uTtiTmB3KSfPa59fLpfDxaZpH/TW9tyy/UtiHDhBPoLmT6QYRZo0H3EM9q56bO
         Ys7XxeqnMsVK5+x56nHDnpG8Q8z+RyvTph7Ghv0wwnUVkd1+tfCDZSAa0nIM9Fq10f9u
         GwjN/NazcCnlG8RORT9ushnwC4KJehuqTSccDLf01upethOBFaSnuPjrZvs7yOvqT9hB
         R8Rt0PNdj2ZlYP6ueDLPjjGOwGw2liDuLAaZwT6qH9uAZCqm3eoFQuXRtXU3+U01ixDa
         xcPg==
X-Gm-Message-State: AJIora99oo7DDJWCE4uuUBWiHw4E9PcqVUrztx6LmVvn5vCJZXAuoXZg
        nk6Ci5BH5zDllhFiUNlKlA/jq3fd6K2iYovML6vNzHSidUlL
X-Google-Smtp-Source: AGRyM1uKsSd650onEmwhokJGlimof4O/e2Jz/kg1yTp8MH9POwOZoqEbseiLCF+mmf9kWFyEzkO4q8DW2srWoa5d8nHGZjx70FfM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1924:b0:331:d5de:57ab with SMTP id
 p36-20020a056638192400b00331d5de57abmr14506899jal.261.1656838153576; Sun, 03
 Jul 2022 01:49:13 -0700 (PDT)
Date:   Sun, 03 Jul 2022 01:49:13 -0700
In-Reply-To: <20220703082839.1475-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098258005e2e2b1ad@google.com>
Subject: Re: [syzbot] INFO: task hung in do_read_cache_folio
From:   syzbot <syzbot+be946efe33b2d9664348@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

carl9170
[    7.224316][    T1] usbcore: registered new interface driver ath6kl_usb
[    7.226176][    T1] usbcore: registered new interface driver ar5523
[    7.228878][    T1] usbcore: registered new interface driver ath10k_usb
[    7.231158][    T1] usbcore: registered new interface driver rndis_wlan
[    7.235186][    T1] mac80211_hwsim: initializing netlink
[    7.275724][    T1] usbcore: registered new interface driver atusb
[    7.284965][   T51] sd 0:0:1:0: Attached scsi generic sg0 type 0
[    7.285442][   T11] sd 0:0:1:0: [sda] 4194304 512-byte logical blocks: (2.15 GB/2.00 GiB)
[    7.288346][   T11] sd 0:0:1:0: [sda] 4096-byte physical blocks
[    7.289973][   T11] sd 0:0:1:0: [sda] Write Protect is off
[    7.292209][    T1] mac802154_hwsim mac802154_hwsim: Added 2 mac802154 hwsim hardware radios
[    7.294503][    T1] VMware vmxnet3 virtual NIC driver - version 1.6.0.0-k-NAPI
[    7.295182][   T11] sd 0:0:1:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.296592][    T1] usbcore: registered new interface driver catc
[    7.299610][    T1] usbcore: registered new interface driver kaweth
[    7.300913][    T1] pegasus: Pegasus/Pegasus II USB Ethernet driver
[    7.302324][    T1] usbcore: registered new interface driver pegasus
[    7.305788][    T1] usbcore: registered new interface driver rtl8150
[    7.306978][    T1] usbcore: registered new interface driver r8152
[    7.308016][    T1] hso: drivers/net/usb/hso.c: Option Wireless
[    7.309652][    T1] usbcore: registered new interface driver hso
[    7.311109][    T1] usbcore: registered new interface driver lan78xx
[    7.314468][    T1] usbcore: registered new interface driver asix
[    7.315877][    T1] usbcore: registered new interface driver ax88179_178a
[    7.317274][    T1] usbcore: registered new interface driver cdc_ether
[    7.319460][    T1] usbcore: registered new interface driver cdc_eem
[    7.320991][    T1] usbcore: registered new interface driver dm9601
[    7.322286][    T1] usbcore: registered new interface driver sr9700
[    7.323786][    T1] usbcore: registered new interface driver CoreChips
[    7.325414][    T1] usbcore: registered new interface driver smsc75xx
[    7.327102][    T1] usbcore: registered new interface driver smsc95xx
[    7.328468][    T1] usbcore: registered new interface driver gl620a
[    7.329625][    T1] usbcore: registered new interface driver net1080
[    7.330779][    T1] usbcore: registered new interface driver plusb
[    7.332015][    T1] usbcore: registered new interface driver rndis_host
[    7.333236][    T1] usbcore: registered new interface driver cdc_subset
[    7.334659][    T1] usbcore: registered new interface driver zaurus
[    7.335954][    T1] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
[    7.337391][    T1] usbcore: registered new interface driver int51x1
[    7.338668][    T1] usbcore: registered new interface driver cdc_phonet
[    7.339366][   T11] page:ffffea00007d6d80 refcount:3 mapcount:0 mapping:ffff88801afbeaf8 index:0x0 pfn:0x1f5b6
[    7.340015][    T1] usbcore: registered new interface driver kalmia
[    7.341525][   T11] memcg:ffff888140150000
[    7.342649][    T1] usbcore: registered new interface driver ipheth
[    7.343799][   T11] aops:def_blk_aops ino:800000
[    7.344581][    T1] usbcore: registered new interface driver sierra_net
[    7.345438][   T11] flags: 0xfff00000022014(uptodate|lru|private|mappedtodisk|node=0|zone=1|lastcpupid=0x7ff)
[    7.346374][    T1] usbcore: registered new interface driver cx82310_eth
[    7.348215][   T11] raw: 00fff00000022014 ffff88801187b020 ffff88801187b020 ffff88801afbeaf8
[    7.349448][    T1] usbcore: registered new interface driver cdc_ncm
[    7.350993][   T11] raw: 0000000000000000 ffff888140d0ed98 00000003ffffffff ffff888140150000
[    7.352159][    T1] usbcore: registered new interface driver huawei_cdc_ncm
[    7.355065][   T11] page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
[    7.355279][    T1] usbcore: registered new interface driver lg-vl600
[    7.356618][   T11] page_owner tracks the page as allocated
[    7.357693][    T1] usbcore: registered new interface driver qmi_wwan
[    7.358917][   T11] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x140cc0(GFP_USER|__GFP_COMP), pid 11, tgid 11 (kworker/u4:1), ts 7321931379, free_ts 7056384385
[    7.359590][    T1] usbcore: registered new interface driver cdc_mbim
[    7.362475][   T11]  get_page_from_freelist+0x1290/0x3b70
[    7.364001][    T1] usbcore: registered new interface driver ch9200
[    7.365293][   T11]  __alloc_pages+0x1c7/0x510
[    7.368392][   T11]  alloc_pages+0x1aa/0x310
[    7.369706][   T11]  folio_alloc+0x1c/0x70
[    7.370739][   T11]  do_read_cache_folio+0x358/0x830
[    7.371915][   T11]  read_cache_page+0x59/0x2a0
[    7.372204][    T1] VFIO - User Level meta-driver version: 0.3
[    7.373726][   T11]  read_part_sector+0xf6/0x920
[    7.375164][   T11]  adfspart_check_ICS+0x9a/0x690
[    7.376164][   T11]  bdev_disk_changed+0x629/0xf60
[    7.377277][   T11]  blkdev_get_whole+0x18a/0x2d0
[    7.378416][   T11]  blkdev_get_by_dev.part.0+0x5ec/0xb90
[    7.379331][   T11]  blkdev_get_by_dev+0x6b/0x80
[    7.380230][   T11]  disk_scan_partitions+0x16a/0x200
[    7.381171][   T11]  device_add_disk+0xc3e/0xe20
[    7.382093][   T11]  sd_probe+0xa70/0xfe0
[    7.384040][   T11]  really_probe+0x23e/0xb90
[    7.384708][    T1] aoe: AoE v85 initialised.
[    7.385335][   T11] page last free stack trace:
[    7.388222][   T11]  free_pcp_prepare+0x549/0xd20
[    7.389573][   T11]  free_unref_page+0x19/0x6a0
[    7.390530][   T11]  __vunmap+0x85d/0xd30
[    7.391942][    T1] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    7.392495][   T11]  free_work+0x58/0x70
[    7.395154][   T11]  process_one_work+0x996/0x1610
[    7.395550][    T1] ehci-pci: EHCI PCI platform driver
[    7.395989][   T11]  worker_thread+0x665/0x1080
[    7.397309][    T1] ehci-platform: EHCI generic platform driver
[    7.397849][   T11]  kthread+0x2e9/0x3a0
[    7.399759][    T1] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.401056][    T1] ohci-pci: OHCI PCI platform driver
[    7.401214][   T11]  ret_from_fork+0x1f/0x30
[    7.405495][   T11] ------------[ cut here ]------------
[    7.405849][    T1] ohci-platform: OHCI generic platform driver
[    7.406732][   T11] kernel BUG at mm/filemap.c:1557!
[    7.408179][    T1] uhci_hcd: USB Universal Host Controller Interface driver
[    7.408749][   T11] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[    7.411418][   T11] CPU: 0 PID: 11 Comm: kworker/u4:1 Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428-dirty #0
[    7.411796][    T1] driver u132_hcd
[    7.412861][   T11] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
[    7.412861][   T11] Workqueue: events_unbound async_run_entry_fn
[    7.412861][   T11] RIP: 0010:folio_unlock+0xae/0xc0
[    7.412861][   T11] Code: e8 e7 38 d9 ff 48 89 ef 31 f6 e8 0d f9 ff ff 5b 5d e9 d6 38 d9 ff e8 d1 38 d9 ff 48 c7 c6 20 75 d6 89 48 89 ef e8 a2 69 0f 00 <0f> 0b 48 89 df e8 e8 fd 25 00 e9 7c ff ff ff 0f 1f 00 41 57 41 56
[    7.412861][   T11] RSP: 0018:ffffc900001074d0 EFLAGS: 00010293
[    7.412861][   T11] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    7.412861][   T11] RDX: ffff88813fec3b00 RSI: ffffffff81a12dee RDI: 0000000000000003
[    7.412861][   T11] RBP: ffffea00007d6d80 R08: 0000000000000003 R09: 000000000000ffff
[    7.412861][   T11] R10: 000000000000ffff R11: 0000000000000001 R12: 0000000000000000
[    7.412861][   T11] R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000000000000
[    7.412861][   T11] FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
[    7.412861][   T11] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.412861][   T11] CR2: ffff88823ffff000 CR3: 000000000ba8e000 CR4: 0000000000350ef0
[    7.412861][   T11] Call Trace:
[    7.412861][   T11]  <TASK>
[    7.412861][   T11]  end_buffer_async_read+0x6fe/0xf00
[    7.412861][   T11]  block_read_full_folio+0x687/0xa60
[    7.412861][   T11]  ? blkdev_write_begin+0x40/0x40
[    7.412861][   T11]  ? end_buffer_async_read_io+0x300/0x300
[    7.412861][   T11]  ? folio_flags.constprop.0+0x58/0x150
[    7.412861][   T11]  do_read_cache_folio+0x281/0x830
[    7.412861][   T11]  ? blkdev_writepages+0x20/0x20
[    7.412861][   T11]  read_cache_page+0x59/0x2a0
[    7.412861][   T11]  read_part_sector+0xf6/0x920
[    7.412861][   T11]  ? adfspart_check_ICS+0x690/0x690
[    7.412861][   T11]  adfspart_check_POWERTEC+0x93/0x530
[    7.412861][   T11]  ? __alloc_pages_slowpath.constprop.0+0x2160/0x2160
[    7.412861][   T11]  ? adfspart_check_ADFS+0x410/0x410
[    7.412861][   T11]  ? adfspart_check_ICS+0x690/0x690
[    7.412861][   T11]  ? vsprintf+0x30/0x30
[    7.412861][   T11]  ? alloc_pages+0x1b2/0x310
[    7.412861][   T11]  ? adfspart_check_ICS+0x690/0x690
[    7.412861][   T11]  bdev_disk_changed+0x629/0xf60
[    7.412861][   T11]  blkdev_get_whole+0x18a/0x2d0
[    7.412861][   T11]  blkdev_get_by_dev.part.0+0x5ec/0xb90
[    7.412861][   T11]  ? devcgroup_check_permission+0x1ab/0x440
[    7.412861][   T11]  blkdev_get_by_dev+0x6b/0x80
[    7.412861][   T11]  disk_scan_partitions+0x16a/0x200
[    7.412861][   T11]  device_add_disk+0xc3e/0xe20
[    7.412861][   T11]  sd_probe+0xa70/0xfe0
[    7.412861][   T11]  ? sd_open+0x6d0/0x6d0
[    7.412861][   T11]  really_probe+0x23e/0xb90
[    7.412861][   T11]  __driver_probe_device+0x338/0x4d0
[    7.412861][   T11]  driver_probe_device+0x4c/0x1a0
[    7.412861][   T11]  __device_attach_driver+0x20b/0x2f0
[    7.412861][   T11]  ? driver_allows_async_probing+0x170/0x170
[    7.412861][   T11]  bus_for_each_drv+0x15f/0x1e0
[    7.412861][   T11]  ? bus_for_each_dev+0x1d0/0x1d0
[    7.412861][   T11]  ? _raw_spin_unlock_irqrestore+0x50/0x70
[    7.412861][   T11]  ? lockdep_hardirqs_on+0x79/0x100
[    7.412861][   T11]  ? _raw_spin_unlock_irqrestore+0x3d/0x70
[    7.412861][   T11]  ? device_unbind_cleanup+0x1b0/0x1b0
[    7.412861][   T11]  __device_attach_async_helper+0x1c9/0x280
[    7.412861][   T11]  ? device_unbind_cleanup+0x1b0/0x1b0
[    7.412861][   T11]  ? lockdep_hardirqs_on+0x79/0x100
[    7.412861][   T11]  ? ktime_get+0x38a/0x470
[    7.412861][   T11]  ? ktime_get+0x30b/0x470
[    7.412861][   T11]  async_run_entry_fn+0x9d/0x550
[    7.412861][   T11]  process_one_work+0x996/0x1610
[    7.412861][   T11]  ? pwq_dec_nr_in_flight+0x2a0/0x2a0
[    7.412861][   T11]  ? rwlock_bug.part.0+0x90/0x90
[    7.412861][   T11]  ? _raw_spin_lock_irq+0x41/0x50
[    7.412861][   T11]  worker_thread+0x665/0x1080
[    7.412861][   T11]  ? process_one_work+0x1610/0x1610
[    7.412861][   T11]  kthread+0x2e9/0x3a0
[    7.412861][   T11]  ? kthread_complete_and_exit+0x40/0x40
[    7.412861][   T11]  ret_from_fork+0x1f/0x30
[    7.412861][   T11]  </TASK>
[    7.412861][   T11] Modules linked in:
[    7.412861][    C0] vkms_vblank_simulate: vblank timer overrun
[    7.494800][   T11] ---[ end trace 0000000000000000 ]---
[    7.495791][    T1] fotg210_hcd: FOTG210 Host Controller (EHCI) Driver
[    7.496256][   T11] RIP: 0010:folio_unlock+0xae/0xc0
[    7.497087][    T1] Warning! fotg210_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[    7.497213][    T1] SPI driver max3421-hcd has no spi_device_id for maxim,max3421
[    7.498252][   T11] Code: e8 e7 38 d9 ff 48 89 ef 31 f6 e8 0d f9 ff ff 5b 5d e9 d6 38 d9 ff e8 d1 38 d9 ff 48 c7 c6 20 75 d6 89 48 89 ef e8 a2 69 0f 00 <0f> 0b 48 89 df e8 e8 fd 25 00 e9 7c ff ff ff 0f 1f 00 41 57 41 56
[    7.500298][    T1] usbcore: registered new interface driver cdc_acm
[    7.501805][   T11] RSP: 0018:ffffc900001074d0 EFLAGS: 00010293
[    7.505447][    T1] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    7.507369][   T11] 
[    7.507695][    T1] usbcore: registered new interface driver usblp
[    7.509590][   T11] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    7.510306][    T1] usbcore: registered new interface driver cdc_wdm
[    7.511851][   T11] RDX: ffff88813fec3b00 RSI: ffffffff81a12dee RDI: 0000000000000003
[    7.513320][    T1] usbcore: registered new interface driver usbtmc
[    7.515918][    T1] usbcore: registered new interface driver uas
[    7.516095][   T11] RBP: ffffea00007d6d80 R08: 0000000000000003 R09: 000000000000ffff
[    7.517558][    T1] usbcore: registered new interface driver usb-storage
[    7.518868][   T11] R10: 000000000000ffff R11: 0000000000000001 R12: 0000000000000000
[    7.520464][    T1] usbcore: registered new interface driver ums-alauda
[    7.521492][   T11] R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000000000000
[    7.523238][    T1] usbcore: registered new interface driver ums-cypress
[    7.525495][   T11] FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
[    7.526115][    T1] usbcore: registered new interface driver ums-datafab
[    7.527788][   T11] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.529454][    T1] usbcore: registered new interface driver ums_eneub6250
[    7.531502][   T11] CR2: 0000000000000000 CR3: 000000000ba8e000 CR4: 0000000000350ee0
[    7.531663][    T1] usbcore: registered new interface driver ums-freecom
[    7.533961][   T11] Kernel panic - not syncing: Fatal exception
[    7.535233][   T11] Kernel Offset: disabled
[    7.537875][   T11] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1074279953=/tmp/go-build -gno-record-gcc-switches"

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
https://syzkaller.appspot.com/x/error.txt?x=12cf8297f00000


Tested on:

commit:         08986606 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c005cc080000

