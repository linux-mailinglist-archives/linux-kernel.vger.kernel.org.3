Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3734C571D42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiGLOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiGLOt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:49:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A714E636
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:49:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w12so9682798edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWdXKqvBEPZJ3mA635VvLTJkZo44UTBm15/9rGxOhDg=;
        b=q4cwR0kOaupYQ2Qpj3mF7Dk/O6g0HtRaBJZu4k2L11VBZhgn4mHMUmuPv0orUZ5yeK
         rA+adQOu8Wv1YRm3Kx4zTJisfru2GG0teDHbrgY+VZFdLA1iEMYjUSiX3HF5bQWSDEWz
         ZeV50FkMJlJJIN9EraEFGXXw3zvJ+mQyXAE50+Ah0dipM0Xy0+9lABmW0ANikFf3AqRp
         S8ln76No2VnP+k6BQ91wP5jf1SBIE+KMsFyqpWYg88cLBxWkv/QxyiVNVL0+P29fXDsm
         7oxL2nRJVXbFN/mCRKwstsGEXIpQlLQuhruRFEE0gohSqoUpW5lpYCrX1ReKE9cd+GV0
         U9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWdXKqvBEPZJ3mA635VvLTJkZo44UTBm15/9rGxOhDg=;
        b=rPHX36v6QMn25V1qd3MYpwYBCYGbvKGCBOdfT8sdqAmY+SzSjvAldTq3NTbtMa+7JT
         4gpBB3oUTO6gzGOgjaSGe6/e//2RtMZhxkYUHaR0BIpUZBfhldMTy/UM0Sqwfeqob0aP
         UhvjcfEu03CKdYn1wAsycCEoKnpztqN4Gb5TuFFhaP7Cc1F1VObl9J4MS+jjqhAjo5tO
         qZZpU3cIAd6/PpMJYS61hRCZNqNtCkTpCcghFYEyBfscamNR7U3sMttGdZfhxWPsDoDl
         9kA4PILFPmWfk4c+VGaQeZNUQcvIsPjDE1EYCsA+ynLq5GzQv2kxNguih6oMFznIwhvM
         Ybfg==
X-Gm-Message-State: AJIora9NPVbbgolEy1BJLk7iWCFL/KZ5+0HUH67P71ubYUsT8ALsdxSv
        FBQI8QE9ANeflp+OAn0YB0yvhrID/uo=
X-Google-Smtp-Source: AGRyM1skbHcyY88e6nPbA+JG6pCwg62++rGrFzZrfFhkvJ/IaMIzhiHP4OvJRmKp8sILsTZq2OsSzw==
X-Received: by 2002:aa7:cc03:0:b0:435:5574:bf30 with SMTP id q3-20020aa7cc03000000b004355574bf30mr32358760edt.15.1657637365492;
        Tue, 12 Jul 2022 07:49:25 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7d484000000b0043a46f5fb82sm6120579edr.73.2022.07.12.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:49:25 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] llist: Use try_cmpxchg in llist_add_batch and llist_del_first
Date:   Tue, 12 Jul 2022 16:49:17 +0200
Message-Id: <20220712144917.4497-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
llist_add_batch and llist_del_first. x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg.

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 lib/llist.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/llist.c b/lib/llist.c
index 611ce4881a87..7d78b736e8af 100644
--- a/lib/llist.c
+++ b/lib/llist.c
@@ -30,7 +30,7 @@ bool llist_add_batch(struct llist_node *new_first, struct llist_node *new_last,
 
 	do {
 		new_last->next = first = READ_ONCE(head->first);
-	} while (cmpxchg(&head->first, first, new_first) != first);
+	} while (!try_cmpxchg(&head->first, &first, new_first));
 
 	return !first;
 }
@@ -52,18 +52,14 @@ EXPORT_SYMBOL_GPL(llist_add_batch);
  */
 struct llist_node *llist_del_first(struct llist_head *head)
 {
-	struct llist_node *entry, *old_entry, *next;
+	struct llist_node *entry, *next;
 
 	entry = smp_load_acquire(&head->first);
-	for (;;) {
+	do {
 		if (entry == NULL)
 			return NULL;
-		old_entry = entry;
 		next = READ_ONCE(entry->next);
-		entry = cmpxchg(&head->first, old_entry, next);
-		if (entry == old_entry)
-			break;
-	}
+	} while (!try_cmpxchg(&head->first, &entry, next));
 
 	return entry;
 }
-- 
2.35.3

