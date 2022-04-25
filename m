Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B289850D6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbiDYBqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbiDYBqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:46:47 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D22F18398
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:43:43 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f7d621d1caso22797237b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6krFLzMek3l5FxyJLLw5EIMB9kHvWRijBo91lrCT+qA=;
        b=QETj6H2YIbGzGqxQjockC35Ct6GTnNX/DyZCpn+M2Ty428jV35l0Tk9gczKw2MVqkD
         cxicuwv1SUPrX1M7mtAixlUocwf4JWA1GmkQM9FXNkl2ww5Cvs8o03Z7IfGoLj8foTk/
         g2tWX01ted27kb8S/Ii7pWTaAemQk0dATvLbmHwj29voxZAbsLnGvP/CBsSSr6Da2TaO
         +t5u9gyQ7TSy2PLYPMt2agSZg/Fl2+9KWwIP5e1vXgMPN2GXpHIgkct+vh9+Hhak3X5c
         X2qQqBroC+jYiXlxwgm4FXGGdDRlgDDOeNznTUPUQyyHbXrAyKJ8sSpGSmMz9nmIJnM5
         zdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6krFLzMek3l5FxyJLLw5EIMB9kHvWRijBo91lrCT+qA=;
        b=dRN5wXDzGsS8Eas8gu524ldMTLwy5tMAsK4ULJw0oLWBKoBlQ+oT8ju3YxWZHB4+pb
         ePSCm0s051OH6MxqThWdN2mFQTiAW3PU9XP+fwtKxdcsvMtxXa3MnGmsmWLzj9dfPUJ6
         PHxO50BmZ92SVKBWzP9wYJr25B7olObDXtp+qCWzUYnqTgL5FOR640/qOLJ/yWa+mOUn
         ePmia1FJErM2g6CR8b5/RNxPLmoJrNJdRDKXFk3R2QOb8wp2ZzUtw9yNo5McvbStoOS2
         c7h1kkmMuoFBpLMrNHtSRkot6zI2zMAJyR3KUqaT8VtoEXIv583Kk4Ceg71urOgECo32
         J5lw==
X-Gm-Message-State: AOAM531bxfulkrJ5ZuGjyj97nqb9mrQOwBGb3316rqDNPys3GP+V6SyL
        9CYQ8CTRWXIY1mtxLV2fGrV1MulTe4Y0eeVSfFlOjw==
X-Google-Smtp-Source: ABdhPJxP+wWEZ4vbBaaQSrOOdMXnnMSi3yoK7a0t5hcWjTxeFw5XAcE2bvLX2RTVLyQHI5GbsuXfO6xI5wS6/0N9bFU=
X-Received: by 2002:a81:2054:0:b0:2f4:dfb3:3e3 with SMTP id
 g81-20020a812054000000b002f4dfb303e3mr15165883ywg.332.1650851022309; Sun, 24
 Apr 2022 18:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220425012847.GA21864@xsang-OptiPlex-9020>
In-Reply-To: <20220425012847.GA21864@xsang-OptiPlex-9020>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 24 Apr 2022 18:43:31 -0700
Message-ID: <CANn89iKhEJ3MttikNaJ1YEK5LcRdhrhOY1MrWONcgY9ko7uW=A@mail.gmail.com>
Subject: Re: [tcp] 4057037535: WARNING:at_include/net/tcp.h:#tcp_clean_rtx_queue
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 6:29 PM kernel test robot <oliver.sang@intel.com> w=
rote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 40570375356c874b1578e05c1dcc3ff7c1322dbe ("tcp: add accessors to =
read/set tp->snd_cwnd")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: syzkaller
> version:
> with following parameters:
>
>         runtime: 1800s
>         crash_id: 1e0a1e088f3d3b25620f291e7486b87e64cdf356
>
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [ 31.496199][ C1] WARNING: CPU: 1 PID: 1254 at include/net/tcp.h:1217 tcp=
_clean_rtx_queue+0x224e/0x28c0
> [   31.498766][    C1] Modules linked in: ip6_vti xfrm6_tunnel ip_vti ip_=
gre ipip sit tunnel4 ip_tunnel 8021q garp mrp veth dummy vcan bridge stp ll=
c ip6_gre gre ip6_tunnel tunnel6 tun bochs drm_vram_helper drm_ttm_helper t=
tm sr_mod drm_kms_helper cdrom sg syscopyarea sysfillrect ata_generic sysim=
gblt fb_sys_fops intel_rapl_msr intel_rapl_common crct10dif_pclmul ppdev cr=
c32_pclmul ata_piix crc32c_intel ghash_clmulni_intel rapl drm libata ipmi_d=
evintf ipmi_msghandler joydev parport_pc serio_raw i2c_piix4 parport ip_tab=
les
> [   31.511179][    C1] CPU: 1 PID: 1254 Comm: repro Not tainted 5.18.0-rc=
1-00028-g40570375356c #1
> [   31.513565][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.12.0-1 04/01/2014
> [ 31.516157][ C1] RIP: tcp_clean_rtx_queue+0x224e/0x28c0
> [ 31.518892][ C1] Code: 75 ea ff ff 48 89 ef 89 14 24 e8 8d f6 8e fe 8b 1=
4 24 e9 c9 ea ff ff 4c 89 f7 89 14 24 e8 7a f6 8e fe 8b 14 24 e9 ee ea ff f=
f <0f> 0b e9 cd f7 ff ff 4c 89 8c 24 80 00 00 00 48 89 44 24 78 48 89
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   75 ea                   jne    0xffffffffffffffec
>    2:   ff                      (bad)
>    3:   ff 48 89                decl   -0x77(%rax)
>    6:   ef                      out    %eax,(%dx)
>    7:   89 14 24                mov    %edx,(%rsp)
>    a:   e8 8d f6 8e fe          callq  0xfffffffffe8ef69c
>    f:   8b 14 24                mov    (%rsp),%edx
>   12:   e9 c9 ea ff ff          jmpq   0xffffffffffffeae0
>   17:   4c 89 f7                mov    %r14,%rdi
>   1a:   89 14 24                mov    %edx,(%rsp)
>   1d:   e8 7a f6 8e fe          callq  0xfffffffffe8ef69c
>   22:   8b 14 24                mov    (%rsp),%edx
>   25:   e9 ee ea ff ff          jmpq   0xffffffffffffeb18
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   e9 cd f7 ff ff          jmpq   0xfffffffffffff7fe
>   31:   4c 89 8c 24 80 00 00    mov    %r9,0x80(%rsp)
>   38:   00
>   39:   48 89 44 24 78          mov    %rax,0x78(%rsp)
>   3e:   48                      rex.W
>   3f:   89                      .byte 0x89
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   e9 cd f7 ff ff          jmpq   0xfffffffffffff7d4
>    7:   4c 89 8c 24 80 00 00    mov    %r9,0x80(%rsp)
>    e:   00
>    f:   48 89 44 24 78          mov    %rax,0x78(%rsp)
>   14:   48                      rex.W
>   15:   89                      .byte 0x89
> [   31.527983][    C1] RSP: 0018:ffffc90000188558 EFLAGS: 00010246
> [   31.530575][    C1] RAX: 0000000000000000 RBX: ffff88810c710000 RCX: 1=
ffff110218e209f
> [   31.533389][    C1] RDX: 0000000000004fdc RSI: 0000000000008219 RDI: f=
fffffff9b66bf12
> [   31.536156][    C1] RBP: ffff88810c7106bc R08: ffff88810c710658 R09: f=
fffc900001887b0
> [   31.539244][    C1] R10: 0000000000000000 R11: ffff8881982c4028 R12: f=
fff88810c7104f8
> [   31.543472][    C1] R13: 0000000000001004 R14: ffff88810c710684 R15: f=
fffc90000188780
> [   31.546255][    C1] FS:  00007f3f1ee4d540(0000) GS:ffff888398700000(00=
00) knlGS:0000000000000000
> [   31.550168][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.553203][    C1] CR2: 00007ffce7024198 CR3: 00000001991a8000 CR4: 0=
0000000000406e0
> [   31.556803][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [   31.560524][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [   31.563664][    C1] Call Trace:
> [   31.566375][    C1]  <IRQ>

I am not sure if this gcc-11 specific, but I find this stack trace unusable=
.

I think I will wait for a regular syzbot report to investigate this, as pla=
nned.

Thanks.


> [ 31.568872][ C1] ? process_backlog (include/linux/netdevice.h:3099 net/c=
ore/dev.c:5853)
> [ 31.571598][ C1] ? __napi_poll (net/core/dev.c:6417)
> [ 31.574512][ C1] ? net_rx_action (net/core/dev.c:6486 net/core/dev.c:657=
1)
> [ 31.582096][ C1] ? tcp_ack_update_rtt (net/ipv4/tcp_input.c:3219)
> [ 31.585096][ C1] ? ip_output (net/ipv4/ip_output.c:422)
> [ 31.588205][ C1] ? __ip_queue_xmit (arch/x86/include/asm/preempt.h:85 in=
clude/linux/rcupdate.h:73 include/linux/rcupdate.h:726 net/ipv4/ip_output.c=
:533)
> [ 31.591309][ C1] ? __tcp_transmit_skb (net/ipv4/tcp_output.c:1402 (discr=
iminator 4))
> [ 31.594438][ C1] ? tcp_rcv_established (net/ipv4/tcp_input.c:5542 net/ip=
v4/tcp_input.c:5971)
> [ 31.602140][ C1] ? tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1706)
> [ 31.605173][ C1] ? __release_sock (include/net/sock.h:1051 net/core/sock=
.c:2794)
> [ 31.608262][ C1] ? __sk_flush_backlog (include/linux/spinlock.h:394 net/=
core/sock.c:2815)
> [ 31.611199][ C1] ? tcp_sendmsg_locked (net/ipv4/tcp.c:1295)
> [ 31.614237][ C1] tcp_ack (net/ipv4/tcp_input.c:3864)
> [ 31.616988][ C1] ? tcp_rearm_rto (net/ipv4/tcp_input.c:3738)
> [ 31.619946][ C1] ? skb_try_coalesce (arch/x86/include/asm/atomic.h:29 in=
clude/linux/atomic/atomic-instrumented.h:28 include/linux/skbuff.h:1866 inc=
lude/linux/skbuff.h:1863 net/core/skbuff.c:5276)
> [ 31.622949][ C1] ? skb_release_data (net/core/skbuff.c:677)
> [ 31.625850][ C1] ? __ip_queue_xmit (arch/x86/include/asm/preempt.h:85 in=
clude/linux/rcupdate.h:73 include/linux/rcupdate.h:726 net/ipv4/ip_output.c=
:533)
> [ 31.628741][ C1] ? tcp_reset (net/ipv4/tcp_input.c:5668)
> [ 31.631546][ C1] ? kvm_clock_get_cycles (arch/x86/include/asm/preempt.h:=
85 arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86)
> [ 31.646267][ C1] tcp_rcv_established (net/ipv4/tcp_input.c:5959)
> [ 31.649621][ C1] ? __inet_lookup_established (arch/x86/include/asm/atomi=
c.h:202 include/linux/atomic/atomic-instrumented.h:560 include/linux/refcou=
nt.h:157 include/linux/refcount.h:227 include/linux/refcount.h:245 net/ipv4=
/inet_hashtables.c:415)
> [ 31.652688][ C1] ? tcp_inbound_md5_hash (net/ipv4/tcp.c:4467)
> [ 31.655694][ C1] ? tcp_data_queue (net/ipv4/tcp_input.c:5800)
> [ 31.658687][ C1] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 inc=
lude/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h=
:82 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:134 kerne=
l/locking/spinlock.c:154)
> [ 31.661532][ C1] tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1706)
> [ 31.664236][ C1] tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2074)
> [ 31.667214][ C1] ? tcp_v4_early_demux (net/ipv4/tcp_ipv4.c:1912)
> [ 31.669880][ C1] ? dst_destroy (net/core/dst.c:127)
> [ 31.672397][ C1] ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205 (discr=
iminator 1))
> [ 31.674945][ C1] ? rcu_do_batch (arch/x86/include/asm/preempt.h:27 kerne=
l/rcu/tree.c:2542)
> [ 31.677311][ C1] ip_local_deliver_finish (arch/x86/include/asm/preempt.h=
:85 include/linux/rcupdate.h:73 include/linux/rcupdate.h:726 net/ipv4/ip_in=
put.c:234)
> [ 31.679790][ C1] ip_local_deliver (net/ipv4/ip_input.c:243)
> [ 31.682152][ C1] ? ip_local_deliver_finish (net/ipv4/ip_input.c:243)
> [ 31.684557][ C1] ? __do_softirq (arch/x86/include/asm/jump_label.h:27 in=
clude/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.=
c:559)
> [ 31.686768][ C1] ? __irq_exit_rcu (kernel/softirq.c:432 kernel/softirq.c=
:637)
> [ 31.689060][ C1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/api=
c.c:1097 (discriminator 14))
> [ 31.691618][ C1] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm=
/idtentry.h:645)
> [ 31.693927][ C1] ? finish_task_switch+0x1c1/0x740
> [ 31.697029][ C1] ? memset (mm/kasan/shadow.c:44)
> [ 31.699095][ C1] ? ip_rcv_core (net/ipv4/ip_input.c:523)
> [ 31.701275][ C1] ip_rcv (include/net/dst.h:461 net/ipv4/ip_input.c:437 i=
nclude/linux/netfilter.h:307 include/linux/netfilter.h:301 net/ipv4/ip_inpu=
t.c:556)
> [ 31.703312][ C1] ? ip_rcv_finish (net/ipv4/ip_input.c:549)
> [ 31.705353][ C1] ? refcount_dec_not_one (arch/x86/include/asm/atomic.h:2=
02 include/linux/atomic/atomic-instrumented.h:552 lib/refcount.c:91)
> [ 31.707466][ C1] ? refcount_warn_saturate (lib/refcount.c:75)
> [ 31.709493][ C1] ? preferred_group_nid (kernel/sched/fair.c:717)
> [ 31.711630][ C1] ? update_load_avg (kernel/sched/fair.c:3647 kernel/sche=
d/fair.c:3902)
> [ 31.715378][ C1] ? ip_rcv_finish (net/ipv4/ip_input.c:549)
> [ 31.717604][ C1] __netif_receive_skb_one_core (net/core/dev.c:5409 (disc=
riminator 4))
> [ 31.719774][ C1] ? __netif_receive_skb_list_core (net/core/dev.c:5402)
> [ 31.722020][ C1] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202=
 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlo=
ck.h:82 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:120 k=
ernel/locking/spinlock.c:170)
> [ 31.724095][ C1] ? dst_destroy (net/core/dst.c:127)
> [ 31.726154][ C1] process_backlog (include/linux/netdevice.h:3099 net/cor=
e/dev.c:5853)
> [ 31.728229][ C1] __napi_poll (net/core/dev.c:6417)
> [ 31.730278][ C1] net_rx_action (net/core/dev.c:6486 net/core/dev.c:6571)
> [ 31.732301][ C1] ? napi_threaded_poll (net/core/dev.c:6549)
> [ 31.735070][ C1] ? sched_clock_cpu (kernel/sched/clock.c:369)
> [ 31.737088][ C1] __do_softirq (arch/x86/include/asm/jump_label.h:27 incl=
ude/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:=
559)
> [ 31.739099][ C1] do_softirq (kernel/softirq.c:459 kernel/softirq.c:446)
> [   31.741070][    C1]  </IRQ>
> [   31.744856][    C1]  <TASK>
> [ 31.746699][ C1] ? inet_send_prepare (net/ipv4/af_inet.c:813)
> [ 31.748725][ C1] __local_bh_enable_ip (kernel/softirq.c:383)
> [ 31.750696][ C1] tcp_sendmsg (net/ipv4/tcp.c:1453)
> [ 31.753196][ C1] sock_sendmsg (net/socket.c:705 net/socket.c:725)
> [ 31.755383][ C1] ____sys_sendmsg (net/socket.c:2413)
> [ 31.757403][ C1] ? kernel_sendmsg (net/socket.c:2360)
> [ 31.759426][ C1] ? __ia32_sys_recvmmsg (net/socket.c:2435)
> [ 31.761464][ C1] ? kasan_save_stack (mm/kasan/common.c:40)
> [ 31.764008][ C1] ? kasan_save_stack (mm/kasan/common.c:39)
> [ 31.766031][ C1] ? __kasan_slab_alloc (mm/kasan/common.c:45 mm/kasan/com=
mon.c:436 mm/kasan/common.c:469)
> [ 31.768054][ C1] ? kmem_cache_alloc (mm/slab.h:749 mm/slub.c:3217 mm/slu=
b.c:3225 mm/slub.c:3232 mm/slub.c:3242)
> [ 31.770051][ C1] ? __alloc_file (fs/file_table.c:139)
> [ 31.772190][ C1] ? alloc_empty_file (fs/file_table.c:187)
> [ 31.774271][ C1] ? alloc_file (fs/file_table.c:229)
> [ 31.776641][ C1] ___sys_sendmsg (net/socket.c:2469)
> [ 31.778655][ C1] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_=
64.S:115)
> [ 31.780781][ C1] ? xa_extract (lib/xarray.c:1454)
> [ 31.782714][ C1] ? sendmsg_copy_msghdr (net/socket.c:2456)
> [ 31.785079][ C1] ? memcg_slab_post_alloc_hook (mm/slab.h:526 (discrimina=
tor 2))
> [ 31.787344][ C1] ? sock_i_uid (net/core/sock.c:2429)
> [ 31.789475][ C1] ? inet_csk_update_fastreuse (net/ipv4/inet_connection_s=
ock.c:311)
> [ 31.791556][ C1] ? kmem_cache_alloc (mm/slub.c:3219 mm/slub.c:3225 mm/sl=
ub.c:3232 mm/slub.c:3242)
> [ 31.793634][ C1] ? __fget_light (arch/x86/include/asm/atomic.h:29 includ=
e/linux/atomic/atomic-instrumented.h:28 fs/file.c:1032)
> [ 31.795591][ C1] __sys_sendmmsg (net/socket.c:2553)
> [ 31.797545][ C1] ? __ia32_sys_sendmsg (net/socket.c:2514)
> [ 31.800785][ C1] ? __sys_bind (net/socket.c:1697)
> [ 31.802796][ C1] ? __sys_socket (net/socket.c:1542)
> [ 31.804683][ C1] ? compat_sock_ioctl (net/socket.c:1542)
> [ 31.806894][ C1] ? __ia32_sys_read (fs/read_write.c:634)
> [ 31.808854][ C1] __x64_sys_sendmmsg (net/socket.c:2579)
> [ 31.811111][ C1] ? __x64_sys_bind (net/socket.c:1706)
> [ 31.813103][ C1] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entr=
y/common.c:80)
> [ 31.815273][ C1] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64=
.S:115)
> [   31.817315][    C1] RIP: 0033:0x7f3f1ed7ef59
> [ 31.819337][ C1] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 0=
0 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 0=
5 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 89 01 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   00 c3                   add    %al,%bl
>    2:   66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>    9:   00 00 00
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.18.0-rc1-00028-g40570375356c .config
>         make HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Dx86_64 olddefconfig prepa=
re modules_prepare bzImage modules
>         make HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Dx86_64 INSTALL_MOD_PATH=
=3D<mod-install-dir> modules_install
>         cd <mod-install-dir>
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script =
is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
>
