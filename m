Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801656A82B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiGGQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiGGQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:36:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A0F3206A;
        Thu,  7 Jul 2022 09:36:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y8so18100331eda.3;
        Thu, 07 Jul 2022 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EpRFRQjTAtTr1M5DmE/x/HJDwd5mR/vVrtLFwi8k4Rc=;
        b=EMKT4/3otjt8/rvpIKCJ1b2up/bgSsRt4nctE5sS6+lnuOSbOyoeg/ktEO4LC2wrW7
         Q99cck/TGy6MosOLQ75QZs/hGRX1dUfvsEr5F7N1QUKjI9uEwQb7rmyaaSlWtf8JrC0c
         DCSkH/e1WiRqMJ28VaobSI+VKrzLSssbI65UVRvM91xUA2iL3wO6q9S5rcuuhDpc64tv
         HK4bp1IrDrQWV7+oPb+9c7tdAJyd4OlbN8lvFtEzEIt1q1YVrEcEj2gzUgZHN2Xx5dZf
         JP0wpwymGrtRbjexM9FvahGJJnJDx9bWiqRuKCf7bdZb1XEC4v0Utps82E/SOutECnjk
         pcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EpRFRQjTAtTr1M5DmE/x/HJDwd5mR/vVrtLFwi8k4Rc=;
        b=MAWk7Sm2MO8XBodxBh45BcFgYcjs2p7HSmCHg0tn+nAhqBm+6CDLmmHn+5Oo84fhWA
         4BSDoAQX4nsBEaU7pfR2MAMCmkpk3iFc//HJe8HksJL+ZCL0v85PQrxcp1afgrzBJs/F
         dYxAlln3Rgth0hzwrBsJumojEkJa67u0NuYItMQ1u5URy0rTA4znB/AItq/6YWRzYyaT
         +43ezYjmozhXHxrj7MsUErL2/iVfxZGu8CZu5P0ZecYtpiQ7togPcQk/ANfxJnKZ8reM
         xFBmajj662hBK21Fp41i0sJUSppGe3aAN3UiKMhRXUJjx/ewGH5ba4QRcICj7S+8U4V2
         oGEw==
X-Gm-Message-State: AJIora8qPYrVAPUwR98SyW4MJjSAER1yTTn+7tAEpz72fwkt93ytFCPC
        i9mKjWe2l5/u8XJ1oio5ZvI=
X-Google-Smtp-Source: AGRyM1uthBb64W9W4HBZS6HwalidhRpgNw15fqS9Jvm5Snv3iAZKAdSpM3VWd3ObZl1c/1XPTq8Y4A==
X-Received: by 2002:aa7:d555:0:b0:43a:1be7:9e17 with SMTP id u21-20020aa7d555000000b0043a1be79e17mr37347794edr.183.1657211779662;
        Thu, 07 Jul 2022 09:36:19 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm19009030ejd.69.2022.07.07.09.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:36:19 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     ansuelsmth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] mtd: core: find OF node for every MTD partition
Date:   Thu,  7 Jul 2022 18:36:07 +0200
Message-Id: <20220707163607.20729-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707163607.20729-1-zajec5@gmail.com>
References: <20220707163607.20729-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Don't limit this feature to the "nvmem-cells". There are more cases to
this.
1. Dynamic partitions may need to be handled with parsers
   This applies to "fixed-partitions" parser and all custom ones.
2. Dynamic partitions can be handled with specific drivers
   Consider "u-boot,env" as specified in the u-boot,env.yaml.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/mtdcore.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 79c447fe30b4..f7693736dde4 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -552,7 +552,6 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 	const char *pname, *prefix = "partition-";
 	int plen, mtd_name_len, offset, prefix_len;
 	struct mtd_info *parent;
-	bool found = false;
 
 	/* Check if MTD already has a device node */
 	if (dev_of_node(&mtd->dev))
@@ -588,19 +587,11 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 		plen = strlen(pname) - offset;
 		if (plen == mtd_name_len &&
 		    !strncmp(mtd->name, pname + offset, plen)) {
-			found = true;
+			mtd_set_of_node(mtd, mtd_dn);
 			break;
 		}
 	}
 
-	if (!found)
-		goto exit_partitions;
-
-	/* Set of_node only for nvmem */
-	if (of_device_is_compatible(mtd_dn, "nvmem-cells"))
-		mtd_set_of_node(mtd, mtd_dn);
-
-exit_partitions:
 	of_node_put(partitions);
 exit_parent:
 	of_node_put(parent_dn);
-- 
2.34.1

