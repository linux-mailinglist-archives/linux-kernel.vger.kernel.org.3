Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5D551134
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbiFTHPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiFTHPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:15:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926CE096
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:15:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso9420350pjh.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gs-ncku-edu-tw.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mOlgPiY8NctsBbPdtFtolqRiB7asIJTPtqqPiH8p+8=;
        b=NGhtV6oC7UGeJmGoCzKkFK166pwQEvMLVC/dCGikhg6ACgcA/WW/z4uqE1RfxWK9xl
         GXVg/NlBjL6gdKDROMZrmkw+GzhA8RwfeT4tzRtIlYU0qnHWVTVjdOceiOlo9Kvxbcyy
         p1HH7GCjnwl6ON0TaZCY9mWXn4f5NAa4U8t+BZCTrocYTba1B+gOaccMIjKRe4ZqNPdc
         aFdD19PlV9YmQnxyBP0ZTxZkV5QmBwfWaFM/PPLayRp87xmGuGzpGZRcNrOHjWQeKDqL
         Yh3r6EziufF6Q/gGFYSp3jXSdpTD9jrUjc+bBjs9ys8zgDGsDv2reGhK7yE9LqDG7MRn
         +zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mOlgPiY8NctsBbPdtFtolqRiB7asIJTPtqqPiH8p+8=;
        b=69scfXI5U2f5uzp9LYX2QiCBCW1DG4ed8WC4VgTW80E2E2fhe6o+PrP2TdC5d0d2wC
         L9NZYyFdF3KcIOZk04SXKJ4IRkg1onDcc60EgORcSzwKnz0uuvtVXhK0q9qxbzMYXCWo
         gLMPdndjpSWtnKqUFRqxNXh5xxMg5AczfOFrX8oWE8cXzkw6Y8Q2NmJuPXZ7fPtpPv9j
         PiDkzvx6GDSin7IxwMeC3wOFxxL/P5cOOfwPXxxTc49gTtJZkKptEvmbtRzQUwX8DDje
         5cFYyRc/W5IQLpGSCl8kfSzUzJ/DTCPYeWEhFilMT8Om96siy+O/XReULCDEc64y6vFP
         y9kw==
X-Gm-Message-State: AJIora/C2gx+Syfis1lrKKTokMd30vnHfJhNJCNUjftjJyF3hzhkY0Dr
        u0WqKcHLlPfw5ClDc3ENwFzZMg==
X-Google-Smtp-Source: AGRyM1s3VSa9NaclVivzLgd4xlgsfqOrZGqTr+nFoV4u9Jf+n7sK3ZiPLBzLkiGfZL1yRMOJhzZTTw==
X-Received: by 2002:a17:90a:df91:b0:1e3:4dc8:46e7 with SMTP id p17-20020a17090adf9100b001e34dc846e7mr36092979pjv.106.1655709330826;
        Mon, 20 Jun 2022 00:15:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:288:7001:2724:a6bf:1ff:fe8c:70bc])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79149000000b00518424f8922sm8232210pfi.77.2022.06.20.00.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 00:15:30 -0700 (PDT)
From:   Yun-Ze Li <p76091292@gs.ncku.edu.tw>
To:     akpm@linux-foundation.org
Cc:     jrdr.linux@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yun-Ze Li <p76091292@gs.ncku.edu.tw>
Subject: [PATCH v2] mm, docs: fix comments that mention mem_hotplug_end()
Date:   Mon, 20 Jun 2022 07:15:16 +0000
Message-Id: <20220620071516.1286101-1-p76091292@gs.ncku.edu.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAFqt6zYF3wRRpmhGzK_r9436JbWfVyjnKKp0oWpSZ+3zad=bxw@mail.gmail.com>
References: <CAFqt6zYF3wRRpmhGzK_r9436JbWfVyjnKKp0oWpSZ+3zad=bxw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments that mention mem_hotplug_end() are confusing as there is no
function called mem_hotplug_end(). Fix them by replacing all the
occurences of mem_hotplug_end() in the comments with mem_hotplug_done().

Signed-off-by: Yun-Ze Li <p76091292@gs.ncku.edu.tw>
---
V1 -> V2: Addressed review comments

 include/linux/mmzone.h | 4 ++--
 mm/compaction.c        | 2 +-
 mm/vmscan.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..7c7947109986 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -591,7 +591,7 @@ struct zone {
 	 * give them a chance of being in the same cacheline.
 	 *
 	 * Write access to present_pages at runtime should be protected by
-	 * mem_hotplug_begin/end(). Any reader who can't tolerant drift of
+	 * mem_hotplug_begin/done(). Any reader who can't tolerant drift of
 	 * present_pages should get_online_mems() to get a stable value.
 	 */
 	atomic_long_t		managed_pages;
@@ -870,7 +870,7 @@ typedef struct pglist_data {
 	unsigned long nr_reclaim_start;	/* nr pages written while throttled
 					 * when throttling started. */
 	struct task_struct *kswapd;	/* Protected by
-					   mem_hotplug_begin/end() */
+					   mem_hotplug_begin/done() */
 	int kswapd_order;
 	enum zone_type kswapd_highest_zoneidx;
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 65970107b789..d18b07368755 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3009,7 +3009,7 @@ void kcompactd_run(int nid)
 
 /*
  * Called by memory hotplug when all memory in a node is offlined. Caller must
- * hold mem_hotplug_begin/end().
+ * be hold mem_hotplug_begin/done().
  */
 void kcompactd_stop(int nid)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6918fff06e1..e53195a0c019 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4586,7 +4586,7 @@ void kswapd_run(int nid)
 
 /*
  * Called by memory hotplug when all memory in a node is offlined.  Caller must
- * hold mem_hotplug_begin/end().
+ * be hold mem_hotplug_begin/done().
  */
 void kswapd_stop(int nid)
 {
-- 
2.25.1

