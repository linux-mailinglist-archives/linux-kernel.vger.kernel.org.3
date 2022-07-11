Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02B570BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiGKUbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiGKUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:31:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97428E4C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:28:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p4so3659721wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FYWLbFVIQR/VTDlKfK3KSN2+LTj7T2uVBiUoRPvBIo=;
        b=N/SQpLi6+icPZLn38OToJuJjCZR+Upi3JsxZ2N2fCXyc8dfg12m+8g7Ys174O5H7Jh
         GOXRoYGxEcz0x7Ui6aOjYeilzoDYvBeoMPnX87jF/YZRVQ5bw+Qrbn3W9JLivCrej9kW
         U1/3tInIy4og8FAU/J+Ph8UxBXkdYhnlIp+VPclte0hCgYPPlJtdE6HL+fAhg4yZwl3w
         Eu+wvIjKo+wgRD3ouhuPrW8sQRKwqTeli1pbmoF2xVqObsbXPOYC669Wsoq+dLFGjfIv
         czFhba+KEK61c/DyBmXZzkn6jrkp5aEMHYImO/B9N/y7klgZB9KoJID5K0bPxHgh2TWn
         D/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FYWLbFVIQR/VTDlKfK3KSN2+LTj7T2uVBiUoRPvBIo=;
        b=06jAlVTJpUv4Lc0r8SQ1K5wsJSUVBCoYLhGD2cds4CHuS+MOfmDhP5Yr6LdPFgXphq
         xP92szzQOwNVeIQxKEGXYrNsnGSHmAOddZU5YXy4puqf9EmGnAKaHmMj77xYvvbobhKM
         FYiDYlaP9403nk70d/5U+u+c7kYLldXCZZTSlf+MFVGPscp3a55ET3vASYPkJdG7URID
         7dV6ESJaSF1GGSGAcabSZ0MjT+EioS5X3/AVfPJQkpdDz7LVJAGCIn51DTXmx5YvMnnN
         HY7twBoIZ25hUz3IzgRn3mxZSQLCAkXbVZso73pA4u+udVk9g2xoyMHEMVHbvulHZDjJ
         7Ubw==
X-Gm-Message-State: AJIora8/Sa8X0Ys7ae9cCNrcXxmOBSSBZwlU7roui2uDkbsboVX816n7
        AMPBRVMtM/Q5HJ3EcSSxml3EW3PCcY9atw==
X-Google-Smtp-Source: AGRyM1s/eAWJhE/CU/qLO+2sCXi61cTuiVovpFhSRnn6bA2/Ysn59YVIPeib9CFMCdlaIHjnRIVhsw==
X-Received: by 2002:a05:600c:6004:b0:3a0:41db:aae with SMTP id az4-20020a05600c600400b003a041db0aaemr123120wmb.171.1657571331361;
        Mon, 11 Jul 2022 13:28:51 -0700 (PDT)
Received: from C02FT09GML7L.mynet ([2a01:4b00:87fe:f600:ac48:7ee1:86bb:5471])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d6da3000000b0021d66cf9547sm8269159wrs.0.2022.07.11.13.28.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 13:28:50 -0700 (PDT)
From:   William Lam <william.lam@bytedance.com>
Cc:     William Lam <william.lam@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: compaction: include compound page count for scanning in pageblock isolation
Date:   Mon, 11 Jul 2022 21:28:06 +0100
Message-Id: <20220711202806.22296-1-william.lam@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of scanned pages can be lower than the number of isolated
pages when isolating mirgratable or free pageblock. The metric is being
reported in trace event and also used in vmstat.

This behaviour is confusing since currently the count for isolated pages
takes account of compound page but not for the case of scanned pages.
And given that the number of isolated pages(nr_taken) reported in
mm_compaction_isolate_template trace event is on a single-page basis,
the ambiguity when reporting the number of scanned pages can be removed
by also including compound page count.

Signed-off-by: William Lam <william.lam@bytedance.com>
---
 mm/compaction.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1f89b969c12b..1b51cf2d32b6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -616,6 +616,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 			break;
 		set_page_private(page, order);
 
+		nr_scanned += isolated - 1;
 		total_isolated += isolated;
 		cc->nr_freepages += isolated;
 		list_add_tail(&page->lru, freelist);
@@ -1101,6 +1102,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 isolate_success_no_list:
 		cc->nr_migratepages += compound_nr(page);
 		nr_isolated += compound_nr(page);
+		nr_scanned += compound_nr(page) - 1;
 
 		/*
 		 * Avoid isolating too much unless this block is being
@@ -1504,6 +1506,7 @@ fast_isolate_freepages(struct compact_control *cc)
 			if (__isolate_free_page(page, order)) {
 				set_page_private(page, order);
 				nr_isolated = 1 << order;
+				nr_scanned += nr_isolated - 1;
 				cc->nr_freepages += nr_isolated;
 				list_add_tail(&page->lru, &cc->freepages);
 				count_compact_events(COMPACTISOLATED, nr_isolated);
-- 
2.30.1 (Apple Git-130)

