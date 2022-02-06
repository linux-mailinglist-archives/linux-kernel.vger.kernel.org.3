Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1853C4AB219
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 21:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbiBFU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 15:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343935AbiBFU3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 15:29:50 -0500
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E55C0401C1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 12:29:48 -0800 (PST)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A560320056;
        Sun,  6 Feb 2022 21:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1644179386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mJbQE9aLpDKahWvRXxUd+4aTtXVGsiL8uHGSLEVhR0w=;
        b=DiVIEK2kVh9/PD98+QqNQmpY4Ou7lkgRwa2gzTB9TugbXr4CV3NtvDuah7cvYqP+o2o5M+
        GqGz8M9++antjbHwnZgxrdvou8pCCu3n3lhHzixFjSY/xA62awUPiSDEwT4xZJOlGqRPyl
        0Vo7ufwISCVvpe1S7/Wue88q/DfGLII=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/msm: simplify with dev_err_probe()
Date:   Sun,  6 Feb 2022 21:29:45 +0100
Message-Id: <20220206202945.465195-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error is
printed.

Fixes warnings as:
msm_iommu 7500000.iommu: could not get smmu_pclk

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iommu/msm_iommu.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352b603f..6e6cff5fc469 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -710,36 +710,32 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&iommu->ctx_list);
 
 	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
-	if (IS_ERR(iommu->pclk)) {
-		dev_err(iommu->dev, "could not get smmu_pclk\n");
-		return PTR_ERR(iommu->pclk);
-	}
+	if (IS_ERR(iommu->pclk))
+		return dev_err_probe(iommu->dev, PTR_ERR(iommu->pclk),
+				     "could not get smmu_pclk\n");
 
 	ret = clk_prepare(iommu->pclk);
-	if (ret) {
-		dev_err(iommu->dev, "could not prepare smmu_pclk\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(iommu->dev, ret,
+				     "could not prepare smmu_pclk\n");
 
 	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
 	if (IS_ERR(iommu->clk)) {
-		dev_err(iommu->dev, "could not get iommu_clk\n");
 		clk_unprepare(iommu->pclk);
-		return PTR_ERR(iommu->clk);
+		return dev_err_probe(iommu->dev, PTR_ERR(iommu->clk),
+				     "could not get iommu_clk\n");
 	}
 
 	ret = clk_prepare(iommu->clk);
 	if (ret) {
-		dev_err(iommu->dev, "could not prepare iommu_clk\n");
 		clk_unprepare(iommu->pclk);
-		return ret;
+		return dev_err_probe(iommu->dev, ret, "could not prepare iommu_clk\n");
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iommu->base = devm_ioremap_resource(iommu->dev, r);
 	if (IS_ERR(iommu->base)) {
-		dev_err(iommu->dev, "could not get iommu base\n");
-		ret = PTR_ERR(iommu->base);
+		ret = dev_err_probe(iommu->dev, PTR_ERR(iommu->base), "could not get iommu base\n");
 		goto fail;
 	}
 	ioaddr = r->start;
-- 
2.34.1

