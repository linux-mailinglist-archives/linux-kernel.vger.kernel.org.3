Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712A44CAA9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbiCBQkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242596AbiCBQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:40:48 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A8CEA1E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:40:03 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujXTYxMun+rvpXDm65LBC0iIPgbPBoZhDfYPsPYRrpE=;
        b=Vvu6o+ZYKZCdbhIWypkrGDaSmrcli8fMm/9H1fIRIwfZo46g18kv3aPNPhnQ4oiv4BpRCx
        a0CscnTby2H381xSHN6RzxF7C0Z/76Ck5MlwjXipdTqKzc+JfIVrw2/AmZ8ioX0ISlJyut
        yhcafTGxtI2YEEn5HUWq+BE1JX9xke0=
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
Subject: [PATCH mm 18/22] kasan: add comment about UACCESS regions to kasan_report
Date:   Wed,  2 Mar 2022 17:36:38 +0100
Message-Id: <1201ca3c2be42c7bd077c53d2e46f4a51dd1476a.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
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

Add a comment explaining why kasan_report() is the only reporting
function that uses user_access_save/restore().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 7915af810815..08631d873204 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -430,6 +430,11 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
 	end_report(&flags, ptr);
 }
 
+/*
+ * kasan_report() is the only reporting function that uses
+ * user_access_save/restore(): kasan_report_invalid_free() cannot be called
+ * from a UACCESS region, and kasan_report_async() is not used on x86.
+ */
 bool kasan_report(unsigned long addr, size_t size, bool is_write,
 			unsigned long ip)
 {
-- 
2.25.1

