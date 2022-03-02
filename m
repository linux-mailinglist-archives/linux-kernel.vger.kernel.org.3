Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E84CAA8F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbiCBQjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiCBQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:39:43 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B163BCB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:38:59 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GA4CzC5kQCyt9Q46WjPbGlANWaRE9EWTbe6SrvYEjAk=;
        b=aaBHXo5y2T1+Vm+RNaREb41iINBlTfgGfciO9VaNYAxyxUoq7gYiXaDkPdMoxsduX3sA9g
        TzAIUkekbB8xhUA3Qo3mXL+z0ndkfEB2sBoCKWQJ2d3hO4mxiEgs5KkR9zFLzvL95BCF95
        U/IBKTxSoTLvCJszTBkqfdNgKa1YG4o=
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
Subject: [PATCH mm 13/22] kasan: restructure kasan_report
Date:   Wed,  2 Mar 2022 17:36:33 +0100
Message-Id: <ca28042889858b8cc4724d3d4378387f90d7a59d.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Restructure kasan_report() to make reviewing the subsequent patches
easier.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index a0d4a9d3f933..41c7966451e3 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -457,15 +457,18 @@ static void __kasan_report(void *addr, size_t size, bool is_write,
 bool kasan_report(unsigned long addr, size_t size, bool is_write,
 			unsigned long ip)
 {
-	unsigned long flags = user_access_save();
-	bool ret = false;
+	unsigned long ua_flags = user_access_save();
+	bool ret = true;
 
-	if (likely(report_enabled())) {
-		__kasan_report((void *)addr, size, is_write, ip);
-		ret = true;
+	if (unlikely(!report_enabled())) {
+		ret = false;
+		goto out;
 	}
 
-	user_access_restore(flags);
+	__kasan_report((void *)addr, size, is_write, ip);
+
+out:
+	user_access_restore(ua_flags);
 
 	return ret;
 }
-- 
2.25.1

