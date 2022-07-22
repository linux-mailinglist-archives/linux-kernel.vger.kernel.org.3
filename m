Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815F57DF23
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiGVJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiGVJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:50:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C79D1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:49:01 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M5Vgns024448;
        Fri, 22 Jul 2022 04:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=RqguWUk1rJeah6sayFgpV4hCcMGCEveOejOkfdvaauI=;
 b=WXJYmOr26IMQ/c/8qoDhCKkRgnDcdsn0o3x0IWMIEW2bwOfsP6KBm5a/Fr5+F905Hb88
 udC2qq4EStnbvpYh4+JP8Php7wcMbTmPxdrnGWhU4mEmujfRKB2QPtWRg9h09bw/0Fkg
 jVMuQeDwDuBuHoQDKsX4GOoDzHlJw0lO0/zUZQ+5NMW3QzeaDVtVpRU36JHeZYmHWDPx
 lmey11RTpKGeOGBemc5Mj8x4ejqAx9U4DhNU3zBZHdn+HkovXaoXesnJL5iztxhVbUJ0
 W1UNzZ07g1rH/LlqLj3EvJhzNMtBiI2t5hATG/kdDfF0i3UioDwPwHtEFsLQgvOaHh3A 4w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hdrqfm7mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 04:48:53 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 22 Jul
 2022 04:48:51 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Fri, 22 Jul 2022 04:48:51 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9BC8146B;
        Fri, 22 Jul 2022 09:48:51 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] firmware: cs_dsp: Add pre_stop callback
Date:   Fri, 22 Jul 2022 10:48:50 +0100
Message-ID: <20220722094851.92521-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0IoHYEQNb1QF9zb0f0-Z1f0CO81vWuai
X-Proofpoint-GUID: 0IoHYEQNb1QF9zb0f0-Z1f0CO81vWuai
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code already has a post_stop callback, add a matching pre_stop
callback to the client_ops that is called before execution is stopped.
This callback provides a convenient place for the client code to
communicate with the DSP before it is stopped.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c       | 3 +++
 include/linux/firmware/cirrus/cs_dsp.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 7dad6f57d9704..b402f841d72cf 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -2725,6 +2725,9 @@ void cs_dsp_stop(struct cs_dsp *dsp)
 
 	mutex_lock(&dsp->pwr_lock);
 
+	if (dsp->client_ops->pre_stop)
+		dsp->client_ops->pre_stop(dsp);
+
 	dsp->running = false;
 
 	if (dsp->ops->stop_core)
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 30055706cce21..6ab230218df0e 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -189,7 +189,8 @@ struct cs_dsp {
  * @control_remove:	Called under the pwr_lock when a control is destroyed
  * @pre_run:		Called under the pwr_lock by cs_dsp_run() before the core is started
  * @post_run:		Called under the pwr_lock by cs_dsp_run() after the core is started
- * @post_stop:		Called under the pwr_lock by cs_dsp_stop()
+ * @pre_stop:		Called under the pwr_lock by cs_dsp_stop() before the core is stopped
+ * @post_stop:		Called under the pwr_lock by cs_dsp_stop() after the core is stopped
  * @watchdog_expired:	Called when a watchdog expiry is detected
  *
  * These callbacks give the cs_dsp client an opportunity to respond to events
@@ -200,6 +201,7 @@ struct cs_dsp_client_ops {
 	void (*control_remove)(struct cs_dsp_coeff_ctl *ctl);
 	int (*pre_run)(struct cs_dsp *dsp);
 	int (*post_run)(struct cs_dsp *dsp);
+	void (*pre_stop)(struct cs_dsp *dsp);
 	void (*post_stop)(struct cs_dsp *dsp);
 	void (*watchdog_expired)(struct cs_dsp *dsp);
 };
-- 
2.30.2

