Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B24B3CD8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiBMS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:29:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiBMS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:29:19 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FF575F2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:29:12 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JJcSndXIyuvBOJJcSnONU3; Sun, 13 Feb 2022 19:29:11 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 19:29:11 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iio: adc: xilinx-ams: Use devm_delayed_work_autocancel() to simplify code
Date:   Sun, 13 Feb 2022 19:29:05 +0100
Message-Id: <2626e6a057e40cd2271ef0e5f81d12e607bad5b4.1644776929.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_delayed_work_autocancel() instead of hand writing it. This is
less verbose and saves a few lines of code.

devm_delayed_work_autocancel() uses devm_add_action() instead of
devm_add_action_or_reset(). This is fine, because if the underlying memory
allocation fails, no work has been scheduled yet. So there is nothing to
undo.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/adc/xilinx-ams.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 8343c5f74121..6ffddf4038b8 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -12,6 +12,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -1348,11 +1349,6 @@ static void ams_clk_disable_unprepare(void *data)
 	clk_disable_unprepare(data);
 }
 
-static void ams_cancel_delayed_work(void *data)
-{
-	cancel_delayed_work(data);
-}
-
 static int ams_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -1389,9 +1385,8 @@ static int ams_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
-	ret = devm_add_action_or_reset(&pdev->dev, ams_cancel_delayed_work,
-				       &ams->ams_unmask_work);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &ams->ams_unmask_work,
+					   ams_unmask_worker);
 	if (ret < 0)
 		return ret;
 
-- 
2.32.0

