Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD14519E0A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbiEDLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348824AbiEDLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:33:18 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B62BB38;
        Wed,  4 May 2022 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651663783; x=1683199783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WMfrbW6aHjrx/MqUK3KUM6mipCuetkL4KAFC6OrnsvM=;
  b=Ap1PZZlbuV2+3dpL6YNsD871umm5NbWYeSE3uRREOVWBbAK3tOUwBCfh
   kFLfXwyg9hsMZ2Gq4qE4JIEs4yAvY82afO0lTyCVhWWKCbeIFuBI7MqCj
   i1ru6IVPKkxof1yWZbdSseAPNICr3oF8EP57r1iqKtm31X5/VazwE/RvV
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 04 May 2022 04:29:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 04:29:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 04:29:41 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 04:29:37 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     <arnd@arndb.de>, <catalin.marinas@arm.com>, <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>
Subject: [PATCHv14 9/9] soc: qcom: geni: Disable MMIO tracing for GENI SE
Date:   Wed, 4 May 2022 16:58:28 +0530
Message-ID: <e4e2522c6626e8ecdd3a3ce6d0ac85aba41fae38.1651663123.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1651663123.git.quic_saipraka@quicinc.com>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable MMIO tracing for GENI SE driver to prevent excessive
logging. Any access over serial console would involve a lot of
TX and RX register accesses (and few others), so these MMIO
read/write trace events in these drivers cause a lot of unwanted
noise because of the high frequency of such operations and it is
not very useful tracing these events for such drivers.
Given we want to enable these trace events on development devices
(maybe not production devices) where performance also really
matters so that we don't regress other components by wasting CPU
cycles and memory collecting these traces, it makes more sense to
disable these  traces from such drivers.

Also another reason to disable these traces would be to prevent
recursive tracing when we display the trace buffer containing
these MMIO trace events since writing onto serial console would
further record MMIO traces.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 28a8c0dda66c..a0ceeede450f 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
 
+/* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
+#define __DISABLE_TRACE_MMIO__
+
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
-- 
2.33.1

