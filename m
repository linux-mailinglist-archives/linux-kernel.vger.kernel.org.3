Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DCE570D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGKW30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGKW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:29:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D728735
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 883ACB815E6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080A1C3411C;
        Mon, 11 Jul 2022 22:29:19 +0000 (UTC)
Date:   Mon, 11 Jul 2022 18:29:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220711182918.338f000f@gandalf.local.home>
In-Reply-To: <20220503073844.4148944-1-elver@google.com>
References: <20220503073844.4148944-1-elver@google.com>
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


I know I acked this, but I finally got a tree where it is included in my
testing, and I hit this:

INFO: NMI handler (perf_event_nmi_handler) took too long to run: 9.860 msecs
------------[ cut here ]------------
WARNING: CPU: 1 PID: 16462 at include/trace/events/printk.h:10 printk_sprint+0x81/0xda
Modules linked in: ppdev parport_pc parport
CPU: 1 PID: 16462 Comm: event_benchmark Not tainted 5.19.0-rc5-test+ #5
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
EIP: printk_sprint+0x81/0xda
Code: 89 d8 e8 88 fc 33 00 e9 02 00 00 00 eb 6b 64 a1 a4 b8 91 c1 e8 fd d6 ff ff 84 c0 74 5c 64 a1 14 08 92 c1 a9 00 00 f0 00 74 02 <0f> 0b 64 ff 05 14 08 92 c1 b8 e0 c4 6b c1 e8 a5 dc 00 00 89 c7 e8
EAX: 80110001 EBX: c20a52f8 ECX: 0000000c EDX: 6d203036
ESI: 3df6004c EDI: 00000000 EBP: c61fbd7c ESP: c61fbd70
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
CR0: 80050033 CR2: b7efc000 CR3: 05b80000 CR4: 001506f0
Call Trace:
 vprintk_store+0x24b/0x2ff
perf: interrupt took too long (7980 > 7977), lowering kernel.perf_event_max_sample_rate to 25000
 vprintk+0x37/0x4d
 _printk+0x14/0x16
 nmi_handle+0x1ef/0x24e
 ? find_next_bit.part.0+0x13/0x13
 ? find_next_bit.part.0+0x13/0x13
 ? function_trace_call+0xd8/0xd9
 default_do_nmi+0x57/0x1af
 ? trace_hardirqs_off_finish+0x2a/0xd9
 ? to_kthread+0xf/0xf
 exc_nmi+0x9b/0xf4
 asm_exc_nmi+0xae/0x29c


On Tue,  3 May 2022 09:38:44 +0200
Marco Elver <elver@google.com> wrote:

> Petr points out [1] that calling trace_console_rcuidle() in
> call_console_driver() had been the wrong thing for a while, because
> "printk() always used console_trylock() and the message was flushed to
> the console only when the trylock succeeded. And it was always deferred
> in NMI or when printed via printk_deferred()."

The issue is that we use "trace_console_rcuidle()" where the "_rcuidle()"
version uses srcu, which the last I knew is not safe in NMI context.

Paul, has that changed?

Thus, we need to make sure that printk() is always called when "rcu is
watching" and remove the _rcuidle() part, or we do not call it from nmi
context. Or make srcu nmi safe.

For now, I'm reverting this in my local tree.

-- Steve

