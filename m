Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E92550AA5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiFSMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFSMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:35:12 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486EA55A5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:35:11 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id q13-20020a5d9f0d000000b00669c03397f7so4891418iot.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uHElYmQOE6ssyMoMd11chu18AJnhjDl6vf9dYR/Ja/c=;
        b=GbDOzF+gILwCXaJ+1x5k2vOKmfY1fcCkTxfZIrd0d7kfKqsfcc9V5zhoSYY3m/6XoH
         8Emzd4udiBFrxfNEIu+QePXmtRur3G55PQYmDYSmZxRop5u0EFHPp5ox+hcvMZkb9s00
         UF3S3mJ7pUUxV0OXcRx6+8nKZuf0DqqbpPUyDXR0iANoVv39eJx/1Qp3kAUGUEOp07gn
         8vvRXqfsTOAzxlIx+qYVawMINWBgJ3B++3ZoLIuBJcuiNqNSjdrx9H0anDd4FOqN8Nrg
         Wu5OmbAsN9faXXYiBBHGd7SoV+uupVZ4O5mTFvKGo9zuqLF4XdlwyeFzGUNNtY/FiOPw
         5uaw==
X-Gm-Message-State: AJIora/g6pCxxNG6Bbx6DseT1Bn4TFTiZQ+ioat29QYee9D59j8VUc+z
        qT4R+FEvUnV6LlxRIlaM+dkZdNJldD67GnLP7eH1/tFLjtj3
X-Google-Smtp-Source: AGRyM1v3sYWqv+sioxi7bwRwI5+Ed0D4Iv+wKDWExhTHe95541+Saqfb0iR1E/x6MOZmf6i72HkzitOJvUKpA/un3A0HUH9t08k5
MIME-Version: 1.0
X-Received: by 2002:a92:d8d1:0:b0:2d8:f317:4b02 with SMTP id
 l17-20020a92d8d1000000b002d8f3174b02mr4766886ilo.154.1655642110649; Sun, 19
 Jun 2022 05:35:10 -0700 (PDT)
Date:   Sun, 19 Jun 2022 05:35:10 -0700
In-Reply-To: <20220619121654.313-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e16ed705e1cc376b@google.com>
Subject: Re: [syzbot] possible deadlock in console_lock_spinning_enable (2)
From:   syzbot <syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

[   10.802014][    T1] Simple TC action Loaded
[   10.806041][    T1] netem: version 1.3
[   10.807714][    T1] u32 classifier
[   10.808804][    T1]     Performance counters on
[   10.810052][    T1]     input device check on
[   10.811533][    T1]     Actions configured
[   10.815988][    T1] nf_conntrack_irc: failed to register helpers
[   10.817441][    T1] nf_conntrack_sane: failed to register helpers
[   10.821557][    T1] nf_conntrack_sip: failed to register helpers
[   10.828450][    T1] xt_time: kernel timezone is -0000
[   10.830022][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   10.831890][    T1] IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
[   10.834704][    T1] IPVS: ipvs loaded.
[   10.835491][    T1] IPVS: [rr] scheduler registered.
[   10.836322][    T1] IPVS: [wrr] scheduler registered.
[   10.837408][    T1] IPVS: [lc] scheduler registered.
[   10.838559][    T1] IPVS: [wlc] scheduler registered.
[   10.839491][    T1] IPVS: [fo] scheduler registered.
[   10.840419][    T1] IPVS: [ovf] scheduler registered.
[   10.841754][    T1] IPVS: [lblc] scheduler registered.
[   10.842740][    T1] IPVS: [lblcr] scheduler registered.
[   10.844313][    T1] IPVS: [dh] scheduler registered.
[   10.845800][    T1] IPVS: [sh] scheduler registered.
[   10.846728][    T1] IPVS: [mh] scheduler registered.
[   10.847666][    T1] IPVS: [sed] scheduler registered.
[   10.848884][    T1] IPVS: [nq] scheduler registered.
[   10.850158][    T1] IPVS: [twos] scheduler registered.
[   10.851507][    T1] IPVS: [sip] pe registered.
[   10.852406][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   10.856743][    T1] gre: GRE over IPv4 demultiplexor driver
[   10.858592][    T1] ip_gre: GRE over IPv4 tunneling driver
[   10.867380][    T1] IPv4 over IPsec tunneling driver
[   10.871527][    T1] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[   10.875103][    T1] Initializing XFRM netlink socket
[   10.876272][    T1] IPsec XFRM device driver
[   10.879599][    T1] NET: Registered PF_INET6 protocol family
[   10.895773][    T1] Segment Routing with IPv6
[   10.896808][    T1] RPL Segment Routing with IPv6
[   10.898085][    T1] In-situ OAM (IOAM) with IPv6
[   10.899644][    T1] mip6: Mobile IPv6
[   10.904459][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   10.913264][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   10.918162][    T1] NET: Registered PF_PACKET protocol family
[   10.919995][    T1] NET: Registered PF_KEY protocol family
[   10.921942][    T1] Bridge firewalling registered
[   10.923841][    T1] NET: Registered PF_X25 protocol family
[   10.925469][    T1] X25: Linux Version 0.2
[   10.972954][    T1] NET: Registered PF_NETROM protocol family
[   11.021612][    T1] NET: Registered PF_ROSE protocol family
[   11.023444][    T1] NET: Registered PF_AX25 protocol family
[   11.026495][    T1] can: controller area network core
[   11.029127][    T1] NET: Registered PF_CAN protocol family
[   11.030384][    T1] can: raw protocol
[   11.031262][    T1] can: broadcast manager protocol
[   11.032209][    T1] can: netlink gateway - max_hops=1
[   11.033734][    T1] can: SAE J1939
[   11.035093][    T1] can: isotp protocol
[   11.036248][    T1] Bluetooth: RFCOMM TTY layer initialized
[   11.037955][    T1] Bluetooth: RFCOMM socket layer initialized
[   11.039643][    T1] Bluetooth: RFCOMM ver 1.11
[   11.040831][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   11.041848][    T1] Bluetooth: BNEP filters: protocol multicast
[   11.043280][    T1] Bluetooth: BNEP socket layer initialized
[   11.045263][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   11.046599][    T1] Bluetooth: CMTP socket layer initialized
[   11.047621][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   11.049430][    T1] Bluetooth: HIDP socket layer initialized
[   11.056271][    T1] NET: Registered PF_RXRPC protocol family
[   11.057506][    T1] Key type rxrpc registered
[   11.058461][    T1] Key type rxrpc_s registered
[   11.061172][    T1] NET: Registered PF_KCM protocol family
[   11.062624][    T1] lec:lane_module_init: lec.c: initialized
[   11.063962][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   11.066032][    T1] l2tp_core: L2TP core driver, V2.0
[   11.067399][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   11.068261][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   11.070183][    T1] l2tp_netlink: L2TP netlink interface
[   11.071402][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   11.072721][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   11.075132][    T1] NET: Registered PF_PHONET protocol family
[   11.077079][    T1] 8021q: 802.1Q VLAN Support v1.8
[   11.088753][    T1] DCCP: Activated CCID 2 (TCP-like)
[   11.090644][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   11.094975][    T1] sctp: Hash tables configured (bind 32/56)
[   11.098655][    T1] NET: Registered PF_RDS protocol family
[   11.100754][    T1] Registered RDS/infiniband transport
[   11.103576][    T1] Registered RDS/tcp transport
[   11.104649][    T1] tipc: Activated (version 2.0.0)
[   11.106531][    T1] NET: Registered PF_TIPC protocol family
[   11.108185][    T1] tipc: Started in single node mode
[   11.110008][    T1] NET: Registered PF_SMC protocol family
[   11.111963][    T1] 9pnet: Installing 9P2000 support
[   11.114190][    T1] NET: Registered PF_CAIF protocol family
[   11.121488][    T1] NET: Registered PF_IEEE802154 protocol family
[   11.123184][    T1] Key type dns_resolver registered
[   11.124574][    T1] Key type ceph registered
[   11.126408][    T1] libceph: loaded (mon/osd proto 15/24)
[   11.130146][    T1] batman_adv: B.A.T.M.A.N. advanced 2021.3 (compatibility version 15) loaded
[   11.131683][    T1] openvswitch: Open vSwitch switching datapath
[   11.137487][    T1] NET: Registered PF_VSOCK protocol family
[   11.138831][    T1] mpls_gso: MPLS GSO support
[   11.148136][    T1] IPI shorthand broadcast: enabled
[   11.149291][    T1] AVX2 version of gcm_enc/dec engaged.
[   11.150798][    T1] AES CTR mode by8 optimization enabled
[   11.155757][    T1] sched_clock: Marking stable (11128465327, 27129818)->(11161429034, -5833889)
[   11.159736][    T1] registered taskstats version 1
[   11.169377][    T1] Loading compiled-in X.509 certificates
[   11.173978][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
[   11.179898][    T1] zswap: loaded using pool lzo/zbud
[   11.183624][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   13.358140][    T1] Key type ._fscrypt registered
[   13.360032][    T1] Key type .fscrypt registered
[   13.361849][    T1] Key type fscrypt-provisioning registered
[   13.371180][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   13.373825][    T1] FS-Cache: Netfs 'afs' registered for caching
[   13.386734][    T1] Btrfs loaded, crc32c=crc32c-intel, assert=on, zoned=yes, fsverity=yes
[   13.396616][    T1] Key type big_key registered
[   13.405906][    T1] Key type encrypted registered
[   13.411212][    T1] ima: No TPM chip found, activating TPM-bypass!
[   13.417707][    T1] Loading compiled-in module X.509 certificates
[   13.424860][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
[   13.436509][    T1] ima: Allocated hash algorithm: sha256
[   13.442596][    T1] ima: No architecture policies found
[   13.448375][    T1] evm: Initialising EVM extended attributes:
[   13.454408][    T1] evm: security.selinux (disabled)
[   13.459503][    T1] evm: security.SMACK64
[   13.463910][    T1] evm: security.SMACK64EXEC
[   13.468455][    T1] evm: security.SMACK64TRANSMUTE
[   13.473460][    T1] evm: security.SMACK64MMAP
[   13.477995][    T1] evm: security.apparmor (disabled)
[   13.483185][    T1] evm: security.ima
[   13.487216][    T1] evm: security.capability
[   13.491723][    T1] evm: HMAC attrs: 0x1
[   13.589003][    T1] PM:   Magic number: 10:75:431
[   13.599513][    T1] printk: console [netcon0] enabled
[   13.605434][    T1] netconsole: network logging started
[   13.611823][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   13.621725][    T1] rdma_rxe: loaded
[   13.626413][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.638663][    T1] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.648527][  T919] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   13.656733][    T1] ALSA device list:
[   13.658843][  T919] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   13.662202][    T1]   #0: Dummy 1
[   13.674383][    T1]   #1: Loopback 1
[   13.678273][    T1]   #2: Virtual MIDI Card 1
[   13.686523][    T1] md: Waiting for all devices to be available before autodetect
[   13.694420][    T1] md: If you don't use raid, use raid=noautodetect
[   13.701108][    T1] md: Autodetecting RAID arrays.
[   13.706435][    T1] md: autorun ...
[   13.710407][    T1] md: ... autorun DONE.
[   13.764392][    T1] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[   13.776436][    T1] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   13.809223][    T1] devtmpfs: mounted
[   13.877590][    T1] Freeing unused kernel image (initmem) memory: 3820K
[   13.884779][    T1] Write protecting the kernel read-only data: 169984k
[   13.897551][    T1] Freeing unused kernel image (text/rodata gap) memory: 2012K
[   13.909309][    T1] Freeing unused kernel image (rodata/data gap) memory: 1648K
[   13.923952][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
[   13.936282][    T1] Run /sbin/init as init process
[   14.412276][ T2936] mount (2936) used greatest stack depth: 24032 bytes left
[   14.443897][ T2937] EXT4-fs (sda1): re-mounted. Opts: (null). Quota mode: none.
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or directory
mount: mounting mqueue on /dev/mqueue failed: No such file or di[   14.560305][ T2939] mount (2939) used greatest stack depth: 21664 bytes left
rectory
mount: mounting hugetlbfs on /dev/hugepages failed: No such file or directory
mount: mounting fuse.lxcfs on /var/lib/lxcfs failed: No such file or directory
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: [   15.142288][ T2966] logger (2966) used greatest stack depth: 21264 bytes left
OK
Populating /dev using udev: [   15.355331][ T2968] udevd[2968]: starting version 3.2.10
[   15.518137][ T2969] udevd[2969]: starting eudev-3.2.10
[   15.520485][ T2968] udevd (2968) used greatest stack depth: 20544 bytes left
[   21.510608][ T3058] ================================================================================
[   21.614370][ T3058] UBSAN: object-size-mismatch in net/unix/af_unix.c:977:14
[   21.621715][ T3058] member access within address ffff8880152f2fcc with insufficient space
[   21.721756][ T3058] for an object of type 'struct sockaddr_un'
[   21.778735][ T3058] CPU: 0 PID: 3058 Comm: udevadm Not tainted 5.16.0-rc4-syzkaller-00161-gc741e49150db-dirty #0
[   21.789827][ T3058] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   21.799915][ T3058] Call Trace:
[   21.803217][ T3058]  <TASK>
[   21.806249][ T3058]  dump_stack_lvl+0x1e3/0x2cb
[   21.810967][ T3058]  ? bfq_pos_tree_add_move+0x451/0x451
[   21.817185][ T3058]  ? panic+0x7e3/0x7e3
[   21.821585][ T3058]  ubsan_type_mismatch_common+0x1e6/0x390
[   21.827540][ T3058]  __ubsan_handle_type_mismatch_v1+0x4a/0x60
[   21.833746][ T3058]  unix_autobind+0x129/0x4d0
[   21.838466][ T3058]  ? tomoyo_socket_connect_permission+0x1dc/0x300
[   21.845190][ T3058]  unix_stream_connect+0x896/0x1010
[   21.850428][ T3058]  ? unix_bind+0x9a0/0x9a0
[   21.854864][ T3058]  ? bpf_lsm_socket_connect+0x5/0x10
[   21.860278][ T3058]  ? __sys_connect_file+0xbd/0x170
[   21.865620][ T3058]  ? __x64_sys_connect+0x148/0x1e0
[   21.870845][ T3058]  __x64_sys_connect+0x15b/0x1e0
[   21.875813][ T3058]  ? __sys_connect+0x170/0x170
[   21.880697][ T3058]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   21.886700][ T3058]  ? lockdep_hardirqs_on+0x95/0x140
[   21.892033][ T3058]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   21.898132][ T3058]  do_syscall_64+0x44/0xa0
[   21.902678][ T3058]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   21.908660][ T3058] RIP: 0033:0x7f647d4e3d23
[   21.913184][ T3058] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 18 89 54 24 0c 48
[   21.932989][ T3058] RSP: 002b:00007ffd414990b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
[   21.941845][ T3058] RAX: ffffffffffffffda RBX: 00005610bca2f930 RCX: 00007f647d4e3d23
[   21.949954][ T3058] RDX: 0000000000000013 RSI: 00005610bca2f948 RDI: 0000000000000003
[   21.958122][ T3058] RBP: 000000000000001e R08: 000000000000001e R09: 0030312e322e332d
[   21.966217][ T3058] R10: 00007ffd41499204 R11: 0000000000000246 R12: 00007ffd414990d0
[   21.974216][ T3058] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000007
[   21.982245][ T3058]  </TASK>
[   22.431726][ T3058] ================================================================================
[   22.584101][ T3058] Kernel panic - not syncing: panic_on_warn set ...
[   22.591436][ T3058] CPU: 1 PID: 3058 Comm: udevadm Not tainted 5.16.0-rc4-syzkaller-00161-gc741e49150db-dirty #0
[   22.602145][ T3058] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   22.612502][ T3058] Call Trace:
[   22.615801][ T3058]  <TASK>
[   22.618827][ T3058]  dump_stack_lvl+0x1e3/0x2cb
[   22.623960][ T3058]  ? bfq_pos_tree_add_move+0x451/0x451
[   22.629581][ T3058]  ? panic+0x7e3/0x7e3
[   22.633808][ T3058]  panic+0x2f1/0x7e3
[   22.637988][ T3058]  ? ubsan_type_mismatch_common+0x20a/0x390
[   22.644259][ T3058]  ? fb_is_primary_device+0xcc/0xcc
[   22.649491][ T3058]  ? panic+0x7e3/0x7e3
[   22.653754][ T3058]  ubsan_type_mismatch_common+0x38c/0x390
[   22.659522][ T3058]  __ubsan_handle_type_mismatch_v1+0x4a/0x60
[   22.665536][ T3058]  unix_autobind+0x129/0x4d0
[   22.670153][ T3058]  ? tomoyo_socket_connect_permission+0x1dc/0x300
[   22.676725][ T3058]  unix_stream_connect+0x896/0x1010
[   22.682052][ T3058]  ? unix_bind+0x9a0/0x9a0
[   22.686493][ T3058]  ? bpf_lsm_socket_connect+0x5/0x10
[   22.691811][ T3058]  ? __sys_connect_file+0xbd/0x170
[   22.696954][ T3058]  ? __x64_sys_connect+0x148/0x1e0
[   22.702096][ T3058]  __x64_sys_connect+0x15b/0x1e0
[   22.707072][ T3058]  ? __sys_connect+0x170/0x170
[   22.712396][ T3058]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   22.718411][ T3058]  ? lockdep_hardirqs_on+0x95/0x140
[   22.723725][ T3058]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   22.730002][ T3058]  do_syscall_64+0x44/0xa0
[   22.734580][ T3058]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   22.740704][ T3058] RIP: 0033:0x7f647d4e3d23
[   22.745145][ T3058] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 18 89 54 24 0c 48
[   22.764784][ T3058] RSP: 002b:00007ffd414990b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
[   22.773481][ T3058] RAX: ffffffffffffffda RBX: 00005610bca2f930 RCX: 00007f647d4e3d23
[   22.781474][ T3058] RDX: 0000000000000013 RSI: 00005610bca2f948 RDI: 0000000000000003
[   22.789466][ T3058] RBP: 000000000000001e R08: 000000000000001e R09: 0030312e322e332d
[   22.797548][ T3058] R10: 00007ffd41499204 R11: 0000000000000246 R12: 00007ffd414990d0
[   22.805626][ T3058] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000007
[   22.813634][ T3058]  </TASK>
[   22.817049][ T3058] Kernel Offset: disabled
[   22.821577][ T3058] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=13ea0818080000


Tested on:

commit:         c741e491 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=308b87e56290f642
dashboard link: https://syzkaller.appspot.com/bug?extid=3cc1054e15babd5f4cd2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1472f954080000

