Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE464B0D76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiBJMV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:21:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiBJMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:21:26 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E2125F0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644495687; x=1676031687;
  h=from:to:cc:subject:date:message-id;
  bh=K2aBTgWx9LPBifqZtMRBr5zTaj93/UxFbnz6K+FhbXc=;
  b=CKXH3wsCykIl2appoC4AqRqUwEmwAIi0QRzb/dMG93mJCOcGWJBGmQ1H
   /uNB99CyAvkEBHOrVUQl8IriHq82fGXHkYUFFOULCvg8l7EkdfvyDXXvc
   i6Y9jfLhNT8XVrvjCx8wQgjFIOqY/msra5DJI3IqdCFmHpHhb9/vhFT2r
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 04:21:27 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Feb 2022 04:21:26 -0800
X-QCInternal: smtphost
Received: from maggarwa.ap.qualcomm.com (HELO nitirawa-linux.qualcomm.com) ([10.206.25.176])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 Feb 2022 17:51:19 +0530
Received: by nitirawa-linux.qualcomm.com (Postfix, from userid 2342877)
        id 0E7443C1F; Thu, 10 Feb 2022 17:51:18 +0530 (IST)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nitin Rawat <quic_nitirawa@quicinc.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive.
Date:   Thu, 10 Feb 2022 17:51:16 +0530
Message-Id: <1644495676-8124-1-git-send-email-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Toshiba KBG40ZPZ256G SSD is having resume issues on SC7280 platform.
Hence enabling quick suspend quirks for Toshiba KBG40ZPZ256G on sc7280
platform so that nvme device is taken through shutdown path
during resume.

No issue is seen after enabling this quirks.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/nvme/host/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed6..04c5954 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3032,6 +3032,15 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
+
+		/*
+		 * Toshiba KBG40ZPZ256G on Sc7280 platform is having NVMe
+		 * Resume issue. Appending quick suspend quirks for sc7280
+		 * platforms so that full NVMe device shutdown path is
+		 * executed during resume.
+		 */
+		if (of_machine_is_compatible("qcom,sc7280"))
+			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}

 	return 0;
--
2.7.4

