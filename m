Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B530F54002E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbiFGNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244836AbiFGNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:36:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD5EBEA1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:36:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so14834853plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cANifuekv3RrNVSMfDwwNKlIS+XGYZEXxn/9zPuWb4w=;
        b=I9gGvlIUWRWyF6ebrjCG3H5sLt/OOXut2CllB1UdjHJ1CYxiuetmHCqjBlsoVo+yWZ
         8r5tzEyzjL+HjC4ia+ZPGYkZxTLC3F/RMa6fcV7Gi0rbQG7LKq6CVuTitsbXJJjn2sHU
         9T6EmSXjVajcheGrUKIaYj/ahF332biy0sfZOfzKJVZqR4RlWWRTxcZR+K3rdarSn4/7
         ouSr8jaLtrKC/sg0S8riNDNV91d//nd9W/OqWzeliqb/qHyyafOjJ+9cJCPenu1hg95/
         O0XMnwz5vcIK/eZESH9Tp8ecWqa31w2r8zZkruK1QrChuBu9dGKuMZnSUyAhlJXQoSRF
         Cjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cANifuekv3RrNVSMfDwwNKlIS+XGYZEXxn/9zPuWb4w=;
        b=1W4vQJI6y2gKvysp8JKgxQ+Y340fkY0lz9NDgHJlC5pIA2YzBvp5ALd4aqy6gO5E6Y
         L93uQc/ih7mLHr4NfUX+1eP/RRo68/INme5f370U3MLw57HbhIFSauzjpePG92gVNi03
         hDZxs6M5Fmfb42sAs0fS8i9gkscY3giKLJigJJ1ZkGvZq9D9zdUYKk948QHTDtWltj5A
         5GAUBksyDKHRzpnH6tWybvHKzltvQVA8Pw+bpqixoBACU4Kk8IUKShsec2f7CLn+mzPT
         XZ81vmZ5n7Y9LgRcDk5L8duPFvwo9/mVhtuGARo+i5H0geo2q69F0Facg4TDeKwEYxA3
         aCng==
X-Gm-Message-State: AOAM530hpxCaLSFvH1QhPZSjBS3CXYMaVEe9CkC56GwxYc7AlmzdCKyV
        1NsdUd0yte5hHFufQVlFfT0=
X-Google-Smtp-Source: ABdhPJwCgKyVrtLB9l//rFYq+tS5wlM3yuNiKqzmVWqUM3G2ErV/Toj94O/eQ8DAwyINb2mFMBy/nw==
X-Received: by 2002:a17:902:d5ce:b0:167:6c02:754c with SMTP id g14-20020a170902d5ce00b001676c02754cmr14829376plh.135.1654608962208;
        Tue, 07 Jun 2022 06:36:02 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id n18-20020a62e512000000b0051b8987efc0sm12803741pff.218.2022.06.07.06.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:36:01 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     peterz@infradead.org, acme@redhat.com
Cc:     jolsa@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/btree: simplify btree_{lookup|update}
Date:   Tue,  7 Jun 2022 21:35:56 +0800
Message-Id: <20220607133556.34732-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btree_{lookup|update} both need to look up node by key, using the
common parts(add function btree_lookup_node) to simplify code.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/btree.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/lib/btree.c b/lib/btree.c
index b4cf08a5c267..a82100c73b55 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -238,7 +238,7 @@ static int keyzero(struct btree_geo *geo, unsigned long *key)
 	return 1;
 }
 
-void *btree_lookup(struct btree_head *head, struct btree_geo *geo,
+static void *btree_lookup_node(struct btree_head *head, struct btree_geo *geo,
 		unsigned long *key)
 {
 	int i, height = head->height;
@@ -257,7 +257,16 @@ void *btree_lookup(struct btree_head *head, struct btree_geo *geo,
 		if (!node)
 			return NULL;
 	}
+	return node;
+}
 
+void *btree_lookup(struct btree_head *head, struct btree_geo *geo,
+		unsigned long *key)
+{
+	int i;
+	unsigned long *node;
+
+	node = btree_lookup_node(head, geo, key);
 	if (!node)
 		return NULL;
 
@@ -271,23 +280,10 @@ EXPORT_SYMBOL_GPL(btree_lookup);
 int btree_update(struct btree_head *head, struct btree_geo *geo,
 		 unsigned long *key, void *val)
 {
-	int i, height = head->height;
-	unsigned long *node = head->node;
-
-	if (height == 0)
-		return -ENOENT;
-
-	for ( ; height > 1; height--) {
-		for (i = 0; i < geo->no_pairs; i++)
-			if (keycmp(geo, node, i, key) <= 0)
-				break;
-		if (i == geo->no_pairs)
-			return -ENOENT;
-		node = bval(geo, node, i);
-		if (!node)
-			return -ENOENT;
-	}
+	int i;
+	unsigned long *node;
 
+	node = btree_lookup_node(head, geo, key);
 	if (!node)
 		return -ENOENT;
 
-- 
2.20.1

