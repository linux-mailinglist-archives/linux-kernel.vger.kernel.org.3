Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBB2560BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiF2Vfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiF2Vf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9031361;
        Wed, 29 Jun 2022 14:35:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lw20so35204566ejb.4;
        Wed, 29 Jun 2022 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jieKz72cmVh5R8qYrLL4foPrJEJnRnBgZYhz6Rx/tnM=;
        b=USohIEv4cdQnvKvjNk2QG6gItTrIF4WJwnLMBHVJoQF+ep92m5U5Pkr20bpxb3rN+Q
         JeNDj1Eeu5MoVgtkYlYIuHSI51ICUUwhfwU4uQI5J17/pHIdqZmfKWzfR8ro6bADenAc
         7s+s2//bZ4ZD3/SzId7SglMInyhYO+XMhSE2qYh8xtRviU1htOhOF/StFMg9YTAWajlt
         0dYbxHpVWY72tjtM6i1NPl08uRsqXt5bO995nsrQieEGgOivEG9JN/ZQg6yyomXgFr6C
         mVwASBjr57eRFlA9BOc9l+Ml8qhgJVBfWV/DrHMMoZoF5tvHv0+KuPLBcs1SkIFmkAJY
         IrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jieKz72cmVh5R8qYrLL4foPrJEJnRnBgZYhz6Rx/tnM=;
        b=z9mRGHJmBjPYzZsxC7yJWSv7Cj/8oPDzFT/5LuAu0BuQMLL4KKQV84kt6QiditUMR0
         H0R2Ru1+ZleEWk22OHMuaQaXPIwzdvcMJxy/Rjkug0lY5FAMqD+4VI5MgpwXy8p6vE6I
         DROWj00JywRhG04o9jyB5YafKiTDRB4/F0Rf5aQS8gveelHHJ+vzMvs8rNGQN7v5+xX2
         nn+SYcjakEIsBQ/HlaT+A/WOlY+Zcb9x0yibw9E0tNeCDMqAJgLBEWbWH2ElxqX1NHcp
         7gpp296dMjruMolFv5h+ZoShS5vL9ht6lNc5wd2xxmWD+NflemBPkixC50kkElzf1c1s
         M3fQ==
X-Gm-Message-State: AJIora88rnBFqndqCxucyzi2H652FDi8IDmqGVyhPP7JmZCN79joCioD
        Dq7MN/9WhrFKk18xC/IReXwA8T2Exq8=
X-Google-Smtp-Source: AGRyM1ueTSOk+Pfg906r5kHgVoScaEjxh1Q/2L62UL9nG4lFbq1Cn8zwXFzJ9ra1BHOOMiGnMihKQA==
X-Received: by 2002:a17:907:6eac:b0:726:94ef:5ff3 with SMTP id sh44-20020a1709076eac00b0072694ef5ff3mr5359906ejc.545.1656538523971;
        Wed, 29 Jun 2022 14:35:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:23 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 5/8] mtd: rawnand: intel: Don't re-define NAND_DATA_IFACE_CHECK_ONLY
Date:   Wed, 29 Jun 2022 23:35:05 +0200
Message-Id: <20220629213508.1989600-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
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

NAND_DATA_IFACE_CHECK_ONLY is already defined in
include/linux/mtd/rawnand.h which is also included by the driver. Drop
the re-definition from the intel-nand-controller driver.

Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 056835fd4562..3df16d5ecae8 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -100,8 +100,6 @@
 
 #define HSNAND_ECC_OFFSET	0x008
 
-#define NAND_DATA_IFACE_CHECK_ONLY	-1
-
 #define MAX_CS	2
 
 #define USEC_PER_SEC	1000000L
-- 
2.37.0

