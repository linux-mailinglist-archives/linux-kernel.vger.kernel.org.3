Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B434C191F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbiBWQzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbiBWQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:55:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D321CC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:55:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8C2BB820F7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C1C340E7;
        Wed, 23 Feb 2022 16:54:58 +0000 (UTC)
Date:   Wed, 23 Feb 2022 11:54:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Dao <dqminh@cloudflare.com>
Cc:     kernel-team <kernel-team@cloudflare.com>, mingo@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: 5.15 ftrace bug when enabling function_graph
Message-ID: <20220223115457.7bb575c1@gandalf.local.home>
In-Reply-To: <CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com>
References: <CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 15:47:28 +0000
Daniel Dao <dqminh@cloudflare.com> wrote:

> Hi all
> 
> We had some panic when trying to profile some function using ftrace's
> function_graph.
> The panic is attached here:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 30 PID: 812411 at arch/x86/kernel/ftrace.c:96
> ftrace_verify_code+0x37/0x70
>   Modules linked in: xt_hashlimit macvlan ip_set_hash_netport
> xt_length esp4 xfrm_interface xfrm6_tunnel dummy ipip nft_numgen
> nft_ct ip_gre gre xfrm_user xfrm_algo udp_diag inet_diag fou6
> ip6_tunnel tunnel6 cls_bpf xt_NFLOG xt_statistic lz4 lz4_compress sit
> tunnel4 fou ip_tunnel ip6_udp_tunnel udp_tunnel nft_compat veth tun
> overlay sch_ingress raid0 md_mod essiv dm_crypt trusted asn1_encoder
> tee dm_mod dax nfnetlink_log nft_log nft_limit nft_counter nf_tables
> ip6table_filter ip6table_mangle ip6table_raw ip6table_security
> ip6table_nat ip6_tables xt_state xt_multiport xt_tcpmss iptable_filter
> xt_TCPMSS xt_bpf xt_u32 xt_mark xt_connmark xt_conntrack
> iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment
> xt_tcpudp xt_CT iptable_raw ip_set_hash_net ip_set_hash_ip ip_set
> nfnetlink sch_fq tcp_bbr nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> 8021q garp stp mrp llc skx_edac x86_pkg_temp_thermal kvm_intel kvm
> irqbypass crc32_pclmul crc32c_intel aesni_intel
>   rapl intel_cstate ipmi_ssif mlx5_core i2c_i801 mlxfw i2c_smbus
> xhci_pci acpi_ipmi tpm_crb tls intel_uncore ioatdma i2c_core xhci_hcd
> ipmi_si dca tpm_tis ipmi_devintf tpm_tis_core tiny_power_button
> ipmi_msghandler tpm button fuse efivarfs ip_tables x_tables
> bcmcrypt(O) crypto_simd cryptd [last unloaded: zsmalloc]
>   CPU: 30 PID: 812411 Comm: bash Tainted: G           O
> 5.15.19-cloudflare-2022.2.1 #1
>   Hardware name: Quanta Cloud Technology Inc. QuantaPlex
> T42S-2U/T42S-2U MB (Lewisburg-1G) CLX, BIOS 3B16.Q102 02/19/2020
>   RIP: 0010:ftrace_verify_code+0x37/0x70
>   Code: 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8d
> 7c 24 03 e8 26 1f 1a 00 48 85 c0 75 33 8b 03 39 44 24 03 74 1d <0f> 0b
> b8 ea ff ff ff 48 8b 4c 24 08 65 48 2b 0c 25 28 00 00 00 75
>   RSP: 0018:ffffa86ce19e3d28 EFLAGS: 00010212
>   RAX: 0000000000441f0f RBX: ffffffffa9001e8a RCX: 0000000000000010
>   RDX: 000000000db62b18 RSI: 0000000000000005 RDI: ffffffffa89ea1d0
>   RBP: ffffffffaa764350 R08: 0000000000000001 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
>   R13: ffff8fb8c00f95f0 R14: 0000000000000000 R15: 000000000000000f
>   FS:  00007f3715044740(0000) GS:ffff8ff7bf380000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000055c306a30298 CR3: 0000002e01756002 CR4: 00000000007706e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>   <TASK>
>   ftrace_replace_code+0x9a/0x160
>   ? arch_unoptimize_kprobes+0xb0/0xb0
>   ftrace_modify_all_code+0xbd/0x150
>   ftrace_run_update_code+0x13/0x70
>   ftrace_startup.part.0+0xe1/0x140
>   register_ftrace_graph+0x292/0x2d0
>   graph_trace_init+0x27/0x50
>   tracing_set_tracer+0xdb/0x170
>   tracing_set_trace_write+0x95/0xe0
>   vfs_write+0xbd/0x270
>   ksys_write+0x5f/0xe0
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>   RIP: 0033:0x7f3715135f33
>   Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
> 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
>   RSP: 002b:00007ffc4232a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>   RAX: ffffffffffffffda RBX: 000000000000000f RCX: 00007f3715135f33
>   RDX: 000000000000000f RSI: 000055c2f4c63480 RDI: 0000000000000001
>   RBP: 000055c2f4c63480 R08: 000000000000000a R09: 000000000000000e
>   R10: 000055c2f4c66cd0 R11: 0000000000000246 R12: 000000000000000f
>   R13: 00007f37152066a0 R14: 000000000000000f R15: 00007f37152068a0
>   </TASK>
>   ---[ end trace 3c0096669fc25320 ]---
>   ------------[ ftrace bug ]------------
>   ftrace failed to modify
>   [<ffffffffa89ea1d0>] bpf_dispatcher_xdp_func+0x0/0x10

Of course this is bpf :-/

OK, I found the creation of bpf_dispatcher_xdp_func in include/linux/bpf.h:

#define DEFINE_BPF_DISPATCHER(name)                                     \
        noinline __nocfi unsigned int bpf_dispatcher_##name##_func(     \
                const void *ctx,                                        \
                const struct bpf_insn *insnsi,                          \
                unsigned int (*bpf_func)(const void *,                  \
                                         const struct bpf_insn *))      \
        {                                                               \
                return bpf_func(ctx, insnsi);                           \
        }                                                               \

You can try changing that to:

        noinline __nocfi notrace unsigned int bpf_dispatcher_##name##_func( \

and see if that fixes it for you.

If you can not change the running kernel, you can try this first:

 # echo 'bpf_dispatcher_*_func' > /sys/kernel/tracing/set_ftrace_notrace

It doesn't explain the bug, but at least may be a workaround for you.

>   actual:   ffffffe9:2b:ffffffb6:0d:18

Bah, I need to make that an unsigned char for printing. That was to be:

	e9:2b:b6:0d:18

Unfortunately, we lost what it expected to see due to changes in the
modification code, so I do not really know what the problem was :-/


>   Setting ftrace call site to call ftrace function
>   ftrace record flags: 10000001

So the record says that there's a trampoline used for the callback, and
that there's one user. That makes sense.


>   (1)
>   expected tramp: ffffffffa824bd90

So this the location of the trampoline.

As the instruction is e92bb60d18

Where e9 is the call, and the rest is the offset from the RIP which is:

   ffffffffa89ea1d0 (from above)

   ffffffffa89ea1d0 + 2bb60d18 + 5 (for instruction size)

should give:

Which would give:

   ffffffffd454aeed

Which is not the trampoline. The jump to the trampoline should have it be:

   e9861bc0

If I did my addition correctly, as the trampoline is at a lower location
than the address of the function.

>   ------------[ cut here ]------------
> 
> After this, any attempt to use trace will fail. For example, here we execute
> https://github.com/iovisor/bcc/blob/master/tools/funcslower.py shortly after.
> 
>   WARNING: CPU: 30 PID: 812411 at kernel/trace/ftrace.c:2073
> ftrace_bug+0x22c/0x252

OK, so once a ftrace_bug is hit, ftrace is "shutdown". No more
modifications is done due to the fact that the accounting has no integrity.

>   Modules linked in: xt_hashlimit macvlan ip_set_hash_netport
> xt_length esp4 xfrm_interface xfrm6_tunnel dummy ipip nft_numgen
> nft_ct ip_gre gre xfrm_user xfrm_algo udp_diag inet_diag fou6
> ip6_tunnel tunnel6 cls_bpf xt_NFLOG xt_statistic lz4 lz4_compress sit
> tunnel4 fou ip_tunnel ip6_udp_tunnel udp_tunnel nft_compat veth tun
> overlay sch_ingress raid0 md_mod essiv dm_crypt trusted asn1_encoder
> tee dm_mod dax nfnetlink_log nft_log nft_limit nft_counter nf_tables
> ip6table_filter ip6table_mangle ip6table_raw ip6table_security
> ip6table_nat ip6_tables xt_state xt_multiport xt_tcpmss iptable_filter
> xt_TCPMSS xt_bpf xt_u32 xt_mark xt_connmark xt_conntrack
> iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment
> xt_tcpudp xt_CT iptable_raw ip_set_hash_net ip_set_hash_ip ip_set
> nfnetlink sch_fq tcp_bbr nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> 8021q garp stp mrp llc skx_edac x86_pkg_temp_thermal kvm_intel kvm
> irqbypass crc32_pclmul crc32c_intel aesni_intel
>   rapl intel_cstate ipmi_ssif mlx5_core i2c_i801 mlxfw i2c_smbus
> xhci_pci acpi_ipmi tpm_crb tls intel_uncore ioatdma i2c_core xhci_hcd
> ipmi_si dca tpm_tis ipmi_devintf tpm_tis_core tiny_power_button
> ipmi_msghandler tpm button fuse efivarfs ip_tables x_tables
> bcmcrypt(O) crypto_simd cryptd [last unloaded: zsmalloc]
>   CPU: 30 PID: 812411 Comm: bash Tainted: G        W  O
> 5.15.19-cloudflare-2022.2.1 #1
>   Hardware name: Quanta Cloud Technology Inc. QuantaPlex
> T42S-2U/T42S-2U MB (Lewisburg-1G) CLX, BIOS 3B16.Q102 02/19/2020
>   RIP: 0010:ftrace_bug+0x22c/0x252
>   Code: ff 84 c0 74 d0 eb b4 48 c7 c7 d8 72 75 a9 e8 53 c9 ff ff 48 89
> ef e8 5b 74 7b ff 48 c7 c7 e9 72 75 a9 48 89 c6 e8 3c c9 ff ff <0f> 0b
> c7 05 18 98 4d 01 01 00 00 00 5b c7 05 1d 98 4d 01 00 00 00
>   RSP: 0018:ffffa86ce19e3d50 EFLAGS: 00010246
>   RAX: 0000000000000022 RBX: 00000000ffffffea RCX: ffff8ff7bf39f7b8
>   RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff8ff7bf39f7b0
>   RBP: ffff8fb8c00f95f0 R08: ffffffffaa719120 R09: 000000000000000f
>   R10: 000000000000000f R11: ffff8ff83ff3291a R12: ffffffffa89ea1d0
>   R13: ffffffffa8250030 R14: 0000000000000000 R15: 000000000000000f
>   FS:  00007f3715044740(0000) GS:ffff8ff7bf380000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000055c306a30298 CR3: 0000002e01756002 CR4: 00000000007706e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>   <TASK>
>   ftrace_modify_all_code+0xbd/0x150
>   ftrace_run_update_code+0x13/0x70
>   ftrace_startup.part.0+0xe1/0x140
>   register_ftrace_graph+0x292/0x2d0
>   graph_trace_init+0x27/0x50
>   tracing_set_tracer+0xdb/0x170
>   tracing_set_trace_write+0x95/0xe0
>   vfs_write+0xbd/0x270
>   ksys_write+0x5f/0xe0
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>   RIP: 0033:0x7f3715135f33
>   Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
> 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
>   RSP: 002b:00007ffc4232a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>   RAX: ffffffffffffffda RBX: 000000000000000f RCX: 00007f3715135f33
>   RDX: 000000000000000f RSI: 000055c2f4c63480 RDI: 0000000000000001
>   RBP: 000055c2f4c63480 R08: 000000000000000a R09: 000000000000000e
>   R10: 000055c2f4c66cd0 R11: 0000000000000246 R12: 000000000000000f
>   R13: 00007f37152066a0 R14: 000000000000000f R15: 00007f37152068a0
>   </TASK>
>   ---[ end trace 3c0096669fc25321 ]---
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
>   PGD f607b5067 P4D f607b5067 PUD ef47e0067 PMD 0
>   Oops: 0000 [#1] SMP NOPTI
>   CPU: 4 PID: 852378 Comm: funcslower Tainted: G        W  O
> 5.15.19-cloudflare-2022.2.1 #1
>   Hardware name: Quanta Cloud Technology Inc. QuantaPlex
> T42S-2U/T42S-2U MB (Lewisburg-1G) CLX, BIOS 3B16.Q102 02/19/2020
>   RIP: 0010:register_kprobe+0xb8/0x630
>   Code: aa 48 85 c0 75 0a eb 4a 48 8b 00 48 85 c0 74 42 48 3b 50 28 75
> f2 48 39 c5 74 21 48 8b 70 10 48 8d 56 f0 48 39 d0 75 0f eb 28 <48> 8b
> 52 10 48 83 ea 10 48 39 d0 74 1b 48 39 d5 75 ee 0f 0b 48 c7
>   RSP: 0000:ffffa86cf5313d58 EFLAGS: 00010287
>   RAX: ffff8fc570aa3a40 RBX: 0000000000000000 RCX: 0000000000000000
>   RDX: fffffffffffffff0 RSI: ffff8fcf34e45a28 RDI: ffff8fca4f652700
>   RBP: ffff8fb9f851f918 R08: 0000000000000006 R09: ffff8fb8c7e680e8
>   R10: 0000000000000000 R11: 000000000000005d R12: 0000000000000000
>   R13: ffff8fc5d1c5c860 R14: ffff8fb9f851f9d8 R15: 0000000000000000
>   FS:  00007fa26c8a0740(0000) GS:ffff8fd7bf700000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 0000001be733e003 CR4: 00000000007706e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>   <TASK>
>   __trace_kprobe_create+0x810/0xb10

OK, I'm guessing that something got messed up with the kprobe code when a
kprobe failed to arm. Perhaps not everything is cleaned up properly?

Masami?

-- Steve


>   ? __kmalloc+0x17e/0x320
>   ? print_kprobe_event+0x190/0x190
>   ? probes_write+0x10/0x10
>   trace_probe_create+0x73/0x90
>   create_or_delete_trace_kprobe+0x11/0x30
>   trace_parse_run_command+0xba/0x140
>   vfs_write+0xbd/0x270
>   ksys_write+0x5f/0xe0
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>   RIP: 0033:0x7fa26cc17fb3
>   Code: 75 05 48 83 c4 58 c3 e8 cb 41 ff ff 66 2e 0f 1f 84 00 00 00 00
> 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
>   RSP: 002b:00007ffdf1336128 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>   RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa26cc17fb3
>   RDX: 0000000000000044 RSI: 00007ffdf1336470 RDI: 0000000000000007
>   RBP: 00007ffdf1336470 R08: 00000000ffffffff R09: 00007ffdf1335fb0
>   R10: 00007fa263400090 R11: 0000000000000246 R12: 00007fa26bd150b9
>   R13: 0000000000000007 R14: 00007fa263400490 R15: 00007ffdf1336150
>   </TASK>
>   Modules linked in: xt_hashlimit macvlan ip_set_hash_netport
> xt_length esp4 xfrm_interface xfrm6_tunnel dummy ipip nft_numgen
> nft_ct ip_gre gre xfrm_user xfrm_algo udp_diag inet_diag fou6
> ip6_tunnel tunnel6 cls_bpf xt_NFLOG xt_statistic lz4 lz4_compress sit
> tunnel4 fou ip_tunnel ip6_udp_tunnel udp_tunnel nft_compat veth tun
> overlay sch_ingress raid0 md_mod essiv dm_crypt trusted asn1_encoder
> tee dm_mod dax nfnetlink_log nft_log nft_limit nft_counter nf_tables
> ip6table_filter ip6table_mangle ip6table_raw ip6table_security
> ip6table_nat ip6_tables xt_state xt_multiport xt_tcpmss iptable_filter
> xt_TCPMSS xt_bpf xt_u32 xt_mark xt_connmark xt_conntrack
> iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment
> xt_tcpudp xt_CT iptable_raw ip_set_hash_net ip_set_hash_ip ip_set
> nfnetlink sch_fq tcp_bbr nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> 8021q garp stp mrp llc skx_edac x86_pkg_temp_thermal kvm_intel kvm
> irqbypass crc32_pclmul crc32c_intel aesni_intel
>   rapl intel_cstate ipmi_ssif mlx5_core i2c_i801 mlxfw i2c_smbus
> xhci_pci acpi_ipmi tpm_crb tls intel_uncore ioatdma i2c_core xhci_hcd
> ipmi_si dca tpm_tis ipmi_devintf tpm_tis_core tiny_power_button
> ipmi_msghandler tpm button fuse efivarfs ip_tables x_tables
> bcmcrypt(O) crypto_simd cryptd [last unloaded: zsmalloc]
>   CR2: 0000000000000000
>   ---[ end trace 3c0096669fc25323 ]---
>   RIP: 0010:register_kprobe+0xb8/0x630
>   Code: aa 48 85 c0 75 0a eb 4a 48 8b 00 48 85 c0 74 42 48 3b 50 28 75
> f2 48 39 c5 74 21 48 8b 70 10 48 8d 56 f0 48 39 d0 75 0f eb 28 <48> 8b
> 52 10 48 83 ea 10 48 39 d0 74 1b 48 39 d5 75 ee 0f 0b 48 c7
>   RSP: 0000:ffffa86cf5313d58 EFLAGS: 00010287
>   RAX: ffff8fc570aa3a40 RBX: 0000000000000000 RCX: 0000000000000000
>   RDX: fffffffffffffff0 RSI: ffff8fcf34e45a28 RDI: ffff8fca4f652700
>   RBP: ffff8fb9f851f918 R08: 0000000000000006 R09: ffff8fb8c7e680e8
>   R10: 0000000000000000 R11: 000000000000005d R12: 0000000000000000
>   R13: ffff8fc5d1c5c860 R14: ffff8fb9f851f9d8 R15: 0000000000000000
>   FS:  00007fa26c8a0740(0000) GS:ffff8fd7bf700000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 0000001be733e003 CR4: 00000000007706e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554

