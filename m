Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9344B13A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbiBJQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:55:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244722AbiBJQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:55:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D4C97
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644512131; x=1676048131;
  h=from:to:cc:subject:date:message-id;
  bh=34AVyp8D/2rTg5gc6PV5wOhGYBVl0qG8WJ975vzlQOc=;
  b=XW3J/udIS+h4dY3tdC7tlt8vTXBg5l2iHJdJwIJdkRFqzFwxGodCLjuV
   y433eiecGdxnU0qF+9swMr2L9hpZsMbygRJK85qx0yfto0lKglQ4D8sQJ
   Kmh7FT404KhNWx+zlRBpBs3T0dejD4ahcx08Nby8gA8bSwBQnytXns9zi
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 08:55:30 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Feb 2022 08:55:14 -0800
X-QCInternal: smtphost
Received: from maggarwa.ap.qualcomm.com (HELO nitirawa-linux.qualcomm.com) ([10.206.25.176])
  by ironmsg02-blr.qualcomm.com with ESMTP; 10 Feb 2022 22:25:07 +0530
Received: by nitirawa-linux.qualcomm.com (Postfix, from userid 2342877)
        id 739773C37; Thu, 10 Feb 2022 22:25:06 +0530 (IST)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nitin Rawat <quic_nitirawa@quicinc.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH v2] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Date:   Thu, 10 Feb 2022 22:25:04 +0530
Message-Id: <1644512104-24035-1-git-send-email-quic_nitirawa@quicinc.com>
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

Enable quick suspend quirks for Sc7280 platform, where power
to nvme device is removed during suspend-resume process. This
is done to avoid the failure dring resume.

This enables simple suspend path for this platform.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---

Change from v1-v2:

*Moving the check condition outside vendor/device check
 to make this platform specific

---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed6..fa25d9fab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3032,6 +3032,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
+	} else if (of_machine_is_compatible("qcom,sc7280")) {
+		/*
+		 * Append quick suspend quirks for sc7280 platforms
+		 * so that simple suspend path is executed for this
+		 * platform to avoid any resume failure.
+		 */
+		return NVME_QUIRK_SIMPLE_SUSPEND;
 	}

 	return 0;
--
2.7.4

