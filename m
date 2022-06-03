Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B307253C417
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiFCFQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiFCFQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:16:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BB1DA7A;
        Thu,  2 Jun 2022 22:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654233363; x=1685769363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=L3zoPueqFT9hkpqSI029vmCiT8m18QNBxmuKtLar2Cs=;
  b=hN3kSmVdkMFpjCevTK4D513MM2KHK9npsGS3DAewytrc+D0SVd08Wk0q
   nt3MJ2V6jSs2Zso6sDZVisU6nuFYgKG08f2PRfe0BOFW2QkFNorHE/wSH
   BywBTdDmliRFRVGVzMX5VbMTT3+NBADlb3ru180fIELL4MZYavk6c+2c5
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Jun 2022 22:16:03 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Jun 2022 22:16:01 -0700
X-QCInternal: smtphost
Received: from hu-sartgarg-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.105.147])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Jun 2022 10:45:59 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id C43A25001CD; Fri,  3 Jun 2022 10:45:57 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_kamasali@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH V1 2/2] mmc: sdhci-msm: Enable force hw reset during cqe recovery
Date:   Fri,  3 Jun 2022 10:45:33 +0530
Message-Id: <20220603051534.22672-3-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603051534.22672-1-quic_sartgarg@quicinc.com>
References: <20220603051534.22672-1-quic_sartgarg@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable force hw reset during cqe recovery to make recovery more robust.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/host/sdhci-msm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e395411fb6fd..7fc40bd16031 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2781,6 +2781,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
 
+	/* Enable force hw reset during cqe recovery */
+	msm_host->mmc->cqe_recovery_reset_always = true;
+
 	/* Set the timeout value to max possible */
 	host->max_timeout_count = 0xF;
 
-- 
2.17.1

