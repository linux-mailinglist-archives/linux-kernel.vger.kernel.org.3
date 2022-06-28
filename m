Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED355CFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbiF1L2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345435AbiF1L2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18CA199;
        Tue, 28 Jun 2022 04:28:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ay16so25118946ejb.6;
        Tue, 28 Jun 2022 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wzm8aXQ7jfEpVVa+hUFH1hW1Ct7FIztd1NOXIDzjfE=;
        b=XH74Pz5YOnB4omNJDTWscDju8Y67UOhoqHfCkZwCx5LLSKKYOOXLjuFrhSnLXqhXB3
         abm4wLC2wi/67TJtYAa/4rvjJpmbmWWbhJcLWdWed24A+CE9iREckGSewd0sZjKYPvQ1
         e/O2CTyyhBBO+MkRTN4w1gteEFLZI4Dfa8zZGpVa4eYAKrMbkhl8MvxT0Hy9OPUehRhh
         HZI9X4q0Db5Ykuh0H8l9PpS5SNzz3CtijZO6JId8OMZvKYF9I91K5V/kuYyqvO6JiLbx
         LqrDKHy7KfRuBMfCTnh1rYHX65tbNn3DWi9TBAqbrkRmMUxrt4QU6HUyQhjgKNE+tKaZ
         UNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wzm8aXQ7jfEpVVa+hUFH1hW1Ct7FIztd1NOXIDzjfE=;
        b=gx+4v61TF9m4j+8nAuIGpIdlt2Gen8+3E/jlJ5ORQIEkbTiM+MIJ9XlUyh/nbzeuiL
         LcdnwEvrVVI2JtVPAP6q8hfg8iEbQ9UNL9dMSoycGGxZLrX1b6950r9qn9vNm0gLBC8P
         BEK8kn7/lOc1yZvqNO5vN7vsZA1mNZCT2bHTz9U3SOuSrKkr1zTiN9b5asocJ8RoPA6a
         yRdz6SrJz7eCRJrVE9AWx+lwTJF0F/LwDVy6Qq92ZcP6Z/iAVwzUBm6b7CNnQtJd1+Vn
         kHu8iroWNNdvbgrQmB7+qB90/+GfhBT5j6ZYA7Ya4KtIMgXyD+WTpS06Nm+q1lkg05B/
         u5+Q==
X-Gm-Message-State: AJIora9YMGi5eYh8smqebn5Pw6qWr7Cec9pj+3szsJqQrZ8JnNoY30af
        We3LqEne2x3pW72sK5hfrX4=
X-Google-Smtp-Source: AGRyM1sDsDKOUmH0i6QVDvM2Jlx6H9R/wRxIYS1gH4CBNfulyXXOOVydVqD0/buMOXrZ4rCojhNJPQ==
X-Received: by 2002:a17:906:4fd4:b0:722:f223:8d86 with SMTP id i20-20020a1709064fd400b00722f2238d86mr17271003ejw.558.1656415695311;
        Tue, 28 Jun 2022 04:28:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:14 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 5/8] mtd: rawnand: intel: Don't re-define NAND_DATA_IFACE_CHECK_ONLY
Date:   Tue, 28 Jun 2022 13:27:28 +0200
Message-Id: <20220628112731.2041976-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
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
2.36.1

