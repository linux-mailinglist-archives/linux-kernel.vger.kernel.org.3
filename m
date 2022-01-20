Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8D549539F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiATR4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:56:07 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47728 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233072AbiATR4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:56:05 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K5IpA1022340;
        Thu, 20 Jan 2022 11:55:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=/5EEVxedqyc4lS3w9/oKz7sNBu3Ep8/TONL9EDmsebU=;
 b=LaO+BOC8DgmKHsw0DabB9ReCkuJ1l9E+aL43q8qnIDry7TxQ2aN46EMBu8AEYfoZOROf
 pwEUCC4W9STP68Hk4jaPuDEwyW89q/Eqga/D3wTdUh4yBaZ74Fiog0oorxfNC/mjLJDP
 w6faTs/w/MIT53USD9eILlK421aeYUOUMK1PthNPsu05Q4GOVOcfZ77iLlliSmM751jn
 571Of9i3mga253ab3VUV3Lm8BK4c15/TqG4xKKn/RGXOq9gwbY5IRJdLdf9iToBVjvoG
 FmBzsB+hu7/eYOs/TV2+RdOk/DBW9gjSTpYDX9gOYEyfg7HmSLfy8nWO5+S1cIkkGWhk ZA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dpms0hh17-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jan 2022 11:55:58 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:55:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 17:55:53 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.33])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 83FD946D;
        Thu, 20 Jan 2022 17:55:53 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/3] ASoC: cs42l42: Report full jack status when plug is detected
Date:   Thu, 20 Jan 2022 17:55:47 +0000
Message-ID: <20220120175549.671831-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120175549.671831-1-rf@opensource.cirrus.com>
References: <20220120175549.671831-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AxmdCqB-YQ3vszAcLXuXqLZGPDmSFNFW
X-Proofpoint-GUID: AxmdCqB-YQ3vszAcLXuXqLZGPDmSFNFW
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a plug event is detect report the full state of all status
bits, don't assume that there will have been a previous unplug
event to clear all the bits. Report the state of both HEADPHONE
and MICROPHONE bits according to detected type, and clear all the
button status bits. The current button status is already checked
and reported at the end of the function.

During a system suspend the jack could be unplugged and plugged,
possibly changing the jack type. On resume the interrupt status will
indicate a plug event - there will not be an unplug event to clear
the bits.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 43d98bdb5b5b..2c294868008e 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1637,7 +1637,11 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 
 	mutex_lock(&cs42l42->jack_detect_mutex);
 
-	/* Check auto-detect status */
+	/*
+	 * Check auto-detect status. Don't assume a previous unplug event has
+	 * cleared the flags. If the jack is unplugged and plugged during
+	 * system suspend there won't have been an unplug event.
+	 */
 	if ((~masks[5]) & irq_params_table[5].mask) {
 		if (stickies[5] & CS42L42_HSDET_AUTO_DONE_MASK) {
 			cs42l42_process_hs_type_detect(cs42l42);
@@ -1645,11 +1649,15 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 			case CS42L42_PLUG_CTIA:
 			case CS42L42_PLUG_OMTP:
 				snd_soc_jack_report(cs42l42->jack, SND_JACK_HEADSET,
-						    SND_JACK_HEADSET);
+						    SND_JACK_HEADSET |
+						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 				break;
 			case CS42L42_PLUG_HEADPHONE:
 				snd_soc_jack_report(cs42l42->jack, SND_JACK_HEADPHONE,
-						    SND_JACK_HEADPHONE);
+						    SND_JACK_HEADSET |
+						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 				break;
 			default:
 				break;
-- 
2.11.0

