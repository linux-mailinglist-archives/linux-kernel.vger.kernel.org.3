Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D42D4E7D18
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCYWXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiCYWXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:23:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568241A7738
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:21:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t4so4448999pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v91blLz8wNwh0dLvtLpa8fJvSTejqJw9Y0LtRUMFiP8=;
        b=m7ImBBTPlMOEmnAIbp1aHzsL6z987ZMQXMfwRqwyhiCOh3sw0FwnLiCrCf4fCY2Ed7
         2796sPOaghgEfwmq38VI00BNOSrsMlky4yCGJmOtYTG6KK04oGuSSIUbJTPtKvm3M9hq
         vrovnQwisek0WNHgVKPUdzhMI44PPDyW2ZS63aAt0fZDbTF1IkMJecntL1OHPQxK2U2Y
         8/QXE1H8a47ldbU0GA16XanUNlSdhNjdtFexmOuKQhqv78PcJvWZEpojBZS8qRgKkFcd
         F2XfpLTuD64szeqRvRxyj5xqN1Gfq0dDOaRgcNU6Z4WhIyVOARG2WmDSkfqU+sXFKMD+
         U4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v91blLz8wNwh0dLvtLpa8fJvSTejqJw9Y0LtRUMFiP8=;
        b=e5vQp50L7duRRnOctyWgB/bI6CiHWGt6rvsK2uzKaT+n8FZMiijWhVxhTfo812Sckq
         p9lwWlsSkaze4NsjaGpKyEheyaDUTXLrDZl9yP6bGgGB2sYTsWXpbJLADYpZDQAC9Ie2
         2S76rMGHkhhoOA3etYnWLi199P474gar2vcT4TCq/CTtC5qrqJInuvDZyvoT7hKWGI+F
         1zwpTOYNGT6M870b1YKNSX+69Qypg2OgVfu4qC9fkUKDHf/Y6fEzP/klstKrJ7zxVK7x
         wtn5R2Bh37xGx4dBwhyqMtyk9+E4lIdgLzXmt13esRjLTS/kAm/KQvVRqmD9G4s3yr/V
         q9Mw==
X-Gm-Message-State: AOAM533NN4znXXt7zakdWxQBoSzhjWAfBV5w4OqTdCrnSvSy0qwUOjoZ
        OuzeBDPVhW5JDoOE/v8txWgNHQ==
X-Google-Smtp-Source: ABdhPJy1DOkN3z3dEZ5hdjHML6seq7I5W6l0sQPXsizRWJsO4ml9TQYjzZ+NkQkLOpI4lfXWXi6hVA==
X-Received: by 2002:a62:6403:0:b0:4fa:c74c:83c5 with SMTP id y3-20020a626403000000b004fac74c83c5mr12089783pfb.30.1648246904786;
        Fri, 25 Mar 2022 15:21:44 -0700 (PDT)
Received: from localhost.localdomain ([223.233.78.42])
        by smtp.gmail.com with ESMTPSA id x16-20020a637c10000000b00380b351aaacsm6006490pgc.16.2022.03.25.15.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 15:21:44 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-phy@lists.infradead.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH v4 2/2] phy: qcom-qmp: Add SM8150 PCIe QMP PHYs
Date:   Sat, 26 Mar 2022 03:51:30 +0530
Message-Id: <20220325222130.1783242-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325222130.1783242-1-bhupesh.sharma@linaro.org>
References: <20220325222130.1783242-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8150 has multiple (different) PHY versions:
QMP GEN3x1 PHY - 1 lane
QMP GEN3x2 PHY - 2 lanes

Add support for these with relevant init sequence.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index b144ae1f729a..8e928b9619b6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3294,6 +3294,11 @@ static const char * const sdm845_pciephy_clk_l[] = {
 	"aux", "cfg_ahb", "ref", "refgen",
 };
 
+/* the pcie phy on sm8150 doesn't have a ref clock */
+static const char * const sm8150_pciephy_clk_l[] = {
+	"aux", "cfg_ahb", "refgen",
+};
+
 static const char * const qmp_v4_phy_clk_l[] = {
 	"aux", "ref_clk_src", "ref", "com_aux",
 };
@@ -3583,6 +3588,85 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.pwrdn_delay_max	= 1005,		/* us */
 };
 
+static const struct qmp_phy_cfg sm8150_qmp_gen3x1_pciephy_cfg = {
+	.type = PHY_TYPE_PCIE,
+	.nlanes = 1,
+
+	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
+	.serdes_tbl_sec		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
+	.serdes_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
+	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
+	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
+	.rx_tbl_sec		= sm8250_qmp_gen3x1_pcie_rx_tbl,
+	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
+	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
+	.pcs_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
+	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
+	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
+	.clk_list		= sm8150_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8150_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
+static const struct qmp_phy_cfg sm8150_qmp_gen3x2_pciephy_cfg = {
+	.type = PHY_TYPE_PCIE,
+	.nlanes = 2,
+
+	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
+	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
+	.tx_tbl_sec		= sm8250_qmp_gen3x2_pcie_tx_tbl,
+	.tx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
+	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
+	.rx_tbl_sec		= sm8250_qmp_gen3x2_pcie_rx_tbl,
+	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
+	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
+	.pcs_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
+	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
+	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
+	.clk_list		= sm8150_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8150_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+
+	.is_dual_lane_phy	= true,
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
@@ -6007,6 +6091,12 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm6115-qmp-ufs-phy",
 		.data = &sm6115_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-gen3x1-pcie-phy",
+		.data = &sm8150_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-gen3x2-pcie-phy",
+		.data = &sm8150_qmp_gen3x2_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sm8150-qmp-ufs-phy",
 		.data = &sm8150_ufsphy_cfg,
-- 
2.35.1

