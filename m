Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EAF5844FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiG1RbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1Ra5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:30:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892276FA14;
        Thu, 28 Jul 2022 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659029456; x=1690565456;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=XNFj4plBTLrQLTuoVPA2R4SqV2ybwrCgihjL8EFDQpU=;
  b=eK5QwNNkUD2+LrMxE6i2lKt/FaPqOcj14cDj4hR+P2+8Xp54wKxEsUUr
   i9shkKlnPNot40DZsQNK2X0Pt4Fw/ljnUtK60gcm/vIVebyBQQAOpimY4
   jr7HWHih96bWQ+DOsJInJrpALfLTxJ36Vl9l3kzaIeUEbWaeyZISyLFPZ
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jul 2022 10:30:56 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 10:30:56 -0700
Received: from hu-cchinnad-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Jul 2022 10:30:53 -0700
From:   Chetan C R <quic_cchinnad@quicinc.com>
To:     <bvanassche@acm.org>
CC:     <jejb@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Chetan C R <quic_cchinnad@quicinc.com>
Subject: [PATCH V2] scsi: ufs: Get boot device storage type from command line
Date:   Thu, 28 Jul 2022 23:00:41 +0530
Message-ID: <1659029442-19135-1-git-send-email-quic_cchinnad@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
 - Made UFS_QCOM_CMDLINE as default 'Y' to get __setup()

Get the boot device storage type by reading it from
kernel command line arguments and export the same
information to ufs modules.

Chetan C R (1):
  scsi: ufs: Get boot device storage type from command line

 drivers/ufs/host/Kconfig       | 10 ++++++++
 drivers/ufs/host/Makefile      |  1 +
 drivers/ufs/host/ufs-cmdline.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/ufs/host/ufs-cmdline.c

-- 
2.7.4

