Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80C656456A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiGCGmL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Jul 2022 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCGmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 02:42:10 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090C22DD3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 23:42:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id n85-20020a6b8b58000000b00672792497b8so4013395iod.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 23:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=oHe55PAKH0nt4G4QKEPCxv/FrClv+i7RiNZeySPEDM8=;
        b=ZA2Rs9lJC3HzbpytvC2hhhi/OoH8KS+jvCi6UKmwbj7bNd+JfFUbpTVN5XRU2UScLW
         Eh/NwITM42GqHzzFFRPwmMo8H678x7w1wr1NfBfxXK8VVp0OEhsdd+3YEBPCqVoO8kG9
         95XVgz/qRzcnhFWWPSSDKYBfuHIrKbSo9RwronCwaAFdRliQjbhYpj74TI+OOCgi34KC
         SXMRyPgEI1U5L1FmMsshr+f+IqsqIp6S9AwRhKQNm+iODXirQWvMhv/fW8Y1l9bLcnd1
         QzafRIsrZOqFtB4CpsSQAVaiJU5NqNrmYTSPEfoo0y9m+zIQuogq6Ljhg4c9Ntyz1f58
         7LNA==
X-Gm-Message-State: AJIora/juHIPBfDo1tDn4L02kzQUIVGTUXt8/YED5zA+eSHfcqyKOb3d
        /yPvIsPufn6iF8jRSOLVBWOg6Kus3mXoU2nCoDNTvEDsBKqT
X-Google-Smtp-Source: AGRyM1vPLA3RqkQCMDTDPlgx83yC2VAoi+5aF3DNKTiiVgNR/dtmhsfYW09xdG7KHrblnWmErPP/NzwbokKqJKGMLmhur+RfizMJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:380b:b0:675:849c:ad9d with SMTP id
 bb11-20020a056602380b00b00675849cad9dmr12037082iob.203.1656830527400; Sat, 02
 Jul 2022 23:42:07 -0700 (PDT)
Date:   Sat, 02 Jul 2022 23:42:07 -0700
In-Reply-To: <20220703013354.1025-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009f22805e2e0ebae@google.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
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


[   10.794756][    T1]     Actions configured
[   10.798980][    T1] nf_conntrack_irc: failed to register helpers
[   10.800343][    T1] nf_conntrack_sane: failed to register helpers
[   10.916180][    T1] nf_conntrack_sip: failed to register helpers
[   10.925334][    T1] xt_time: kernel timezone is -0000
[   10.926447][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   10.928073][    T1] IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
[   10.930247][    T1] IPVS: ipvs loaded.
[   10.931222][    T1] IPVS: [rr] scheduler registered.
[   10.932047][    T1] IPVS: [wrr] scheduler registered.
[   10.933355][    T1] IPVS: [lc] scheduler registered.
[   10.934246][    T1] IPVS: [wlc] scheduler registered.
[   10.934951][    T1] IPVS: [fo] scheduler registered.
[   10.935883][    T1] IPVS: [ovf] scheduler registered.
[   10.936731][    T1] IPVS: [lblc] scheduler registered.
[   10.937688][    T1] IPVS: [lblcr] scheduler registered.
[   10.938722][    T1] IPVS: [dh] scheduler registered.
[   10.939424][    T1] IPVS: [sh] scheduler registered.
[   10.940664][    T1] IPVS: [mh] scheduler registered.
[   10.941647][    T1] IPVS: [sed] scheduler registered.
[   10.942479][    T1] IPVS: [nq] scheduler registered.
[   10.943378][    T1] IPVS: [twos] scheduler registered.
[   10.945063][    T1] IPVS: [sip] pe registered.
[   10.945914][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   10.949523][    T1] gre: GRE over IPv4 demultiplexor driver
[   10.950671][    T1] ip_gre: GRE over IPv4 tunneling driver
[   10.959843][    T1] IPv4 over IPsec tunneling driver
[   10.963931][    T1] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[   10.965654][    T1] Initializing XFRM netlink socket
[   10.966501][    T1] IPsec XFRM device driver
[   10.969892][    T1] NET: Registered PF_INET6 protocol family
[   10.983255][    T1] Segment Routing with IPv6
[   10.984380][    T1] RPL Segment Routing with IPv6
[   10.985473][    T1] In-situ OAM (IOAM) with IPv6
[   10.986688][    T1] mip6: Mobile IPv6
[   10.991973][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   11.000450][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   11.004645][    T1] NET: Registered PF_PACKET protocol family
[   11.005898][    T1] NET: Registered PF_KEY protocol family
[   11.007907][    T1] Bridge firewalling registered
[   11.009408][    T1] NET: Registered PF_X25 protocol family
[   11.010490][    T1] X25: Linux Version 0.2
[   11.056697][    T1] NET: Registered PF_NETROM protocol family
[   11.102477][    T1] NET: Registered PF_ROSE protocol family
[   11.104096][    T1] NET: Registered PF_AX25 protocol family
[   11.105175][    T1] can: controller area network core
[   11.107418][    T1] NET: Registered PF_CAN protocol family
[   11.108767][    T1] can: raw protocol
[   11.109525][    T1] can: broadcast manager protocol
[   11.110776][    T1] can: netlink gateway - max_hops=1
[   11.112235][    T1] can: SAE J1939
[   11.112864][    T1] can: isotp protocol
[   11.114031][    T1] Bluetooth: RFCOMM TTY layer initialized
[   11.115090][    T1] Bluetooth: RFCOMM socket layer initialized
[   11.116448][    T1] Bluetooth: RFCOMM ver 1.11
[   11.117194][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   11.118258][    T1] Bluetooth: BNEP filters: protocol multicast
[   11.119119][    T1] Bluetooth: BNEP socket layer initialized
[   11.119936][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   11.120795][    T1] Bluetooth: CMTP socket layer initialized
[   11.121612][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   11.122979][    T1] Bluetooth: HIDP socket layer initialized
[   11.128646][    T1] NET: Registered PF_RXRPC protocol family
[   11.129561][    T1] Key type rxrpc registered
[   11.130235][    T1] Key type rxrpc_s registered
[   11.132345][    T1] NET: Registered PF_KCM protocol family
[   11.134208][    T1] lec:lane_module_init: lec.c: initialized
[   11.135104][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   11.136035][    T1] l2tp_core: L2TP core driver, V2.0
[   11.136763][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   11.137521][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   11.138798][    T1] l2tp_netlink: L2TP netlink interface
[   11.139676][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   11.140591][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   11.142091][    T1] NET: Registered PF_PHONET protocol family
[   11.144330][    T1] 8021q: 802.1Q VLAN Support v1.8
[   11.158244][    T1] DCCP: Activated CCID 2 (TCP-like)
[   11.159895][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   11.164250][    T1] sctp: Hash tables configured (bind 32/56)
[   11.167526][    T1] NET: Registered PF_RDS protocol family
[   11.169491][    T1] Registered RDS/infiniband transport
[   11.171614][    T1] Registered RDS/tcp transport
[   11.172335][    T1] tipc: Activated (version 2.0.0)
[   11.173958][    T1] NET: Registered PF_TIPC protocol family
[   11.175494][    T1] tipc: Started in single node mode
[   11.177372][    T1] NET: Registered PF_SMC protocol family
[   11.178657][    T1] 9pnet: Installing 9P2000 support
[   11.179908][    T1] NET: Registered PF_CAIF protocol family
[   11.186645][    T1] NET: Registered PF_IEEE802154 protocol family
[   11.188074][    T1] Key type dns_resolver registered
[   11.188970][    T1] Key type ceph registered
[   11.190736][    T1] libceph: loaded (mon/osd proto 15/24)
[   11.194170][    T1] batman_adv: B.A.T.M.A.N. advanced 2022.2 (compatibility version 15) loaded
[   11.195538][    T1] openvswitch: Open vSwitch switching datapath
[   11.200918][    T1] NET: Registered PF_VSOCK protocol family
[   11.202106][    T1] mpls_gso: MPLS GSO support
[   11.210879][    T1] IPI shorthand broadcast: enabled
[   11.211827][    T1] AVX2 version of gcm_enc/dec engaged.
[   11.212938][    T1] AES CTR mode by8 optimization enabled
[   11.216937][    T1] sched_clock: Marking stable (11189291508, 27411798)->(11228251728, -11548422)
[   11.220049][    T1] registered taskstats version 1
[   11.226325][    T1] Loading compiled-in X.509 certificates
[   11.232410][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 327992f6769a077bd3f61b5b84c11a0b7686edca'
[   11.237367][    T1] zswap: loaded using pool lzo/zbud
[   11.239785][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   13.446441][    T1] Key type ._fscrypt registered
[   13.447548][    T1] Key type .fscrypt registered
[   13.448655][    T1] Key type fscrypt-provisioning registered
[   13.457608][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   13.471332][    T1] Btrfs loaded, crc32c=crc32c-intel, assert=on, zoned=yes, fsverity=yes
[   13.481315][    T1] Key type big_key registered
[   13.489809][    T1] Key type encrypted registered
[   13.495191][    T1] ima: No TPM chip found, activating TPM-bypass!
[   13.501677][    T1] Loading compiled-in module X.509 certificates
[   13.510483][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 327992f6769a077bd3f61b5b84c11a0b7686edca'
[   13.521562][    T1] ima: Allocated hash algorithm: sha256
[   13.527593][    T1] ima: No architecture policies found
[   13.533919][    T1] evm: Initialising EVM extended attributes:
[   13.540125][    T1] evm: security.selinux (disabled)
[   13.545284][    T1] evm: security.SMACK64
[   13.549630][    T1] evm: security.SMACK64EXEC
[   13.554262][    T1] evm: security.SMACK64TRANSMUTE
[   13.559359][    T1] evm: security.SMACK64MMAP
[   13.564258][    T1] evm: security.apparmor (disabled)
[   13.569451][    T1] evm: security.ima
[   13.573281][    T1] evm: security.capability
[   13.577912][    T1] evm: HMAC attrs: 0x1
[   13.667958][    T1] PM:   Magic number: 14:892:568
[   13.674812][    T1] tty ptyb0: hash matches
[   13.681749][    T1] printk: console [netcon0] enabled
[   13.687578][    T1] netconsole: network logging started
[   13.693813][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   13.702896][    T1] rdma_rxe: loaded
[   13.707226][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.718938][    T1] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.728511][   T14] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   13.735610][    T1] ALSA device list:
[   13.739036][   T14] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   13.742820][    T1]   #0: Dummy 1
[   13.754601][    T1]   #1: Loopback 1
[   13.758445][    T1]   #2: Virtual MIDI Card 1
[   13.766195][    T1] md: Waiting for all devices to be available before autodetect
[   13.773982][    T1] md: If you don't use raid, use raid=noautodetect
[   13.780525][    T1] md: Autodetecting RAID arrays.
[   13.785616][    T1] md: autorun ...
[   13.789260][    T1] md: ... autorun DONE.
[   13.851436][    T1] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
[   13.860907][    T1] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   13.871937][    T1] devtmpfs: mounted
[   13.933201][    T1] Freeing unused kernel image (initmem) memory: 2532K
[   13.940276][    T1] Write protecting the kernel read-only data: 188416k
[   13.952095][    T1] Freeing unused kernel image (text/rodata gap) memory: 2016K
[   13.961388][    T1] Freeing unused kernel image (rodata/data gap) memory: 968K
[   13.976834][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
[   13.986636][    T1] Run /sbin/init as init process
[   14.016105][    T1] ================================================================================
[   14.026198][    T1] UBSAN: array-index-out-of-bounds in security/integrity/iint.c:95:2
[   14.034474][    T1] index -1 is out of range for type 'struct lock_class_key [2]'
[   14.042117][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428-dirty #0
[   14.052389][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
[   14.062467][    T1] Call Trace:
[   14.066465][    T1]  <TASK>
[   14.069409][    T1]  dump_stack_lvl+0x1e3/0x2cb
[   14.074120][    T1]  ? bfq_pos_tree_add_move+0x436/0x436
[   14.079687][    T1]  ? panic+0x76e/0x76e
[   14.083765][    T1]  ? rcu_read_lock_sched_held+0x89/0x130
[   14.089406][    T1]  __ubsan_handle_out_of_bounds+0x107/0x150
[   14.095337][    T1]  integrity_inode_get+0x417/0x420
[   14.100496][    T1]  process_measurement+0x444/0x1c10
[   14.105745][    T1]  ? print_irqtrace_events+0x220/0x220
[   14.111236][    T1]  ? ima_file_mmap+0x1b0/0x1b0
[   14.116014][    T1]  ? kasan_quarantine_put+0xd4/0x230
[   14.121423][    T1]  ? smack_current_getsecid_subj+0x19/0xe0
[   14.127356][    T1]  ima_bprm_check+0x11e/0x2a0
[   14.132103][    T1]  ? ima_file_mprotect+0x510/0x510
[   14.137259][    T1]  ? tomoyo_bprm_check_security+0x115/0x130
[   14.143150][    T1]  ? bpf_lsm_bprm_check_security+0x5/0x10
[   14.148873][    T1]  bprm_execve+0x817/0x1590
[   14.153386][    T1]  ? alloc_bprm+0x3b0/0x3b0
[   14.157892][    T1]  ? alloc_bprm+0x353/0x3b0
[   14.162394][    T1]  kernel_execve+0x8eb/0xa00
[   14.167065][    T1]  kernel_init+0xda/0x2b0
[   14.171391][    T1]  ? rest_init+0x270/0x270
[   14.175801][    T1]  ret_from_fork+0x1f/0x30
[   14.180231][    T1]  </TASK>
[   14.183787][    T1] ================================================================================
[   14.193269][    T1] Kernel panic - not syncing: panic_on_warn set ...
[   14.199850][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428-dirty #0
[   14.210167][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
[   14.220252][    T1] Call Trace:
[   14.223537][    T1]  <TASK>
[   14.226571][    T1]  dump_stack_lvl+0x1e3/0x2cb
[   14.231355][    T1]  ? bfq_pos_tree_add_move+0x436/0x436
[   14.236810][    T1]  ? panic+0x76e/0x76e
[   14.240957][    T1]  ? preempt_schedule_thunk+0x16/0x18
[   14.246363][    T1]  ? vscnprintf+0x59/0x80
[   14.250705][    T1]  panic+0x312/0x76e
[   14.254604][    T1]  ? __ubsan_handle_out_of_bounds+0x12c/0x150
[   14.260665][    T1]  ? fb_is_primary_device+0xcc/0xcc
[   14.265939][    T1]  ? panic+0x76e/0x76e
[   14.270008][    T1]  ? rcu_read_lock_sched_held+0x89/0x130
[   14.275730][    T1]  __ubsan_handle_out_of_bounds+0x14d/0x150
[   14.281647][    T1]  integrity_inode_get+0x417/0x420
[   14.286807][    T1]  process_measurement+0x444/0x1c10
[   14.292135][    T1]  ? print_irqtrace_events+0x220/0x220
[   14.297831][    T1]  ? ima_file_mmap+0x1b0/0x1b0
[   14.302633][    T1]  ? kasan_quarantine_put+0xd4/0x230
[   14.307994][    T1]  ? smack_current_getsecid_subj+0x19/0xe0
[   14.313918][    T1]  ima_bprm_check+0x11e/0x2a0
[   14.318661][    T1]  ? ima_file_mprotect+0x510/0x510
[   14.323793][    T1]  ? tomoyo_bprm_check_security+0x115/0x130
[   14.329699][    T1]  ? bpf_lsm_bprm_check_security+0x5/0x10
[   14.335526][    T1]  bprm_execve+0x817/0x1590
[   14.340156][    T1]  ? alloc_bprm+0x3b0/0x3b0
[   14.344935][    T1]  ? alloc_bprm+0x353/0x3b0
[   14.349436][    T1]  kernel_execve+0x8eb/0xa00
[   14.354026][    T1]  kernel_init+0xda/0x2b0
[   14.358519][    T1]  ? rest_init+0x270/0x270
[   14.362929][    T1]  ret_from_fork+0x1f/0x30
[   14.367343][    T1]  </TASK>
[   14.370965][    T1] Kernel Offset: disabled
[   14.375385][    T1] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1808995379=/tmp/go-build -gno-record-gcc-switches"

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
https://syzkaller.appspot.com/x/error.txt?x=15eb7be0080000


Tested on:

commit:         08986606 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=75c9ff14e1db87c0
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ef70ec080000

