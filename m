Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70FB56434A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiGBXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiGBXMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:12:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461FBBC21;
        Sat,  2 Jul 2022 16:12:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z41so7188707ede.1;
        Sat, 02 Jul 2022 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTaZ/9+DRnLhDSj0DOV2C+IIhpHfbKqhWacVmkOB7BY=;
        b=WAh2tNKM0lRNF8UUHv4MaNqhtwRvQubb5330+ZE3Y2mae4IDnvy7linhak+uRdzDuL
         fCnOAUVX4274xrZMmLilupQ2Z1rmJFGjBYLiBQuiV9sbuW+yfo2nF+9jAAxwZXGyXUiQ
         mGhlewzANw11TbAAokn2DtuU28zUdub/OmqISYRxdUQf6mqAhq+SYB95psXCfnNz2VE7
         4Tyts//6DcsvsM8fyorliVDkfQeEi5iRyVm6igDR6m4vjEA3BeXscWuVYmO7FPmZ+vez
         b23iT/69ltBEHcXQWzut2ARq0z9pXxhcECQ/3Fn6s+6qdba7bMl67X5ssgJdadDriehm
         g9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTaZ/9+DRnLhDSj0DOV2C+IIhpHfbKqhWacVmkOB7BY=;
        b=7rdLGvY1LrX+ja1b/hJfI9mjrJIRiP2ZpHvySqXD4tANn4kTFpP6haVs/r1LL48pZB
         ty1oUo+Elbo56/RhcjCx1R3wzfKJKWTwfw5AovquyQIZ/7LLhjzkbjJTJt/1D5YXwYNP
         jkFoHemW2vn8QzTga84xSZGqUesy7rW39WmZahKfQ+K7zo/6gkHrjxYBYtEp04muXu9t
         y/sH3SLhyL/JuwP6E/ZUznusDCmqcXifirDPRiBWwoARGl5Nr4LIUmVfdAcyILihwBmh
         TBNdiLI4QUXTGtIlVgBaxXnAHR3FWd7ui+X+DAHXZSX2f0DCoyhOjMCTebrXG/YjGoQC
         hNkA==
X-Gm-Message-State: AJIora84i4TBUP0ONBmeIWHiHy2+ZOjGJzDq9iSXDX3odBPE37ZxuBQP
        hfGDezxsOhAVizVWuyA5kv4=
X-Google-Smtp-Source: AGRyM1t0QOBr9erpyf7jmjLE/oOiBlNlr/q0V5DW66YddsJao3mqr3ZWGBJYQtA1HfnkFRmj1rVVmA==
X-Received: by 2002:a05:6402:1e95:b0:437:ce7f:e17a with SMTP id f21-20020a0564021e9500b00437ce7fe17amr27711429edf.169.1656803563812;
        Sat, 02 Jul 2022 16:12:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4d4-2700-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4d4:2700:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm12234329ejb.28.2022.07.02.16.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 16:12:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 4/8] mtd: rawnand: intel: Remove undocumented compatible string
Date:   Sun,  3 Jul 2022 01:12:23 +0200
Message-Id: <20220702231227.1579176-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
References: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
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

The "intel,nand-controller" compatible string is not part of the
dt-bindings. Remove it from the driver as it's not supposed to be used
without any documentation for it.

Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 3df3f32423f9..056835fd4562 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -723,7 +723,6 @@ static int ebu_nand_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ebu_nand_match[] = {
-	{ .compatible = "intel,nand-controller" },
 	{ .compatible = "intel,lgm-ebunand" },
 	{}
 };
-- 
2.37.0

