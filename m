Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37DE576143
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiGOM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGOM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:27:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F487820C2;
        Fri, 15 Jul 2022 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657888021; x=1689424021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9PzAlK3XwGr2L3CaJM9u4+5spJ/TFu+eRcQmE0ngfMc=;
  b=ri0utD3vBK7XltfRMdNdHU93QoviRT+gD8aZjwX627ETx+7rOtxk41qE
   aEI3oVu+zrkPv7wWkZrv644BUb18Z+WHgW4TDSag5NUHbXObzhfqMpKAf
   ymHYXoz4MlGFu+kOdQWihgeT84aZAE8fv6XEf+TwCVTEZDJgdo6VaZgtw
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Jul 2022 05:27:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 05:27:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 05:26:20 -0700
Received: from hu-kshivnan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 05:26:17 -0700
From:   Shivnandan Kumar <quic_kshivnan@quicinc.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shivnandan Kumar" <quic_kshivnan@quicinc.com>
Subject: [PATCH v4]PM: QoS: Add check to make sure CPU freq is non-negative
Date:   Fri, 15 Jul 2022 17:55:39 +0530
Message-ID: <20220715122539.3978614-1-quic_kshivnan@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	CPU frequency should never be negative.
	If some client driver calls freq_qos_update_request with
	negative value which will be very high in absolute terms,
	then qos driver sets max CPU freq at fmax as it considers
	it's absolute value but it will add plist node with negative
	priority. plist node has priority from INT_MIN (highest)
	to INT_MAX(lowest). Once priority is set as negative,
	another client will not be able to reduce CPU frequency.
	Adding check to make sure CPU freq is non-negative will
	fix this problem.

Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
---
v3->v4
	-used 0 instead of FREQ_QOS_MIN_DEFAULT_VALUE
v2->v3 
	-changed commit text
v1->v2
	-addressed comments from Rafael
	-changed commit text accordingly
 kernel/power/qos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index ec7e1e85923e..af51ed6d45ef 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -531,7 +531,7 @@ int freq_qos_add_request(struct freq_constraints *qos,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(qos) || !req)
+	if (IS_ERR_OR_NULL(qos) || !req || value < 0)
 		return -EINVAL;
 
 	if (WARN(freq_qos_request_active(req),
@@ -563,7 +563,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  */
 int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
 {
-	if (!req)
+	if (!req || new_value < 0)
 		return -EINVAL;
 
 	if (WARN(!freq_qos_request_active(req),
-- 
2.25.1

