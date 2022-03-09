Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B247E4D35EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiCIQiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiCIQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:12 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F30DE2D4;
        Wed,  9 Mar 2022 08:23:37 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 96AE41C0008;
        Wed,  9 Mar 2022 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBRIeLyR/4fuJk7gsuq+GGFfhXePuyoJiqkqDqgc92I=;
        b=PSt5q9XqkeLaILnZL/FbR+oGsJmMBzNQm2ELPayUQLyMANYfWZgGk7F4UMNJNo9R4T1KOf
        2BmfDvETD2wgqTzG6/13VDpXtJJjutXlNIGTxDsj89iQ5aC3Ba9AVyZW0ISZuCUcvFfNEE
        4gbav8vpeo+rLMpMiXBVqTxELXFh2bGzdqt1yBa/g8PIa0TW+j6C9mQyXZR5DftlIkuoMr
        2Dxj8HgdWQV6Jf1SSXWikylz9HQLVd7dsA5UiEu2OHOpizzz6y8b+ZFq9+oldRvMcz+lgw
        7Gt+hH18ARRsH0979LIRwXyCpDz5wBarneFUorE/nPvDAwNLeo353tsRBdTUtw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/29] rtc: add new RTC_FEATURE_ALARM_WAKEUP_ONLY feature
Date:   Wed,  9 Mar 2022 17:22:53 +0100
Message-Id: <20220309162301.61679-22-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RTCs have an IRQ pin that is not connected to a CPU interrupt but
rather directly to a PMIC or power supply. In that case, it is still useful
to be able to set alarms but we shouldn't expect interrupts.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 include/uapi/linux/rtc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index 03e5b776e597..97aca4503a6a 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -133,7 +133,8 @@ struct rtc_param {
 #define RTC_FEATURE_UPDATE_INTERRUPT	4
 #define RTC_FEATURE_CORRECTION		5
 #define RTC_FEATURE_BACKUP_SWITCH_MODE	6
-#define RTC_FEATURE_CNT			7
+#define RTC_FEATURE_ALARM_WAKEUP_ONLY	7
+#define RTC_FEATURE_CNT			8
 
 /* parameter list */
 #define RTC_PARAM_FEATURES		0
-- 
2.35.1

