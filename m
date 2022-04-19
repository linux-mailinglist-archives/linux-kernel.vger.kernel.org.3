Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2C5061BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245542AbiDSBkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiDSBkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:40:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C392201BE;
        Mon, 18 Apr 2022 18:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650332242; x=1681868242;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=tmgwZkvCV2R6IyuCglak7yhL3N9zBgqGkPbpA6ubX9c=;
  b=JzyHl3yLWykIOmzk0BxiSjdnYx+7WcT9SiV2Kdbx6jxZw+xeOK+xqAIf
   5kBqdoVLVqtg8BXEDaWKlLSY3XOPCsVsU2rpyQkr4NAWnasRnG0yRmoj1
   X0q2LCUdkFymsrm5Hu3fT3RXoZ00ePQMNrL7k1cb0i4/o3pucDb3A2umO
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Apr 2022 18:37:21 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 18:37:21 -0700
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 18:37:20 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_cang@quicinc.com>, <quic_asutoshd@quicinc.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "Daejun Park" <daejun7.park@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Can Guo" <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] scsi: ufs: Increase the UIC command timeout to 5 seconds
Date:   Mon, 18 Apr 2022 18:36:05 -0700
Message-ID: <55bd9cf4216e80e73e63cf25c042d60e67592b44.1650331167.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the UIC command timeout to avoid false and unnecessary
UFS errors printout. There are increasing number of false UIC command
timeout error events where the actual cause of the issues is interrupt
starvation. When looking into these issues closely, it was clear that
the UIC command completed successfully, but the CPUs were hogged by other
subsystems for more than 500ms, causing a false UIC command timeout.

Increase the UIC command timeout to 5 seconds to avoid false and
time consuming support calls so that we can shift the focus to where
the real issue would be.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3f9caaf..806acf4 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -35,7 +35,7 @@
 				 UTP_TASK_REQ_COMPL |\
 				 UFSHCD_ERROR_MASK)
 /* UIC command timeout, unit: ms */
-#define UIC_CMD_TIMEOUT	500
+#define UIC_CMD_TIMEOUT	5000
 
 /* NOP OUT retries waiting for NOP IN response */
 #define NOP_OUT_RETRIES    10
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

