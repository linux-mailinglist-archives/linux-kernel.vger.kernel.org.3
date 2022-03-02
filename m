Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CA4CAA80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiCBQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiCBQih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:38:37 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18A2C66B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:37:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I05J+o+7HT6Q0jFo6xpWdgjFaYldkohtghm32sfnKb0=;
        b=EoZSAVxP43kd9ROACbNMePuzm1dcn+XXaWMyw5ByZ/ttIEznjWnvjbWO0dH1GvTwB4McX2
        /2JSo4+MY3aZM3Dozy0YXIjTDH8PVgk+iIZXPfy/fkQnDliZIfQGZae3tuP+/dvC8GtBfz
        Mqgr+ukf08BswObNocR5H/yHe/qOgnw=
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
Subject: [PATCH mm 06/22] kasan: simplify async check in end_report
Date:   Wed,  2 Mar 2022 17:36:26 +0100
Message-Id: <1c8ce43f97300300e62c941181afa2eb738965c5.1646237226.git.andreyknvl@google.com>
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

Currently, end_report() does not call trace_error_report_end() for bugs
detected in either async or asymm mode (when kasan_async_fault_possible()
returns true), as the address of the bad access might be unknown.

However, for asymm mode, the address is known for faults triggered by
read operations.

Instead of using kasan_async_fault_possible(), simply check that
the addr is not NULL when calling trace_error_report_end().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index d60ee8b81e2b..2d892ec050be 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -112,7 +112,7 @@ static void start_report(unsigned long *flags)
 
 static void end_report(unsigned long *flags, unsigned long addr)
 {
-	if (!kasan_async_fault_possible())
+	if (addr)
 		trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
-- 
2.25.1

