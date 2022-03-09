Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593774D35CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiCIQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbiCIQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:30 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D4150400;
        Wed,  9 Mar 2022 08:23:57 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 790731BF20A;
        Wed,  9 Mar 2022 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C6FB6jhgDsl5acxT2klDaDicyoea6PWDZxx1o8S4oU=;
        b=cwbnSDJenHY3cCJNJzpk4h5KZESvbQZkXsQo1tjsM4mUFX0U2NfPC0C6uV8LC113OBFjMI
        nHAfpMIXLR+vj4H0PH5SP2EU3/2ue6/QWM8VZbg0G9pVqcKAw/UCsb4Mmh0i3b+enaLbxm
        IGjPzYFNvKW498S+6JS+Dyj+gGaJ84ZssFXF5BevLeak/ye2FYkgcohuFpqWRZ09dZwlkL
        h5UxBGq8C5puxCf7hyZqhX3M5dUpE5sXdCE7LXqVkF0yAP+iq+sdv65GrHC1eoVWSFxoKQ
        sBzMN+Y3RkqBqSe/dmtParmCYfZfcKjqZv0RU3aWmMge9H4NNJdkCmolMTTVcw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/29] rtc: remove uie_unsupported
Date:   Wed,  9 Mar 2022 17:23:00 +0100
Message-Id: <20220309162301.61679-29-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uie_unsupported is not used by any drivers anymore, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c | 3 ---
 include/linux/rtc.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 40d504dac1a9..3c8eec2218df 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -399,9 +399,6 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 	if (!rtc->ops->set_alarm)
 		clear_bit(RTC_FEATURE_ALARM, rtc->features);
 
-	if (rtc->uie_unsupported)
-		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
-
 	if (rtc->ops->set_offset)
 		set_bit(RTC_FEATURE_CORRECTION, rtc->features);
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 47fd1c2d3a57..1fd9c6a21ebe 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -110,8 +110,6 @@ struct rtc_device {
 	struct hrtimer pie_timer; /* sub second exp, so needs hrtimer */
 	int pie_enabled;
 	struct work_struct irqwork;
-	/* Some hardware can't support UIE mode */
-	int uie_unsupported;
 
 	/*
 	 * This offset specifies the update timing of the RTC.
-- 
2.35.1

