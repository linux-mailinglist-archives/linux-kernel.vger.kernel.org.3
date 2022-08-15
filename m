Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B34593409
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiHOR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiHOR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:34 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB42101F2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:26:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAEx/c/mmemAOYN7U5Ei2xaXPeOZSoEWDL9UZpK60r0=;
        b=R20EA7oAomwCGwjwSSXc68I8nGtAsWSkArq+d7Lvpq61KedXxontAEQ2bnokPbfD0NtU8x
        xm0IZ+lflHzqFDTiZiXwqRXTJ9fRjkcDSFVkT4574cTffSi+HEv6kDBDmSl7QqQcbCVaZ1
        acNxbHKziIvIqY+1oADJf47N9bKzzrM=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 10/11] seq_buf: Move to kernel/tracing
Date:   Mon, 15 Aug 2022 13:26:12 -0400
Message-Id: <20220815172613.621627-11-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

Tracing is the last user of seq_buf, which has been replaced by
printbufs elsewhere; move out of lib/ since it's no longer the standard
API.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/Makefile           | 1 +
 {lib => kernel/trace}/seq_buf.c | 0
 lib/Makefile                    | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename {lib => kernel/trace}/seq_buf.c (100%)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c6651e16b5..03ad4d8c27 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_TRACING) += trace_seq.o
 obj-$(CONFIG_TRACING) += trace_stat.o
 obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING) += 	pid_list.o
+obj-$(CONFIG_TRACING) += seq_buf.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_SYNTH_EVENT_GEN_TEST) += synth_event_gen_test.o
diff --git a/lib/seq_buf.c b/kernel/trace/seq_buf.c
similarity index 100%
rename from lib/seq_buf.c
rename to kernel/trace/seq_buf.c
diff --git a/lib/Makefile b/lib/Makefile
index d44f8d03d6..9ed57a1f9f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -32,7 +32,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 idr.o extable.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
-	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
+	 earlycpio.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
 	 buildid.o cpumask.o printbuf.o
 
-- 
2.36.1

