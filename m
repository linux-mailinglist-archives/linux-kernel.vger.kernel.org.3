Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0534CAA75
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbiCBQhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbiCBQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:37:33 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE3C4B78
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:36:50 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uo3r1XZ2YxXX2Y0KQk7NP/LkQS2+d42pEDKbCuKVO2A=;
        b=dqtbv/8FM/BpZ36aN0SoEvBbrDqGpQNujrrTiFrcZ/GGK1iACrmtY3v9EpgsqMoF5kVf+V
        T77/+r0QQUpdIhNtrvEvaDV4gqjloM1z7E8wkpf36GllOgJ+Wk5zA4ChirBxB4zHXCD8Ai
        ZlMMu+FEdx2HixPTDXf2hhJwnz8Ki+I=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 04/22] kasan: improve stack frame info in reports
Date:   Wed,  2 Mar 2022 17:36:24 +0100
Message-Id: <aa613f097c12f7b75efb17f2618ae00480fb4bc3.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

- Print at least task name and id for reports affecting allocas
  (get_address_stack_frame_info() does not support them).

- Capitalize first letter of each sentence.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report_generic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 3751391ff11a..7e03cca569a7 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -180,7 +180,7 @@ static void print_decoded_frame_descr(const char *frame_descr)
 		return;
 
 	pr_err("\n");
-	pr_err("this frame has %lu %s:\n", num_objects,
+	pr_err("This frame has %lu %s:\n", num_objects,
 	       num_objects == 1 ? "object" : "objects");
 
 	while (num_objects--) {
@@ -266,13 +266,14 @@ void kasan_print_address_stack_frame(const void *addr)
 	if (WARN_ON(!object_is_on_stack(addr)))
 		return;
 
+	pr_err("The buggy address belongs to stack of task %s/%d\n",
+	       current->comm, task_pid_nr(current));
+
 	if (!get_address_stack_frame_info(addr, &offset, &frame_descr,
 					  &frame_pc))
 		return;
 
-	pr_err("\n");
-	pr_err("addr %px is located in stack of task %s/%d at offset %lu in frame:\n",
-	       addr, current->comm, task_pid_nr(current), offset);
+	pr_err(" and is located at offset %lu in frame:\n", offset);
 	pr_err(" %pS\n", frame_pc);
 
 	if (!frame_descr)
-- 
2.25.1

