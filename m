Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D187491207
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbiAQW5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:57:36 -0500
Received: from mail.hugovil.com ([162.243.120.170]:47626 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243714AbiAQW5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=lYvTF/25cdLyhwma94gJzi2/3ahZEKEEqHXKbvbNM4w=; b=h
        VtpwJKgX8UDKLEjdziaK3s6P64HJLzen0N33uEA+S7Ol4r9orx8ebOL5faCMwL1GP6VIfeb688j35
        ledL7H/Pv8yZ+vmOLoFpiaQ0lngpiE0T24BXG5oWy2h4juDO42KZb8xZALWxTCbthl0oiYLOA4yNr
        kl1oBK02YIUnzX48=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54812 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1n9awN-0005lm-Fb; Mon, 17 Jan 2022 17:57:32 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jan 2022 17:56:24 -0500
Message-Id: <20220117225625.1252233-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: dimonoff.com]
        * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH] rtc: pcf2127: add error checking and message when disabling POR0
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If PCF2127 device is absent from the I2C bus, or if there is a
communication problem, disabling POR0 may fail silently and we
still continue with probing the device. In that case, abort probe
operation and display an error message.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 81a5b1f2e68c..e6d0838ccfe3 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -690,8 +690,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	 * The "Power-On Reset Override" facility prevents the RTC to do a reset
 	 * after power on. For normal operation the PORO must be disabled.
 	 */
-	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+	ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
 				PCF2127_BIT_CTRL1_POR_OVRD);
+	if (ret < 0) {
+		dev_err(dev, "PORO disabling failed\n");
+		return ret;
+	}
 
 	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CLKOUT, &val);
 	if (ret < 0)
-- 
2.30.2

