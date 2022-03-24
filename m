Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2F4E5F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiCXHfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348706AbiCXHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:34:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF78C6A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:33:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so7370068ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p4XcSqi4hilkip9A6euflsFWMknVrb5Cx1p1GP8tqr4=;
        b=bdyv8sM/IbxgLlqNsgWS4QfHyvT2X0/AWGQYTRSqDdZ9PrqhsvuV8mM+ZxrIyK5Pgd
         NKDQ6+4xPrAXOoFvvJpjhagUhjV/8IpZ9lXcol3uqQ2poM/tGmQQkk26gCezg4JtF7jq
         3tXq7mfUuMkI90mOFCP7YO50njmm6YmXTGL3XmwPazWRPfkISRTYlKpxnzpABMdZmpgA
         og1FfIt3HniAnlSuUD6cKLK9b7Ia36dl/0iQWUpL/sToYfdh9g1mExXow/9FRKenG3a1
         KWl1JoUmIJdAN9JqGsBUkdWEO6kZJykY+hOO0LYeXOTG4yDT7dx7nHe/08G7aLAQ4HEE
         xJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p4XcSqi4hilkip9A6euflsFWMknVrb5Cx1p1GP8tqr4=;
        b=etpKJMXJTyoIf7y1th7yh5Vo7X4vblOYzP6gGvD+UEHDWM02LoNcHCuq1vlAUaUHlA
         Pbrh/WYloAt5rHPw3+I4Z+zawJTsZxVMxdOeIWO0lVo05Mi9FkEyoj7gH9Q6F5gBTOnD
         3Rg0aXu5fkvaEm+/QMbwrfNnGIGn8+VCs2MeSeyCVgAtwORo+UZkNBrug8SKA4PpXZC7
         ivjx9lhtRHrrPEXKAzJhwTUWgHOluBJHiLOOjMlQVK5tbfxC9SCTAN1elSELLmOH2zfi
         6PFuHhuGPkBWNVSNRdDFjfxs9e7wB03MrP0HWW+ZM7KS9mXI2sDG46hSQc+LOSQ6f4OT
         EZjg==
X-Gm-Message-State: AOAM5305Fi493TXLOVsYMhY3CYccx73fFEO0SfWXE0d8eMXyw3KVL3Dv
        ix+3VVcLPY2Q3CH/pp5mWFo=
X-Google-Smtp-Source: ABdhPJyI9A7dnH+iZmfHuDRtn8Mxx20fJ8PXgCgaG9YqLXSdrktGF/XpSS3ERdrQq5VuK/j+3hKCvQ==
X-Received: by 2002:a17:907:72c5:b0:6da:e99e:226c with SMTP id du5-20020a17090772c500b006dae99e226cmr4246712ejc.515.1648107182221;
        Thu, 24 Mar 2022 00:33:02 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm1054724eda.59.2022.03.24.00.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:33:01 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] w1: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:32:27 +0100
Message-Id: <20220324073227.66486-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/w1/w1.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..1219476cce88 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -830,49 +830,47 @@ int w1_slave_detach(struct w1_slave *sl)
 
 struct w1_master *w1_search_master_id(u32 id)
 {
-	struct w1_master *dev;
-	int found = 0;
+	struct w1_master *dev = NULL, *iter;
 
 	mutex_lock(&w1_mlock);
-	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
-		if (dev->id == id) {
-			found = 1;
-			atomic_inc(&dev->refcnt);
+	list_for_each_entry(iter, &w1_masters, w1_master_entry) {
+		if (iter->id == id) {
+			dev = iter;
+			atomic_inc(&iter->refcnt);
 			break;
 		}
 	}
 	mutex_unlock(&w1_mlock);
 
-	return (found)?dev:NULL;
+	return dev;
 }
 
 struct w1_slave *w1_search_slave(struct w1_reg_num *id)
 {
 	struct w1_master *dev;
-	struct w1_slave *sl = NULL;
-	int found = 0;
+	struct w1_slave *sl = NULL, *iter;
 
 	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		mutex_lock(&dev->list_mutex);
-		list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
-			if (sl->reg_num.family == id->family &&
-					sl->reg_num.id == id->id &&
-					sl->reg_num.crc == id->crc) {
-				found = 1;
+		list_for_each_entry(iter, &dev->slist, w1_slave_entry) {
+			if (iter->reg_num.family == id->family &&
+					iter->reg_num.id == id->id &&
+					iter->reg_num.crc == id->crc) {
+				sl = iter;
 				atomic_inc(&dev->refcnt);
-				atomic_inc(&sl->refcnt);
+				atomic_inc(&iter->refcnt);
 				break;
 			}
 		}
 		mutex_unlock(&dev->list_mutex);
 
-		if (found)
+		if (sl)
 			break;
 	}
 	mutex_unlock(&w1_mlock);
 
-	return (found)?sl:NULL;
+	return sl;
 }
 
 void w1_reconnect_slaves(struct w1_family *f, int attach)

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

