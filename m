Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33E4C417D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiBYJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiBYJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:33:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470D017B0F6;
        Fri, 25 Feb 2022 01:32:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so1300171wmg.2;
        Fri, 25 Feb 2022 01:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Anr/HpsJ2V3LE7H1qAJzQqqWy2ZK47ULNqlFEib6tU=;
        b=P7ly3xMyPOrr3B0325E0teDM/lnRIOn9XJo7vDUt6oM76ogcTuQmAW6QSIVXm06n6x
         clY6WFc+TmNkhiQfhXRr8z+8+GnhlhufGuUcCpWy72mXjFb/viNp1REsO6MooFRkqJKW
         LiKPKOSqw2QbIhK8uF5COvxCOU35Ijtfx4xyKac9cRmg7dMheotudn9S9JZ3N7Tn7SyF
         7Dz20E21T8NXyZywwDBROSordMx0mgKNb9BsZ3K4K7lDo/5eowmZTV2onhx2j37l5Ond
         fYQvlVkhQXEtA1WzjBBIhYtMWPIIrs+qS4YVXWl27BzzfOPOQwSa5ZBSDUWT2SW3Pkd/
         Wtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Anr/HpsJ2V3LE7H1qAJzQqqWy2ZK47ULNqlFEib6tU=;
        b=0W6atkdqnYO3Lxx/uEZ6DDxYf9JCIfOZwfYm83Vb3lTwz4Y28HtdxypCOG6O6HO55Y
         C6f51U2VOIQLfvnLcDtAF4rA3Ku1N5q2a8zhX/YwCStY2gjXB5yVE/Pwk6lZk0CI9HWT
         ZjeaPeYkCDb3DbqYnMmyl2WXBIl9MIMY3/rxxenk3IAfPKihV4kmOZ67JxBhswrhGafG
         MDUjDTJpGjzsZrl4ZffP4x9/0RMyH4X7tIeyu6tjTW90iSDoi8XFcSgIfk98M7t0fMQB
         +U/MedHjZA7V/NIWi2hVIDiqqoSrKG5wjooOhLke8+ND0NkEZ6onkpEYYUa4tmgT5IQ+
         Xncg==
X-Gm-Message-State: AOAM533oMr8tMxZbvCRMTSpbPlURQytICFjI5vnZ12ATYEu9K9ocFWCc
        5oVOC62C0w0dW4eHJlRewtU=
X-Google-Smtp-Source: ABdhPJwoCKrFbFoCIBMTdfn2qSE6TEQIPQ9CT9XkwjlSqgeqEjqMCQ0M7IbjTCUATIRzbiSlEcckPw==
X-Received: by 2002:a05:600c:20b:b0:381:263:b5d6 with SMTP id 11-20020a05600c020b00b003810263b5d6mr1904829wmi.73.1645781561681;
        Fri, 25 Feb 2022 01:32:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc762000000b00380fd1ba4ebsm7733046wmk.9.2022.02.25.01.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:32:21 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] iommu/arm-smmu: remove redundant assignment to variable res
Date:   Fri, 25 Feb 2022 09:32:05 +0000
Message-Id: <20220225093205.170973-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable res is being assigned a value that isn't being read
later. The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/iommu/arm/arm-smmu/arm-smmu.c:2109:10: warning: Although the
value stored to 'res' is used in the enclosing expression, the value
is never actually read from 'res' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4bc75c4ce402..f83d2c32b5a9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2106,7 +2106,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return PTR_ERR(smmu);
 
 	num_irqs = 0;
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
+	while (platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs)) {
 		num_irqs++;
 		if (num_irqs > smmu->num_global_irqs)
 			smmu->num_context_irqs++;
-- 
2.34.1

