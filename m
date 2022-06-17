Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3683954FC1C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383184AbiFQRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiFQRUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:20:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523334BAC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:20:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z14so4606763pgh.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cl4SWERm0MrHvdlWl57BAJhfsIoZCFsRyOEFX1fY+NE=;
        b=WVfCl7zJi1VxrQ/xCZXh0EAU+mLSwUO64Szw+ujj1f9tdVruFJRACq20zE6Fzle70p
         AsE3EqN3x4DVOg4S8y4pdF4ywWuDIHsY6qjTz5VysWp3NGlmT9RSa/4l3/Z8ONSPJBiV
         SFKkZv76PrBfVAmWib0M41LOD1GC6UqMf/ZzpXFY2K9VEOY0OQbeACJ7FV1YFc4iNTMC
         mJsJvaYrF1sQOeMNHaNX14f35GMSvUOHT7V8XUhKBmTTZq/+ERd0CrQKLh3MM/5TLidx
         2Qjp+saRl11uzJIYyNowKDsKNEit/PcBluprmxbH6uZC6h491sNacxToRRMu3oXyShED
         qWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cl4SWERm0MrHvdlWl57BAJhfsIoZCFsRyOEFX1fY+NE=;
        b=PTL/N13E8BSXZcyd5skbWsl05ulBHrpTNL8qdQnJjEu+LlHHZ/886JrK9yqiOOmArB
         Y5IyU0RyEr888fc1msU3sMu6NpBu1meaSN9dTgCLDlDZRNksruMH62v59pu0z0pFYGaR
         wH3SKd6c//ecizX/ZOzHzjk7Mjf0/RqtY1F2ofaRCG//ZQyl0IhnJWAooffe1eD/0t6l
         W+fqVkfLvTIbrL2OBdwmSTrGVnKfhuxGaAIvKmsj2Uk4f3WjXdwIdcmHY7gp9Ig+6iwN
         efST1QLagRN4ob5ctPCaL2GxlucxcclRzs5/hOfyl0UMaF6omP2tBxg87Klab1GC9sk1
         +oZA==
X-Gm-Message-State: AJIora/dLWGZs60YJ+qmwxBbdp2LmJHip8ORn6kY/Z2C68cB/zOyatTg
        k7d5SORt8IHcR+Kq3yRYgzk=
X-Google-Smtp-Source: AGRyM1tq052kF6oeakD4ELJlLjNImEJZP2CBbiH9IlEQlLjQ9OHDuR2tkvD+PnDBxuDOn6TjXGM8WA==
X-Received: by 2002:a63:894a:0:b0:3fc:a724:578c with SMTP id v71-20020a63894a000000b003fca724578cmr10094549pgd.499.1655486422827;
        Fri, 17 Jun 2022 10:20:22 -0700 (PDT)
Received: from biggie.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00163f2fe1e64sm3834475plg.255.2022.06.17.10.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 10:20:22 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     airlied@linux.ie
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH v2] Remove unnecessary variable assignment in agp_generic_create_gatt_table()
Date:   Fri, 17 Jun 2022 22:50:11 +0530
Message-Id: <20220617172011.39897-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <81aaa86d-f963-0265-6a4e-6a6110758b99@linuxfoundation.org>
References: <81aaa86d-f963-0265-6a4e-6a6110758b99@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variable assignments in the function
agp_generic_create_gatt_table(). This fixes the clang scan warnings:

warning: Value stored to 'page_order' is never read [deadcode.DeadStores]
        page_order = num_entries = 0;

warning: Although the value stored to 'num_entries' is used in the
enclosing expression, the value is never actually read from 'num_entries'
[deadcode.DeadStores]

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
changes in v2:
1. Initialize the variables where they are declared.

 drivers/char/agp/generic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 3ffbb1c80c5c..7fe72c07647d 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -851,8 +851,8 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 {
 	char *table;
 	char *table_end;
-	int page_order;
-	int num_entries;
+	int page_order = 0;
+	int num_entries = 0;
 	int i;
 	void *temp;
 	struct page *page;
@@ -864,7 +864,6 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 	table = NULL;
 	i = bridge->aperture_size_idx;
 	temp = bridge->current_size;
-	page_order = num_entries = 0;
 
 	if (bridge->driver->size_type != FIXED_APER_SIZE) {
 		do {
-- 
2.34.1

