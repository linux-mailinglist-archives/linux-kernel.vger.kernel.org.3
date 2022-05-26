Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D0E534EED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345931AbiEZMOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiEZMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:14:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A23B0A5E;
        Thu, 26 May 2022 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653567290; x=1685103290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=muvrNAbA9KUhGpmb4Y3QN40P7gy4+uJmLvPE+pNb5js=;
  b=gm26l0gp/eFjQXG1qf0vvX7OWwqbpNsm6G0gBQtizP3mqXWAnZ3HVWG6
   5LSuEAMDZFozl3mdunEDDCQRCr6NBKA2OFlgt2qiOYWzzqbY2MQmL2U/o
   ScbgjU3xlXdqfPwcvHcdtcwcfWDKnXZ+Rc+XTrtj1VTrRjEUzMAXJJYi6
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2022 05:14:50 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 May 2022 05:14:48 -0700
X-QCInternal: smtphost
Received: from hu-sartgarg-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.105.147])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 May 2022 17:44:44 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 242BA5001B7; Thu, 26 May 2022 17:44:43 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_kamasali@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH V2 2/2] mmc: sdhci-msm: Add wakeup functionality to sdio cards
Date:   Thu, 26 May 2022 17:42:15 +0530
Message-Id: <20220526121215.25947-3-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220526121215.25947-1-quic_sartgarg@quicinc.com>
References: <20220526121215.25947-1-quic_sartgarg@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch initializes wakeup source if the detected card
is a sdio card and enables the wakeup capability.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/host/sdhci-msm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e395411fb6fd..3bfc506e5c45 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2376,6 +2376,18 @@ static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
 	return -EAGAIN;
 }
 
+static void sdhci_msm_card_init_wakeup(struct mmc_card *card)
+{
+	int ret;
+
+	if (mmc_card_sdio(card)) {
+		ret = device_init_wakeup(&card->dev, true);
+		if (ret)
+			pr_err("%s: %s: failed to init wakeup: %d\n",
+				mmc_hostname(card->host), __func__, ret);
+	}
+}
+
 #define DRIVER_NAME "sdhci_msm"
 #define SDHCI_MSM_DUMP(f, x...) \
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
@@ -2794,6 +2806,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_msm_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
+	host->mmc_host_ops.card_init_wakeup = sdhci_msm_card_init_wakeup;
+
 	if (of_property_read_bool(node, "supports-cqe"))
 		ret = sdhci_msm_cqe_add_host(host, pdev);
 	else
-- 
2.17.1

