Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4704CBEBE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiCCNTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiCCNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:19:16 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F00148906;
        Thu,  3 Mar 2022 05:18:31 -0800 (PST)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 37CE23F7B1;
        Thu,  3 Mar 2022 14:18:29 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] clk: qcom: Fix sorting of SDX_GCC_65 in Makefile and Kconfig
Date:   Thu,  3 Mar 2022 14:18:10 +0100
Message-Id: <20220303131812.302302-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303131812.302302-1-marijn.suijten@somainline.org>
References: <20220303131812.302302-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep at least the list of `CONFIG_SM_` drivers sorted
alphabetically, SDX_GCC_65 should have been moved one line up.  This in
turn makes it easier and cleaner to add the followup SM_DISPCC_6125
driver in the right place, right before SM_DISPCC_8250.

Fixes: d79afa201328 ("clk: qcom: Add SDX65 GCC support")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Kconfig  | 14 +++++++-------
 drivers/clk/qcom/Makefile |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index f5b54bfc992f..161b257da9ca 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -574,13 +574,6 @@ config SDX_GCC_55
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
-config SM_CAMCC_8250
-	tristate "SM8250 Camera Clock Controller"
-	select SM_GCC_8250
-	help
-	  Support for the camera clock controller on SM8250 devices.
-	  Say Y if you want to support camera devices and camera functionality.
-
 config SDX_GCC_65
 	tristate "SDX65 Global Clock Controller"
 	select QCOM_GDSC
@@ -589,6 +582,13 @@ config SDX_GCC_65
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
+config SM_CAMCC_8250
+	tristate "SM8250 Camera Clock Controller"
+	select SM_GCC_8250
+	help
+	  Support for the camera clock controller on SM8250 devices.
+	  Say Y if you want to support camera devices and camera functionality.
+
 config SM_DISPCC_8250
 	tristate "SM8150 and SM8250 Display Clock Controller"
 	depends on SM_GCC_8150 || SM_GCC_8250
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index d96d6793fc7d..3e4eb843b8d2 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -84,8 +84,8 @@ obj-$(CONFIG_SDM_GPUCC_845) += gpucc-sdm845.o
 obj-$(CONFIG_SDM_LPASSCC_845) += lpasscc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SDX_GCC_55) += gcc-sdx55.o
-obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
 obj-$(CONFIG_SDX_GCC_65) += gcc-sdx65.o
+obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
 obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
 obj-$(CONFIG_SM_GCC_6115) += gcc-sm6115.o
 obj-$(CONFIG_SM_GCC_6125) += gcc-sm6125.o
-- 
2.35.1

