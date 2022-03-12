Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F24D6FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiCLPqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiCLPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:46:53 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0F96D86C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:45:47 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647099945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YtbCAnJ5abXcprPbTV1RAyWaH18oFJblxeHW3cll9LQ=;
        b=migH5osFGokxS38pvhVLSH9oA/YZ2x8l6qmAVMGbWSrmceR+ZNN4o/hxvUnxoZxwmdmdem
        znjfG8dNuU+P7vYMHFwa9s293NZhg/XJtEwCFXaa4Cirl/gPR8MwUmqkgAfoDqYcXCWm7l
        DnQqxhiBgJ34bQFh3Iq86tq5H++vDII=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] fix for "kasan: print basic stack frame info for SW_TAGS"
Date:   Sat, 12 Mar 2022 16:45:43 +0100
Message-Id: <d7598f11a34ed96e508f7640fa038662ed2305ec.1647099922.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Using object_is_on_stack() requires linux/sched/task_stack.h.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report_sw_tags.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index 68724ba3d814..7a26397297ed 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/slab.h>
 #include <linux/stackdepot.h>
 #include <linux/stacktrace.h>
-- 
2.25.1

