Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA25A3626
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiH0JDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiH0JDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:03:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F6E29812
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:03:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x19so3562142plc.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=BnthDXQwip9Q9g75mHYulJV0YY03kw/VBBFjsliYM+A=;
        b=oJYgfkP4CP3NNgASktL4x7ODjcR3+HD3vZEwb07NsH609p1YZorhMYaw3uBuhLsaSu
         LZl0QJbmhi0jUukkNquR9EvRQwgy1orz6Qlv9WmSDCJ2x/HAt8SuOhGRRAclg8A068o0
         H6cfWJZSar0AKRZ3vshQt11x9r00U0mbpgkpZSeMSS1XYqBpesH0f5xFjODDp+uhyaJ0
         wXCO8cvU6XjxJ3rp9P2CjOjUN1KMdy5Uu2ZDItMGzCzspltNns3YcHzTAc1sFYUDEM2c
         7UXykdPmR0Y8hi+57sQCVryu7P2/zquX1LjrNBhpnUvGRqEkT+xapyZkXJm6wZ35As4O
         X0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=BnthDXQwip9Q9g75mHYulJV0YY03kw/VBBFjsliYM+A=;
        b=KD5yggKON17YPXVR8FHH5QBlkAS59ecf9/YQr9XZeLtNUUhnvoqF0AsUsrrE7MR54E
         qHwi17f0FcEcujRObf4f260ZCxl+5+tWDNQGs5LftRthc6eu3XfwzEtpJQrpPm0cf/PN
         M3hBNFmzCp+5chclxcVgEjh9NvxN2QFrjYEfK9Klfba7QDLSg34mesLRFAadZMWyTzSl
         dPVUaHHgYnEc+axRRNUpVqC2z9ol3gzd9rrph4aXAA8TYOoxxWPfxNRKwod717VUyXku
         k/OqAdAfmKMtm2nfH3gde51J+ggSK+n+Kg1WYU8DYHJONKGYv4CTtFrdchOn6PwXjA5R
         u2nw==
X-Gm-Message-State: ACgBeo3tgZo0zpIq8FWtGzjYEDY+hoHm1wIPs8Z0Ch9rEBoXgPaz13Py
        gOszy3/MbMEC3w5aZfpgPQ==
X-Google-Smtp-Source: AA6agR5cNMunEZrg1m2YWRxKj5/mEUiiHmC6GSFb8/9x4IAe9RfU9EnhJkNT4Z4v232c7q5+3WCBeQ==
X-Received: by 2002:a17:90b:1644:b0:1fb:ab0c:c5bf with SMTP id il4-20020a17090b164400b001fbab0cc5bfmr8493090pjb.27.1661590998059;
        Sat, 27 Aug 2022 02:03:18 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b001fb09316a26sm2943332pjj.43.2022.08.27.02.03.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:03:17 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 2/2] mm/damon/vaddr: remove comparison between mm and last_mm when checking region accesses
Date:   Sat, 27 Aug 2022 17:02:51 +0800
Message-Id: <1661590971-20893-3-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
References: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The damon regions that belong to the same damon target have the same
'struct mm_struct *mm', so it's unnecessary to compare the mm and last_mm
objects among the damon regions in one damon target when checking accesses.
But the check is necessary when the target changed in
'__damon_va_check_accesses()', so we can simplify the whole operation by
using the bool 'same_target' to indicate whether the target changed.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e481f81c3efb..5f66c826ee3a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -533,15 +533,14 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r)
+				struct damon_region *r, bool same_target)
 {
-	static struct mm_struct *last_mm;
 	static unsigned long last_addr;
 	static unsigned long last_page_sz = PAGE_SIZE;
 	static bool last_accessed;
 
 	/* If the region is in the last checked page, reuse the result */
-	if (mm == last_mm && (ALIGN_DOWN(last_addr, last_page_sz) ==
+	if (same_target && (ALIGN_DOWN(last_addr, last_page_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_page_sz))) {
 		if (last_accessed)
 			r->nr_accesses++;
@@ -552,7 +551,6 @@ static void __damon_va_check_access(struct mm_struct *mm,
 	if (last_accessed)
 		r->nr_accesses++;
 
-	last_mm = mm;
 	last_addr = r->sampling_addr;
 }
 
@@ -562,14 +560,17 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	struct mm_struct *mm;
 	struct damon_region *r;
 	unsigned int max_nr_accesses = 0;
+	bool same_target;
 
 	damon_for_each_target(t, ctx) {
 		mm = damon_get_mm(t);
 		if (!mm)
 			continue;
+		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r);
+			__damon_va_check_access(mm, r, same_target);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+			same_target = true;
 		}
 		mmput(mm);
 	}
-- 
2.27.0

