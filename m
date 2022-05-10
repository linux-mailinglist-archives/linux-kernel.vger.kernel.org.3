Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508615214EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiEJMQY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 May 2022 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiEJMQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:16:17 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AFBDEF4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:12:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so11711896iov.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=mBYb17bGtROtr3HqNzMkm7TDiR/DoUONCGdntgZzogM=;
        b=rEPk4GHzfjXG5R89iXPP4Xrrw8eg3Eg5XHTvGoMbAZlXN+woxaNUNaKrCnn/BqCXbl
         ZL0JfTY/qzu+yKM2XmhG6N1etAZvAJK5v56UnhATPfrTQmXkRUdlFrzKwxM540qC5XIQ
         ++7cL4rmjaQKIQeIQa887fxLFXBAEXO3c9hUN1hhX/m32JRll9EMpoX7zMOf2gZ+l2oN
         Yzm1Wl4gqKiYvDVlkSvZ7cau+1ATvVHOilGDAoqKhGu52zDQYYVpyteckxzhgBJRNFmx
         a+eVNbKsKUc/kQN0BUyIftN97E/hcp6kEMJb5hkZ7465QcHKyLy2NUcR0yE6QjPbvIt4
         nojg==
X-Gm-Message-State: AOAM5335HEhW90WJTNl0J+AXKt8LhC91J4JEiNkmjjjBmzpaveDONABN
        jNleDMqRxis7ABCL+Ke5pXSQ/s7AqbHIwFXFzZRr6t5osYRm
X-Google-Smtp-Source: ABdhPJxHpbJARO8SM4hBy3ZmkB0Dy/8/uHHkVVo0vL/qOnOBw4k7kpIUz4oMUuw1bZwDmdRg5DJLthp0aLuOeWltkUSyU8iYhyQB
MIME-Version: 1.0
X-Received: by 2002:a6b:6302:0:b0:653:92da:5c31 with SMTP id
 p2-20020a6b6302000000b0065392da5c31mr8668976iog.151.1652184728118; Tue, 10
 May 2022 05:12:08 -0700 (PDT)
Date:   Tue, 10 May 2022 05:12:08 -0700
In-Reply-To: <20220510115257.5804-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2a81305dea73b7f@google.com>
Subject: Re: [syzbot] INFO: task hung in synchronize_rcu (3)
From:   syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ackground, child pid 4958
[   23.507564][ T4959] 8021q: adding VLAN 0 to HW filter on device bond0
[   23.519205][ T4959] eql: remember to turn off Van-Jacobson compression on your slave devices
Starting sshd: OK

syzkaller
Warning: Permanently added '10.128.0.85' (ECDSA) to the list of known hosts.
2022/05/10 12:11:01 ignoring optional flag "raw_cover"="false"
2022/05/10 12:11:01 fuzzer started
2022/05/10 12:11:01 connecting to host at 10.128.0.169:33779
2022/05/10 12:11:01 checking machine...
2022/05/10 12:11:01 checking revisions...
2022/05/10 12:11:01 testing simple program...
syzkaller login: [   40.935530][ T5379] cgroup: Unknown subsys name 'net'
[   41.071569][ T5379] cgroup: Unknown subsys name 'rlimit'
[   42.335602][ T5385] IPVS: ftp: loaded support on port[0] = 21
[   42.394890][ T5385] chnl_net:caif_netlink_parms(): no params data found
[   42.433361][ T5385] bridge0: port 1(bridge_slave_0) entered blocking state
[   42.440978][ T5385] bridge0: port 1(bridge_slave_0) entered disabled state
[   42.449123][ T5385] device bridge_slave_0 entered promiscuous mode
[   42.458302][ T5385] bridge0: port 2(bridge_slave_1) entered blocking state
[   42.466010][ T5385] bridge0: port 2(bridge_slave_1) entered disabled state
[   42.473764][ T5385] device bridge_slave_1 entered promiscuous mode
[   42.490493][ T5385] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
[   42.502207][ T5385] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
[   42.521537][ T5385] team0: Port device team_slave_0 added
[   42.529481][ T5385] team0: Port device team_slave_1 added
[   42.545295][ T5385] batman_adv: batadv0: Adding interface: batadv_slave_0
[   42.552353][ T5385] batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   42.578953][ T5385] batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
[   42.591532][ T5385] batman_adv: batadv0: Adding interface: batadv_slave_1
[   42.598589][ T5385] batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   42.624881][ T5385] batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
[   42.647993][ T5385] device hsr_slave_0 entered promiscuous mode
[   42.654646][ T5385] device hsr_slave_1 entered promiscuous mode
[   42.722230][ T5385] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   42.732556][ T5385] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   42.742043][ T5385] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   42.750927][ T5385] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   42.771509][ T5385] bridge0: port 2(bridge_slave_1) entered blocking state
[   42.779012][ T5385] bridge0: port 2(bridge_slave_1) entered forwarding state
[   42.786862][ T5385] bridge0: port 1(bridge_slave_0) entered blocking state
[   42.794013][ T5385] bridge0: port 1(bridge_slave_0) entered forwarding state
[   42.833264][ T5385] 8021q: adding VLAN 0 to HW filter on device bond0
[   42.845912][   T17] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   42.854933][   T17] bridge0: port 1(bridge_slave_0) entered disabled state
[   42.864247][   T17] bridge0: port 2(bridge_slave_1) entered disabled state
[   42.872531][   T17] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
[   42.886684][ T5385] 8021q: adding VLAN 0 to HW filter on device team0
[   42.897461][   T17] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
[   42.907316][   T17] bridge0: port 1(bridge_slave_0) entered blocking state
[   42.914462][   T17] bridge0: port 1(bridge_slave_0) entered forwarding state
[   42.937517][ T3022] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
[   42.947781][ T3022] bridge0: port 2(bridge_slave_1) entered blocking state
[   42.954822][ T3022] bridge0: port 2(bridge_slave_1) entered forwarding state
[   42.963063][ T3022] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
[   42.972691][ T3022] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
[   42.981899][   T17] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
[   42.992884][ T2950] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link becomes ready
[   43.004741][    T5] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link becomes ready
[   43.016276][ T5385] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
[   43.032499][    T5] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes ready
[   43.040966][    T5] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes ready
[   43.054589][ T5385] 8021q: adding VLAN 0 to HW filter on device batadv0
[   43.072616][   T17] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link becomes ready
[   43.090598][    T5] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link becomes ready
[   43.098877][    T5] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes ready
[   43.107021][    T5] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes ready
[   43.116925][ T5385] device veth0_vlan entered promiscuous mode
[   43.128438][ T5385] device veth1_vlan entered promiscuous mode
[   43.147614][ T3022] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link becomes ready
[   43.156727][ T3022] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link becomes ready
[   43.166137][ T3022] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link becomes ready
[   43.176463][ T5385] device veth0_macvtap entered promiscuous mode
[   43.186693][ T5385] device veth1_macvtap entered promiscuous mode
[   43.202698][ T5385] batman_adv: batadv0: Interface activated: batadv_slave_0
[   43.210227][ T3022] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link becomes ready
[   43.220664][ T3022] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link becomes ready
[   43.232280][ T5385] batman_adv: batadv0: Interface activated: batadv_slave_1
[   43.240456][    T5] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
[   43.290329][ T1019] wlan0: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
[   43.304944][ T1019] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
[   43.314460][    T8] wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
[   43.317814][   T17] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   43.322678][    T8] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
[   43.340187][   T17] IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
[   43.375727][ T5385] cgroup: cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation
2022/05/10 12:11:04 building call list...
executing program
[   43.949689][ T5385] ==================================================================
[   43.958088][ T5385] BUG: KASAN: use-after-free in task_active_pid_ns+0xb1/0xd0
[   43.965539][ T5385] Read of size 4 at addr ffff88823b705004 by task syz-executor.0/5385
[   43.973758][ T5385] 
[   43.976084][ T5385] CPU: 1 PID: 5385 Comm: syz-executor.0 Not tainted 5.8.0-rc6-syzkaller-00003-g4fa640dc5230-dirty #0
[   43.987108][ T5385] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   43.997146][ T5385] Call Trace:
[   44.000503][ T5385]  dump_stack+0xf6/0x16e
[   44.004912][ T5385]  ? task_active_pid_ns+0xb1/0xd0
[   44.009937][ T5385]  ? task_active_pid_ns+0xb1/0xd0
[   44.014952][ T5385]  print_address_description.constprop.0.cold+0xae/0x467
[   44.022061][ T5385]  ? __wake_up_common_lock+0xde/0x130
[   44.027426][ T5385]  ? vprintk_func+0x95/0x241
[   44.032153][ T5385]  ? task_active_pid_ns+0xb1/0xd0
[   44.037652][ T5385]  kasan_report.cold+0x1f/0x37
[   44.042526][ T5385]  ? task_active_pid_ns+0xb1/0xd0
[   44.049012][ T5385]  task_active_pid_ns+0xb1/0xd0
[   44.053869][ T5385]  do_notify_parent+0x33a/0xf80
[   44.058742][ T5385]  ? do_exit+0x24f2/0x2ce0
[   44.063163][ T5385]  ? send_sigqueue+0x810/0x810
[   44.068821][ T5385]  ? lock_release+0x810/0x810
[   44.073605][ T5385]  ? zap_pid_ns_processes+0x547/0x6b0
[   44.079083][ T5385]  ? lockdep_hardirqs_on_prepare+0x383/0x560
[   44.085067][ T5385]  do_exit+0x222c/0x2ce0
[   44.089312][ T5385]  ? find_held_lock+0x2d/0x110
[   44.094251][ T5385]  ? mm_update_next_owner+0x7b0/0x7b0
[   44.099762][ T5385]  ? get_signal+0x330/0x20c0
[   44.104390][ T5385]  ? lock_downgrade+0x730/0x730
[   44.109354][ T5385]  do_group_exit+0x125/0x310
[   44.113999][ T5385]  get_signal+0x408/0x20c0
[   44.118435][ T5385]  ? __sanitizer_cov_trace_switch+0x45/0x70
[   44.124335][ T5385]  do_signal+0x82/0x2490
[   44.128581][ T5385]  ? preempt_schedule_irq+0x54/0xe0
[   44.133868][ T5385]  ? loop_configure+0x1350/0x1350
[   44.138899][ T5385]  ? copy_siginfo_to_user32+0xa0/0xa0
[   44.144267][ T5385]  ? lockdep_hardirqs_on_prepare+0x383/0x560
[   44.150252][ T5385]  ? blkdev_common_ioctl+0x1760/0x1760
[   44.155730][ T5385]  ? __prepare_exit_to_usermode+0x105/0x1e0
[   44.161630][ T5385]  ? lockdep_hardirqs_on_prepare+0x383/0x560
[   44.167607][ T5385]  __prepare_exit_to_usermode+0x12f/0x1e0
[   44.173842][ T5385]  do_syscall_64+0x52/0xe0
[   44.178260][ T5385]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   44.184141][ T5385] RIP: 0033:0x7fc9dc7e3e07
[   44.188537][ T5385] Code: Bad RIP value.
[   44.192952][ T5385] RSP: 002b:00007fc9dce2ad78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   44.201527][ T5385] RAX: fffffffffffffffa RBX: 00007fc9dce2ae00 RCX: 00007fc9dc7e3e07
[   44.209505][ T5385] RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
[   44.217473][ T5385] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fc9dce2ac10
[   44.225715][ T5385] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
[   44.233866][ T5385] R13: 000000000000a98e R14: 0000000000000003 R15: 00007fc9dce2ae40
[   44.241969][ T5385] 
[   44.244321][ T5385] Allocated by task 0:
[   44.248405][ T5385]  save_stack+0x1b/0x40
[   44.253199][ T5385]  __kasan_kmalloc.constprop.0+0xc2/0xd0
[   44.258892][ T5385]  kmem_cache_alloc+0xd7/0x310
[   44.263743][ T5385]  alloc_pid+0xd5/0xda0
[   44.267914][ T5385]  copy_process+0x3194/0x6f00
[   44.272589][ T5385]  _do_fork+0x12c/0xa90
[   44.276747][ T5385]  kernel_thread+0xb5/0xf0
[   44.281155][ T5385]  rest_init+0x23/0x460
[   44.285492][ T5385]  start_kernel+0x9a7/0x9e2
[   44.290003][ T5385]  secondary_startup_64+0xa4/0xb0
[   44.295023][ T5385] 
[   44.297432][ T5385] Freed by task 5379:
[   44.301413][ T5385]  save_stack+0x1b/0x40
[   44.305562][ T5385]  __kasan_slab_free+0x11f/0x160
[   44.310492][ T5385]  slab_free_freelist_hook+0x53/0x140
[   44.315869][ T5385]  kmem_cache_free+0x8a/0x380
[   44.320637][ T5385]  put_pid.part.0+0xfa/0x150
[   44.325216][ T5385]  put_pid+0x1b/0x30
[   44.329280][ T5385]  proc_do_cad_pid+0x153/0x180
[   44.334036][ T5385]  proc_sys_call_handler+0x28f/0x5b0
[   44.339320][ T5385]  vfs_write+0x2b0/0x6b0
[   44.343560][ T5385]  ksys_write+0x12d/0x250
[   44.347892][ T5385]  do_syscall_64+0x46/0xe0
[   44.352313][ T5385]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   44.358195][ T5385] 
[   44.360517][ T5385] The buggy address belongs to the object at ffff88823b705000
[   44.360517][ T5385]  which belongs to the cache pid of size 224
[   44.373875][ T5385] The buggy address is located 4 bytes inside of
[   44.373875][ T5385]  224-byte region [ffff88823b705000, ffff88823b7050e0)
[   44.386972][ T5385] The buggy address belongs to the page:
[   44.392605][ T5385] page:ffffea0008edc140 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
[   44.401714][ T5385] flags: 0x57ff00000000200(slab)
[   44.406664][ T5385] raw: 057ff00000000200 dead000000000100 dead000000000122 ffff8880b5889400
[   44.415255][ T5385] raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
[   44.423841][ T5385] page dumped because: kasan: bad access detected
[   44.430383][ T5385] page_owner tracks the page as allocated
[   44.436115][ T5385] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x0()
[   44.444534][ T5385]  register_early_stack+0x66/0xb0
[   44.449557][ T5385]  init_page_owner+0x6b/0x7e0
[   44.454230][ T5385]  page_ext_init+0x3a8/0x3b8
[   44.458814][ T5385]  kernel_init_freeable+0x31a/0x691
[   44.463993][ T5385] page_owner free stack trace missing
[   44.469360][ T5385] 
[   44.471943][ T5385] Memory state around the buggy address:
[   44.477750][ T5385]  ffff88823b704f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   44.485827][ T5385]  ffff88823b704f80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
[   44.494006][ T5385] >ffff88823b705000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   44.502327][ T5385]                    ^
[   44.506747][ T5385]  ffff88823b705080: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   44.514917][ T5385]  ffff88823b705100: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
[   44.523036][ T5385] ==================================================================
[   44.531112][ T5385] Disabling lock debugging due to kernel taint
[   44.537345][ T5385] Kernel panic - not syncing: panic_on_warn set ...
[   44.543927][ T5385] CPU: 1 PID: 5385 Comm: syz-executor.0 Tainted: G    B             5.8.0-rc6-syzkaller-00003-g4fa640dc5230-dirty #0
[   44.556232][ T5385] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   44.566311][ T5385] Call Trace:
[   44.569690][ T5385]  dump_stack+0xf6/0x16e
[   44.573924][ T5385]  panic+0x370/0x7b0
[   44.577811][ T5385]  ? __warn_printk+0xf3/0xf3
[   44.582893][ T5385]  ? _raw_spin_unlock_irqrestore+0x2a/0x60
[   44.588693][ T5385]  ? task_active_pid_ns+0xb1/0xd0
[   44.593702][ T5385]  ? task_active_pid_ns+0xb1/0xd0
[   44.598801][ T5385]  end_report+0x4d/0x53
[   44.603132][ T5385]  kasan_report.cold+0xd/0x37
[   44.607988][ T5385]  ? task_active_pid_ns+0xb1/0xd0
[   44.613020][ T5385]  task_active_pid_ns+0xb1/0xd0
[   44.617896][ T5385]  do_notify_parent+0x33a/0xf80
[   44.622770][ T5385]  ? do_exit+0x24f2/0x2ce0
[   44.627188][ T5385]  ? send_sigqueue+0x810/0x810
[   44.632657][ T5385]  ? lock_release+0x810/0x810
[   44.637341][ T5385]  ? zap_pid_ns_processes+0x547/0x6b0
[   44.642962][ T5385]  ? lockdep_hardirqs_on_prepare+0x383/0x560
[   44.649038][ T5385]  do_exit+0x222c/0x2ce0
[   44.653378][ T5385]  ? find_held_lock+0x2d/0x110
[   44.658402][ T5385]  ? mm_update_next_owner+0x7b0/0x7b0
[   44.663759][ T5385]  ? get_signal+0x330/0x20c0
[   44.668437][ T5385]  ? lock_downgrade+0x730/0x730
[   44.673317][ T5385]  do_group_exit+0x125/0x310
[   44.677990][ T5385]  get_signal+0x408/0x20c0
[   44.682633][ T5385]  ? __sanitizer_cov_trace_switch+0x45/0x70
[   44.688780][ T5385]  do_signal+0x82/0x2490
[   44.693465][ T5385]  ? preempt_schedule_irq+0x54/0xe0
[   44.698679][ T5385]  ? loop_configure+0x1350/0x1350
[   44.703960][ T5385]  ? copy_siginfo_to_user32+0xa0/0xa0
[   44.712100][ T5385]  ? lockdep_hardirqs_on_prepare+0x383/0x560
[   44.718153][ T5385]  ? blkdev_common_ioctl+0x1760/0x1760
[   44.723592][ T5385]  ? __prepare_exit_to_usermode+0x105/0x1e0
[   44.729636][ T5385]  ? lockdep_hardirqs_on_prepare+0x383/0x560
[   44.735596][ T5385]  __prepare_exit_to_usermode+0x12f/0x1e0
[   44.741652][ T5385]  do_syscall_64+0x52/0xe0
[   44.746053][ T5385]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   44.751954][ T5385] RIP: 0033:0x7fc9dc7e3e07
[   44.756428][ T5385] Code: Bad RIP value.
[   44.760473][ T5385] RSP: 002b:00007fc9dce2ad78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   44.769542][ T5385] RAX: fffffffffffffffa RBX: 00007fc9dce2ae00 RCX: 00007fc9dc7e3e07
[   44.779439][ T5385] RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
[   44.787651][ T5385] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fc9dce2ac10
[   44.795603][ T5385] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
[   44.803567][ T5385] R13: 000000000000a98e R14: 0000000000000003 R15: 00007fc9dce2ae40
[   44.812073][ T5385] Kernel Offset: disabled
[   44.816388][ T5385] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=159d83faf00000


Tested on:

commit:         4fa640dc Merge tag 'vfio-v5.8-rc7' of git://github.com..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8387e9c623864db
dashboard link: https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a4f831f00000

