Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D7C55734A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiFWGrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiFWGrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:47:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A054475E;
        Wed, 22 Jun 2022 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655966840; x=1687502840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4mo3Auz6NZMqFD1nkIrxnbi027ADaGF0eOPOXEV96Jw=;
  b=mqwZm5whutlnASAClUEZn7qFlNg9nHJhBbYrFp7Z5AZ1mUPkcVSmhGCa
   3MvVrCCOdg51x1cO/7JBjl50oH4LRG0MPwZmu/itTBlwHgB+9ibEMO8Zv
   gdgfxspE3xNfCPpKFP5v2ETbEBgXSz1QmO6fnH3a3n37V80pq/5cisKEl
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 22 Jun 2022 23:47:20 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Jun 2022 23:47:18 -0700
X-QCInternal: smtphost
Received: from hu-kshivnan-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.107.231])
  by ironmsg02-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Jun 2022 12:17:09 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 427426)
        id 8F08D21D7F; Thu, 23 Jun 2022 12:17:08 +0530 (+0530)
From:   Shivnandan Kumar <quic_kshivnan@quicinc.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
Subject: [PATCH]     PM: QoS: Add check to make sure CPU freq is non-negative
Date:   Thu, 23 Jun 2022 12:16:05 +0530
Message-Id: <20220623064605.2538969-1-quic_kshivnan@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	CPU frequency should never be non-negative.
	If some client driver calls freq_qos_update_request with some
	value greater than INT_MAX, then it will set max CPU freq at
	fmax but it will add plist node with some negative priority.
	plist node has priority from INT_MIN (highest) to INT_MAX
	(lowest). Once priority is set as negative, another client
	will not be able to reduce max CPU frequency. Adding check
	to make sure CPU freq is non-negative will fix this problem.
Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>

---
 kernel/power/qos.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index ec7e1e85923e..41e96fe34bfd 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -531,7 +531,8 @@ int freq_qos_add_request(struct freq_constraints *qos,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(qos) || !req)
+	if (IS_ERR_OR_NULL(qos) || !req || value < FREQ_QOS_MIN_DEFAULT_VALUE
+		|| value > FREQ_QOS_MAX_DEFAULT_VALUE)
 		return -EINVAL;
 
 	if (WARN(freq_qos_request_active(req),
@@ -563,7 +564,8 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  */
 int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
 {
-	if (!req)
+	if (!req || new_value < FREQ_QOS_MIN_DEFAULT_VALUE ||
+		new_value > FREQ_QOS_MAX_DEFAULT_VALUE)
 		return -EINVAL;
 
 	if (WARN(!freq_qos_request_active(req),
-- 
2.25.1

