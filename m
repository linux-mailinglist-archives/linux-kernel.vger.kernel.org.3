Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78C58AFF6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbiHESiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbiHESiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:38:10 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D4517E14
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:38:08 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 7so5148212ybw.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=H1G97p0ebjjWS1BiFc5IQD3M990lR7pfT2PkRV7Ha68=;
        b=EQdhRDXBh8ix/j93Fc8mqycZbqHR1C4L+H09/ooMRD+G6B1xt6OVfudIuku8OAzQul
         8S/5WOW2XybyeBunl3raW+97UYiAbI2ZiQjnQJUZ1+nSOpO56SmnLPz2Xy1bw2028L2f
         BH4xIR1BNtu1E+xXq/DqOxKq4Sa6YeXN7bVsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=H1G97p0ebjjWS1BiFc5IQD3M990lR7pfT2PkRV7Ha68=;
        b=ke2xxAPHAsIyz6/BkiXH5nuy5Vob1diEXhFdwG3iT7z34d9j8QHfFNBiudPC/MAuX8
         ++PZ3j6XZnn0ppC77GK33ZmsSGF8AdoeS7ysorgUkz3GpqUWltTSwPMjKsmFXdFwZNOF
         Eccgk49tOWfHVwIb3SHO8F62RbPPqvhGEB3fFcKJrOHnGDp43NOn5ShCezSTa+MomuI9
         cGu5GQSPexy4yvrOW2TjF2q5veGev4Sv1T2jjMsU9t6HT+Tov+8MdA6vK75tOPjicMS5
         MFFGGOrs2gEfYUx96eaGL3YciUdSHqaanwYiHY+LBoKfQmks86m3V6GEGO9VYoJFcGmX
         Zgrg==
X-Gm-Message-State: ACgBeo3Q2iqWvBXDy3TV+I379JezO8k3z7AOJLsxQGZle2iHrIeAFtJE
        AWRNy7kMKc1JkmVCp/baCBQ+sCC6jW0gJ00hlt6raQ==
X-Google-Smtp-Source: AA6agR76ncg4X1vtULcyrPEpybuGEJBneyHgHuvyfSXr6u8hQQGw9/RqpdGU2xvwS6vxEmmumTvGvux8+VLSShHgLS8=
X-Received: by 2002:a25:d496:0:b0:676:f547:cb5b with SMTP id
 m144-20020a25d496000000b00676f547cb5bmr6447290ybf.115.1659724687555; Fri, 05
 Aug 2022 11:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com>
 <20220223115457.7bb575c1@gandalf.local.home>
In-Reply-To: <20220223115457.7bb575c1@gandalf.local.home>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 5 Aug 2022 11:37:56 -0700
Message-ID: <CABWYdi1aKXWDjT+-aAQvn7eLcySbmeEucVS+8RAbUPE+bprK6A@mail.gmail.com>
Subject: Re: 5.15 ftrace bug when enabling function_graph
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Dao <dqminh@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 8:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 23 Feb 2022 15:47:28 +0000
> Daniel Dao <dqminh@cloudflare.com> wrote:
>
> > Hi all
> >
> > We had some panic when trying to profile some function using ftrace's
> > function_graph.
> > The panic is attached here:
> >
> >   ------------[ cut here ]------------
> >   WARNING: CPU: 30 PID: 812411 at arch/x86/kernel/ftrace.c:96
> > ftrace_verify_code+0x37/0x70
> >   Modules linked in: xt_hashlimit macvlan ip_set_hash_netport
> > xt_length esp4 xfrm_interface xfrm6_tunnel dummy ipip nft_numgen
> > nft_ct ip_gre gre xfrm_user xfrm_algo udp_diag inet_diag fou6
> > ip6_tunnel tunnel6 cls_bpf xt_NFLOG xt_statistic lz4 lz4_compress sit
> > tunnel4 fou ip_tunnel ip6_udp_tunnel udp_tunnel nft_compat veth tun
> > overlay sch_ingress raid0 md_mod essiv dm_crypt trusted asn1_encoder
> > tee dm_mod dax nfnetlink_log nft_log nft_limit nft_counter nf_tables
> > ip6table_filter ip6table_mangle ip6table_raw ip6table_security
> > ip6table_nat ip6_tables xt_state xt_multiport xt_tcpmss iptable_filter
> > xt_TCPMSS xt_bpf xt_u32 xt_mark xt_connmark xt_conntrack
> > iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment
> > xt_tcpudp xt_CT iptable_raw ip_set_hash_net ip_set_hash_ip ip_set
> > nfnetlink sch_fq tcp_bbr nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> > 8021q garp stp mrp llc skx_edac x86_pkg_temp_thermal kvm_intel kvm
> > irqbypass crc32_pclmul crc32c_intel aesni_intel
> >   rapl intel_cstate ipmi_ssif mlx5_core i2c_i801 mlxfw i2c_smbus
> > xhci_pci acpi_ipmi tpm_crb tls intel_uncore ioatdma i2c_core xhci_hcd
> > ipmi_si dca tpm_tis ipmi_devintf tpm_tis_core tiny_power_button
> > ipmi_msghandler tpm button fuse efivarfs ip_tables x_tables
> > bcmcrypt(O) crypto_simd cryptd [last unloaded: zsmalloc]
> >   CPU: 30 PID: 812411 Comm: bash Tainted: G           O
> > 5.15.19-cloudflare-2022.2.1 #1
> >   Hardware name: Quanta Cloud Technology Inc. QuantaPlex
> > T42S-2U/T42S-2U MB (Lewisburg-1G) CLX, BIOS 3B16.Q102 02/19/2020
> >   RIP: 0010:ftrace_verify_code+0x37/0x70
> >   Code: 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8d
> > 7c 24 03 e8 26 1f 1a 00 48 85 c0 75 33 8b 03 39 44 24 03 74 1d <0f> 0b
> > b8 ea ff ff ff 48 8b 4c 24 08 65 48 2b 0c 25 28 00 00 00 75
> >   RSP: 0018:ffffa86ce19e3d28 EFLAGS: 00010212
> >   RAX: 0000000000441f0f RBX: ffffffffa9001e8a RCX: 0000000000000010
> >   RDX: 000000000db62b18 RSI: 0000000000000005 RDI: ffffffffa89ea1d0
> >   RBP: ffffffffaa764350 R08: 0000000000000001 R09: 0000000000000000
> >   R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
> >   R13: ffff8fb8c00f95f0 R14: 0000000000000000 R15: 000000000000000f
> >   FS:  00007f3715044740(0000) GS:ffff8ff7bf380000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 000055c306a30298 CR3: 0000002e01756002 CR4: 00000000007706e0
> >   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >   PKRU: 55555554
> >   Call Trace:
> >   <TASK>
> >   ftrace_replace_code+0x9a/0x160
> >   ? arch_unoptimize_kprobes+0xb0/0xb0
> >   ftrace_modify_all_code+0xbd/0x150
> >   ftrace_run_update_code+0x13/0x70
> >   ftrace_startup.part.0+0xe1/0x140
> >   register_ftrace_graph+0x292/0x2d0
> >   graph_trace_init+0x27/0x50
> >   tracing_set_tracer+0xdb/0x170
> >   tracing_set_trace_write+0x95/0xe0
> >   vfs_write+0xbd/0x270
> >   ksys_write+0x5f/0xe0
> >   do_syscall_64+0x38/0x90
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >   RIP: 0033:0x7f3715135f33
> >   Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
> > 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
> > 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> >   RSP: 002b:00007ffc4232a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> >   RAX: ffffffffffffffda RBX: 000000000000000f RCX: 00007f3715135f33
> >   RDX: 000000000000000f RSI: 000055c2f4c63480 RDI: 0000000000000001
> >   RBP: 000055c2f4c63480 R08: 000000000000000a R09: 000000000000000e
> >   R10: 000055c2f4c66cd0 R11: 0000000000000246 R12: 000000000000000f
> >   R13: 00007f37152066a0 R14: 000000000000000f R15: 00007f37152068a0
> >   </TASK>
> >   ---[ end trace 3c0096669fc25320 ]---
> >   ------------[ ftrace bug ]------------
> >   ftrace failed to modify
> >   [<ffffffffa89ea1d0>] bpf_dispatcher_xdp_func+0x0/0x10
>
> Of course this is bpf :-/
>
> OK, I found the creation of bpf_dispatcher_xdp_func in include/linux/bpf.h:
>
> #define DEFINE_BPF_DISPATCHER(name)                                     \
>         noinline __nocfi unsigned int bpf_dispatcher_##name##_func(     \
>                 const void *ctx,                                        \
>                 const struct bpf_insn *insnsi,                          \
>                 unsigned int (*bpf_func)(const void *,                  \
>                                          const struct bpf_insn *))      \
>         {                                                               \
>                 return bpf_func(ctx, insnsi);                           \
>         }                                                               \
>
> You can try changing that to:
>
>         noinline __nocfi notrace unsigned int bpf_dispatcher_##name##_func( \
>
> and see if that fixes it for you.
>
> If you can not change the running kernel, you can try this first:
>
>  # echo 'bpf_dispatcher_*_func' > /sys/kernel/tracing/set_ftrace_notrace
>
> It doesn't explain the bug, but at least may be a workaround for you.

I tried this and it still failed:

root@foo:~# echo 'bpf_dispatcher_*_func' >
/sys/kernel/tracing/set_ftrace_notrace

root@foo:~# trace-cmd record -p function_graph -l handle_mm_fault -P 3367417
plugin 'function_graph'
Hit Ctrl^C to stop recording
^CCPU0 data recorded at offset=0x59d000
0 bytes in size
CPU1 data recorded at offset=0x59d000
0 bytes in size
CPU2 data recorded at offset=0x59d000
0 bytes in size
...
0 bytes in size
CPU94 data recorded at offset=0x59d000
0 bytes in size
CPU95 data recorded at offset=0x59d000
0 bytes in size
/sys/kernel/tracing/set_ftrace_notrace: No such device
trace-cmd: No such device
opening to '/sys/kernel/tracing/set_graph_function'

The failure looks identical to me:

[1459708.617487] ------------[ cut here ]------------
[1459708.631682] WARNING: CPU: 80 PID: 2658120 at
arch/x86/kernel/ftrace.c:96 ftrace_verify_code+0x37/0x70
[1459708.631702] Modules linked in: mptcp_diag raw_diag unix_diag
xt_LOG nf_log_syslog xt_hashlimit esp4 ip_set_hash_netport xt_length
mpls_gso mpls_iptunnel mpls_router dummy ipip xfrm_interface
xfrm6_tunnel nft_numgen nft_ct ip_gre gre xfrm_user xfrm_algo cls_bpf
fou6 ip6_tunnel tunnel6 zstd zstd_compress zram zsmalloc sit tunnel4
fou ip_tunnel ip6_udp_tunnel udp_tunnel nft_compat veth tun tcp_diag
overlay sch_ingress udp_diag inet_diag raid0 md_mod essiv dm_crypt
trusted tee asn1_encoder dm_mod dax nft_log nft_limit nft_counter
nf_tables ip6table_filter ip6table_mangle ip6table_raw
ip6table_security ip6table_nat ip6_tables xt_state xt_multiport
xt_tcpmss iptable_filter xt_TCPMSS xt_bpf xt_NFLOG nfnetlink_log
xt_connbytes xt_statistic xt_u32 xt_mark xt_connmark xt_conntrack
iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment
xt_tcpudp xt_CT iptable_raw ip_set_hash_net ip_set_hash_ip ip_set
nfnetlink sch_fq tcp_bbr nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
[1459708.632094]  8021q mrp garp stp llc skx_edac x86_pkg_temp_thermal
kvm_intel kvm irqbypass crc32_pclmul crc32c_intel aesni_intel rapl
intel_cstate ipmi_ssif mlx5_core acpi_ipmi i2c_i801 tpm_crb xhci_pci
intel_uncore tls i2c_smbus ipmi_si ioatdma mlxfw xhci_hcd i2c_core
ipmi_devintf tpm_tis dca tpm_tis_core ipmi_msghandler
tiny_power_button tpm button fuse efivarfs ip_tables x_tables
bcmcrypt(O) crypto_simd cryptd [last unloaded: kheaders]
[1459708.632292] CPU: 80 PID: 2658120 Comm: trace-cmd Kdump: loaded
Tainted: G           O      5.15.46-cloudflare-2022.6.2 #1
[1459708.632308] RIP: 0010:ftrace_verify_code+0x37/0x70
[1459708.632318] Code: 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24
08 31 c0 48 8d 7c 24 03 e8 56 23 1a 00 48 85 c0 75 33 8b 03 39 44 24
03 74 1d <0f> 0b b8 ea ff ff ff 48 8b 54 24 08 65 48 2b 14 25 28 00 00
00 75
[1459708.632324] RSP: 0018:ffff96d4e1b1fde0 EFLAGS: 00010292
[1459708.632333] RAX: 0000000000441f0f RBX: ffffffffaca01f2a RCX:
0000000000000010
[1459709.019133] RDX: 00007fffffffffff RSI: 0000000000000005 RDI:
ffffffffac3ea960
[1459709.019142] RBP: ffffffffae15c310 R08: 0000000000000001 R09:
0000000000000000
[1459709.019147] R10: 0000000000000000 R11: 0000000000000001 R12:
0000000000000001
[1459709.067594] R13: ffff9232000f9010 R14: ffffffffaca1aa20 R15:
ffff923528af8040
[1459709.067603] FS:  00007f503619f740(0000) GS:ffff9270ffa00000(0000)
knlGS:0000000000000000
[1459709.067609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1459709.067614] CR2: 00007f867b659740 CR3: 00000001e940a004 CR4:
00000000007706e0
[1459709.067619] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[1459709.145561] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[1459709.145566] PKRU: 55555554
[1459709.145570] Call Trace:
[1459709.145575]  <TASK>
[1459709.192099]  ftrace_replace_code+0x9a/0x160
[1459709.203969]  ftrace_modify_all_code+0xb8/0x150
[1459709.203995]  ftrace_run_update_code+0x13/0x70
[1459709.204007]  ftrace_hash_move_and_update_ops+0x1af/0x1f0
[1459709.204029]  ftrace_regex_release+0x7d/0x150
[1459709.204046]  __fput+0x89/0x240
[1459709.204068]  task_work_run+0x59/0x90
[1459709.204083]  exit_to_user_mode_prepare+0x111/0x120
[1459709.204102]  syscall_exit_to_user_mode+0x1d/0x40
[1459709.204117]  do_syscall_64+0x48/0x90
[1459709.204130]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[1459709.204140] RIP: 0033:0x7f50363800f3
[1459709.204161] Code: 8b 15 d9 9e 00 00 f7 d8 64 89 02 48 c7 c0 ff ff
ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24
0c e8
[1459709.204169] RSP: 002b:00007fffe51a87e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000003
[1459709.204179] RAX: 0000000000000000 RBX: 000055d469c41c8a RCX:
00007f50363800f3
[1459709.204185] RDX: 0000000000000201 RSI: 000055d46b294420 RDI:
0000000000000004
[1459709.204190] RBP: 000055d46b294420 R08: 0000000000000001 R09:
0000000000000026
[1459709.204195] R10: 0000000000000000 R11: 0000000000000246 R12:
00007fffe51aa8d0
[1459709.204201] R13: 000055d469c5a720 R14: 00007fffe51aa8e0 R15:
000055d469c5a720
[1459709.204242]  </TASK>
[1459709.204247] ---[ end trace 630569145d18772d ]---
[1459709.204253] ------------[ ftrace bug ]------------
[1459709.204257] ftrace failed to modify
[1459709.204262] [<ffffffffac3ea960>] bpf_dispatcher_xdp_func+0x0/0x10
[1459709.204275]  actual:   ffffffe9:ffffff9b:76:ffffffb0:14
[1459709.204302] Setting ftrace call site to call ftrace function
[1459709.204305] ftrace record flags: 10000001
[1459709.204309]  (1)
                  expected tramp: ffffffffabc4bcb0
[1459709.204325] ------------[ cut here ]------------
[1459709.204328] WARNING: CPU: 80 PID: 2658120 at
kernel/trace/ftrace.c:2073 ftrace_bug+0x22c/0x252
[1459709.204343] Modules linked in: mptcp_diag raw_diag unix_diag
xt_LOG nf_log_syslog xt_hashlimit esp4 ip_set_hash_netport xt_length
mpls_gso mpls_iptunnel mpls_router dummy ipip xfrm_interface
xfrm6_tunnel nft_numgen nft_ct ip_gre gre xfrm_user xfrm_algo cls_bpf
fou6 ip6_tunnel tunnel6 zstd zstd_compress zram zsmalloc sit tunnel4
fou ip_tunnel ip6_udp_tunnel udp_tunnel nft_compat veth tun tcp_diag
overlay sch_ingress udp_diag inet_diag raid0 md_mod essiv dm_crypt
trusted tee asn1_encoder dm_mod dax nft_log nft_limit nft_counter
nf_tables ip6table_filter ip6table_mangle ip6table_raw
ip6table_security ip6table_nat ip6_tables xt_state xt_multiport
xt_tcpmss iptable_filter xt_TCPMSS xt_bpf xt_NFLOG nfnetlink_log
xt_connbytes xt_statistic xt_u32 xt_mark xt_connmark xt_conntrack
iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment
xt_tcpudp xt_CT iptable_raw ip_set_hash_net ip_set_hash_ip ip_set
nfnetlink sch_fq tcp_bbr nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
[1459709.556275]  8021q mrp garp stp llc skx_edac x86_pkg_temp_thermal
kvm_intel kvm irqbypass crc32_pclmul crc32c_intel aesni_intel rapl
intel_cstate ipmi_ssif mlx5_core acpi_ipmi i2c_i801 tpm_crb xhci_pci
intel_uncore tls i2c_smbus ipmi_si ioatdma mlxfw xhci_hcd i2c_core
ipmi_devintf tpm_tis dca tpm_tis_core ipmi_msghandler
tiny_power_button tpm button fuse efivarfs ip_tables x_tables
bcmcrypt(O) crypto_simd cryptd [last unloaded: kheaders]
[1459709.556461] CPU: 80 PID: 2658120 Comm: trace-cmd Kdump: loaded
Tainted: G        W  O      5.15.46-cloudflare-2022.6.2 #1
[1459709.556473] RIP: 0010:ftrace_bug+0x22c/0x252
[1459709.556489] Code: ff 84 c0 74 d0 eb b4 48 c7 c7 e2 d5 26 ad e8 83
c9 ff ff 48 89 ef e8 3d 6b 7b ff 48 c7 c7 2a 3d 26 ad 48 89 c6 e8 6c
c9 ff ff <0f> 0b c7 05 5a 60 4d 01 01 00 00 00 5b c7 05 5f 60 4d 01 00
00 00
[1459709.556495] RSP: 0018:ffff96d4e1b1fe08 EFLAGS: 00010246
[1459709.556503] RAX: 0000000000000022 RBX: 00000000ffffffea RCX:
0000000000000027
[1459709.556508] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffff9270ffa1f770
[1459709.556512] RBP: ffff9232000f9010 R08: ffffffffae1110e0 R09:
000000000000000f
[1459709.556517] R10: 000000000000000f R11: ffff92717ffae5b2 R12:
ffffffffac3ea960
[1459709.556521] R13: ffff923528af8040 R14: ffffffffaca1aa20 R15:
ffff923528af8040
[1459709.556526] FS:  00007f503619f740(0000) GS:ffff9270ffa00000(0000)
knlGS:0000000000000000
[1459709.556531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1459709.556535] CR2: 00007f867b659740 CR3: 00000001e940a004 CR4:
00000000007706e0
[1459709.556540] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[1459709.556545] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[1459709.556551] PKRU: 55555554
[1459709.556555] Call Trace:
[1459709.556561]  <TASK>
[1459709.556573]  ftrace_modify_all_code+0xb8/0x150
[1459709.556591]  ftrace_run_update_code+0x13/0x70
[1459709.556600]  ftrace_hash_move_and_update_ops+0x1af/0x1f0
[1459709.556621]  ftrace_regex_release+0x7d/0x150
[1459709.556637]  __fput+0x89/0x240
[1459709.556696]  task_work_run+0x59/0x90
[1459709.556712]  exit_to_user_mode_prepare+0x111/0x120
[1459709.556729]  syscall_exit_to_user_mode+0x1d/0x40
[1459709.556743]  do_syscall_64+0x48/0x90
[1459709.556755]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[1459709.556764] RIP: 0033:0x7f50363800f3
[1459709.556786] Code: 8b 15 d9 9e 00 00 f7 d8 64 89 02 48 c7 c0 ff ff
ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24
0c e8
[1459709.556792] RSP: 002b:00007fffe51a87e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000003
[1459709.556801] RAX: 0000000000000000 RBX: 000055d469c41c8a RCX:
00007f50363800f3
[1459709.556806] RDX: 0000000000000201 RSI: 000055d46b294420 RDI:
0000000000000004
[1459709.556812] RBP: 000055d46b294420 R08: 0000000000000001 R09:
0000000000000026
[1459709.556817] R10: 0000000000000000 R11: 0000000000000246 R12:
00007fffe51aa8d0
[1459709.556822] R13: 000055d469c5a720 R14: 00007fffe51aa8e0 R15:
000055d469c5a720
[1459709.556857]  </TASK>
[1459709.556861] ---[ end trace 630569145d18772e ]---
