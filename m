Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EB04953A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiATR4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:56:09 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:63454 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233073AbiATR4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:56:05 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K5IpA2022340;
        Thu, 20 Jan 2022 11:55:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=qpxI/iRkVYhxItmhbuo5ZUu8r1IM5OGMC1OqPFE0SUg=;
 b=oIYqgyNR2pSLbtOG1InBf8rnDntxQspE5Vs0mklFi9F4/JNuJ2in72mogsdbfFeapqPI
 /w3PMmNfFIhzxrXdcZgusgT4gCmG5w853Qi0aIWI3sFI3VZNThh/SGgtK17oK+fnTgWI
 S/xH3HkpjEt5VetJ5ww0czMNElAJvzJpicQjpOzZ2LOTHqmeUq8xvNgiw9mcOXTandJH
 lVjGq0fN2F6qnDE9b8YQha2sKBNztVJgd8NDDb+PIihqfR724gbPYCbLm2ZEd6UtSzrS
 GhPStYIo4auzQtyfi9AgOxXVhY5MieCxh1venND3XqHDb1gbnas5PbQWCxXESjESfR16 5g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dpms0hh17-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jan 2022 11:55:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:55:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 17:55:54 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.33])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D954DB13;
        Thu, 20 Jan 2022 17:55:53 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: cs42l42: Change jack_detect_mutex to a lock of all IRQ handling
Date:   Thu, 20 Jan 2022 17:55:48 +0000
Message-ID: <20220120175549.671831-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120175549.671831-1-rf@opensource.cirrus.com>
References: <20220120175549.671831-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Tb1h8vlk67feNATXvhenmQCl6xSRGZpJ
X-Proofpoint-GUID: Tb1h8vlk67feNATXvhenmQCl6xSRGZpJ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename jack_detect_mutex to irq_lock and make it lock the entire IRQ
handling.

The jack_detect_mutex was introduced to synchronize registering an
ALSA jack handler, via cs42l42_set_jack(), with the jack state
processing in the IRQ handler, and was taken only around the
relevant part of the IRQ handling code.

System suspend will need to synchronize with the IRQ handler thread
so will need a similar mutex that surrounds all of the IRQ handling.
Repurposing the existing jack_detect_mutex is the simplest option.
It does no harm for a call to cs42l42_set_jack() to additionally
block the first few lines of IRQ handling, and the only interrupts
used by the driver are all for jack handling.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 11 +++++------
 sound/soc/codecs/cs42l42.h |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2c294868008e..f1b95d45af4a 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -550,7 +550,7 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 
 	/* Prevent race with interrupt handler */
-	mutex_lock(&cs42l42->jack_detect_mutex);
+	mutex_lock(&cs42l42->irq_lock);
 	cs42l42->jack = jk;
 
 	if (jk) {
@@ -566,7 +566,7 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 			break;
 		}
 	}
-	mutex_unlock(&cs42l42->jack_detect_mutex);
+	mutex_unlock(&cs42l42->irq_lock);
 
 	return 0;
 }
@@ -1613,6 +1613,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	unsigned int i;
 	int report = 0;
 
+	mutex_lock(&cs42l42->irq_lock);
 
 	/* Read sticky registers to clear interurpt */
 	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
@@ -1635,8 +1636,6 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 		CS42L42_M_DETECT_FT_MASK |
 		CS42L42_M_HSBIAS_HIZ_MASK);
 
-	mutex_lock(&cs42l42->jack_detect_mutex);
-
 	/*
 	 * Check auto-detect status. Don't assume a previous unplug event has
 	 * cleared the flags. If the jack is unplugged and plugged during
@@ -1713,7 +1712,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 		}
 	}
 
-	mutex_unlock(&cs42l42->jack_detect_mutex);
+	mutex_unlock(&cs42l42->irq_lock);
 
 	return IRQ_HANDLED;
 }
@@ -2062,7 +2061,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 
 	cs42l42->dev = &i2c_client->dev;
 	i2c_set_clientdata(i2c_client, cs42l42);
-	mutex_init(&cs42l42->jack_detect_mutex);
+	mutex_init(&cs42l42->irq_lock);
 
 	cs42l42->regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
 	if (IS_ERR(cs42l42->regmap)) {
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 9fff183dce8e..53d96287abba 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -842,7 +842,7 @@ struct  cs42l42_private {
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
-	struct mutex jack_detect_mutex;
+	struct mutex irq_lock;
 	int pll_config;
 	int bclk;
 	u32 sclk;
-- 
2.11.0

