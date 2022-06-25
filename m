Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6D455AAAA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiFYNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiFYNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:53:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BB5E0FA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:53:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 23so4934936pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssSG9NDaz5ZbJzVFSE1tuGr3e4HO/pxxMdMPP20OtO0=;
        b=TL+K1YseN25fcSGqq1Qwlw2Sd8g0IvOXwpW29JCwIuShvRjOlkGNOolHJs7/TcdaiQ
         cufEbEO8ELC75aOOOINMDCXBxTb67TT2x/cI6vIyDxQLJxSu+eP/k6T1bbOxlWbyAb21
         TpqdLzbKdUGJf0/kdsyTY+JZcb73LvrIftABHj9NDwZEBx5cjG7zSY7ClFWOSrGv87y2
         NolSF0DxRTEKjnfD1nRfxafjawPIV7ZFoNqMq9ksr09uUf5kixbwW4MlOFh/Jmy5RWEi
         nfVVO0cXu1953vCC6MqM2rRZ5CYWBL98Pm2VH2/8PZMyjUfrtaXQBQNk5EJuwjRgqZ1x
         5nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssSG9NDaz5ZbJzVFSE1tuGr3e4HO/pxxMdMPP20OtO0=;
        b=sMy1f4P0Z0lsBOkqt34XWNsXq7Spqo0OM7URoi/yXpdoM16+ukj5QictxndiRRLFY2
         2rL4vWdBav3jDjoo95W/+mLPtjgplUW1WJsZAfk3d5ebaPjOHnnw4U14hDfYxfZGioNy
         KVb7uaVE3ed2r11P3YkvUI+3iN2/hbVPw7te7+CogefMSY7cXM7azxoOhAjHB+AFG3Oq
         em24vN8LVlqJ9OnUbtdkMFql3fpdJacazZNwS4fbGgP2CeYZqZalAv3WjbWJYG73OGLt
         DC4v21vR406vuXarNNMHiOIWbeuY4ew6cXyHLtvj3Uk7I8cKdTt2RsD1n2j6j3uSrvAa
         TsNQ==
X-Gm-Message-State: AJIora+c7eyB3EspxkmmR/Sk1DleOn3Z4F+TApyFjnyGypcTzfuFlmJB
        0nNkZU02633Mx112Oh4hAqWmBqjjxAx87NbO
X-Google-Smtp-Source: AGRyM1v28COo6h6W3qeUrtuekHe3A2GZFl5WCroiVF54Hr7iP5K3rcffXTRT6E+cGy//Q/5GbK2BKA==
X-Received: by 2002:a63:3606:0:b0:40d:677:8815 with SMTP id d6-20020a633606000000b0040d06778815mr3870366pga.212.1656165209959;
        Sat, 25 Jun 2022 06:53:29 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id k64-20020a17090a14c600b001eb162ffaa3sm3600119pja.25.2022.06.25.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 06:53:29 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     willy@infradead.org, rdunlap@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/radix-tree: Remove unused argument of insert_entries
Date:   Sat, 25 Jun 2022 21:53:24 +0800
Message-Id: <20220625135324.72574-1-wuchi.zero@gmail.com>
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

The historical context of the unused argument is as follow:

2: commit <3a08cd52c37c79> (radix tree: Remove multiorder support)
  Remove the code related to macro CONFIG_RADIX_TREE_MULTIORDER
to convert to the xArray.
  Without the macro, there is no need to retain the argument.

1: commit <175542f575723e> (radix-tree: add radix_tree_join)
  Add insert_entries(..., bool replace) function, depending on the
macro CONFIG_RADIX_TREE_MULTIORDER definition, the implementation
is different. Notice that the implementation without the macro doesn't
use the argument.

[Matthew Wilcox: add historical context for argument]

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

