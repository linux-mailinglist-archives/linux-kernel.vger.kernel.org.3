Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECED357BD32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiGTRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiGTRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:50:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6DD27FDF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A70CBB82185
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D45C3411E;
        Wed, 20 Jul 2022 17:50:18 +0000 (UTC)
Date:   Wed, 20 Jul 2022 13:50:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <20220720135016.3178ffc6@gandalf.local.home>
In-Reply-To: <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
        <20220720125736.48164a14@gandalf.local.home>
        <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
        <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 19:24:32 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> There's a patch for that:
> 
>   https://lkml.kernel.org/r/20220713213819.460771-1-keescook@chromium.org
> 
> it seems to have gotten lost, let me go queue that.

With this applied, I now have:

[    2.442118] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    2.443117] SRBDS: Vulnerable: No microcode
[    2.463339] ------------[ cut here ]------------
[    2.464117] missing return thunk: lkdtm_rodata_do_nothing+0x0/0x8-lkdtm_rodata_do_nothing+0x5/0x8: e9 00 00 00 00
[    2.464128] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:558 apply_returns+0xcb/0x219
[    2.466117] Modules linked in:
[    2.467117] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc7-test+ #66
[    2.468117] Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
[    2.469117] RIP: 0010:apply_returns+0xcb/0x219
[    2.470117] Code: 80 3d d1 32 06 02 00 75 59 49 89 d8 b9 05 00 00 00 4c 89 e2 48 89 de 48 c7 c7 63 98 b4 ae c6 05 b3 32 06 02 01 e8 f8 4f fb 00 <0f> 0b eb 34 44 0f b6 65 a2 31 c0 48 8d 55 c1 c6 45 c0 c3 48 89 d7
[    2.471117] RSP: 0000:ffffffffaee03df0 EFLAGS: 00010286
[    2.472117] RAX: 0000000000000000 RBX: ffffffffae73e8a8 RCX: ffffffffae056641
[    2.473117] RDX: ffffffffaee03d78 RSI: 0000000000000001 RDI: 00000000ffffffff
[    2.474117] RBP: ffffffffaee03ea8 R08: 0000000000000000 R09: 00000000ffffffea
[    2.475117] R10: 000000000000001f R11: ffffffffaee03a4d R12: ffffffffae73e8ad
[    2.476117] R13: ffffffffaf550d30 R14: 0000000000000000 R15: ffffffffaee32138
[    2.477117] FS:  0000000000000000(0000) GS:ffff9d71d6400000(0000) knlGS:0000000000000000
[    2.478117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033


-- Steve
