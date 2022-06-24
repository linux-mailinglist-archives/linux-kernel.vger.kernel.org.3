Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D70559A38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiFXNPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiFXNPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:15:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A7F5131E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:15:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so2799842pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLEzT1lVPllrHjLeUu8Tp5LunthrrN5z9TuJneyrGl8=;
        b=oXf5rgI/XnjiQNuTXHNqZt1plR0QkNOkdKwtQg1cpBHlfCjAerIUFlEhQBg+//78lN
         rDYcBPI2m/fRXUsgkJl4jBrqOQgNIuDzTtmzpSVau3rYJnp+iiQjyAswIjw9mWYrK5Ka
         I8f1oHiUTiW7Q4H6ekv+S4l66a9dbsM+ipbA0U/RDFZb796cjtTnROJocqzmAJ+Xz5/z
         kWbxjsEb6tYyMNNjC5bcIoqyenTgI/EKedmyqXFT+c/ulwuHU6J0aKmcy9kgnfnO2JIw
         chezLCjpat0pJ6m/3nA/90JF96a0TqMIwdVD3vhv6bxAJc66bo0VO0fxqZEE4vD0H+vu
         5R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLEzT1lVPllrHjLeUu8Tp5LunthrrN5z9TuJneyrGl8=;
        b=LH1aaYocpnFm5owhRmYv5jXmpPsmJG/eciyV+auO0GQGtkzDJt3C4DBjxdFWxSMX5f
         MzrxrdxwcFqTyiPfgc0hi+Ym1yn4hhDIOPo2LkLQrxaK+j3RY2Zn6eP+sGNR8TUZzN+c
         dFy9SD88Bd/Hpahj9sOgDQB03GDNfrK33/exa1eu3cy2q9VLKZrwSFUepj8CoKDDjxqT
         gXAKIoE5Dxte5CVXMXVhW73G+N9PtfE6EDIwT9gf/rOa8WoGttdApc5tzu0Mb93FmAn5
         sE7s8vR1SCCoDrHZBknmWSbs9OF0kZb14Ku+eGx1qwIQYNrxnIjSCj8UMu8CZ4Rhu6z+
         9wxQ==
X-Gm-Message-State: AJIora+UtxG8stczsZXcP7+JfbsYLUzcdNlY8PurkxaqZ8REbQ0vfXBp
        68gvnoUTEr0QCiWkaWvnB+mXx836PqwCDL7m
X-Google-Smtp-Source: AGRyM1v0QFhyMww7IFJiiQi/xGDnt7C+Iw/PHZS5gc6tMJXYhPHNj5Y02gCQrxzsBrFY1KrzXqfTEQ==
X-Received: by 2002:a17:90b:4a0a:b0:1ec:bd8d:a128 with SMTP id kk10-20020a17090b4a0a00b001ecbd8da128mr3962815pjb.67.1656076528709;
        Fri, 24 Jun 2022 06:15:28 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id je10-20020a170903264a00b0016636256970sm1787432plb.167.2022.06.24.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 06:15:28 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     willy@infradead.org, rdunlap@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/radix-tree: Remove unuse argument of insert_entries
Date:   Fri, 24 Jun 2022 21:15:23 +0800
Message-Id: <20220624131523.46153-1-wuchi.zero@gmail.com>
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

Function insert_entries doesn't use the 'bool replace' argument,
and the function is only used locally, remove the argument.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/radix-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index b3afafe46fff..3c78e1e8b2ad 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -677,7 +677,7 @@ static void radix_tree_free_nodes(struct radix_tree_node *node)
 }
 
 static inline int insert_entries(struct radix_tree_node *node,
-		void __rcu **slot, void *item, bool replace)
+		void __rcu **slot, void *item)
 {
 	if (*slot)
 		return -EEXIST;
@@ -711,7 +711,7 @@ int radix_tree_insert(struct radix_tree_root *root, unsigned long index,
 	if (error)
 		return error;
 
-	error = insert_entries(node, slot, item, false);
+	error = insert_entries(node, slot, item);
 	if (error < 0)
 		return error;
 
-- 
2.20.1

