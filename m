Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B0A56A810
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiGGQ2S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Jul 2022 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGGQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:28:16 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC94D172
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:28:14 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l4-20020a056e021aa400b002dab8f7402dso9620388ilv.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=5OjmohO35U7cb/qEuhbxJM65OOjh04xt8ylTj5KlNdo=;
        b=ufxjfzOSBhPJMHExYE6OxDsCok9m20nrl7TLFDcqBN0LbuzSLK+mdQJqUwgqX0O5dg
         FGKJXQEAa+DOp33YwBv410fefjUo7fKU767gNTaUFnCkuzTysKFbTAV85JqSL1ROCVQH
         ijUneBCiTpiq9c+ND5S85X4zITCaz/DtDskJdfF8PBCDY8Qz7FxeIeq4FPpxsbJ/KEHT
         R48XAju8a+tvNvgLr5lyhZi2N3MF9hqonZ4JsPDuCROTPFYKBltwqgaslFuoJSHxafz8
         CX1eeUf+mwJThibxx5UjyFUbezo57pnkB/GU68BMZJfairwOSm3UxcT0v/RmSCHF9IUh
         fTmQ==
X-Gm-Message-State: AJIora+F9D1Qglx1E/fwoFXmxcPpRxbaitGcSx++6RbPG6pfvZ1tIRFk
        UQt83B+4945ZDWx0YWCVPlarPnExbw2XgEe95VvGT3jkUPDZ
X-Google-Smtp-Source: AGRyM1vEnkALVT6QetMT+y2ryzTsmSWdojcaZv1LIZPVu2yWzpmTgR4k//nJwZCtB+N6b4jZ0M25DonTb07qcYXKwQIbPRmts5zi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1412:b0:33c:8dcd:56e6 with SMTP id
 k18-20020a056638141200b0033c8dcd56e6mr28102980jad.86.1657211293383; Thu, 07
 Jul 2022 09:28:13 -0700 (PDT)
Date:   Thu, 07 Jul 2022 09:28:13 -0700
In-Reply-To: <181d96ca20b.6fc4a90525206.7370482761379113134@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075c37e05e3399211@google.com>
Subject: Re: [syzbot] linux-next boot error: general protection fault in add_mtd_device
From:   syzbot <syzbot+fe013f55a2814a9e8cfd@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-next@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

6.6.0
[    3.293811][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.296985][    T1] FS-Cache: Loaded
[    3.299821][    T1] CacheFiles: Loaded
[    3.301735][    T1] TOMOYO: 2.6.0
[    3.303022][    T1] Mandatory Access Control activated.
[    3.308387][    T1] AppArmor: AppArmor Filesystem Enabled
[    3.310932][    T1] pnp: PnP ACPI init
[    3.333081][    T1] pnp: PnP ACPI: found 7 devices
[    3.387288][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.391662][    T1] NET: Registered PF_INET protocol family
[    3.397452][    T1] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    3.412428][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, vmalloc)
[    3.416351][    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
[    3.421360][    T1] TCP established hash table entries: 65536 (order: 7, 524288 bytes, vmalloc)
[    3.430604][    T1] TCP bind hash table entries: 65536 (order: 10, 4718592 bytes, vmalloc hugepage)
[    3.438876][    T1] TCP: Hash tables configured (established 65536 bind 65536)
[    3.444254][    T1] MPTCP token hash table entries: 8192 (order: 7, 720896 bytes, vmalloc)
[    3.450021][    T1] UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    3.455480][    T1] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    3.459868][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.464349][    T1] RPC: Registered named UNIX socket transport module.
[    3.466551][    T1] RPC: Registered udp transport module.
[    3.468052][    T1] RPC: Registered tcp transport module.
[    3.469630][    T1] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.474445][    T1] NET: Registered PF_XDP protocol family
[    3.476136][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.478533][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    3.480808][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.483102][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfefff window]
[    3.486449][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.488875][    T1] PCI: CLS 0 bytes, default 64
[    3.490261][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.492502][    T1] software IO TLB: mapped [mem 0x00000000b5a00000-0x00000000b9a00000] (64MB)
[    3.495480][    T1] ACPI: bus type thunderbolt registered
[    3.509757][   T57] kworker/u4:1 (57) used greatest stack depth: 27256 bytes left
[    3.511725][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    3.539645][    T1] kvm: already loaded vendor module 'kvm_intel'
[    3.541703][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb700c3c76, max_idle_ns: 440795286388 ns
[    3.545330][    T1] clocksource: Switched to clocksource tsc
[    3.555572][   T62] kworker/u4:4 (62) used greatest stack depth: 26864 bytes left
[    7.007347][    T1] Initialise system trusted keyrings
[    7.010222][    T1] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    7.053672][    T1] zbud: loaded
[    7.062452][    T1] DLM installed
[    7.071357][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.083415][    T1] NFS: Registering the id_resolver key type
[    7.084569][    T1] Key type id_resolver registered
[    7.085956][    T1] Key type id_legacy registered
[    7.087430][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.088957][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    7.090898][    T1] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    7.099997][    T1] Key type cifs.spnego registered
[    7.101124][    T1] Key type cifs.idmap registered
[    7.102589][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[    7.104795][    T1] ntfs3: Max link count 4000
[    7.105478][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    7.106598][    T1] ntfs3: Read-only LZX/Xpress compression included
[    7.110177][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[    7.112037][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    7.117328][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    7.119672][    T1] QNX4 filesystem 0.2.3 registered.
[    7.121322][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    7.123668][    T1] fuse: init (API version 7.36)
[    7.128698][    T1] orangefs_debugfs_init: called with debug mask: :none: :0:
[    7.130627][    T1] orangefs_init: module version upstream loaded
[    7.132582][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[    7.151005][    T1] SGI XFS with ACLs, security attributes, realtime, quota, fatal assert, debug enabled
[    7.165385][    T1] 9p: Installing v9fs 9p2000 file system support
[    7.168114][    T1] NILFS version 2 loaded
[    7.168946][    T1] befs: version: 0.9.3
[    7.171224][    T1] ocfs2: Registered cluster interface o2cb
[    7.172474][    T1] ocfs2: Registered cluster interface user
[    7.174608][    T1] OCFS2 User DLM kernel interface loaded
[    7.186651][    T1] gfs2: GFS2 installed
[    7.200575][    T1] ceph: loaded (mds proto 32)
[    7.214141][    T1] NET: Registered PF_ALG protocol family
[    7.215457][    T1] xor: automatically using best checksumming function   avx       
[    7.216575][    T1] async_tx: api initialized (async)
[    7.217530][    T1] Key type asymmetric registered
[    7.218239][    T1] Asymmetric key parser 'x509' registered
[    7.219470][    T1] Asymmetric key parser 'pkcs8' registered
[    7.220454][    T1] Key type pkcs7_test registered
[    7.224877][    T1] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    7.226248][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
[    7.228234][    T1] io scheduler mq-deadline registered
[    7.229517][    T1] io scheduler kyber registered
[    7.231202][    T1] io scheduler bfq registered
[    7.246749][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    7.259853][    T1] ACPI: button: Power Button [PWRF]
[    7.262507][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    7.265778][    T1] ACPI: button: Sleep Button [SLPF]
[    7.292165][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    7.293783][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
[    7.313174][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[    7.314393][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
[    7.333582][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    7.334602][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
[    7.348953][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
[    7.771530][    T1] N_HDLC line discipline registered with maxframe=4096
[    7.772933][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.774539][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    7.783403][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    7.791265][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
[    7.797093][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
[    7.809304][    T1] Non-volatile memory driver v1.3
[    7.827944][    T1] Linux agpgart interface v0.103
[    7.833603][    T1] ACPI: bus type drm_connector registered
[    7.838434][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[    7.845071][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
[    7.907391][    T1] Console: switching to colour frame buffer device 128x48
[    7.925767][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
[    7.927589][    T1] usbcore: registered new interface driver udl
[    7.989754][    T1] brd: module loaded
[    8.050181][    T1] loop: module loaded
[    8.135078][    T1] zram: Added device: zram0
[    8.143367][    T1] null_blk: disk nullb0 created
[    8.144480][    T1] null_blk: module loaded
[    8.145538][    T1] Guest personality initialized and is inactive
[    8.147216][    T1] VMCI host device registered (name=vmci, major=10, minor=119)
[    8.148573][    T1] Initialized host personality
[    8.149563][    T1] usbcore: registered new interface driver rtsx_usb
[    8.151595][    T1] usbcore: registered new interface driver viperboard
[    8.153227][    T1] usbcore: registered new interface driver dln2
[    8.154829][    T1] usbcore: registered new interface driver pn533_usb
[    8.161056][    T1] nfcsim 0.2 initialized
[    8.162049][    T1] usbcore: registered new interface driver port100
[    8.163368][    T1] usbcore: registered new interface driver nfcmrvl
[    8.167580][    T1] Loading iSCSI transport class v2.0-870.
[    8.202542][    T1] scsi host0: Virtio SCSI HBA
[    8.248257][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    8.251625][   T46] scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
[    8.289244][    T1] Rounding down aligned max_sectors from 4294967295 to 4294967288
[    8.291872][    T1] db_root: cannot open: /etc/target
[    8.294506][    T1] slram: not enough parameters.
[    8.301140][    T1] general protection fault, probably for non-canonical address 0xdffffc00000000ac: 0000 [#1] PREEMPT SMP KASAN
[    8.303611][    T1] KASAN: null-ptr-deref in range [0x0000000000000560-0x0000000000000567]
[    8.305651][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc5-next-20220707-syzkaller #0
[    8.308417][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
[    8.308417][    T1] RIP: 0010:add_mtd_device+0xbc8/0x1520
[    8.308417][    T1] Code: 48 81 fd 60 fe ff ff 0f 84 90 fd ff ff e8 30 9a 95 fc 48 8d bd 60 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 da 08 00 00 48 8b ad 60 05 00 00 48 85 ed 0f 84
[    8.308417][    T1] RSP: 0000:ffffc90000067c98 EFLAGS: 00010206
[    8.308417][    T1] RAX: dffffc0000000000 RBX: ffff8881472e2000 RCX: 0000000000000000
[    8.308417][    T1] RDX: 00000000000000ac RSI: ffffffff84e5ed10 RDI: 0000000000000560
[    8.308417][    T1] RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
[    8.308417][    T1] R10: ffffffff89e00000 R11: 0000000000000000 R12: ffff8881472e2004
[    8.308417][    T1] R13: ffff8881472e2028 R14: 0000000000000000 R15: 0000000005a00000
[    8.308417][    T1] FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
[    8.308417][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.308417][    T1] CR2: 0000000000000000 CR3: 000000000bc8e000 CR4: 00000000003506e0
[    8.308417][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    8.308417][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    8.308417][    T1] Call Trace:
[    8.308417][    T1]  <TASK>
[    8.308417][    T1]  ? del_mtd_partitions+0x50/0x50
[    8.308417][    T1]  ? lockdep_init_map_type+0x21a/0x7f0
[    8.308417][    T1]  ? mtd_erase+0x8e0/0x8e0
[    8.308417][    T1]  ? lockdep_init_map_type+0x21a/0x7f0
[    8.308417][    T1]  ? __raw_spin_lock_init+0x36/0x110
[    8.308417][    T1]  mtd_device_parse_register+0x50c/0x850
[    8.308417][    T1]  mtdram_init_device+0x291/0x350
[    8.308417][    T1]  ? init_phram+0x99/0x99
[    8.308417][    T1]  init_mtdram+0xe5/0x177
[    8.308417][    T1]  ? init_phram+0x99/0x99
[    8.308417][    T1]  do_one_initcall+0xfe/0x650
[    8.308417][    T1]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[    8.308417][    T1]  ? parameq+0x120/0x170
[    8.308417][    T1]  kernel_init_freeable+0x6b1/0x73a
[    8.308417][    T1]  ? rest_init+0x270/0x270
[    8.308417][    T1]  kernel_init+0x1a/0x1d0
[    8.308417][    T1]  ? rest_init+0x270/0x270
[    8.308417][    T1]  ret_from_fork+0x1f/0x30
[    8.308417][    T1]  </TASK>
[    8.308417][    T1] Modules linked in:
[    8.354639][    T1] ---[ end trace 0000000000000000 ]---
[    8.356288][    T1] RIP: 0010:add_mtd_device+0xbc8/0x1520
[    8.358068][    T1] Code: 48 81 fd 60 fe ff ff 0f 84 90 fd ff ff e8 30 9a 95 fc 48 8d bd 60 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 da 08 00 00 48 8b ad 60 05 00 00 48 85 ed 0f 84
[    8.364455][    T1] RSP: 0000:ffffc90000067c98 EFLAGS: 00010206
[    8.366307][    T1] RAX: dffffc0000000000 RBX: ffff8881472e2000 RCX: 0000000000000000
[    8.368860][    T1] RDX: 00000000000000ac RSI: ffffffff84e5ed10 RDI: 0000000000000560
[    8.371267][    T1] RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
[    8.373529][    T1] R10: ffffffff89e00000 R11: 0000000000000000 R12: ffff8881472e2004
[    8.376204][    T1] R13: ffff8881472e2028 R14: 0000000000000000 R15: 0000000005a00000
[    8.378489][    T1] FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
[    8.381365][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.383439][    T1] CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
[    8.385780][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    8.388324][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    8.390899][    T1] Kernel panic - not syncing: Fatal exception
[    8.393182][    T1] Kernel Offset: disabled
[    8.394024][    T1] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build360636327=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at bff65f44b
nothing to commit, working tree clean


go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=bff65f44b47bd73f56c3d6a5c3899de5f5775136 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220704-135716'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=bff65f44b47bd73f56c3d6a5c3899de5f5775136 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220704-135716'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=bff65f44b47bd73f56c3d6a5c3899de5f5775136 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220704-135716'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"bff65f44b47bd73f56c3d6a5c3899de5f5775136\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=1521cd5c080000


Tested on:

commit:         75d7bf5e Add linux-next specific files for 20220707
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=12690a05d4f2fc33
dashboard link: https://syzkaller.appspot.com/bug?extid=fe013f55a2814a9e8cfd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
