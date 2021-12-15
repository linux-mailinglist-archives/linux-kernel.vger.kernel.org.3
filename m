Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1849C4753D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhLOHgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhLOHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:36:48 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919ACC061401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:36:47 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g17so52642248ybe.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Txey5TvppQ9SxkGwpqzwLxQlcdZEzVzJHYD0usFp+fE=;
        b=HkW/YAda3Xch9wPX1KoVd4el7AGShRTK5LZ82PrDfHAFmSoUfR9xeT4z4HhfFjn88V
         EUOB2G9uAPLksA5lHqL7Kws6W9uB9Ki7W6blpTCh1XuOca+ZNeLYlu24+sTWKe5lfBA9
         GQoMd/xLVNpTQixYcOkZuVzo0oTq4hBVigP9ECxex0FvdjLNiC5EvRnOSD0pqCySpBfh
         1aSolCMRljGTQJidl4IrpR550w5HBKzPsDLq+decB9cQKBQ0EmJuRNzZn8/aqoQpfisn
         MaV3g+P4qUrNbJuLW/AupaQtOxh6rUBzEbLN67HDVuB8IKwqGrizBv7VqZoH25QvywSJ
         PHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Txey5TvppQ9SxkGwpqzwLxQlcdZEzVzJHYD0usFp+fE=;
        b=E6dVDV037sI5VxEDNlllQokmWRqPQXqL0EwgPiefKrwkNkxEA/7EnuBLPuz1k+yXkN
         pv/vE2qqcrKIlLfNw4WgcWd4vIVjonzbRnDXKiYTDFOI17azwmfcDIa7o0vzjRdYTZen
         zuYC7+IZJCvjAUpY3tGEGUd6CffOZ/gUy67foxlxrVUABp4ieNxVsANX+suRJiFVAzyS
         BEEy6eGXOwp+CG9+0J1oOfB9J8z4eBuYIy1BOQ45abD+YQrMNQ/ZxMZOQngYV6uN3w9O
         cLKf3WpGrKZkgK9KN6OqTCA2Wq0C/rcJzThRrvLUwl1Bchmj+SDcbL3bLEnODIhjneWx
         yWXQ==
X-Gm-Message-State: AOAM530dTp1khkjwTkkdUpvp1DqvxfpCBdPdbfQnpQdH0sEOdxx31gml
        vUyfB/GkbxBUo85X1u6OLJPFtJ7v7Qj4YhyXQ3CSZy0HQVI=
X-Google-Smtp-Source: ABdhPJyXIxLgQk+37f6o3LMH5iVK4mSQaoKR8YjiA+k+7SdmhXUJJLbNHiXIi8yFB1p+lCk/rWrqFpUbI6ZUdd7nrQ0=
X-Received: by 2002:a25:8052:: with SMTP id a18mr3893694ybn.634.1639553805205;
 Tue, 14 Dec 2021 23:36:45 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Wed, 15 Dec 2021 07:36:34 +0000
Message-ID: <CAC=wTOhV_QTAbH+u8amNF4+wu6ae5qCLmtWW4Z2zNdVZHrfA=Q@mail.gmail.com>
Subject: ARM64 kernel crash
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please personally cc me on answers/comments as I am not currently
subscribed to the LKML.
Trying again because I messed up the format badly the first time
round. Apologies for that.

My team has a problem which is being bounced between Canonical support
and Xilinx support.
We are using kernel 5.4.0-xilinx-v2020.2 built from sources under
https://github.com/Xilinx/linux-xlnx with a Ubuntu 20.04 userland on
an ARM64 embedded linux machine (i.e. not x86-64). When trying to set
up a file system on a ramdisk, we get a kernel crash for sizes of
ramdisk larger than 2GB while trying to 'dd if=3D/dev/zero ...'  in
preparation for issuing mkfs.
 Some questions:
1) Is it possible that there is an incompatibility between the Ubuntu
userland and the Xilinx kernel ? I think it is not possible to have an
incompatibility here, which would land the support question solidly in
Xilinx' court.
2) Is there a known problem with this kernel level on ARM64 hardware ?
3) Would it be likely to be productive to move to a newer Xilinx kernel ?
4) If I have to debug this myself, where do I start ?

Here is the log from boot until crash

ZynqMP> setenv serverip 9.2.225.84
ZynqMP> setenv ipaddr 9.2.227.19
ZynqMP> setenv gatewayip 9.2.224.2
ZynqMP> setenv netmask 255.255.248.0
ZynqMP> setenv bootcmd "run netboot"
ZynqMP> setenv netstart 0x10000000
ZynqMP> setenv bootargs "console=3DttyPS0,115200n8 root=3D/dev/nfs
rootfstype=3Dnfs nfsroot=3D${serverip}:/export/"
ZynqMP> setenv kernel_img "/tftpboot/cuttlefisharm2/image.ub"
ZynqMP> setenv netboot "tftpboot ${netstart} ${kernel_img} && bootm"
ZynqMP> saveenv
Unknown command 'saveenv' - try 'help'
ZynqMP> run netboot
Using ethernet@ff0e0000 device
TFTP from server 9.2.225.84; our IP address is 9.2.227.19
Filename '/tftpboot/cuttlefisharm2/image.ub'.
Load address: 0x10000000
Loading: #################################################################
         #################################################################
         #################################################################
         ###############################
         2.5 MiB/s
done
Bytes transferred =3D 8478220 (815e0c hex)
## Loading kernel from FIT Image at 10000000 ...
   Using 'conf@system-top.dtb' configuration
   Trying 'kernel@1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  gzip compressed
     Data Start:   0x100000e8
     Data Size:    8444173 Bytes =3D 8.1 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x00080000
     Entry Point:  0x00080000
     Hash algo:    sha256
     Hash value:
6ce5faf07f3c77c3c6775d50bd8eb6feb60c93fe7844430c238b13fe006accf5
   Verifying Hash Integrity ... sha256+ OK
## Loading fdt from FIT Image at 10000000 ...
   Using 'conf@system-top.dtb' configuration
   Trying 'fdt@system-top.dtb' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x1080db08
     Data Size:    32155 Bytes =3D 31.4 KiB
     Architecture: AArch64
     Hash algo:    sha256
     Hash value:
c62ab3c2fb6377746a8709f3ddc20e3f46064514e16cae2795a46a780d020417
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0x1080db08
   Uncompressing Kernel Image
   Loading Device Tree to 000000000fff5000, end 000000000ffffd9a ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.4.0-xilinx-v2020.2 (oe-user@oe-host)
(gcc version 9.2.0 (GCC)) #1 SMP Thu N1
[    0.000000] Machine model: xlnx,zynqmp
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 256 MiB at 0x000000006fc00000
[    0.000000] On node 0 totalpages: 4194048
[    0.000000]   DMA32 zone: 8188 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 524032 pages, LIFO batch:63
[    0.000000]   Normal zone: 57344 pages used for memmap
[    0.000000]   Normal zone: 3670016 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 22 pages/cpu s49880 r8192 d32040 u90112
[    0.000000] pcpu-alloc: s49880 r8192 d32040 u90112 alloc=3D22*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 41285=
16
[    0.000000] Kernel command line: console=3DttyPS0,115200n8
root=3D/dev/nfs rootfstype=3Dnfs nfsroot=3D9.2.225.84
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x6bc00000-0x6fc00000] (64MB)
[    0.000000] Memory: 16110024K/16776192K available (12092K kernel
code, 740K rwdata, 3764K rodata, 768K )
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Adjusting CPU interface base to 0x00000000f902f000
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] random: get_random_bytes called from
start_kernel+0x2a8/0x42c with crng_init=3D0
[    0.000000] arch_timer: cp15 timer(s) running at 33.33MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x7b0074340, max_idle_ns:s
[    0.000003] sched_clock: 56 bits at 33MHz, resolution 30ns, wraps
every 2199023255543ns
[    0.000293] Console: colour dummy device 80x25
[    0.000318] Calibrating delay loop (skipped), value calculated
using timer frequency.. 66.66 BogoMIPS ()
[    0.000326] pid_max: default: 32768 minimum: 301
[    0.000518] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.000568] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.001596] ASID allocator initialised with 32768 entries
[    0.001654] rcu: Hierarchical SRCU implementation.
[    0.001877] EFI services will not be available.
[    0.002015] smp: Bringing up secondary CPUs ...
[    0.002359] Detected VIPT I-cache on CPU1
[    0.002393] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.002763] Detected VIPT I-cache on CPU2
[    0.002782] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.003117] Detected VIPT I-cache on CPU3
[    0.003136] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.003184] smp: Brought up 1 node, 4 CPUs
[    0.003196] SMP: Total of 4 processors activated.
[    0.003201] CPU features: detected: 32-bit EL0 Support
[    0.003206] CPU features: detected: CRC32 instructions
[    0.003239] CPU: All CPU(s) started at EL2
[    0.003252] alternatives: patching kernel code
[    0.004466] devtmpfs: initialized
[    0.008967] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 764504178510000s
[    0.008980] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    0.015242] xor: measuring software checksum speed
[    0.052055]    8regs     :  2375.000 MB/sec
[    0.092080]    32regs    :  2725.000 MB/sec
[    0.132112]    arm64_neon:  2365.000 MB/sec
[    0.132117] xor: using function: 32regs (2725.000 MB/sec)
[    0.132168] pinctrl core: initialized pinctrl subsystem
[    0.132565] DMI not present or invalid.
[    0.132811] NET: Registered protocol family 16
[    0.133945] DMA: preallocated 256 KiB pool for atomic allocations
[    0.133971] audit: initializing netlink subsys (disabled)
[    0.134111] audit: type=3D2000 audit(0.132:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    0.134503] cpuidle: using governor menu
[    0.134761] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers=
.
[    0.134908] Serial: AMBA PL011 UART driver
[    0.146844] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.146851] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.146856] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.146860] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    1.209443] cryptd: max_cpu_qlen set to 1000
[    1.232920] DRBG: Continuing without Jitter RNG
[    1.308905] raid6: neonx8   gen()  1563 MB/s
[    1.376938] raid6: neonx8   xor()  1450 MB/s
[    1.445018] raid6: neonx4   gen()  1491 MB/s
[    1.513043] raid6: neonx4   xor()  1406 MB/s
[    1.581089] raid6: neonx2   gen()  1116 MB/s
[    1.649148] raid6: neonx2   xor()  1120 MB/s
[    1.717236] raid6: neonx1   gen()   733 MB/s
[    1.785237] raid6: neonx1   xor()   743 MB/s
[    1.853292] raid6: int64x8  gen()  1165 MB/s
[    1.921350] raid6: int64x8  xor()   758 MB/s
[    1.989429] raid6: int64x4  gen()   967 MB/s
[    2.057467] raid6: int64x4  xor()   710 MB/s
[    2.125502] raid6: int64x2  gen()   666 MB/s
[    2.193564] raid6: int64x2  xor()   532 MB/s
[    2.261606] raid6: int64x1  gen()   438 MB/s
[    2.329675] raid6: int64x1  xor()   363 MB/s
[    2.329679] raid6: using algorithm neonx8 gen() 1563 MB/s
[    2.329682] raid6: .... xor() 1450 MB/s, rmw enabled
[    2.329687] raid6: using neon recovery algorithm
[    2.330035] iommu: Default domain type: Translated
[    2.330268] SCSI subsystem initialized
[    2.330300] libata version 3.00 loaded.
[    2.330423] usbcore: registered new interface driver usbfs
[    2.330457] usbcore: registered new interface driver hub
[    2.330489] usbcore: registered new device driver usb
[    2.330520] mc: Linux media interface: v0.10
[    2.330541] videodev: Linux video capture interface: v2.00
[    2.330564] pps_core: LinuxPPS API ver. 1 registered
[    2.330568] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    2.330579] PTP clock support registered
[    2.330597] EDAC MC: Ver: 3.0.0
[    2.330997] zynqmp-ipi-mbox mailbox@ff990400: Registered ZynqMP IPI
mbox with TX/RX channels.
[    2.331174] FPGA manager framework
[    2.331301] Advanced Linux Sound Architecture Driver Initialized.
[    2.331576] Bluetooth: Core ver 2.22
[    2.331601] NET: Registered protocol family 31
[    2.331606] Bluetooth: HCI device and connection manager initialized
[    2.331614] Bluetooth: HCI socket layer initialized
[    2.331620] Bluetooth: L2CAP socket layer initialized
[    2.331634] Bluetooth: SCO socket layer initialized
[    2.332095] clocksource: Switched to clocksource arch_sys_counter
[    2.332191] VFS: Disk quotas dquot_6.6.0
[    2.332236] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    2.336429] NET: Registered protocol family 2
[    2.336785] tcp_listen_portaddr_hash hash table entries: 8192
(order: 5, 131072 bytes, linear)
[    2.336941] TCP established hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    2.337732] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes, linear)
[    2.338530] TCP: Hash tables configured (established 131072 bind 65536)
[    2.338619] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear=
)
[    2.338892] UDP-Lite hash table entries: 8192 (order: 6, 262144
bytes, linear)
[    2.339266] NET: Registered protocol family 1
[    2.339573] RPC: Registered named UNIX socket transport module.
[    2.339578] RPC: Registered udp transport module.
[    2.339581] RPC: Registered tcp transport module.
[    2.339585] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.339872] PCI: CLS 0 bytes, default 64
[    2.368863] Initialise system trusted keyrings
[    2.368951] workingset: timestamp_bits=3D46 max_order=3D22 bucket_order=
=3D0
[    2.369777] NFS: Registering the id_resolver key type
[    2.369792] Key type id_resolver registered
[    2.369796] Key type id_legacy registered
[    2.369805] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.369821] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red H=
at, Inc.
[    2.383001] NET: Registered protocol family 38
[    2.383008] Key type asymmetric registered
[    2.383013] Asymmetric key parser 'x509' registered
[    2.383039] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 246)
[    2.383045] io scheduler mq-deadline registered
[    2.383049] io scheduler kyber registered
[    2.383772] xilinx-xdma-pcie a0000000.axi-pcie: Using MSI Decode mode
[    2.383783] xilinx-xdma-pcie a0000000.axi-pcie: IRQ misc not found
[    2.383788] xilinx-xdma-pcie a0000000.axi-pcie: Unable to find misc IRQ =
line
[    2.383793] xilinx-xdma-pcie a0000000.axi-pcie: Parsing DT failed
[    2.384939] ps_pcie_dma init()
[    2.410271] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.411312] Serial: AMBA driver
[    2.413072] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    2.417493] brd: module loaded
[    2.422218] loop: module loaded
[    2.422943] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    2.424174] libphy: Fixed MDIO Bus: probed
[    2.425308] tun: Universal TUN/TAP device driver, 1.6
[    2.425394] CAN device driver interface
[    2.426043] usbcore: registered new interface driver asix
[    2.426086] usbcore: registered new interface driver ax88179_178a
[    2.426111] usbcore: registered new interface driver cdc_ether
[    2.426133] usbcore: registered new interface driver net1080
[    2.426155] usbcore: registered new interface driver cdc_subset
[    2.426177] usbcore: registered new interface driver zaurus
[    2.426210] usbcore: registered new interface driver cdc_ncm
[    2.426956] usbcore: registered new interface driver uas
[    2.426987] usbcore: registered new interface driver usb-storage
[    2.427429] rtc_zynqmp ffa60000.rtc: registered as rtc0
[    2.427475] i2c /dev entries driver
[    2.428812] usbcore: registered new interface driver uvcvideo
[    2.428816] USB Video Class driver (1.1.1)
[    2.429113] Bluetooth: HCI UART driver ver 2.3
[    2.429119] Bluetooth: HCI UART protocol H4 registered
[    2.429123] Bluetooth: HCI UART protocol BCSP registered
[    2.429142] Bluetooth: HCI UART protocol LL registered
[    2.429146] Bluetooth: HCI UART protocol ATH3K registered
[    2.429162] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    2.429199] Bluetooth: HCI UART protocol Intel registered
[    2.429215] Bluetooth: HCI UART protocol QCA registered
[    2.429243] usbcore: registered new interface driver bcm203x
[    2.429269] usbcore: registered new interface driver bpa10x
[    2.429297] usbcore: registered new interface driver bfusb
[    2.429324] usbcore: registered new interface driver btusb
[    2.429364] usbcore: registered new interface driver ath3k
[    2.429476] EDAC MC: ECC not enabled
[    2.429611] EDAC DEVICE0: Giving out device to module
zynqmp-ocm-edac controller zynqmp_ocm: DEV ff9600)
[    2.430033] sdhci: Secure Digital Host Controller Interface driver
[    2.430036] sdhci: Copyright(c) Pierre Ossman
[    2.430040] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.430320] ledtrig-cpu: registered to indicate activity on CPUs
[    2.430368] zynqmp_firmware_probe Platform Management API v1.1
[    2.430374] zynqmp_firmware_probe Trustzone version v1.0
[    2.454654] alg: No test for xilinx-zynqmp-aes (zynqmp-aes)
[    2.454837] zynqmp_aes zynqmp_aes: AES Successfully Registered
[    2.454837]
[    2.454996] alg: No test for xilinx-keccak-384 (zynqmp-keccak-384)
[    2.455232] alg: No test for xilinx-zynqmp-rsa (zynqmp-rsa)
[    2.455498] usbcore: registered new interface driver usbhid
[    2.455502] usbhid: USB HID core driver
[    2.457878] ARM CCI_400_r1 PMU driver probed
[    2.458341] fpga_manager fpga0: Xilinx ZynqMP FPGA Manager registered
[    2.458714] usbcore: registered new interface driver snd-usb-audio
[    2.459464] pktgen: Packet Generator for packet performance
testing. Version: 2.75
[    2.460268] Initializing XFRM netlink socket
[    2.460367] NET: Registered protocol family 10
[    2.460796] Segment Routing with IPv6
[    2.460911] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.461256] NET: Registered protocol family 17
[    2.461269] NET: Registered protocol family 15
[    2.461288] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scrip.
[    2.461293] can: controller area network core (rev 20170425 abi 9)
[    2.461324] NET: Registered protocol family 29
[    2.461329] can: raw protocol (rev 20170425)
[    2.461334] can: broadcast manager protocol (rev 20170425 t)
[    2.461340] can: netlink gateway (rev 20190810) max_hops=3D1
[    2.461410] Bluetooth: RFCOMM TTY layer initialized
[    2.461418] Bluetooth: RFCOMM socket layer initialized
[    2.461433] Bluetooth: RFCOMM ver 1.11
[    2.461441] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.461445] Bluetooth: BNEP filters: protocol multicast
[    2.461451] Bluetooth: BNEP socket layer initialized
[    2.461455] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    2.461460] Bluetooth: HIDP socket layer initialized
[    2.461572] 9pnet: Installing 9P2000 support
[    2.461594] Key type dns_resolver registered
[    2.461983] registered taskstats version 1
[    2.461987] Loading compiled-in X.509 certificates
[    2.463025] Btrfs loaded, crc32c=3Dcrc32c-generic
[    2.472375] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq =3D 38,
base_baud =3D 6249999) is a xuartps
[    3.778541] printk: console [ttyPS0] enabled
[    3.783170] of-fpga-region fpga-full: FPGA Region probed
[    3.789082] GPIO IRQ not connected
[    3.792480] XGpio: gpio@410000000: registered, base is 511
[    3.798608] xilinx-zynqmp-dma fd500000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.805716] xilinx-zynqmp-dma fd510000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.812828] xilinx-zynqmp-dma fd520000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.819943] xilinx-zynqmp-dma fd530000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.827054] xilinx-zynqmp-dma fd540000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.834158] xilinx-zynqmp-dma fd550000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.841265] xilinx-zynqmp-dma fd560000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.848377] xilinx-zynqmp-dma fd570000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.855552] xilinx-zynqmp-dma ffa80000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.862660] xilinx-zynqmp-dma ffa90000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.869764] xilinx-zynqmp-dma ffaa0000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.876871] xilinx-zynqmp-dma ffab0000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.883982] xilinx-zynqmp-dma ffac0000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.891085] xilinx-zynqmp-dma ffad0000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.898192] xilinx-zynqmp-dma ffae0000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.905308] xilinx-zynqmp-dma ffaf0000.dma: ZynqMP DMA driver Probe succ=
ess
[    3.912758] spi_master spi0: cannot find modalias for
/amba/spi@ff0f0000/flash@0
[    3.920152] spi_master spi0: Failed to create SPI device for
/amba/spi@ff0f0000/flash@0
[    3.928451] macb ff0e0000.ethernet: Not enabling partial store and forwa=
rd
[    3.935888] libphy: MACB_mii_bus: probed
[    3.973440] zynqmp_pll_disable() clock disable failed for dpll_int, ret =
=3D -13
[    4.012877] Micrel KSZ9031 Gigabit PHY
ff0e0000.ethernet-ffffffff:04: attached PHY driver [Micrel KSZ90)
[    4.028694] macb ff0e0000.ethernet eth0: Cadence GEM rev 0x50070106
at 0xff0e0000 irq 30 (00:0a:35:00:2)
[    4.038824] xilinx-axipmon ffa00000.perf-monitor: Probed Xilinx APM
[    4.045350] xilinx-axipmon fd0b0000.perf-monitor: Probed Xilinx APM
[    4.051829] xilinx-axipmon fd490000.perf-monitor: Probed Xilinx APM
[    4.058319] xilinx-axipmon ffa10000.perf-monitor: Probed Xilinx APM
[    4.098280] mmc0: SDHCI controller on ff170000.mmc [ff170000.mmc]
using ADMA 64-bit
[    4.108569] rtc_zynqmp ffa60000.rtc: setting system clock to
2068-03-21T21:23:50 UTC (3099590630)
[    4.117439] of_cfs_init
[    4.119894] of_cfs_init: OK
[    4.125107] pps pps0: new PPS source ptp0
[    4.129118] macb ff0e0000.ethernet: gem-ptp-timer ptp clock registered.
[    4.159643] mmc0: new high speed SDHC card at address 5048
[    4.165584] mmcblk0: mmc0:5048 SD32G 28.9 GiB
[    4.171651]  mmcblk0: p1 p2
[    8.224688] macb ff0e0000.ethernet eth0: link up (1000/Full)
[    8.236115] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    8.256098] IP-Config: Complete:
[    8.259316]      device=3Deth0, hwaddr=3D00:0a:35:00:22:01,
ipaddr=3D9.2.227.19, mask=3D255.255.248.0, gw=3D9.2.22
[    8.269052]      host=3D9.2.227.19, domain=3D, nis-domain=3D(none)
[    8.274701]      bootserver=3D9.2.225.84, rootserver=3D9.2.225.84, rootp=
ath=3D
[    8.281560] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    8.418185] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.425939] ALSA device list:
[    8.428903]   No soundcards found.
[    8.432616] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    8.441227] cfg80211: failed to load regulatory.db
[    8.453336] VFS: Mounted root (nfs filesystem) on device 0:19.
[    8.459597] devtmpfs: mounted
[    8.462795] Freeing unused kernel memory: 768K
[    8.476133] Run /sbin/init as init process
[    8.490298] random: fast init done
[    8.664485] cgroup2: Unknown parameter 'memory_recursiveprot'
[    8.679628] systemd[1]: systemd 248.3-1ubuntu8 running in system
mode. (+PAM +AUDIT +SELINUX +APPARMOR )
[    8.710820] systemd[1]: Detected architecture arm64.

Welcome to Ubuntu 21.10!

[    8.729369] systemd[1]: Hostname set to <cuttlefisharm1>.
[    8.999096] random: lvmconfig: uninitialized urandom read (4 bytes read)
[   10.381721] random: crng init done
[   10.524500] systemd[1]: Queued start job for default target
Graphical Interface.
[   10.554125] systemd[1]: Created slice system-modprobe.slice.
[  OK  ] Created slice system-modprobe.slice.
[   10.577283] systemd[1]: Created slice system-postfix.slice.
[  OK  ] Created slice system-postfix.slice.
[   10.617032] systemd[1]: Created slice system-serial\x2dgetty.slice.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[   10.640937] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[   10.664379] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[  OK  ] Started Forward Password R=E2=80=A6uests to Wall Directory Watch.
[   10.688428] systemd[1]: Condition check resulted in Arbitrary
Executable File Formats File System Autom.
[   10.700339] systemd[1]: Reached target User and Group Name Lookups.
[  OK  ] Reached target User and Group Name Lookups.
[   10.724261] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
[   10.740213] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[   10.756225] systemd[1]: Reached target Local Verity Integrity
Protected Volumes.
[  OK  ] Reached target Local Verity Integrity Protected Volumes.
[   10.780472] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[  OK  ] Listening on Device-mapper event daemon FIFOs.
[   10.805429] systemd[1]: Listening on LVM2 poll daemon socket.
[  OK  ] Listening on LVM2 poll daemon socket.
[   10.829147] systemd[1]: Listening on Syslog Socket.
[  OK  ] Listening on Syslog Socket.
[   10.844349] systemd[1]: Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[   10.869255] systemd[1]: Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Audit Socket.
[   10.892444] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[   10.916550] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[   10.933073] systemd[1]: Listening on Network Service Netlink Socket.
[  OK  ] Listening on Network Service Netlink Socket.
[   10.957516] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[   10.980463] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[   11.022153] systemd[1]: Mounting Huge Pages File System...
         Mounting Huge Pages File System...
[   11.042793] systemd[1]: Mounting POSIX Message Queue File System...
         Mounting POSIX Message Queue File System...
[   11.066957] systemd[1]: Mounting Kernel Debug File System...
         Mounting Kernel Debug File System...
[   11.084562] systemd[1]: Condition check resulted in Kernel Trace
File System being skipped.
[   11.093444] systemd[1]: systemd-journald.service: unit configures
an IP firewall, but the local system .
[   11.106321] systemd[1]: (This warning is only shown for the first
unit using IP firewalling.)
[   11.134296] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[   11.152502] systemd[1]: Starting Set the console keyboard layout...
         Starting Set the console keyboard layout...
[   11.177623] systemd[1]: Condition check resulted in Create list of
static device nodes for the current .
[   11.191847] systemd[1]: Starting Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress .
         Starting Monitoring of LVM=E2=80=A6meventd or progress polling...
[   11.223907] systemd[1]: Starting Load Kernel Module configfs...
         Starting Load Kernel Module configfs...
[   11.243273] systemd[1]: Starting Load Kernel Module drm...
         Starting Load Kernel Module drm...
[   11.263091] systemd[1]: Starting Load Kernel Module fuse...
         Starting Load Kernel Module fuse...
[   11.280719] systemd[1]: Condition check resulted in OpenVSwitch
configuration for cleanup being skipped.
[   11.293757] systemd[1]: Condition check resulted in Set Up
Additional Binary Formats being skipped.
[   11.326335] systemd[1]: Starting Load Kernel Modules...
         Starting Load Kernel Modules...
[   11.343343] systemd[1]: Starting Remount Root and Kernel File Systems...
         Starting Remount Root and Kernel File Systems...
[   11.367153] systemd[1]: Starting Coldplug All udev Devices...
         Starting Coldplug All udev Devices...
[   11.387135] systemd[1]: Starting Uncomplicated firewall...
         Starting Uncomplicated firewall...
[   11.408038] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Kernel Debug File System.
[  OK  ] Finished Set the console keyboard layout.
[  OK  ] Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module drm.
[  OK  ] Finished Load Kernel Module fuse.
[  OK  ] Finished Load Kernel Modules.
[  OK  ] Finished Remount Root and Kernel File Systems.
[  OK  ] Finished Uncomplicated firewall.
         Mounting Kernel Configuration File System...
         Starting Flush Journal to Persistent Storage...
         Starting Load/Save Random Seed...
[   11.673665] systemd-journald[379]: Received client request to flush
runtime journal.
         Starting Apply Kernel Variables...
         Starting Create System Users...
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Finished Apply Kernel Variables.
[  OK  ] Finished Create System Users.
[  OK  ] Finished Load/Save Random Seed.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Finished Create Static Device Nodes in /dev.
         Starting Rule-based Manage=E2=80=A6for Device Events and Files...
[  OK  ] Finished Coldplug All udev Devices.
[  OK  ] Started Rule-based Manager for Device Events and Files.
[  OK  ] Started Dispatch Password =E2=80=A6ts to Console Directory Watch.
[  OK  ] Reached target Local Encrypted Volumes.
[  OK  ] Found device /dev/ttyPS0.
[  OK  ] Finished Flush Journal to Persistent Storage.
[  OK  ] Listening on Load/Save RF =E2=80=A6itch Status /dev/rfkill Watch.
[  OK  ] Finished Monitoring of LVM=E2=80=A6 dmeventd or progress polling.
[  OK  ] Reached target Local File Systems (Pre).
         Mounting Mount unit for core18, revision 2127...
         Mounting Mount unit for lxd, revision 21032...
         Mounting Mount unit for snapd, revision 12707...
[FAILED] Failed to mount Mount unit for core18, revision 2127.
See 'systemctl status snap-core18-2127.mount' for details.
[FAILED] Failed to mount Mount unit for lxd, revision 21032.
See 'systemctl status snap-lxd-21032.mount' for details.
[DEPEND] Dependency failed for Sock=E2=80=A6r snap application lxd.daemon.
[DEPEND] Dependency failed for Serv=E2=80=A6snap application lxd.activate.
[FAILED] Failed to mount Mount unit for snapd, revision 12707.
See 'systemctl status snap-snapd-12707.mount' for details.
[  OK  ] Reached target Local File Systems.
         Starting Set console font and keymap...
         Starting Create final runt=E2=80=A6dir for shutdown pivot root...
         Starting Tell Plymouth To Write Out Runtime Data...
         Starting Create Volatile Files and Directories...
[  OK  ] Finished Set console font and keymap.
[  OK  ] Finished Create final runt=E2=80=A6e dir for shutdown pivot root.
[  OK  ] Finished Tell Plymouth To Write Out Runtime Data.
[  OK  ] Finished Create Volatile Files and Directories.
         Starting Network Time Synchronization...
         Starting Update UTMP about System Boot/Shutdown...
         Starting Initial cloud-init job (pre-networking)...
[  OK  ] Finished Update UTMP about System Boot/Shutdown.
[   15.197645] proc: Bad value for 'hidepid'
[  OK  ] Started Network Time Synchronization.
[  OK  ] Reached target System Time Set.
[   18.316749] cloud-init[591]: Cloud-init v.
21.3-1-g6803368d-0ubuntu3 running 'init-local' at Wed, 21 Ma.
[  OK  ] Finished Initial cloud-init job (pre-networking).
[  OK  ] Reached target Network (Pre).
         Starting Network Service...
[   19.286854] proc: Bad value for 'hidepid'
[  OK  ] Started Network Service.
         Starting Wait for Network to be Configured...
         Starting Network Name Resolution...
[  OK  ] Finished Wait for Network to be Configured.
         Starting Initial cloud-ini=E2=80=A6 (metadata service crawler)...
[   19.792990] proc: Bad value for 'hidepid'
[  OK  ] Started Network Name Resolution.
[  OK  ] Reached target Network.
[  OK  ] Reached target Host and Network Name Lookups.
[   22.265736] cloud-init[600]: Cloud-init v.
21.3-1-g6803368d-0ubuntu3 running 'init' at Wed, 21 Mar 2068.
[   22.786663] cloud-init[600]: ci-info:
+++++++++++++++++++++++++++++++++++++++Net device info++++++++++++
[   22.808420] cloud-init[600]: ci-info:
+--------+-------+-----------------------------+---------------+-+
[   22.828271] cloud-init[600]: ci-info: | Device |   Up  |
Address           |      Mask     | |
[   22.852353] cloud-init[600]: ci-info:
+--------+-------+-----------------------------+---------------+-+
[   22.872295] cloud-init[600]: ci-info: |  eth0  |  True |
9.2.227.19         | 255.255.248.0 | |
[   22.896341] cloud-init[600]: ci-info: |  eth0  |  True |
fe80::20a:35ff:fe00:2201/64 |       .       | |
[   22.916259] cloud-init[600]: ci-info: |   lo   |  True |
127.0.0.1          |   255.0.0.0   | |
[   22.936185] cloud-init[600]: ci-info: |   lo   |  True |
::1/128           |       .       | |
[   22.956216] cloud-init[600]: ci-info: |  sit0  | False |
  .              |       .       | |
[   22.976301] cloud-init[600]: ci-info:
+--------+-------+-----------------------------+---------------+-+
[   22.996188] cloud-init[600]: ci-info:
++++++++++++++++++++++++++++Route IPv4 info+++++++++++++++++++++++
[   23.012160] cloud-init[600]: ci-info:
+-------+-------------+-----------+---------------+-----------+--+
[   23.028202] cloud-init[600]: ci-info: | Route | Destination |
Gateway  |    Genmask    | Interface | F|
[   23.044232] cloud-init[600]: ci-info:
+-------+-------------+-----------+---------------+-----------+--+
[   23.060170] cloud-init[600]: ci-info: |   0   |   0.0.0.0   |
9.2.224.2 |    0.0.0.0    |    eth0   |  |
[   23.076161] cloud-init[600]: ci-info: |   1   |  9.2.224.0  |
0.0.0.0  | 255.255.248.0 |    eth0   |  |
[   23.092214] cloud-init[600]: ci-info:
+-------+-------------+-----------+---------------+-----------+--+
[   23.108241] cloud-init[600]: ci-info: +++++++++++++++++++Route IPv6
info+++++++++++++++++++
[   23.124244] cloud-init[600]: ci-info:
+-------+-------------+---------+-----------+-------+
[   23.140174] cloud-init[600]: ci-info: | Route | Destination |
Gateway | Interface | Flags |
[   23.156195] cloud-init[600]: ci-info:
+-------+-------------+---------+-----------+-------+
[   23.172160] cloud-init[600]: ci-info: |   1   |    local    |    ::
  |    eth0   |   U   |
[   23.188274] cloud-init[600]: ci-info: |   2   |  fe80::/64  |    ::
  |    eth0   |   U   |
[   23.204213] cloud-init[600]: ci-info: |   3   |   ff00::/8  |    ::
  |    eth0   |   U   |
[   23.421637] cloud-init[600]: ci-info:
+-------+-------------+---------+-----------+-------+
[  OK  ] Finished Initial cloud-ini=E2=80=A6ob (metadata service crawler).
[  OK  ] Reached target Cloud-config availability.
[  OK  ] Reached target Network is Online.
[  OK  ] Reached target System Initialization.
[  OK  ] Started Trigger to poll fo=E2=80=A6y enabled on GCP LTS non-pro).
[  OK  ] Started Daily apt download activities.
[  OK  ] Started Daily apt upgrade and clean activities.
[  OK  ] Started Periodic ext4 Onli=E2=80=A6ata Check for All Filesystems.
[  OK  ] Started Discard unused blocks once a week.
[  OK  ] Started Refresh fwupd metadata regularly.
[  OK  ] Started Daily rotation of log files.
[  OK  ] Started Daily man-db regeneration.
[  OK  ] Started Message of the Day.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Started Ubuntu Advantage Timer for running repeated jobs.
[  OK  ] Started Download data for =E2=80=A6ailed at package install time.
[  OK  ] Started Check to see wheth=E2=80=A6w version of Ubuntu available.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Timers.
[  OK  ] Listening on cloud-init hotplug hook socket.
[  OK  ] Listening on D-Bus System Message Bus Socket.
         Starting Docker Socket for the API.
[  OK  ] Listening on Open-iSCSI iscsid Socket.
         Starting Socket activation for snappy daemon.
[  OK  ] Listening on UUID daemon activation socket.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[  OK  ] Finished Availability of block devices.
[  OK  ] Listening on Docker Socket for the API.
[  OK  ] Listening on Socket activation for snappy daemon.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Accounts Service...
         Starting LSB: automatic crash report generation...
         Starting Deferred execution scheduler...
         Starting containerd container runtime...
[  OK  ] Started Regular background program processing daemon.
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started Save initial kernel messages after boot.
         Starting Remove Stale Onli=E2=80=A6t4 Metadata Check Snapshots...
[  OK  ] Started irqbalance daemon.
         Starting Dispatcher daemon for systemd-networkd...
         Starting Postfix Mail Transport Agent (instance -)...
         Starting System Logging Service...
         Starting Snap Daemon...
         Starting OpenBSD Secure Shell server...
         Starting User Login Management...
         Starting Permit User Sessions...
         Starting Ubuntu FAN network setup...
[   26.275017] proc: Bad value for 'hidepid'
         Starting Disk Manager...
         Starting Rotate log files...
         Starting Daily man-db regeneration...
[  OK  ] Started Deferred execution scheduler.
[  OK  ] Finished Remove Stale Onli=E2=80=A6ext4 Metadata Check Snapshots.
[  OK  ] Finished Permit User Sessions.
[  OK  ] Finished Ubuntu FAN network setup.
[  OK  ] Started System Logging Service.
         Starting Hold until boot process finishes up...
         Starting Terminate Plymouth Boot Screen...
[  OK  ] Finished Terminate Plymouth Boot Screen.
[  OK  ] Started OpenBSD Secure Shell server.
[  OK  ] Finished Hold until boot process finishes up.
[  OK  ] Started Serial Getty on ttyPS0.
         Starting Set console scheme...
[  OK  ] Started LSB: automatic crash report generation.
[  OK  ] Finished Set console scheme.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Started Getty on tty1.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started User Login Management.
[  OK  ] Started Unattended Upgrades Shutdown.
         Starting Authorization Manager...
[  OK  ] Started Authorization Manager.
[  OK  ] Started Accounts Service.
[  OK  ] Started Dispatcher daemon for systemd-networkd.
[  OK  ] Started Snap Daemon.
         Starting Wait until snapd is fully seeded...
[  OK  ] Finished Wait until snapd is fully seeded.
         Starting Apply the settings specified in cloud-config...
[  OK  ] Started containerd container runtime.
         Starting Docker Application Container Engine...
[  OK  ] Started Disk Manager.
[FAILED] Failed to start Postfix Ma=E2=80=A6 Transport Agent (instance -).
See 'systemctl status postfix@-.service' for details.
[   29.973135] overlayfs: filesystem on
'/var/lib/docker/check-overlayfs-support260923788/upper' not suppor
[   30.618293] overlayfs: filesystem on
'/var/lib/docker/check-overlayfs-support168220027/upper' not suppor
[   31.664641] cloud-init[790]: Cloud-init v.
21.3-1-g6803368d-0ubuntu3 running 'modules:config' at Wed, 2.

Ubuntu 21.10 cuttlefisharm1 ttyPS0

cuttlefisharm1 login: [   35.251865] overlayfs: filesystem on
'/var/lib/docker/check-overlayfs-support7114r
[   35.903183] cloud-init[858]: Cloud-init v.
21.3-1-g6803368d-0ubuntu3 running 'modules:final' at Wed, 21.
[   35.923127] overlayfs: filesystem on
'/var/lib/docker/check-overlayfs-support746885532/upper' not suppor
[   35.975901] cloud-init[858]: Cloud-init v.
21.3-1-g6803368d-0ubuntu3 finished at Wed, 21 Mar 2068 21:24s
[   36.082810] cloud-init[858]: 2068-03-21 21:24:22,477 -
cc_final_message.py[WARNING]: Used fallback datae
[   40.413307] overlayfs: filesystem on
'/var/lib/docker/check-overlayfs-support002292139/upper' not suppor
[   40.937166] overlayfs: filesystem on
'/var/lib/docker/check-overlayfs-support240114958/upper' not suppor
[  112.624740] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  112.633516] Mem abort info:
[  112.636291]   ESR =3D 0x96000004
[  112.639330]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  112.644624]   SET =3D 0, FnV =3D 0
[  112.647662]   EA =3D 0, S1PTW =3D 0
[  112.650786] Data abort info:
[  112.653651]   ISV =3D 0, ISS =3D 0x00000004
[  112.657470]   CM =3D 0, WnR =3D 0
[  112.660423] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000b4f60b000
[  112.666845] [0000000000000000] pgd=3D0000000000000000
[  112.671707] Internal error: Oops: 96000004 [#1] SMP
[  112.676567] Modules linked in: br_netfilter
[  112.680747] CPU: 2 PID: 1060 Comm: dd Not tainted 5.4.0-xilinx-v2020.2 #=
1
[  112.687521] Hardware name: xlnx,zynqmp (DT)
[  112.691689] pstate: a0000085 (NzCv daIf -PAN -UAO)
[  112.696472] pc : __wake_up_common+0x58/0x170
[  112.700726] lr : __wake_up_common_lock+0x98/0x110
[  112.705410] sp : ffff800011ad3520
[  112.708709] x29: ffff800011ad3520 x28: 0000000000000080
[  112.714003] x27: ffff800011ad3650 x26: 0000000000000000
[  112.719298] x25: 0000000000000003 x24: 0000000000000000
[  112.724593] x23: 0000000000000001 x22: ffff800011ad35f0
[  112.729888] x21: ffff8000110d5d88 x20: 0000000000000001
[  112.735183] x19: ffff8000110d5d80 x18: fffffe002d6cd0c8
[  112.740477] x17: ffff000b6c001008 x16: ffff000b6c001028
[  112.745772] x15: 0001000000000000 x14: 0000000000000000
[  112.751067] x13: 0000000000000000 x12: 0000000000000000
[  112.756362] x11: 0000000000000000 x10: 0000000000000000
[  112.761657] x9 : 0000000000000000 x8 : 0000000000000000
[  112.766952] x7 : 0000000000000000 x6 : ffffffffffffffe8
[  112.772247] x5 : ffff800011ad35f0 x4 : ffff800011ad3650
[  112.777541] x3 : 0000000000000000 x2 : 0000000000000001
[  112.782836] x1 : 0000000000000000 x0 : 0000000000000000
[  112.788132] Call trace:
[  112.790565]  __wake_up_common+0x58/0x170
[  112.794479]  __wake_up_common_lock+0x98/0x110
[  112.798819]  __wake_up+0x14/0x20
[  112.802029]  wake_up_bit+0x78/0xa0
[  112.805416]  unlock_buffer+0x2c/0x38
[  112.808974]  end_buffer_async_write+0x98/0x1c0
[  112.813401]  end_bio_bh_io_sync+0x30/0x60
[  112.817396]  bio_endio+0x114/0x170
[  112.820791]  brd_make_request+0x1c8/0x1d0
[  112.824790]  generic_make_request+0xa4/0x2c8
[  112.829042]  submit_bio+0x3c/0x1a0
[  112.832427]  submit_bh_wbc+0x18c/0x1f8
[  112.836160]  __block_write_full_page+0x300/0x570
[  112.840760]  block_write_full_page+0x110/0x120
[  112.845187]  blkdev_writepage+0x18/0x20
[  112.849009]  __writepage+0x1c/0x80
[  112.852401]  write_cache_pages+0x170/0x370
[  112.856481]  generic_writepages+0x58/0x90
[  112.860473]  blkdev_writepages+0xc/0x18
[  112.864292]  do_writepages+0x50/0x100
[  112.867939]  __filemap_fdatawrite_range+0xfc/0x140
[  112.872712]  filemap_write_and_wait+0x28/0x88
[  112.877053]  __blkdev_put+0x80/0x258
[  112.880610]  blkdev_put+0x4c/0x110
[  112.883996]  blkdev_close+0x1c/0x28
[  112.887469]  __fput+0x88/0x208
[  112.890506]  ____fput+0xc/0x18
[  112.893545]  task_work_run+0xc8/0xf8
[  112.897105]  do_notify_resume+0x344/0x388
[  112.901104]  work_pending+0x8/0x10
[  112.904493] Code: 54000700 a90153f3 2a0203f7 52800018 (f9400cd3)
[  112.910576] ---[ end trace 2627235d8e7d8d8a ]---
[  112.915231] BUG: Bad page map in process dd  pte:20000b5600efd3 pmd:b68c=
da003
[  112.915329] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000020
[  112.922361] addr:0000aaaae7723000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b64190c60 0
[  112.922373] file:dd fault:filemap_fault mmap:nfs_file_mmap
readpage:nfs_readpage
[  112.922379] CPU: 2 PID: 1060 Comm: dd Tainted: G      D
5.4.0-xilinx-v2020.2 #1
[  112.931151] Mem abort info:
[  112.941127] Hardware name: xlnx,zynqmp (DT)
[  112.941128] Call trace:
[  112.941131]  dump_backtrace+0x0/0x140
[  112.941134]  show_stack+0x14/0x20
[  112.941143]  dump_stack+0xac/0xd0
[  112.948520]   ESR =3D 0x96000004
[  112.956675]  print_bad_pte+0x164/0x1e8
[  112.956678]  vm_normal_page+0x88/0xa8
[  112.956682]  unmap_page_range+0x5d0/0xc48
[  112.959466]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  112.963627]  unmap_single_vma+0x48/0xa0
[  112.963629]  unmap_vmas+0x6c/0xe0
[  112.963633]  exit_mmap+0xc4/0x178
[  112.963640]  mmput+0x50/0x138
[  112.966066]   SET =3D 0, FnV =3D 0
[  112.969712]  do_exit+0x270/0x9b8
[  112.969715]  die+0x248/0x288
[  112.969720]  die_kernel_fault+0x60/0x70
[  112.973023]   EA =3D 0, S1PTW =3D 0
[  112.976317]  __do_kernel_fault+0x84/0x120
[  112.976320]  do_page_fault+0x1cc/0x478
[  112.976325]  do_translation_fault+0x5c/0x78
[  112.979367] Data abort info:
[  112.983096]  do_mem_abort+0x3c/0x98
[  112.983099]  el1_da+0x1c/0x90
[  112.983103]  __wake_up_common+0x58/0x170
[  112.983109]  __wake_up_common_lock+0x98/0x110
[  112.986755]   ISV =3D 0, ISS =3D 0x00000004
[  112.990744]  __wake_up+0x14/0x20
[  112.990747]  wake_up_bit+0x78/0xa0
[  112.990751]  unlock_buffer+0x2c/0x38
[  112.996052]   CM =3D 0, WnR =3D 0
[  112.999866]  end_buffer_async_write+0x98/0x1c0
[  112.999869]  end_bio_bh_io_sync+0x30/0x60
[  112.999875]  bio_endio+0x114/0x170
[  113.000062] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000020
[  113.000064] Mem abort info:
[  113.000066]   ESR =3D 0x96000004
[  113.000068]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  113.000070]   SET =3D 0, FnV =3D 0
[  113.000071]   EA =3D 0, S1PTW =3D 0
[  113.000072] Data abort info:
[  113.000074]   ISV =3D 0, ISS =3D 0x00000004
[  113.000075]   CM =3D 0, WnR =3D 0
[  113.000078] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000b6502b000
[  113.000080] [0000000000000020] pgd=3D0000000000000000
[  113.000083] Internal error: Oops: 96000004 [#2] SMP
[  113.000084] Modules linked in: br_netfilter
[  113.000091] CPU: 1 PID: 665 Comm: rs:main Q:Reg Tainted: G      D
        5.4.0-xilinx-v2020.2 #1
[  113.000093] Hardware name: xlnx,zynqmp (DT)
[  113.000097] pstate: 20000005 (nzCv daif -PAN -UAO)
[  113.000103] pc : kmem_cache_alloc+0x104/0x160
[  113.000107] lr : kmem_cache_alloc+0x28/0x160
[  113.000108] sp : ffff800011443d20
[  113.000110] x29: ffff800011443d20 x28: ffff000b6368ad80
[  113.000114] x27: ffff000b6368ad80 x26: 0000000000000002
[  113.000117] x25: 0000000000000010 x24: 0000000000000000
[  113.000121] x23: ffff8000111ab000 x22: 0000000000000001
[  113.000124] x21: 0000000000000000 x20: 0000000000000000
[  113.000128] x19: 0000000000000cc0 x18: 0000000000000000
[  113.000131] x17: 0000000000000000 x16: 0000000000000000
[  113.000134] x15: 0000000000000000 x14: ffff000b69fcc300
[  113.000138] x13: 0000000000000000 x12: 0000000000000000
[  113.000141] x11: 0000000000000000 x10: ffff000b6451a200
[  113.000144] x9 : 0000000000000000 x8 : 0000000000000000
[  113.000147] x7 : 0000000000000000 x6 : 0000000000000000
[  113.000150] x5 : 0000000000000000 x4 : 0000000000000000
[  113.000154] x3 : 0000000000000000 x2 : ffff8000110d9000
[  113.000157] x1 : 0000000000000cc0 x0 : 000000000000004c
[  113.000160] Call trace:
[  113.000164]  kmem_cache_alloc+0x104/0x160
[  113.000170]  getname_flags+0x44/0x1c8
[  113.000173]  user_path_at_empty+0x2c/0x58
[  113.000177]  do_faccessat+0x9c/0x258
[  113.000180]  __arm64_sys_faccessat+0x1c/0x28
[  113.000186]  el0_svc_common.constprop.0+0x68/0x160
[  113.000189]  el0_svc_handler+0x6c/0x88
[  113.000192]  el0_svc+0x8/0xc
[  113.000198] Code: 52800001 9428e398 17ffffe9 37b00073 (b9402280)
[  113.000200] ---[ end trace 2627235d8e7d8d8b ]---
[  113.000233] Unable to handle kernel paging request at virtual
address 00000005aeed7d90
[  113.000235] Mem abort info:
[  113.000236]   ESR =3D 0x96000004
[  113.000238]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  113.000240]   SET =3D 0, FnV =3D 0
[  113.000241]   EA =3D 0, S1PTW =3D 0
[  113.000242] Data abort info:
[  113.000244]   ISV =3D 0, ISS =3D 0x00000004
[  113.000245]   CM =3D 0, WnR =3D 0
[  113.000248] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000b6502b000
[  113.000250] [00000005aeed7d90] pgd=3D0000000000000000
[  113.000253] Internal error: Oops: 96000004 [#3] SMP
[  113.000254] Modules linked in: br_netfilter
[  113.000259] CPU: 1 PID: 665 Comm: rs:main Q:Reg Tainted: G      D
        5.4.0-xilinx-v2020.2 #1
[  113.000261] Hardware name: xlnx,zynqmp (DT)
[  113.000264] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  113.000269] pc : __d_lookup+0x38/0x1a8
[  113.000273] lr : d_lookup+0x38/0x68
[  113.000274] sp : ffff8000114437f0
[  113.000276] x29: ffff8000114437f0 x28: ffff800011443928
[  113.000280] x27: 0000000000000299 x26: ffff000b6bc03840
[  113.000283] x25: 0000000000000276 x24: ffff800010ec2f08
[  113.000287] x23: ffff000b6b900300 x22: 0000000000000000
[  113.000290] x21: 00000000b5ddafb2 x20: ffff800011443928
[  113.000294] x19: ffff8000110d8480 x18: 0000000000000000
[  113.000297] x17: 0000000000000041 x16: 0000000000000001
[  113.000301] x15: ffff000b6368b1a8 x14: ffffffffffffffff
[  113.000304] x13: ffff800011443948 x12: ffff80001144393d
[  113.000307] x11: 00e8000b5e172f53 x10: 0000000000000000
[  113.000311] x9 : fffffe002d585c80 x8 : 0000000000000299
[  113.000314] x7 : 000000000000ffff x6 : 0000000000000002
[  113.000317] x5 : 61c8864680b583eb x4 : b937d799bfc46592
[  113.000321] x3 : 0000000000353636 x2 : ffff8000110db000
[  113.000324] x1 : 0000000000000000 x0 : 00000000b5ddafb2
[  113.000327] Call trace:
[  113.000330]  __d_lookup+0x38/0x1a8
[  113.000334]  d_lookup+0x38/0x68
[  113.000337]  d_hash_and_lookup+0x50/0x68
[  113.000342]  proc_flush_task+0x98/0x198
[  113.000345]  release_task+0x64/0x4c0
[  113.000348]  do_exit+0x520/0x9b8
[  113.000351]  die+0x248/0x288
[  113.000354]  die_kernel_fault+0x60/0x70
[  113.000357]  __do_kernel_fault+0x84/0x120
[  113.000360]  do_page_fault+0x1cc/0x478
[  113.000363]  do_translation_fault+0x5c/0x78
[  113.000366]  do_mem_abort+0x3c/0x98
[  113.000368]  el1_da+0x1c/0x90
[  113.000372]  kmem_cache_alloc+0x104/0x160
[  113.000376]  getname_flags+0x44/0x1c8
[  113.000380]  user_path_at_empty+0x2c/0x58
[  113.000383]  do_faccessat+0x9c/0x258
[  113.000386]  __arm64_sys_faccessat+0x1c/0x28
[  113.000390]  el0_svc_common.constprop.0+0x68/0x160
[  113.000393]  el0_svc_handler+0x6c/0x88
[  113.000396]  el0_svc+0x8/0xc
[  113.000401] Code: b9400395 b9401020 f9400421 1ac026a0 (f8607833)
[  113.000403] ---[ end trace 2627235d8e7d8d8c ]---
[  113.000405] Fixing recursive fault but reboot is needed!
[  113.003180] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000b69ff9000
[  113.006475]  brd_make_request+0x1c8/0x1d0
[  113.009429] [0000000000000020] pgd=3D0000000000000000
[  113.012462]  generic_make_request+0xa4/0x2c8
[  113.012465]  submit_bio+0x3c/0x1a0
[  113.012469]  submit_bh_wbc+0x18c/0x1f8
[  113.015687] Internal error: Oops: 96000004 [#4] SMP
[  113.018547]  __block_write_full_page+0x300/0x570
[  113.022364] Modules linked in: br_netfilter
[  113.025491]  block_write_full_page+0x110/0x120
[  113.029484] CPU: 0 PID: 379 Comm: systemd-journal Tainted: G      D
          5.4.0-xilinx-v2020.2 #1
[  113.033216]  blkdev_writepage+0x18/0x20
[  113.037381] Hardware name: xlnx,zynqmp (DT)
[  113.040248]  __writepage+0x1c/0x80
[  113.043719] pstate: 20000005 (nzCv daif -PAN -UAO)
[  113.046672]  write_cache_pages+0x170/0x370
[  113.050579] pc : kmem_cache_alloc+0x104/0x160
[  113.054917]  generic_writepages+0x58/0x90
[  113.058737] lr : kmem_cache_alloc+0x28/0x160
[  113.061947]  blkdev_writepages+0xc/0x18
[  113.065331] sp : ffff80001142bd60
[  113.068891]  do_writepages+0x50/0x100
[  113.071841] x29: ffff80001142bd60 x28: ffff000b6aa58d80
[  113.076270]  __filemap_fdatawrite_range+0xfc/0x140
[  113.080261] x27: 0000000000000000 x26: 0000000000000000
[  113.083648]  filemap_write_and_wait+0x28/0x88
[  113.092413] x25: 0000000056000000 x24: 0000000000000015
[  113.095192]  __blkdev_put+0x80/0x258
[  113.098228] x23: ffff8000111ab000 x22: 0000000000000000
[  113.103525]  blkdev_put+0x4c/0x110
[  113.106561] x21: 0000000000000000 x20: 0000000000000000
[  113.109688]  blkdev_close+0x1c/0x28
[  113.112550] x19: 0000000000000cc0 x18: 0000000000000000
[  113.116372]  __fput+0x88/0x208
[  113.119321] x17: 0000000000000000 x16: 0000000000000000
[  113.125746]  ____fput+0xc/0x18
[  113.130605] x15: 0000000000000000 x14: 0000000000000000
[  113.135469]  task_work_run+0xc8/0xf8
[  113.139632] x13: 0000000000000000 x12: 0000000000000000
[  113.148664]  do_notify_resume+0x344/0x388
[  113.152826] x11: 0000000000000000 x10: 0000000000000000
[  113.157602]  work_pending+0x8/0x10
[  113.161940] x9 : 0000000000000000 x8 : 0000000000000000
[  113.166209] BUG: Bad page map in process dd  pte:20000b5275cfd3 pmd:b68c=
da003
[  113.169491] x7 : 0000000000000000 x6 : 0000000000000002
[  113.169494] x5 : 0000000000000000 x4 : 0000000000020802
[  113.174803] addr:0000aaaae7724000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b64190c60 1
[  113.180089] x3 : 0000000000000000 x2 : ffff8000110d9000
[  113.180092] x1 : 0000000000000cc0 x0 : 000000000000004c
[  113.180097] Call trace:
[  113.185406] file:dd fault:filemap_fault mmap:nfs_file_mmap
readpage:nfs_readpage
[  113.190690]  kmem_cache_alloc+0x104/0x160
[  113.190694]  getname_flags+0x44/0x1c8
[  113.190699]  getname+0x14/0x20
[  113.196001] CPU: 2 PID: 1060 Comm: dd Tainted: G    B D
5.4.0-xilinx-v2020.2 #1
[  113.201289]  do_sys_open+0xec/0x218
[  113.206582] Hardware name: xlnx,zynqmp (DT)
[  113.211878]  __arm64_sys_openat+0x20/0x28
[  113.217171] Call trace:
[  113.222470]  el0_svc_common.constprop.0+0x68/0x160
[  113.227763]  dump_backtrace+0x0/0x140
[  113.233059]  el0_svc_handler+0x6c/0x88
[  113.238352]  show_stack+0x14/0x20
[  113.243647]  el0_svc+0x8/0xc
[  113.248944]  dump_stack+0xac/0xd0
[  113.251374] Code: 52800001 9428e398 17ffffe9 37b00073 (b9402280)
[  113.255366]  print_bad_pte+0x164/0x1e8
[  113.259010] ---[ end trace 2627235d8e7d8d8d ]---
[  113.263004]  vm_normal_page+0x88/0xa8
[  113.266602] BUG: Bad page map in process systemd-journal
pte:20000b692cffd3 pmd:b69db4003
[  113.270815]  unmap_page_range+0x5d0/0xc48
[  113.270818]  unmap_single_vma+0x48/0xa0
[  113.270822]  unmap_vmas+0x6c/0xe0
[  113.275605] addr:0000aaaaabcb8000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b6a18f790 0
[  113.279330]  exit_mmap+0xc4/0x178
[  113.279334]  mmput+0x50/0x138
[  113.279339]  do_exit+0x270/0x9b8
[  113.282210] file:systemd-journald fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[  113.288279]  die+0x248/0x288
[  113.288282]  die_kernel_fault+0x60/0x70
[  113.288285]  __do_kernel_fault+0x84/0x120
[  113.288289]  do_page_fault+0x1cc/0x478
[  113.925841]  do_translation_fault+0x5c/0x78
[  113.930007]  do_mem_abort+0x3c/0x98
[  113.933479]  el1_da+0x1c/0x90
[  113.936431]  __wake_up_common+0x58/0x170
[  113.940337]  __wake_up_common_lock+0x98/0x110
[  113.944677]  __wake_up+0x14/0x20
[  113.947887]  wake_up_bit+0x78/0xa0
[  113.951273]  unlock_buffer+0x2c/0x38
[  113.954832]  end_buffer_async_write+0x98/0x1c0
[  113.959258]  end_bio_bh_io_sync+0x30/0x60
[  113.963252]  bio_endio+0x114/0x170
[  113.966638]  brd_make_request+0x1c8/0x1d0
[  113.970630]  generic_make_request+0xa4/0x2c8
[  113.974883]  submit_bio+0x3c/0x1a0
[  113.978268]  submit_bh_wbc+0x18c/0x1f8
[  113.982001]  __block_write_full_page+0x300/0x570
[  113.986601]  block_write_full_page+0x110/0x120
[  113.991028]  blkdev_writepage+0x18/0x20
[  113.994848]  __writepage+0x1c/0x80
[  113.998233]  write_cache_pages+0x170/0x370
[  114.002313]  generic_writepages+0x58/0x90
[  114.006305]  blkdev_writepages+0xc/0x18
[  114.010124]  do_writepages+0x50/0x100
[  114.013770]  __filemap_fdatawrite_range+0xfc/0x140
[  114.018544]  filemap_write_and_wait+0x28/0x88
[  114.022884]  __blkdev_put+0x80/0x258
[  114.026443]  blkdev_put+0x4c/0x110
[  114.029828]  blkdev_close+0x1c/0x28
[  114.033300]  __fput+0x88/0x208
[  114.036338]  ____fput+0xc/0x18
[  114.039376]  task_work_run+0xc8/0xf8
[  114.042936]  do_notify_resume+0x344/0x388
[  114.046927]  work_pending+0x8/0x10
[  114.050315] CPU: 0 PID: 379 Comm: systemd-journal Tainted: G    B D
          5.4.0-xilinx-v2020.2 #1
[  114.050322] BUG: Bad page map in process dd  pte:20000b5552ffd3 pmd:b68c=
da003
[  114.059521] Hardware name: xlnx,zynqmp (DT)
[  114.059522] Call trace:
[  114.059526]  dump_backtrace+0x0/0x140
[  114.059530]  show_stack+0x14/0x20
[  114.066655] addr:0000aaaae7725000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b64190c60 2
[  114.070817]  dump_stack+0xac/0xd0
[  114.070820]  print_bad_pte+0x164/0x1e8
[  114.070824]  vm_normal_page+0x88/0xa8
[  114.073260] file:dd fault:filemap_fault mmap:nfs_file_mmap
readpage:nfs_readpage
[  114.076900]  unmap_page_range+0x5d0/0xc48
[  114.076903]  unmap_single_vma+0x48/0xa0
[  114.076906]  unmap_vmas+0x6c/0xe0
[  114.076910]  exit_mmap+0xc4/0x178
[  114.122653]  mmput+0x50/0x138
[  114.125604]  do_exit+0x270/0x9b8
[  114.128815]  die+0x248/0x288
[  114.131680]  die_kernel_fault+0x60/0x70
[  114.135499]  __do_kernel_fault+0x84/0x120
[  114.139492]  do_page_fault+0x1cc/0x478
[  114.143225]  do_translation_fault+0x5c/0x78
[  114.147391]  do_mem_abort+0x3c/0x98
[  114.150863]  el1_da+0x1c/0x90
[  114.153815]  kmem_cache_alloc+0x104/0x160
[  114.157808]  getname_flags+0x44/0x1c8
[  114.161453]  getname+0x14/0x20
[  114.164491]  do_sys_open+0xec/0x218
[  114.167963]  __arm64_sys_openat+0x20/0x28
[  114.171957]  el0_svc_common.constprop.0+0x68/0x160
[  114.176730]  el0_svc_handler+0x6c/0x88
[  114.180462]  el0_svc+0x8/0xc
[  114.183329] CPU: 2 PID: 1060 Comm: dd Tainted: G    B D
5.4.0-xilinx-v2020.2 #1
[  114.183336] BUG: Bad page map in process systemd-journal
pte:20000b69b00fd3 pmd:b69db4003
[  114.191493] Hardware name: xlnx,zynqmp (DT)
[  114.191494] Call trace:
[  114.191497]  dump_backtrace+0x0/0x140
[  114.191502]  show_stack+0x14/0x20
[  114.199756] addr:0000aaaaabcb9000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b6a18f790 1
[  114.203916]  dump_stack+0xac/0xd0
[  114.203919]  print_bad_pte+0x164/0x1e8
[  114.203924]  vm_normal_page+0x88/0xa8
[  114.206361] file:systemd-journald fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[  114.210000]  unmap_page_range+0x5d0/0xc48
[  114.210003]  unmap_single_vma+0x48/0xa0
[  114.210006]  unmap_vmas+0x6c/0xe0
[  114.210011]  exit_mmap+0xc4/0x178
[  114.256969]  mmput+0x50/0x138
[  114.259920]  do_exit+0x270/0x9b8
[  114.263131]  die+0x248/0x288
[  114.265996]  die_kernel_fault+0x60/0x70
[  114.269815]  __do_kernel_fault+0x84/0x120
[  114.273808]  do_page_fault+0x1cc/0x478
[  114.277540]  do_translation_fault+0x5c/0x78
[  114.281706]  do_mem_abort+0x3c/0x98
[  114.285178]  el1_da+0x1c/0x90
[  114.288131]  __wake_up_common+0x58/0x170
[  114.292037]  __wake_up_common_lock+0x98/0x110
[  114.296377]  __wake_up+0x14/0x20
[  114.299587]  wake_up_bit+0x78/0xa0
[  114.302973]  unlock_buffer+0x2c/0x38
[  114.306532]  end_buffer_async_write+0x98/0x1c0
[  114.310958]  end_bio_bh_io_sync+0x30/0x60
[  114.314952]  bio_endio+0x114/0x170
[  114.318338]  brd_make_request+0x1c8/0x1d0
[  114.322329]  generic_make_request+0xa4/0x2c8
[  114.326582]  submit_bio+0x3c/0x1a0
[  114.329968]  submit_bh_wbc+0x18c/0x1f8
[  114.333700]  __block_write_full_page+0x300/0x570
[  114.338301]  block_write_full_page+0x110/0x120
[  114.342728]  blkdev_writepage+0x18/0x20
[  114.346548]  __writepage+0x1c/0x80
[  114.349933]  write_cache_pages+0x170/0x370
[  114.354013]  generic_writepages+0x58/0x90
[  114.358005]  blkdev_writepages+0xc/0x18
[  114.361823]  do_writepages+0x50/0x100
[  114.365470]  __filemap_fdatawrite_range+0xfc/0x140
[  114.370244]  filemap_write_and_wait+0x28/0x88
[  114.374584]  __blkdev_put+0x80/0x258
[  114.378143]  blkdev_put+0x4c/0x110
[  114.381528]  blkdev_close+0x1c/0x28
[  114.385000]  __fput+0x88/0x208
[  114.388038]  ____fput+0xc/0x18
[  114.391076]  task_work_run+0xc8/0xf8
[  114.394635]  do_notify_resume+0x344/0x388
[  114.398627]  work_pending+0x8/0x10
[  114.402015] CPU: 0 PID: 379 Comm: systemd-journal Tainted: G    B D
          5.4.0-xilinx-v2020.2 #1
[  114.402022] BUG: Bad page map in process dd  pte:20000b51bd4fd3 pmd:b68c=
da003
[  114.411221] Hardware name: xlnx,zynqmp (DT)
[  114.411222] Call trace:
[  114.411225]  dump_backtrace+0x0/0x140
[  114.411230]  show_stack+0x14/0x20
[  114.418356] addr:0000aaaae7726000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b64190c60 3
[  114.422516]  dump_stack+0xac/0xd0
[  114.422518]  print_bad_pte+0x164/0x1e8
[  114.422521]  vm_normal_page+0x88/0xa8
[  114.422526]  unmap_page_range+0x5d0/0xc48
[  114.424960] file:dd fault:filemap_fault mmap:nfs_file_mmap
readpage:nfs_readpage
[  114.428600]  unmap_single_vma+0x48/0xa0
[  114.428602]  unmap_vmas+0x6c/0xe0
[  114.428606]  exit_mmap+0xc4/0x178
[  114.428611]  mmput+0x50/0x138
[  114.477304]  do_exit+0x270/0x9b8
[  114.480515]  die+0x248/0x288
[  114.483380]  die_kernel_fault+0x60/0x70
[  114.487199]  __do_kernel_fault+0x84/0x120
[  114.491192]  do_page_fault+0x1cc/0x478
[  114.494924]  do_translation_fault+0x5c/0x78
[  114.499090]  do_mem_abort+0x3c/0x98
[  114.502562]  el1_da+0x1c/0x90
[  114.505515]  kmem_cache_alloc+0x104/0x160
[  114.509507]  getname_flags+0x44/0x1c8
[  114.513153]  getname+0x14/0x20
[  114.516190]  do_sys_open+0xec/0x218
[  114.519662]  __arm64_sys_openat+0x20/0x28
[  114.523657]  el0_svc_common.constprop.0+0x68/0x160
[  114.528430]  el0_svc_handler+0x6c/0x88
[  114.532162]  el0_svc+0x8/0xc
[  114.535028] CPU: 2 PID: 1060 Comm: dd Tainted: G    B D
5.4.0-xilinx-v2020.2 #1
[  114.535035] BUG: Bad page map in process systemd-journal
pte:20000b694abfd3 pmd:b69db4003
[  114.543193] Hardware name: xlnx,zynqmp (DT)
[  114.543194] Call trace:
[  114.543197]  dump_backtrace+0x0/0x140
[  114.543202]  show_stack+0x14/0x20
[  114.551455] addr:0000aaaaabcba000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b6a18f790 2
[  114.555616]  dump_stack+0xac/0xd0
[  114.555619]  print_bad_pte+0x164/0x1e8
[  114.555623]  vm_normal_page+0x88/0xa8
[  114.558061] file:systemd-journald fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[  114.561700]  unmap_page_range+0x5d0/0xc48
[  114.561703]  unmap_single_vma+0x48/0xa0
[  114.561706]  unmap_vmas+0x6c/0xe0
[  114.561710]  exit_mmap+0xc4/0x178
[  114.608669]  mmput+0x50/0x138
[  114.611619]  do_exit+0x270/0x9b8
[  114.614830]  die+0x248/0x288
[  114.617695]  die_kernel_fault+0x60/0x70
[  114.621515]  __do_kernel_fault+0x84/0x120
[  114.625507]  do_page_fault+0x1cc/0x478
[  114.629240]  do_translation_fault+0x5c/0x78
[  114.633406]  do_mem_abort+0x3c/0x98
[  114.636878]  el1_da+0x1c/0x90
[  114.639831]  __wake_up_common+0x58/0x170
[  114.643737]  __wake_up_common_lock+0x98/0x110
[  114.648077]  __wake_up+0x14/0x20
[  114.651287]  wake_up_bit+0x78/0xa0
[  114.654672]  unlock_buffer+0x2c/0x38
[  114.658231]  end_buffer_async_write+0x98/0x1c0
[  114.662658]  end_bio_bh_io_sync+0x30/0x60
[  114.666652]  bio_endio+0x114/0x170
[  114.670037]  brd_make_request+0x1c8/0x1d0
[  114.670258] Unable to handle kernel paging request at virtual
address ffffffffffffffe0
[  114.674031]  generic_make_request+0xa4/0x2c8
[  114.681932] Mem abort info:
[  114.686183]  submit_bio+0x3c/0x1a0
[  114.688960]   ESR =3D 0x96000004
[  114.692345]  submit_bh_wbc+0x18c/0x1f8
[  114.695384]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  114.699116]  __block_write_full_page+0x300/0x570
[  114.704410]   SET =3D 0, FnV =3D 0
[  114.709011]  block_write_full_page+0x110/0x120
[  114.712049]   EA =3D 0, S1PTW =3D 0
[  114.716476]  blkdev_writepage+0x18/0x20
[  114.719600] Data abort info:
[  114.723421]  __writepage+0x1c/0x80
[  114.726284]   ISV =3D 0, ISS =3D 0x00000004
[  114.729670]  write_cache_pages+0x170/0x370
[  114.733489]   CM =3D 0, WnR =3D 0
[  114.737569]  generic_writepages+0x58/0x90
[  114.740521] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000010040=
00
[  114.744513]  blkdev_writepages+0xc/0x18
[  114.751196] [ffffffffffffffe0] pgd=3D0000000000000000
[  114.755015]  do_writepages+0x50/0x100
[  114.759877] Internal error: Oops: 96000004 [#5] SMP
[  114.763523]  __filemap_fdatawrite_range+0xfc/0x140
[  114.768381] Modules linked in: br_netfilter
[  114.773157]  filemap_write_and_wait+0x28/0x88
[  114.777324] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G    B D
  5.4.0-xilinx-v2020.2 #1
[  114.781664]  __blkdev_put+0x80/0x258
[  114.790168] Hardware name: xlnx,zynqmp (DT)
[  114.793729]  blkdev_put+0x4c/0x110
[  114.797895] pstate: 00000005 (nzcv daif -PAN -UAO)
[  114.801280]  blkdev_close+0x1c/0x28
[  114.806058] pc : dev_gro_receive+0x25c/0x6c0
[  114.809527]  __fput+0x88/0x208
[  114.813780] lr : napi_gro_receive+0x30/0xc8
[  114.816818]  ____fput+0xc/0x18
[  114.820982] sp : ffff80001001bcf0
[  114.824023]  task_work_run+0xc8/0xf8
[  114.827319] x29: ffff80001001bcf0 x28: 0000000000000000
[  114.830881]  do_notify_resume+0x344/0x388
[  114.836173] x27: 000000008000c03c x26: ffff000b6a9708a0
[  114.840167]  work_pending+0x8/0x10
[  114.845460] x25: 0000000000000000 x24: 000000000000000e
[  114.848849] CPU: 0 PID: 379 Comm: systemd-journal Tainted: G    B D
          5.4.0-xilinx-v2020.2 #1
[  114.848857] BUG: Bad page map in process dd  pte:20000b50cdcfd3 pmd:b68c=
da003
[  114.848864] addr:0000aaaae7727000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b64190c60 4
[  114.848873] file:dd fault:filemap_fault mmap:nfs_file_mmap
readpage:nfs_readpage
[  114.854141] x23: ffff000b6a9708d8 x22: 0000000000000000
[  114.863342] Hardware name: xlnx,zynqmp (DT)
[  114.870459] x21: ffff8000110ddb98 x20: ffff000b68fcbf28
[  114.880441] Call trace:
[  114.887819] x19: ffff000b68fcbf00 x18: fffffe002d758f88
[  114.893116]  dump_backtrace+0x0/0x140
[  114.897281] x17: ffff000b6c001088 x16: ffff000b6c0010a8
[  114.902577]  show_stack+0x14/0x20
[  114.905006] x15: 0001000000000000 x14: ffffffffe95988c3
[  114.910303]  dump_stack+0xac/0xd0
[  114.913946] x13: 003d08a7b5905ad6 x12: 00003d08ffff8ff4
[  114.919243]  print_bad_pte+0x164/0x1e8
[  114.922540] x11: 000000000000700c x10: 0000000000000040
[  114.927836]  vm_normal_page+0x88/0xa8
[  114.931133] x9 : ffff000b6a9708a0 x8 : ffff8000110f5360
[  114.936429]  unmap_page_range+0x5d0/0xc48
[  114.940160] x7 : 0000000000000000 x6 : ffff000b454a78c0
[  114.945456]  unmap_single_vma+0x48/0xa0
[  114.949101] x5 : ffff000b68fcbf28 x4 : 0000000000000000
[  114.954397]  unmap_vmas+0x6c/0xe0
[  114.958388] x3 : 0000000000005a93 x2 : 0000000000000000
[  114.963685]  exit_mmap+0xc4/0x178
[  114.967503] x1 : ffffffffffffffe0 x0 : ffff8000110de3a8
[  114.972800]  mmput+0x50/0x138
[  114.976095] Call trace:
[  114.981392]  do_exit+0x270/0x9b8
[  114.984691]  dev_gro_receive+0x25c/0x6c0
[  114.989985]  die+0x248/0x288
[  114.992937]  napi_gro_receive+0x30/0xc8
[  114.995367]  die_kernel_fault+0x60/0x70
[  114.998581]  gem_rx+0x188/0x2b8
[  115.002485]  __do_kernel_fault+0x84/0x120
[  115.005349]  macb_poll+0x58/0x100
[  115.009168]  do_page_fault+0x1cc/0x478
[  115.010933] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000020
[  115.010934] Mem abort info:
[  115.010936]   ESR =3D 0x96000004
[  115.010938]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  115.010940]   SET =3D 0, FnV =3D 0
[  115.010942]   EA =3D 0, S1PTW =3D 0
[  115.010943] Data abort info:
[  115.010944]   ISV =3D 0, ISS =3D 0x00000004
[  115.010946]   CM =3D 0, WnR =3D 0
[  115.010948] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000b66d8d000
[  115.010950] [0000000000000020] pgd=3D0000000000000000
[  115.012988]  net_rx_action+0x114/0x340
[  115.016113]  do_translation_fault+0x5c/0x78
[  115.020105]  __do_softirq+0x118/0x22c
[  115.023403]  do_mem_abort+0x3c/0x98
[  115.027138]  irq_exit+0x98/0xc0
[  115.035903]  el1_da+0x1c/0x90
[  115.038682]  __handle_domain_irq+0x64/0xb8
[  115.041720]  kmem_cache_alloc+0x104/0x160
[  115.047013]  gic_handle_irq+0x5c/0xb8
[  115.050052]  getname_flags+0x44/0x1c8
[  115.053176]  el1_irq+0xb8/0x140
[  115.056041]  getname+0x14/0x20
[  115.059860]  arch_cpu_idle+0x10/0x18
[  115.062812]  do_sys_open+0xec/0x218
[  115.069235]  do_idle+0x200/0x280
[  115.074095]  __arm64_sys_openat+0x20/0x28
[  115.077828]  cpu_startup_entry+0x20/0x28
[  115.081996]  el0_svc_common.constprop.0+0x68/0x160
[  115.085641]  secondary_start_kernel+0x11c/0x158
[  115.089113]  el0_svc_handler+0x6c/0x88
[  115.092239] Code: aa0103f9 d1008021 eb00033f 54000620 (79400022)
[  115.095188]  el0_svc+0x8/0xc
[  115.099271] ---[ end trace 2627235d8e7d8d8e ]---
[  115.103262] CPU: 2 PID: 1060 Comm: dd Tainted: G    B D
5.4.0-xilinx-v2020.2 #1
[  115.103270] BUG: Bad page map in process systemd-journal
pte:20000b68b25fd3 pmd:b69db4003
[  115.103274] addr:0000aaaaabcbb000 vm_flags:00000875
anon_vma:0000000000000000 mapping:ffff000b6a18f790 3
[  115.103281] file:systemd-journald fault:filemap_fault
mmap:nfs_file_mmap readpage:nfs_readpage
[  115.106905] Kernel panic - not syncing: Fatal exception in interrupt
[  115.110550] Hardware name: xlnx,zynqmp (DT)
[  115.113675] SMP: stopping secondary CPUs
[  115.116712] Call trace:
[  115.213236]  dump_backtrace+0x0/0x140
[  115.216882]  show_stack+0x14/0x20
[  115.220181]  dump_stack+0xac/0xd0
[  115.223478]  print_bad_pte+0x164/0x1e8
[  115.227211]  vm_normal_page+0x88/0xa8
[  115.230857]  unmap_page_range+0x5d0/0xc48
[  115.234849]  unmap_single_vma+0x48/0xa0
[  115.238668]  unmap_vmas+0x6c/0xe0
[  115.241968]  exit_mmap+0xc4/0x178
[  115.245266]  mmput+0x50/0x138
[  115.248217]  do_exit+0x270/0x9b8
[  115.251428]  die+0x248/0x288
[  115.254293]  die_kernel_fault+0x60/0x70
[  115.258112]  __do_kernel_fault+0x84/0x120
[  115.262105]  do_page_fault+0x1cc/0x478
[  115.265838]  do_translation_fault+0x5c/0x78
[  115.270004]  do_mem_abort+0x3c/0x98
[  115.273476]  el1_da+0x1c/0x90
[  115.276428]  __wake_up_common+0x58/0x170
[  115.280334]  __wake_up_common_lock+0x98/0x110
[  115.284674]  __wake_up+0x14/0x20
[  115.287884]  wake_up_bit+0x78/0xa0
[  115.291270]  unlock_buffer+0x2c/0x38
[  115.294829]  end_buffer_async_write+0x98/0x1c0
[  115.299256]  end_bio_bh_io_sync+0x30/0x60
[  115.303249]  bio_endio+0x114/0x170
[  115.306635]  brd_make_request+0x1c8/0x1d0
[  115.310627]  generic_make_request+0xa4/0x2c8
[  115.314880]  submit_bio+0x3c/0x1a0
[  115.318265]  submit_bh_wbc+0x18c/0x1f8
[  115.321998]  __block_write_full_page+0x300/0x570
[  115.326598]  block_write_full_page+0x110/0x120
[  115.331025]  blkdev_writepage+0x18/0x20
[  115.334845]  __writepage+0x1c/0x80
[  115.338230]  write_cache_pages+0x170/0x370
[  115.342310]  generic_writepages+0x58/0x90
[  115.346302]  blkdev_writepages+0xc/0x18
[  115.350121]  do_writepages+0x50/0x100
[  115.353767]  __filemap_fdatawrite_range+0xfc/0x140
[  115.358541]  filemap_write_and_wait+0x28/0x88
[  115.362881]  __blkdev_put+0x80/0x258
[  115.366440]  blkdev_put+0x4c/0x110
[  115.369825]  blkdev_close+0x1c/0x28
[  115.373297]  __fput+0x88/0x208
[  115.376335]  ____fput+0xc/0x18
[  115.379373]  task_work_run+0xc8/0xf8
[  115.382933]  do_notify_resume+0x344/0x388
[  115.386925]  work_pending+0x8/0x10
[  116.168068] SMP: failed to stop secondary CPUs 1,3
[  116.172845] Kernel Offset: disabled
[  116.176318] CPU features: 0x0002,20002004
[  116.180309] Memory Limit: none
[  116.183351] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---
Xilinx Zynq MP First Stage Boot Loader
Release 2020.2   Nov 18 2021  -  19:48:02


Thanks all !
T J (Chris) Ward, IBM Research.
Scalable Data-Centric Computing - IBM Spectrum MPI
IBM United Kingdom Ltd., Hursley Park, Winchester, Hants, SO21 2JN
011-44-1962-818679
LinkedIn https://www.linkedin.com/in/tjcward/
ResearchGate https://www.researchgate.net/profile/Thomas_Ward16


Unless stated otherwise above:
IBM United Kingdom Limited - Registered in England and Wales with number 74=
1598.
Registered office: PO Box 41, North Harbour, Portsmouth, Hampshire PO6 3AU
