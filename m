Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41F572785
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiGLUkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiGLUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C98CC782
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC7361AAF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4258C341CE;
        Tue, 12 Jul 2022 20:39:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oBMfk-0049Qr-NY;
        Tue, 12 Jul 2022 16:39:56 -0400
Message-ID: <20220712203956.570631907@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jul 2022 16:39:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [for-linus][PATCH 6/6] samples: Use KSYM_NAME_LEN for kprobes
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

From: Tiezhu Yang <yangtiezhu@loongson.cn>

It is better and enough to use KSYM_NAME_LEN for kprobes
in samples, no need to define and use the other values.

Link: https://lkml.kernel.org/r/1654651402-21552-1-git-send-email-yangtiezhu@loongson.cn

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/kprobes/kprobe_example.c    | 5 ++---
 samples/kprobes/kretprobe_example.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index f991a66b5b02..fd346f58ddba 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -16,9 +16,8 @@
 #include <linux/module.h>
 #include <linux/kprobes.h>
 
-#define MAX_SYMBOL_LEN	64
-static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
-module_param_string(symbol, symbol, sizeof(symbol), 0644);
+static char symbol[KSYM_NAME_LEN] = "kernel_clone";
+module_param_string(symbol, symbol, KSYM_NAME_LEN, 0644);
 
 /* For each probe you need to allocate a kprobe structure */
 static struct kprobe kp = {
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 228321ecb161..cbf16542d84e 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -23,11 +23,10 @@
 #include <linux/module.h>
 #include <linux/kprobes.h>
 #include <linux/ktime.h>
-#include <linux/limits.h>
 #include <linux/sched.h>
 
-static char func_name[NAME_MAX] = "kernel_clone";
-module_param_string(func, func_name, NAME_MAX, S_IRUGO);
+static char func_name[KSYM_NAME_LEN] = "kernel_clone";
+module_param_string(func, func_name, KSYM_NAME_LEN, 0644);
 MODULE_PARM_DESC(func, "Function to kretprobe; this module will report the"
 			" function's execution time");
 
-- 
2.35.1
