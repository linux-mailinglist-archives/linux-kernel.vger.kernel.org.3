Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29A5592EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiHOMcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHOMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:31:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129656544
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:31:47 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F6QtCv017052;
        Mon, 15 Aug 2022 07:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=3jJJbEOLk9a85ZAnddY3kLGQt7HVvvSjcbc++nxi5dw=;
 b=QcHfyj/jhfrHVbK2jBFqzsp1L7wkn7IMEOvEnQ2jcKKM+SaTFhDs44Z8IOy0yPbEkujz
 Ss4LEuEJNhUrMBTqwoAy094bP1bH8dmkyEV/CNYYoI4HRbgq679+QS3BrbN431iV/qKg
 JuwwGjfXliYtGglL70wF3F5zGZXaD2aI5j9kWbF1CeVUirL+p1Rhv1CfX0jElO2jZ7t0
 boSwVvyLc2ofeKrJS3ZdrQs0zdV5tbFbTVLBHgOzfEBJ9aBcMTn9gBV504Fwn++9XaZx
 d9CLVHD8RWCerc+uEYzuqpjzygFTCwvzw9DzLB3IP3RZdg2C6Tw4RmVgN0b4kY1qrJlt hg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hx9c1t5vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 07:31:40 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 15 Aug
 2022 07:31:38 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Mon, 15 Aug 2022 07:31:38 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4889A477;
        Mon, 15 Aug 2022 12:31:38 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Only report button state if there was a button interrupt
Date:   Mon, 15 Aug 2022 13:31:38 +0100
Message-ID: <20220815123138.3810249-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 26028QheQjMJl6GpH4o4NGv2KXOaQw67
X-Proofpoint-GUID: 26028QheQjMJl6GpH4o4NGv2KXOaQw67
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only report a button state change if the interrupt status shows that
there was a button event.

Previously the code would always drop into the button reporting at the
end of interrupt handling if the jack was present. If neither of the
button report interrupts were pending it would report all buttons
released. This could then lead to a button being reported as released
while it is still pressed.

Fixes: c5b8ee0879bc ("ASoC: cs42l42: Report jack and button detection")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index d545a593a251..daafd4251ce6 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1617,7 +1617,6 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	unsigned int current_plug_status;
 	unsigned int current_button_status;
 	unsigned int i;
-	int report = 0;
 
 	mutex_lock(&cs42l42->irq_lock);
 	if (cs42l42->suspended) {
@@ -1711,13 +1710,15 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 
 			if (current_button_status & CS42L42_M_DETECT_TF_MASK) {
 				dev_dbg(cs42l42->dev, "Button released\n");
-				report = 0;
+				snd_soc_jack_report(cs42l42->jack, 0,
+						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 			} else if (current_button_status & CS42L42_M_DETECT_FT_MASK) {
-				report = cs42l42_handle_button_press(cs42l42);
-
+				snd_soc_jack_report(cs42l42->jack,
+						    cs42l42_handle_button_press(cs42l42),
+						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 			}
-			snd_soc_jack_report(cs42l42->jack, report, SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-								   SND_JACK_BTN_2 | SND_JACK_BTN_3);
 		}
 	}
 
-- 
2.30.2

