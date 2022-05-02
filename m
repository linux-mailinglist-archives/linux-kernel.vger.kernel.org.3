Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485E516E56
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384632AbiEBKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384592AbiEBKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:49:02 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58013D02;
        Mon,  2 May 2022 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651488333; x=1683024333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6iHGRSOgrWXi0lQ9VNy7cHosK8o01EFmqWMART4qQrI=;
  b=ll2ABofMad8pYBHtFeiIGD5ASJ7A6qz93HZQky0+yCRPL2OU5R/T0FqN
   yQ7S+4w2t+b/Cg6mcNVDkClhh59YToA0RVnKuhHGxFbWdgj4CDi/sCbbM
   0/aP6PYYLTfItjJkn02qMk5UOLWbv+F9p6Do+lo/W0ElPnwIE4wNEQpAL
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 03:45:33 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 03:45:31 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 16:15:20 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 38FAD3D9A; Mon,  2 May 2022 16:15:19 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 2/2] tty: serial: qcom_geni_serial: Disable MMIO tracing
Date:   Mon,  2 May 2022 16:15:14 +0530
Message-Id: <1651488314-19382-3-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651488314-19382-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1651488314-19382-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register read/write tracing is causing excessive
logging and filling the rtb buffer and effecting
performance.

Disabled MMIO tracing to disable register
read/write tracing.

Signed-off-by: Visweswara Tanuku <quic_vtanuku@quicinc.com>
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f496102..aa8facb 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1,5 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+/*
+ * Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* Disable MMIO tracing */
+#define __DISABLE_TRACE_MMIO__
 
 #include <linux/clk.h>
 #include <linux/console.h>
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

