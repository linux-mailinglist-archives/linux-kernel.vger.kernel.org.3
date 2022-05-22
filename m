Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF753031A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbiEVMcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 08:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344947AbiEVMb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 08:31:59 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2013E06
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 05:31:57 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id skkRnZLZaEhCQskkRnwoNU; Sun, 22 May 2022 14:31:55 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 22 May 2022 14:31:55 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dan.carpenter@oracle.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] bus: qcom-ssc-block-bus: Fix resource release in .remove function
Date:   Sun, 22 May 2022 14:31:50 +0200
Message-Id: <d9c9889ac01bf5656e0902ad369e8811c44c3e0c.1653222646.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These resources are allocated using devm_ioremap_resource(), so there is no
need to call iounmap() explicitly.

Fixes: 97d485edc1d9 ("bus: add driver for initializing the SSC bus on (some) qcom SoCs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bus/qcom-ssc-block-bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bus/qcom-ssc-block-bus.c b/drivers/bus/qcom-ssc-block-bus.c
index eedeb29a5ff3..eaa39e08dd96 100644
--- a/drivers/bus/qcom-ssc-block-bus.c
+++ b/drivers/bus/qcom-ssc-block-bus.c
@@ -356,9 +356,6 @@ static int qcom_ssc_block_bus_remove(struct platform_device *pdev)
 
 	qcom_ssc_block_bus_deinit(&pdev->dev);
 
-	iounmap(data->reg_mpm_sscaon_config0);
-	iounmap(data->reg_mpm_sscaon_config1);
-
 	qcom_ssc_block_bus_pds_disable(data->pds, data->num_pds);
 	qcom_ssc_block_bus_pds_detach(&pdev->dev, data->pds, data->num_pds);
 	pm_runtime_disable(&pdev->dev);
-- 
2.34.1

