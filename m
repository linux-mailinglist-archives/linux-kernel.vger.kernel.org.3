Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81B550C22
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiFSQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFSQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:42:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C90CE34
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:42:09 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n12-20020a92260c000000b002d3c9fc68d6so6061244ile.19
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zEVVFfG8OJqN8UCtsz3GzGKDZEw5xDwgnm/h27INUZw=;
        b=I6CnlZIAMQDe8UrZ3WHBPDK3TNWkR4lRrM0ktEIegebgcxYJs/cdw1kurwdQV+Vg+z
         MHH4cK/SMExdn4IT9L8fnxNsHbDHUDOReJWh+Fjgk7iaJYqHbhgeQJD/xcNAcohfjw8D
         Nd+IsUgp2zvDQY8+Hfz+ms16ltf4LTrapAWqkYBFrHEjRa82EwIyboqnICMgyiXomJzA
         rdrLbrRrA7aRdLt7RyMU/2On7eB051Yt+hNJGEAz3rMTaMWqCCeGwPiNo15LZm7SOaVy
         kQT36+S2G8H/fmoJn6gPsO7ITccW6KkhijkuWER2WW5ri6kQgrksYbxxOHbLOoV30w3s
         zGdQ==
X-Gm-Message-State: AJIora8m8HexcdzymXyL2hzSg+EjU3gGktJputx4V4Am9G6FI+HBZIJf
        IYM1SMm6/+CeW2PeyenA/fZE7fzxPT3aFA/Nju2NJsDJv+aV
X-Google-Smtp-Source: AGRyM1tmQcyPJ7L/QBclQfvxJhZ7ORVLS75cFBNh3dXWY8IVueXxS0G1mpyhoRBGRqsOj3Zv+L2yIxU7wiVeQfKaYHq41VbzbGnE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d94:b0:331:7980:af97 with SMTP id
 l20-20020a0566380d9400b003317980af97mr11062036jaj.26.1655656928609; Sun, 19
 Jun 2022 09:42:08 -0700 (PDT)
Date:   Sun, 19 Jun 2022 09:42:08 -0700
In-Reply-To: <20220619133032.381-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000198bb405e1cfabfc@google.com>
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

733894][    T1] nf_conntrack_irc: failed to register helpers
[    9.735393][    T1] nf_conntrack_sane: failed to register helpers
[    9.738647][    T1] nf_conntrack_sip: failed to register helpers
[    9.744443][    T1] xt_time: kernel timezone is -0000
[    9.746343][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[    9.748347][    T1] IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
[    9.750263][    T1] IPVS: ipvs loaded.
[    9.751181][    T1] IPVS: [rr] scheduler registered.
[    9.752409][    T1] IPVS: [wrr] scheduler registered.
[    9.753418][    T1] IPVS: [lc] scheduler registered.
[    9.754260][    T1] IPVS: [wlc] scheduler registered.
[    9.755407][    T1] IPVS: [fo] scheduler registered.
[    9.756393][    T1] IPVS: [ovf] scheduler registered.
[    9.758180][    T1] IPVS: [lblc] scheduler registered.
[    9.759670][    T1] IPVS: [lblcr] scheduler registered.
[    9.760978][    T1] IPVS: [dh] scheduler registered.
[    9.762122][    T1] IPVS: [sh] scheduler registered.
[    9.763108][    T1] IPVS: [mh] scheduler registered.
[    9.764073][    T1] IPVS: [sed] scheduler registered.
[    9.765581][    T1] IPVS: [nq] scheduler registered.
[    9.766717][    T1] IPVS: [twos] scheduler registered.
[    9.767890][    T1] IPVS: [sip] pe registered.
[    9.769097][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    9.772940][    T1] gre: GRE over IPv4 demultiplexor driver
[    9.775256][    T1] ip_gre: GRE over IPv4 tunneling driver
[    9.783020][    T1] IPv4 over IPsec tunneling driver
[    9.787176][    T1] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    9.789164][    T1] Initializing XFRM netlink socket
[    9.790288][    T1] IPsec XFRM device driver
[    9.793369][    T1] NET: Registered PF_INET6 protocol family
[    9.806445][    T1] Segment Routing with IPv6
[    9.807546][    T1] RPL Segment Routing with IPv6
[    9.808892][    T1] In-situ OAM (IOAM) with IPv6
[    9.810163][    T1] mip6: Mobile IPv6
[    9.814261][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    9.823034][    T1] ip6_gre: GRE over IPv6 tunneling driver
[    9.827601][    T1] NET: Registered PF_PACKET protocol family
[    9.829247][    T1] NET: Registered PF_KEY protocol family
[    9.831023][    T1] Bridge firewalling registered
[    9.832598][    T1] NET: Registered PF_X25 protocol family
[    9.833907][    T1] X25: Linux Version 0.2
[    9.877600][    T1] NET: Registered PF_NETROM protocol family
[    9.919929][    T1] NET: Registered PF_ROSE protocol family
[    9.922618][    T1] NET: Registered PF_AX25 protocol family
[    9.924364][    T1] can: controller area network core
[    9.926445][    T1] NET: Registered PF_CAN protocol family
[    9.927484][    T1] can: raw protocol
[    9.928285][    T1] can: broadcast manager protocol
[    9.929768][    T1] can: netlink gateway - max_hops=1
[    9.931513][    T1] can: SAE J1939
[    9.932476][    T1] can: isotp protocol
[    9.934137][    T1] Bluetooth: RFCOMM TTY layer initialized
[    9.936704][    T1] Bluetooth: RFCOMM socket layer initialized
[    9.938406][    T1] Bluetooth: RFCOMM ver 1.11
[    9.939497][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.940847][    T1] Bluetooth: BNEP filters: protocol multicast
[    9.942188][    T1] Bluetooth: BNEP socket layer initialized
[    9.943175][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[    9.944837][    T1] Bluetooth: CMTP socket layer initialized
[    9.946399][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    9.947644][    T1] Bluetooth: HIDP socket layer initialized
[    9.952472][    T1] NET: Registered PF_RXRPC protocol family
[    9.953713][    T1] Key type rxrpc registered
[    9.954373][    T1] Key type rxrpc_s registered
[    9.956935][    T1] NET: Registered PF_KCM protocol family
[    9.958405][    T1] lec:lane_module_init: lec.c: initialized
[    9.959966][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[    9.961343][    T1] l2tp_core: L2TP core driver, V2.0
[    9.962248][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[    9.963438][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[    9.964924][    T1] l2tp_netlink: L2TP netlink interface
[    9.966842][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[    9.968489][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[    9.970375][    T1] NET: Registered PF_PHONET protocol family
[    9.972316][    T1] 8021q: 802.1Q VLAN Support v1.8
[    9.982243][    T1] DCCP: Activated CCID 2 (TCP-like)
[    9.983972][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[    9.988828][    T1] sctp: Hash tables configured (bind 32/56)
[    9.992797][    T1] NET: Registered PF_RDS protocol family
[    9.995952][    T1] Registered RDS/infiniband transport
[    9.998331][    T1] Registered RDS/tcp transport
[    9.999301][    T1] tipc: Activated (version 2.0.0)
[   10.001185][    T1] NET: Registered PF_TIPC protocol family
[   10.003426][    T1] tipc: Started in single node mode
[   10.005953][    T1] NET: Registered PF_SMC protocol family
[   10.007663][    T1] 9pnet: Installing 9P2000 support
[   10.009531][    T1] NET: Registered PF_CAIF protocol family
[   10.016448][    T1] NET: Registered PF_IEEE802154 protocol family
[   10.018804][    T1] Key type dns_resolver registered
[   10.019981][    T1] Key type ceph registered
[   10.022035][    T1] libceph: loaded (mon/osd proto 15/24)
[   10.025632][    T1] batman_adv: B.A.T.M.A.N. advanced 2021.3 (compatibility version 15) loaded
[   10.027479][    T1] openvswitch: Open vSwitch switching datapath
[   10.032455][    T1] NET: Registered PF_VSOCK protocol family
[   10.034348][    T1] mpls_gso: MPLS GSO support
[   10.042692][    T1] IPI shorthand broadcast: enabled
[   10.044218][    T1] AVX2 version of gcm_enc/dec engaged.
[   10.045496][    T1] AES CTR mode by8 optimization enabled
[   10.050326][    T1] sched_clock: Marking stable (10029278411, 20887515)->(10056257631, -6091705)
[   10.054020][    T1] registered taskstats version 1
[   10.061818][    T1] Loading compiled-in X.509 certificates
[   10.065938][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
[   10.071352][    T1] zswap: loaded using pool lzo/zbud
[   10.074824][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   11.756607][    T1] Key type ._fscrypt registered
[   11.757678][    T1] Key type .fscrypt registered
[   11.758612][    T1] Key type fscrypt-provisioning registered
[   11.765929][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   11.767788][    T1] FS-Cache: Netfs 'afs' registered for caching
[   11.778052][    T1] Btrfs loaded, crc32c=crc32c-intel, assert=on, zoned=yes, fsverity=yes
[   11.780678][    T1] Key type big_key registered
[   11.784695][    T1] Key type encrypted registered
[   11.787180][    T1] ima: No TPM chip found, activating TPM-bypass!
[   11.788307][    T1] Loading compiled-in module X.509 certificates
[   11.790027][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
[   11.792366][    T1] ima: Allocated hash algorithm: sha256
[   11.793679][    T1] ima: No architecture policies found
[   11.795462][    T1] evm: Initialising EVM extended attributes:
[   11.796533][    T1] evm: security.selinux (disabled)
[   11.797337][    T1] evm: security.SMACK64
[   11.798128][    T1] evm: security.SMACK64EXEC
[   11.798914][    T1] evm: security.SMACK64TRANSMUTE
[   11.800050][    T1] evm: security.SMACK64MMAP
[   11.801294][    T1] evm: security.apparmor (disabled)
[   11.802445][    T1] evm: security.ima
[   11.803150][    T1] evm: security.capability
[   11.803875][    T1] evm: HMAC attrs: 0x1
[   11.878842][    T1] PM:   Magic number: 10:155:591
[   11.880170][    T1] cec cec18: hash matches
[   11.881277][    T1] usbmon usbmon27: hash matches
[   11.882205][    T1] usb usb20-port4: hash matches
[   11.883765][    T1] tty ptyc9: hash matches
[   11.886992][    T1] printk: console [netcon0] enabled
[   11.888301][    T1] netconsole: network logging started
[   11.889910][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   11.893148][    T1] rdma_rxe: loaded
[   11.894125][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   11.900422][    T1] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   11.902966][  T136] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   11.907426][  T136] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   11.907483][    T1] ALSA device list:
[   11.910739][    T1]   #0: Dummy 1
[   11.911554][    T1]   #1: Loopback 1
[   11.912331][    T1]   #2: Virtual MIDI Card 1
[   11.916533][    T1] md: Waiting for all devices to be available before autodetect
[   11.918559][    T1] md: If you don't use raid, use raid=noautodetect
[   11.919724][    T1] md: Autodetecting RAID arrays.
[   11.920947][    T1] md: autorun ...
[   11.921743][    T1] md: ... autorun DONE.
[   11.945958][    T1] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[   11.949061][    T1] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   11.952878][    T1] devtmpfs: mounted
[   12.009316][    T1] Freeing unused kernel image (initmem) memory: 3820K
[   12.011137][    T1] Write protecting the kernel read-only data: 169984k
[   12.017381][    T1] Freeing unused kernel image (text/rodata gap) memory: 2012K
[   12.021141][    T1] Freeing unused kernel image (rodata/data gap) memory: 1648K
[   12.026563][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
[   12.029361][    T1] Run /sbin/init as init process
[   12.252245][ T2936] mount (2936) used greatest stack depth: 24880 bytes left
[   12.289115][ T2937] EXT4-fs (sda1): re-mounted. Opts: (null). Quota mode: none.
[   12.322458][ T2938] mkdir (2938) used greatest stack depth: 24744 bytes left
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or directory
mount: mounting mqueue on /dev/mqueue failed: No such file or directory
mount: [   12.363510][ T2939] mount (2939) used greatest stack depth: 21664 bytes left
mounting hugetlbfs on /dev/hugepages failed: No such file or directory
mount: mounting fuse.lxcfs on /var/lib/lxcfs failed: No such file or directory
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
[   12.811121][ T2964] logger (2964) used greatest stack depth: 21264 bytes left
Populating /dev using udev: [   13.003968][ T2968] udevd[2968]: starting version 3.2.10
[   13.183619][ T2969] udevd[2969]: starting eudev-3.2.10
[   13.187999][ T2968] udevd (2968) used greatest stack depth: 20544 bytes left
[   18.203068][ T3046] ================================================================================
[   18.275244][ T3046] UBSAN: object-size-mismatch in net/unix/af_unix.c:978:14
[   18.282483][ T3046] member access within address ffff888022443ccc with insufficient space
[   18.402043][ T3046] for an object of type 'struct sockaddr_un'
[   18.441637][ T3046] CPU: 0 PID: 3046 Comm: udevadm Not tainted 5.16.0-rc4-syzkaller-00161-gc741e49150db-dirty #0
[   18.452006][ T3046] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   18.462097][ T3046] Call Trace:
[   18.465396][ T3046]  <TASK>
[   18.468342][ T3046]  dump_stack_lvl+0x1e3/0x2cb
[   18.473067][ T3046]  ? bfq_pos_tree_add_move+0x451/0x451
[   18.478547][ T3046]  ? panic+0x7e3/0x7e3
[   18.482662][ T3046]  ubsan_type_mismatch_common+0x1e6/0x390
[   18.488404][ T3046]  __ubsan_handle_type_mismatch_v1+0x4a/0x60
[   18.494662][ T3046]  unix_autobind+0x14f/0x4d0
[   18.499274][ T3046]  ? tomoyo_socket_connect_permission+0x1dc/0x300
[   18.505713][ T3046]  unix_stream_connect+0x896/0x1010
[   18.511209][ T3046]  ? unix_bind+0x9a0/0x9a0
[   18.515642][ T3046]  ? bpf_lsm_socket_connect+0x5/0x10
[   18.520954][ T3046]  ? __sys_connect_file+0xbd/0x170
[   18.526083][ T3046]  ? __x64_sys_connect+0x148/0x1e0
[   18.531221][ T3046]  __x64_sys_connect+0x15b/0x1e0
[   18.536184][ T3046]  ? __sys_connect+0x170/0x170
[   18.540974][ T3046]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   18.546993][ T3046]  ? lockdep_hardirqs_on+0x95/0x140
[   18.552212][ T3046]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   18.558211][ T3046]  do_syscall_64+0x44/0xa0
[   18.562649][ T3046]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   18.568558][ T3046] RIP: 0033:0x7fa1d19a6d23
[   18.572984][ T3046] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 18 89 54 24 0c 48
[   18.592779][ T3046] RSP: 002b:00007ffe3ca5fba8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
[   18.601476][ T3046] RAX: ffffffffffffffda RBX: 0000559f3535a930 RCX: 00007fa1d19a6d23
[   18.609893][ T3046] RDX: 0000000000000013 RSI: 0000559f3535a948 RDI: 0000000000000003
[   18.618135][ T3046] RBP: 000000000000001e R08: 000000000000001e R09: 0030312e322e332d
[   18.626560][ T3046] R10: 00007ffe3ca5fcf4 R11: 0000000000000246 R12: 00007ffe3ca5fbc0
[   18.634896][ T3046] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000007
[   18.642900][ T3046]  </TASK>
[   19.205668][ T3046] ================================================================================
[   19.215846][ T3046] Kernel panic - not syncing: panic_on_warn set ...
[   19.222533][ T3046] CPU: 0 PID: 3046 Comm: udevadm Not tainted 5.16.0-rc4-syzkaller-00161-gc741e49150db-dirty #0
[   19.233304][ T3046] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   19.243368][ T3046] Call Trace:
[   19.246699][ T3046]  <TASK>
[   19.249729][ T3046]  dump_stack_lvl+0x1e3/0x2cb
[   19.255049][ T3046]  ? bfq_pos_tree_add_move+0x451/0x451
[   19.260526][ T3046]  ? panic+0x7e3/0x7e3
[   19.264636][ T3046]  panic+0x2f1/0x7e3
[   19.268561][ T3046]  ? ubsan_type_mismatch_common+0x20a/0x390
[   19.274478][ T3046]  ? fb_is_primary_device+0xcc/0xcc
[   19.279697][ T3046]  ? panic+0x7e3/0x7e3
[   19.283805][ T3046]  ubsan_type_mismatch_common+0x38c/0x390
[   19.289548][ T3046]  __ubsan_handle_type_mismatch_v1+0x4a/0x60
[   19.295542][ T3046]  unix_autobind+0x14f/0x4d0
[   19.300151][ T3046]  ? tomoyo_socket_connect_permission+0x1dc/0x300
[   19.306789][ T3046]  unix_stream_connect+0x896/0x1010
[   19.312097][ T3046]  ? unix_bind+0x9a0/0x9a0
[   19.316616][ T3046]  ? bpf_lsm_socket_connect+0x5/0x10
[   19.322357][ T3046]  ? __sys_connect_file+0xbd/0x170
[   19.327486][ T3046]  ? __x64_sys_connect+0x148/0x1e0
[   19.332870][ T3046]  __x64_sys_connect+0x15b/0x1e0
[   19.338167][ T3046]  ? __sys_connect+0x170/0x170
[   19.343057][ T3046]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   19.349499][ T3046]  ? lockdep_hardirqs_on+0x95/0x140
[   19.354717][ T3046]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   19.360820][ T3046]  do_syscall_64+0x44/0xa0
[   19.365259][ T3046]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   19.371340][ T3046] RIP: 0033:0x7fa1d19a6d23
[   19.375766][ T3046] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 18 89 54 24 0c 48
[   19.396086][ T3046] RSP: 002b:00007ffe3ca5fba8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
[   19.404692][ T3046] RAX: ffffffffffffffda RBX: 0000559f3535a930 RCX: 00007fa1d19a6d23
[   19.412688][ T3046] RDX: 0000000000000013 RSI: 0000559f3535a948 RDI: 0000000000000003
[   19.420676][ T3046] RBP: 000000000000001e R08: 000000000000001e R09: 0030312e322e332d
[   19.428658][ T3046] R10: 00007ffe3ca5fcf4 R11: 0000000000000246 R12: 00007ffe3ca5fbc0
[   19.436730][ T3046] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000007
[   19.444816][ T3046]  </TASK>
[   19.448180][ T3046] Kernel Offset: disabled
[   19.452546][ T3046] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=152f2d28080000


Tested on:

commit:         c741e491 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=308b87e56290f642
dashboard link: https://syzkaller.appspot.com/bug?extid=3cc1054e15babd5f4cd2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150bf2f8080000

