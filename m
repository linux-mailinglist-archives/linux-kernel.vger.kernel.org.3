Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE7574F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiGNNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbiGNNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:44:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9452477;
        Thu, 14 Jul 2022 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657806250; x=1689342250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gHdsixsz1auIu7i5568UQTbakjMkD0Fc5TX5GEXk8js=;
  b=bDjfwwaM29YNs7jUwoGItV4pdYvFwVzL+CVKXpZwGymf/PGkpQ2m1lye
   U3sTLOW8ZDZtYYwDQbBiNs/kf2Cx5HmwDd52mwjV1Ll2ODYofwdpOyIpY
   YVZz8Q+Xnzml49/o0M2QnsGs1L4GAwP92dE2LQ2jb7KpR8TKGH8H+cAhu
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 14 Jul 2022 06:44:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:44:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 06:44:08 -0700
Received: from hu-kshivnan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 06:44:06 -0700
From:   Shivnandan Kumar <quic_kshivnan@quicinc.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shivnandan Kumar" <quic_kshivnan@quicinc.com>
Subject: [PATCH v2 1/1] PM: QoS: Add check to make sure CPU freq is non-negative
Date:   Thu, 14 Jul 2022 19:13:42 +0530
Message-ID: <20220714134342.3498384-1-quic_kshivnan@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	CPU frequency should never be negative.
	If some client driver calls freq_qos_update_request with some
	value greater than INT_MAX, then it will set max CPU freq at
	fmax but it will add plist node with some negative priority.
	plist node has priority from INT_MIN (highest) to INT_MAX
	(lowest). Once priority is set as negative, another client
	will not be able to reduce CPU frequency. Adding check to
	make sure CPU freq is non-negative will fix this problem.

Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>

---
v1->v2
	-addressed comments from Rafael
	-changed commit text accordingly

 kernel/power/qos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index ec7e1e85923e..27e6596f287a 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -531,7 +531,7 @@ int freq_qos_add_request(struct freq_constraints *qos,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(qos) || !req)
+	if (IS_ERR_OR_NULL(qos) || !req || value < FREQ_QOS_MIN_DEFAULT_VALUE)
 		return -EINVAL;
 
 	if (WARN(freq_qos_request_active(req),
@@ -563,7 +563,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  */
 int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
 {
-	if (!req)
+	if (!req || new_value < FREQ_QOS_MIN_DEFAULT_VALUE)
 		return -EINVAL;
 
 	if (WARN(!freq_qos_request_active(req),
-- 
2.25.1

