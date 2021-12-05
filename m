Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4C8468ADA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 13:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhLEMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 07:49:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43684 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhLEMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 07:49:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98274B80E3D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 12:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A29C341C1;
        Sun,  5 Dec 2021 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638708345;
        bh=PhBof5rlBjiSqbnRvTvXi9beOUSTlalVYgRgFMB2aTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tDi9Xb6hMdeB8zAYOHTuJsKmKVN+73TDYe/UvOA4+ClOTMwYkrkOX2Ib2dhlQCznL
         VaFwGI9nUuB1/g/j86EouWD8+T3K5+4lxaKIFCojQ2egZ1YPcrYjgT2FHkK8tpLhP9
         +cpKZ9JoxGSdyDgYIwYi2RO+qIvRvLuEXnp4HZIdETSgSqieMd1p3/otBBprakagE2
         YBhWNao44PMmi/BgnRRxj0apH34GMW8b1fS08GNxfzdz8y11z2gBRqfDkbNxSAjvpY
         hzXGvDD3oGacZ+pB8s9gwEH+RTK0g14bEUGhz8dR+ARy5SlzE+A+AdP4RKaDQDYj4e
         hxL5BJ4SjkTuw==
Date:   Sun, 5 Dec 2021 21:45:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>, peterz@infradead.org,
        mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v6 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init
Message-Id: <20211205214532.bac420c582b0c9905d5d815e@kernel.org>
In-Reply-To: <20211202125800.7b346733@gandalf.local.home>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211202021606.48812-1-yinan@linux.alibaba.com>
        <20211202021606.48812-2-yinan@linux.alibaba.com>
        <20211202125800.7b346733@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2 Dec 2021 12:58:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  2 Dec 2021 10:16:05 +0800
> Yinan Liu <yinan@linux.alibaba.com> wrote:
> 
> > When the kernel starts, the initialization of ftrace takes
> > up a portion of the time (approximately 6~8ms) to sort mcount
> > addresses. We can save this time by moving mcount-sorting to
> > compile time.
> > 
> > Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> After applying this, I get a failure on the kprobe self tests at boot up:
> 
>  Testing ftrace filter: OK
>  trace_kprobe: Testing kprobe tracing: 
>  trace_kprobe: Could not probe notrace function kprobe_trace_selftest_target
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 1 at kernel/trace/trace_kprobe.c:1973 kprobe_trace_self_tests_init+0x5c/0x497
>  Modules linked in:
>  CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W         5.16.0-rc3-test+ #40
>  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
>  RIP: 0010:kprobe_trace_self_tests_init+0x5c/0x497
>  Code: 5f d7 94 ff 00 0f 85 48 04 00 00 48 c7 c7 c0 ff 8e 88 e8 6b bb cd fd 48 c7 c7 20 00 8f 88 e8 a9 b6 db fc 41 89 c4 85 c0 74 16 <0f> 0b 48 c7 c7 a0 00 8f 88 41 bc 01 00 00 00 e8 44 bb cd fd eb 33
>  RSP: 0000:ffffc90000037d00 EFLAGS: 00010282
>  RAX: 00000000ffffffea RBX: 0000000000000000 RCX: dffffc0000000000
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880c2b33eb4
>  RBP: 1ffff92000006fa9 R08: ffffffff872e1900 R09: 0000000080000171
>  R10: fffff52000006f15 R11: 0000000000000001 R12: 00000000ffffffea
>  R13: 0000000000000007 R14: ffffffff8a608098 R15: ffffffff8a6080a0
>  FS:  0000000000000000(0000) GS:ffff8880c2b00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000009260e001 CR4: 00000000001706e0
>  Call Trace:
>   <TASK>
>   ? init_kprobe_trace+0x1c4/0x1c4
>   do_one_initcall+0x89/0x2b0
>   ? trace_event_raw_event_initcall_finish+0x150/0x150
>   ? parameq+0x90/0x90
>   ? _raw_spin_unlock_irqrestore+0x19/0x40
>   kernel_init_freeable+0x35a/0x3e7
>   ? console_on_rootfs+0x52/0x52
>   ? _raw_spin_unlock+0x30/0x30
>   ? rest_init+0xf0/0xf0
>   ? rest_init+0xf0/0xf0
>   kernel_init+0x19/0x140
>   ret_from_fork+0x22/0x30
>   </TASK>
>  ---[ end trace 27c06839fac37d16 ]---

I confirmed this warning, but also I saw below warning too.
Maybe this also came from same commit?

[    4.936720] Testing tracer function_graph: FAILED!
[    6.186714] ------------[ cut here ]------------
[    6.187301] WARNING: CPU: 0 PID: 1 at kernel/trace/trace.c:1953 run_tracer_selftest+0x13b/0x192
[    6.187698] Modules linked in:
[    6.188698] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc3+ #174
[    6.189381] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/4
[    6.189698] RIP: 0010:run_tracer_selftest+0x13b/0x192
[    6.190698] Code: 60 48 c7 c6 00 6b 35 82 48 89 df e8 d3 18 33 00 4c 89 2d a4 82 a8 00 41 89 c4 b
[    6.191698] RSP: 0000:ffffc90000013e48 EFLAGS: 00010246
[    6.192250] RAX: 0000000000000007 RBX: ffffffff823ff940 RCX: ffff88807dc00000
[    6.192697] RDX: 0000000000000000 RSI: ffffffff810c7983 RDI: ffffffff810c7983
[    6.193697] RBP: ffffc90000013e60 R08: 0000000000000000 R09: ffffc90000013c40
[    6.194415] R10: 0000000000000001 R11: 0000000000000001 R12: 00000000ffffffed
[    6.194697] R13: ffffffff8241c620 R14: ffffffff8266e290 R15: 0000000000000000
[    6.195698] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[    6.196698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.197317] CR2: 0000000000000000 CR3: 000000000220c000 CR4: 00000000000006b0
[    6.197700] Call Trace:
[    6.198698]  <TASK>
[    6.199017]  register_tracer+0x123/0x1d4
[    6.199698]  ? init_graph_tracefs+0x2d/0x2d
[    6.200159]  init_graph_trace+0x62/0x64
[    6.200583]  do_one_initcall+0x48/0x200
[    6.200699]  kernel_init_freeable+0x1f0/0x23f
[    6.201180]  ? rest_init+0xd0/0xd0
[    6.201699]  kernel_init+0x1a/0x130
[    6.202132]  ret_from_fork+0x22/0x30
[    6.202703]  </TASK>
[    6.203098] ---[ end trace e84e39016448db0f ]---
[    6.203804] NET: Registered PF_NETLINK/PF_ROUTE protocol family

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
