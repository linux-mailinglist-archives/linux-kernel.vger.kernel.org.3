Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB34E459C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiCVR6j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbiCVR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:58:37 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CCC8EB66
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:57:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id m4-20020a924b04000000b002c851e73720so584607ilg.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=7hSYUpq30shPrn1anLJiqXbFF/RwF850jZ3TUw5aUK0=;
        b=sDG3yxzK+c7wYCWFfmk8nWQ23Pu/11keyH1U95LXGvEWyUbgFCdbW8anz9+AfXPv9x
         ouWjCt2Dr3nkEiycFCU2PI7MFJnDDNIE4Kkto85DFrjn2HDQJMSbNVw2sRgOakr9kjb9
         GLRUs/a03RmzjiuMKxzz+1Ue9YXx4P7cfdc0Lzgmiz7GZaYToO87N643O3K3V6HpqOw/
         wo6Ji3ML7nO7ZVofMhtHsFIrTW6ZYqWAkEqwqPErYuu24EKvTrKZ0hN1xhbrfTiaADlY
         nRqzAf0A791NUa8sV80QiEph6RzEmgp95xq4YEH8tj4fri2Is2XFOb6qH2eGzLJSMyFz
         sJnw==
X-Gm-Message-State: AOAM53146cVS22/hqZZke9X4sUv3n2Hr9G3zWq99dwff2Id8wxrgaycI
        XRk5Eg9G4jNw6WrjHlpTrRyj/tuIBiZPE8qFiLch4H14DbGn
X-Google-Smtp-Source: ABdhPJxB5yYCMAkHyiCEB19bhX1fxpgNANyrAcwXTQgkU0m/HHcm3zF2uVBtyabaKeMtcE2SzWLJX/6ad3jFky4Y0nq7me8zYR/v
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13d4:b0:31a:65c5:a4ee with SMTP id
 i20-20020a05663813d400b0031a65c5a4eemr11992531jaj.259.1647971828403; Tue, 22
 Mar 2022 10:57:08 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:57:08 -0700
In-Reply-To: <20220322134809.3382-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e971305dad25766@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in blk_release_queue
From:   syzbot <syzbot+bbea00057d3d55c4889b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

00000000 R09: 0000000000000001
R10: ffffffff873c1678 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880b9c00000 R14: 000000000003b180 R15: ffff88806f8f8ec0
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056420cdd2db0 CR3: 000000006a719000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 napi_schedule include/linux/netdevice.h:465 [inline]
 wg_queue_enqueue_per_peer_rx drivers/net/wireguard/queueing.h:204 [inline]
 wg_packet_decrypt_worker+0x408/0x5d0 drivers/net/wireguard/receive.c:510
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>


[   32.467287][ T3174] 8021q: adding VLAN 0 to HW filter on device bond0
[   32.481614][ T3174] eql: remember to turn off Van-Jacobson compression on your slave devices
Starting sshd: OK

syzkaller
syzkaller login: [   43.713954][   T27] kauditd_printk_skb: 37 callbacks suppressed
[   43.713966][   T27] audit: type=1400 audit(1647971762.505:73): avc:  denied  { transition } for  pid=3381 comm="sshd" path="/bin/sh" dev="sda1" ino=73 scontext=system_u:system_r:initrc_t tcontext=root:sysadm_r:sysadm_t tclass=process permissive=1
[   43.744491][   T27] audit: type=1400 audit(1647971762.535:74): avc:  denied  { write } for  pid=3381 comm="sh" path="pipe:[718]" dev="pipefs" ino=718 scontext=root:sysadm_r:sysadm_t tcontext=system_u:system_r:initrc_t tclass=fifo_file permissive=1
Warning: Permanently added '10.128.0.110' (ECDSA) to the list of known hosts.
2022/03/22 17:56:12 fuzzer started
2022/03/22 17:56:12 connecting to host at 10.128.0.169:44989
2022/03/22 17:56:12 checking machine...
2022/03/22 17:56:12 checking revisions...
2022/03/22 17:56:12 testing simple program...
[   54.135544][   T27] audit: type=1400 audit(1647971772.925:75): avc:  denied  { getattr } for  pid=3585 comm="syz-fuzzer" path="user:[4026531837]" dev="nsfs" ino=4026531837 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:nsfs_t tclass=file permissive=1
[   54.159389][   T27] audit: type=1400 audit(1647971772.935:76): avc:  denied  { read } for  pid=3585 comm="syz-fuzzer" dev="nsfs" ino=4026531837 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:nsfs_t tclass=file permissive=1
[   54.182001][   T27] audit: type=1400 audit(1647971772.935:77): avc:  denied  { open } for  pid=3585 comm="syz-fuzzer" path="user:[4026531837]" dev="nsfs" ino=4026531837 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:nsfs_t tclass=file permissive=1
[   54.206388][   T27] audit: type=1400 audit(1647971772.955:78): avc:  denied  { read } for  pid=3585 comm="syz-fuzzer" name="raw-gadget" dev="devtmpfs" ino=730 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:device_t tclass=chr_file permissive=1
[   54.211078][ T3594] cgroup: Unknown subsys name 'net'
[   54.229939][   T27] audit: type=1400 audit(1647971772.955:79): avc:  denied  { open } for  pid=3585 comm="syz-fuzzer" path="/dev/raw-gadget" dev="devtmpfs" ino=730 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:device_t tclass=chr_file permissive=1
[   54.258611][   T27] audit: type=1400 audit(1647971772.955:80): avc:  denied  { read } for  pid=3585 comm="syz-fuzzer" name="vhci" dev="devtmpfs" ino=1072 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:vhost_device_t tclass=chr_file permissive=1
[   54.282401][   T27] audit: type=1400 audit(1647971772.955:81): avc:  denied  { open } for  pid=3585 comm="syz-fuzzer" path="/dev/vhci" dev="devtmpfs" ino=1072 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:vhost_device_t tclass=chr_file permissive=1
[   54.306043][   T27] audit: type=1400 audit(1647971772.995:82): avc:  denied  { mounton } for  pid=3594 comm="syz-executor" path="/syzcgroup/unified" dev="sda1" ino=1136 scontext=root:sysadm_r:sysadm_t tcontext=root:object_r:root_t tclass=dir permissive=1
[   54.329350][   T27] audit: type=1400 audit(1647971772.995:83): avc:  denied  { mount } for  pid=3594 comm="syz-executor" name="/" dev="cgroup2" ino=1 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:cgroup_t tclass=filesystem permissive=1
[   54.352653][   T27] audit: type=1400 audit(1647971773.035:84): avc:  denied  { unmount } for  pid=3594 comm="syz-executor" scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:cgroup_t tclass=filesystem permissive=1
[   54.465100][ T3594] cgroup: Unknown subsys name 'rlimit'
[   55.749146][ T3597] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[   55.757962][ T3597] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[   55.765791][ T3597] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[   55.774317][ T3597] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[   55.782335][ T3597] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
[   55.790024][ T3597] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[   55.888732][ T3596] chnl_net:caif_netlink_parms(): no params data found
[   55.935296][ T3596] bridge0: port 1(bridge_slave_0) entered blocking state
[   55.942935][ T3596] bridge0: port 1(bridge_slave_0) entered disabled state
[   55.951228][ T3596] device bridge_slave_0 entered promiscuous mode
[   55.960805][ T3596] bridge0: port 2(bridge_slave_1) entered blocking state
[   55.968208][ T3596] bridge0: port 2(bridge_slave_1) entered disabled state
[   55.977002][ T3596] device bridge_slave_1 entered promiscuous mode
[   56.001058][ T3596] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
[   56.012334][ T3596] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
[   56.036313][ T3596] team0: Port device team_slave_0 added
[   56.043980][ T3596] team0: Port device team_slave_1 added
[   56.062964][ T3596] batman_adv: batadv0: Adding interface: batadv_slave_0
[   56.070197][ T3596] batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   56.096244][ T3596] batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
[   56.109529][ T3596] batman_adv: batadv0: Adding interface: batadv_slave_1
[   56.116590][ T3596] batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   56.142881][ T3596] batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
[   56.169447][ T3596] device hsr_slave_0 entered promiscuous mode
[   56.176134][ T3596] device hsr_slave_1 entered promiscuous mode
[   56.269761][ T3596] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   56.280937][ T3596] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   56.290761][ T3596] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   56.301238][ T3596] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   56.323697][ T3596] bridge0: port 2(bridge_slave_1) entered blocking state
[   56.330921][ T3596] bridge0: port 2(bridge_slave_1) entered forwarding state
[   56.339194][ T3596] bridge0: port 1(bridge_slave_0) entered blocking state
[   56.346413][ T3596] bridge0: port 1(bridge_slave_0) entered forwarding state
[   56.396709][ T3596] 8021q: adding VLAN 0 to HW filter on device bond0
[   56.410674][ T2978] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   56.422814][ T2978] bridge0: port 1(bridge_slave_0) entered disabled state
[   56.432014][ T2978] bridge0: port 2(bridge_slave_1) entered disabled state
[   56.440155][ T2978] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
[   56.456015][ T3596] 8021q: adding VLAN 0 to HW filter on device team0
[   56.469551][ T3606] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
[   56.478037][ T3606] bridge0: port 1(bridge_slave_0) entered blocking state
[   56.485116][ T3606] bridge0: port 1(bridge_slave_0) entered forwarding state
[   56.497293][ T2978] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
[   56.506617][ T2978] bridge0: port 2(bridge_slave_1) entered blocking state
[   56.514201][ T2978] bridge0: port 2(bridge_slave_1) entered forwarding state
[   56.539518][ T2978] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
[   56.549352][ T2978] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
[   56.559707][ T2978] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link becomes ready
[   56.568764][ T2978] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link becomes ready
[   56.579092][ T3596] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
[   56.590204][ T3607] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
[   56.611807][ T3596] 8021q: adding VLAN 0 to HW filter on device batadv0
[   56.619341][ T3607] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes ready
[   56.626779][ T3607] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes ready
[   56.740702][  T918] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link becomes ready
[   56.755262][ T3607] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link becomes ready
[   56.765895][ T3596] device veth0_vlan entered promiscuous mode
[   56.774072][  T918] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes ready
[   56.782437][  T918] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes ready
[   56.795036][ T3596] device veth1_vlan entered promiscuous mode
[   56.815649][  T918] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link becomes ready
[   56.823912][  T918] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link becomes ready
[   56.832252][  T918] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link becomes ready
[   56.843344][ T3596] device veth0_macvtap entered promiscuous mode
[   56.854010][ T3596] device veth1_macvtap entered promiscuous mode
[   56.870540][ T3596] batman_adv: batadv0: Interface activated: batadv_slave_0
[   56.881039][  T918] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link becomes ready
[   56.892621][  T918] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link becomes ready
[   56.903247][ T3596] batman_adv: batadv0: Interface activated: batadv_slave_1
[   56.911688][ T3607] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1: link becomes ready
[   56.920911][ T3607] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
[   56.931905][ T3596] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
executing program
[   56.948659][ T3596] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
[   56.957369][ T3596] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
[   56.966522][ T3596] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
[   56.999871][ T3606] ------------[ cut here ]------------
[   57.005683][ T3606] WARNING: CPU: 0 PID: 3606 at net/core/dev.c:4280 __napi_schedule+0xe2/0x440
[   57.014591][ T3606] Modules linked in:
[   57.018588][ T3606] CPU: 0 PID: 3606 Comm: kworker/0:3 Not tainted 5.17.0-next-20220321-syzkaller-dirty #0
[   57.018624][ T3606] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   57.018640][ T3606] Workqueue: wg-crypt-wg0 wg_packet_decrypt_worker
[   57.045433][ T3606] RIP: 0010:__napi_schedule+0xe2/0x440
[   57.051066][ T3606] Code: 74 4a e8 d1 c1 3b fa 31 ff 65 44 8b 25 57 59 c6 78 41 81 e4 00 ff 0f 00 44 89 e6 e8 d8 c3 3b fa 45 85 e4 75 07 e8 ae c1 3b fa <0f> 0b e8 a7 c1 3b fa 65 44 8b 25 77 63 c6 78 31 ff 44 89 e6 e8 b5
[   57.067042][ T1084] wlan0: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
[   57.070904][ T3606] RSP: 0018:ffffc9000345fc78 EFLAGS: 00010093
[   57.070928][ T3606] RAX: 0000000000000000 RBX: ffff888070589a48 RCX: 0000000000000000
[   57.070941][ T3606] RDX: ffff88802199c180 RSI: ffffffff873c1682 RDI: 0000000000000003
[   57.070956][ T3606] RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000001
[   57.070970][ T3606] R10: ffffffff873c1678 R11: 0000000000000000 R12: 0000000000000000
[   57.070984][ T3606] R13: ffff8880b9c00000 R14: 000000000003b180 R15: ffff88806f8f8ec0
[   57.093188][ T3606] FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
[   57.093215][ T3606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.093230][ T3606] CR2: 000056420cdd2db0 CR3: 000000006a719000 CR4: 00000000003506f0
[   57.093245][ T3606] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   57.157189][ T3606] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   57.165160][ T3606] Call Trace:
[   57.168447][ T3606]  <TASK>
[   57.171387][ T3606]  wg_packet_decrypt_worker+0x408/0x5d0
[   57.177231][ T3606]  process_one_work+0x996/0x1610
[   57.182468][ T3606]  ? pwq_dec_nr_in_flight+0x2a0/0x2a0
[   57.187872][ T3606]  ? rwlock_bug.part.0+0x90/0x90
[   57.192808][ T3606]  ? _raw_spin_lock_irq+0x41/0x50
[   57.197846][ T3606]  worker_thread+0x665/0x1080
[   57.202550][ T3606]  ? __kthread_parkme+0x15f/0x220
[   57.207663][ T3606]  ? process_one_work+0x1610/0x1610
[   57.213043][ T3606]  kthread+0x2e9/0x3a0
[   57.217131][ T3606]  ? kthread_complete_and_exit+0x40/0x40
[   57.222861][ T3606]  ret_from_fork+0x1f/0x30
[   57.227279][ T3606]  </TASK>
[   57.230291][ T3606] Kernel panic - not syncing: panic_on_warn set ...
[   57.237581][ T3606] CPU: 0 PID: 3606 Comm: kworker/0:3 Not tainted 5.17.0-next-20220321-syzkaller-dirty #0
[   57.247421][ T3606] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   57.257570][ T3606] Workqueue: wg-crypt-wg0 wg_packet_decrypt_worker
[   57.264122][ T3606] Call Trace:
[   57.267432][ T3606]  <TASK>
[   57.270626][ T3606]  dump_stack_lvl+0xcd/0x134
[   57.275394][ T3606]  panic+0x2d7/0x636
[   57.279292][ T3606]  ? panic_print_sys_info.part.0+0x10b/0x10b
[   57.285286][ T3606]  ? __warn.cold+0x1d1/0x2c5
[   57.289883][ T3606]  ? __napi_schedule+0xe2/0x440
[   57.294944][ T3606]  __warn.cold+0x1e2/0x2c5
[   57.299540][ T3606]  ? __napi_schedule+0xe2/0x440
[   57.304419][ T3606]  report_bug+0x1bd/0x210
[   57.309008][ T3606]  handle_bug+0x3c/0x60
[   57.313427][ T3606]  exc_invalid_op+0x14/0x40
[   57.318035][ T3606]  asm_exc_invalid_op+0x12/0x20
[   57.322984][ T3606] RIP: 0010:__napi_schedule+0xe2/0x440
[   57.328448][ T3606] Code: 74 4a e8 d1 c1 3b fa 31 ff 65 44 8b 25 57 59 c6 78 41 81 e4 00 ff 0f 00 44 89 e6 e8 d8 c3 3b fa 45 85 e4 75 07 e8 ae c1 3b fa <0f> 0b e8 a7 c1 3b fa 65 44 8b 25 77 63 c6 78 31 ff 44 89 e6 e8 b5
[   57.348960][ T3606] RSP: 0018:ffffc9000345fc78 EFLAGS: 00010093
[   57.355050][ T3606] RAX: 0000000000000000 RBX: ffff888070589a48 RCX: 0000000000000000
[   57.363106][ T3606] RDX: ffff88802199c180 RSI: ffffffff873c1682 RDI: 0000000000000003
[   57.371088][ T3606] RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000001
[   57.379069][ T3606] R10: ffffffff873c1678 R11: 0000000000000000 R12: 0000000000000000
[   57.387122][ T3606] R13: ffff8880b9c00000 R14: 000000000003b180 R15: ffff88806f8f8ec0
[   57.395350][ T3606]  ? __napi_schedule+0xd8/0x440
[   57.400222][ T3606]  ? __napi_schedule+0xe2/0x440
[   57.405107][ T3606]  ? __napi_schedule+0xe2/0x440
[   57.410057][ T3606]  wg_packet_decrypt_worker+0x408/0x5d0
[   57.415803][ T3606]  process_one_work+0x996/0x1610
[   57.420847][ T3606]  ? pwq_dec_nr_in_flight+0x2a0/0x2a0
[   57.426230][ T3606]  ? rwlock_bug.part.0+0x90/0x90
[   57.431256][ T3606]  ? _raw_spin_lock_irq+0x41/0x50
[   57.436372][ T3606]  worker_thread+0x665/0x1080
[   57.441055][ T3606]  ? __kthread_parkme+0x15f/0x220
[   57.446101][ T3606]  ? process_one_work+0x1610/0x1610
[   57.451565][ T3606]  kthread+0x2e9/0x3a0
[   57.455724][ T3606]  ? kthread_complete_and_exit+0x40/0x40
[   57.461364][ T3606]  ret_from_fork+0x1f/0x30
[   57.465912][ T3606]  </TASK>
[   57.469667][ T3606] Kernel Offset: disabled
[   57.474426][ T3606] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=17aae1a3700000


Tested on:

commit:         f9006d92 Add linux-next specific files for 20220321
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=988d5d4e5a475e90
dashboard link: https://syzkaller.appspot.com/bug?extid=bbea00057d3d55c4889b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f20eeb700000

