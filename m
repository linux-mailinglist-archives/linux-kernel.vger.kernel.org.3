Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C19553AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354109AbiFUTzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353792AbiFUTzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:55:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485C289AC;
        Tue, 21 Jun 2022 12:55:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lw20so7389887ejb.4;
        Tue, 21 Jun 2022 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmLQpIEr89ZBDY4anFjTosysEvGwUfMAqwQk46EbHQA=;
        b=R4yNkC8agC+5mzC+cE0N8IJ0dkaJTmlai/IpgVXM1jRHI2S+1soTY4yG40VdPt/x28
         8+4zkX3RQV+/hiPY5OoJAYN9/NNBXxpHtG6ytMON3XMCSMKK6Qo9oR4uNSkatHit9Ioa
         toFh48uIUDA9hoT/VaYfValVFZ1G609phmARm468i82i3ttvgJJfpZ1f+hvpXJs9qG+m
         lWbMXZ27dsEsUxUnQg/7zTE3/DxxxV7Bf2bYalkzgDBiSQVRFm+uNTJOfVE6gX7wNkz+
         8O9MY8MO8JNjs+2/Iblmors/0hMaXZfzCwv0EDb2y152HtaBBP7HJkYu2Kb0VfGpAldy
         wNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmLQpIEr89ZBDY4anFjTosysEvGwUfMAqwQk46EbHQA=;
        b=7speNibEnLqxdJQiSXxqFZqO8CXEderIbLVjnp0tsl7s/+XHHvYnL9L4TyDeH/6bg9
         2awH7zk7AwDaPJBBQVHngspPNq1uuIFSU6Sy/9WiGjxT7kUmc9VMdLIP6bnaeC8Pdrfq
         EGDxAFlSRS33RBSz2WEke469nq33RtCZydl7nFrT5KcyxF8vwfNT7bDO4M56uwSJs4EX
         6i1Z+ayfL9GsH+78HTltL01GSxWV0/CjGpzyrZELtcOZBumU6UXXR6uM7UxltKdLtvet
         94BIuEiiimJvM+co5wGZNwR/Zt3ql8vFfk6/KgaeyuVO5E1Uzs+9v2ngNSCUQzZWfXyk
         2Mrg==
X-Gm-Message-State: AJIora8ihEva1uI7/Vd0M73lEszLFjm7l9eUJ8svT8DHHHwKcCwzln1T
        lhsXqD3CHkpNb2/r9J9vLzI=
X-Google-Smtp-Source: AGRyM1vNL/LMEd8YBM3Uk3NwflBYV+RGWo+XPiMc1e5evAATMCyqI8/MtpUWsZ1djfnSPY8YMaPQiw==
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id di4-20020a170906730400b006ff0a765b09mr27664919ejc.193.1655841315013;
        Tue, 21 Jun 2022 12:55:15 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-158.xnet.hr. [88.207.99.158])
        by smtp.googlemail.com with ESMTPSA id b14-20020a056402084e00b0043565c79879sm10713114edz.43.2022.06.21.12.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:55:14 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 1/3] phy: qcom-qmp-pcie: make pipe clock rate configurable
Date:   Tue, 21 Jun 2022 21:55:10 +0200
Message-Id: <20220621195512.1760362-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

IPQ8074 Gen3 PCIe PHY uses 250MHz as the pipe clock rate instead of 125MHz
like every other PCIe QMP PHY does, so make it configurable as part of the
qmp_phy_cfg.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v4:
* Set 125MHz as the default if not set in qmp_phy_cfg
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index b2cd0cf965d8..66be854fe7f3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1284,6 +1284,9 @@ struct qmp_phy_cfg {
 
 	/* true, if PHY has secondary tx/rx lanes to be configured */
 	bool is_dual_lane_phy;
+
+	/* QMP PHY pipe clock interface rate */
+	unsigned long pipe_clock_rate;
 };
 
 /**
@@ -2121,8 +2124,15 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 
 	init.ops = &clk_fixed_rate_ops;
 
-	/* controllers using QMP phys use 125MHz pipe clock interface */
-	fixed->fixed_rate = 125000000;
+	/*
+	 * Controllers using QMP PHY-s use 125MHz pipe clock interface
+	 * unless other frequency is specified in the PHY config.
+	 */
+	if (qmp->phys[0]->cfg->pipe_clock_rate)
+		fixed->fixed_rate = qmp->phys[0]->cfg->pipe_clock_rate;
+	else
+		fixed->fixed_rate = 125000000;
+
 	fixed->hw.init = &init;
 
 	ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
-- 
2.36.1

