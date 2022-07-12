Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5637557277B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiGLUkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiGLUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A646C9236
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A90A161A9C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16898C341CF;
        Tue, 12 Jul 2022 20:39:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oBMfk-0049PD-60;
        Tue, 12 Jul 2022 16:39:56 -0400
Message-ID: <20220712203956.024204201@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jul 2022 16:39:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sascha Hauer <sha@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [for-linus][PATCH 3/6] ftrace: Be more specific about arch impact when function tracer is
 enabled
References: <20220712203924.060569640@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It was brought up that on ARMv7, that because the FUNCTION_TRACER does not
use nops to keep function tracing disabled because of the use of a link
register, it does have some performance impact.

The start of functions when -pg is used to compile the kernel is:

	push    {lr}
	bl      8010e7c0 <__gnu_mcount_nc>

When function tracing is tuned off, it becomes:

	push    {lr}
	add   sp, sp, #4

Which just puts the stack back to its normal location. But these two
instructions at the start of every function does incur some overhead.

Be more honest in the Kconfig FUNCTION_TRACER description and specify that
the overhead being in the noise was x86 specific, but other architectures
may vary.

Link: https://lore.kernel.org/all/20220705105416.GE5208@pengutronix.de/
Link: https://lkml.kernel.org/r/20220706161231.085a83da@gandalf.local.home

Reported-by: Sascha Hauer <sha@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index debbbb083286..ccd6a5ade3e9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -194,7 +194,8 @@ config FUNCTION_TRACER
 	  sequence is then dynamically patched into a tracer call when
 	  tracing is enabled by the administrator. If it's runtime disabled
 	  (the bootup default), then the overhead of the instructions is very
-	  small and not measurable even in micro-benchmarks.
+	  small and not measurable even in micro-benchmarks (at least on
+	  x86, but may have impact on other architectures).
 
 config FUNCTION_GRAPH_TRACER
 	bool "Kernel Function Graph Tracer"
-- 
2.35.1
