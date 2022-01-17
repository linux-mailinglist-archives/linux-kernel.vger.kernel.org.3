Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F1491209
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbiAQW5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:57:54 -0500
Received: from mail.hugovil.com ([162.243.120.170]:47636 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiAQW5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=eRfcHBnhbwqYtyrduiwv+S9EIycAIao9n4R5EcS/cbY=; b=p
        PXEnO348HBcs1W+V1mU/az3PRaAD035nCmCDeex0q0MnxjhzWa1h89L6Peu8HdxeQo5ovMVlGOn1I
        ZH/cKbvYwbBTq0AHWa6HIkZ/KPrzIwF3FRd3lgeRvi3haj/Ozwi2ifp4y8Vb2cfcIH2IXEfn/RWS9
        DFJE9PgKrk6w/4tE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54814 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1n9awg-0005m9-1n; Mon, 17 Jan 2022 17:57:50 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jan 2022 17:57:42 -0500
Message-Id: <20220117225742.1252362-1-hugo@hugovil.com>
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
Subject: [PATCH] rtc: pcf2127: use IRQ flags obtained from device tree if available
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If the interrupt pin of the PCF2127 is routed to the input of a GPIO
expander using the pca953x driver, the later will only accept an IRQ
of type IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_RISING, and the IRQ
request will fail.

Therefore, allow the IRQ type to be passed from the device tree data
if available.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index e6d0838ccfe3..cea10fdbb010 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -659,9 +659,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
 
 	if (alarm_irq > 0) {
+		unsigned long flags;
+
+		/*
+		 * If flags = 0, devm_request_threaded_irq() will use IRQ flags
+		 * obtained from device tree.
+		 */
+		if (dev_fwnode(dev))
+			flags = 0;
+		else
+			flags = IRQF_TRIGGER_LOW;
+
 		ret = devm_request_threaded_irq(dev, alarm_irq, NULL,
 						pcf2127_rtc_irq,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						flags | IRQF_ONESHOT,
 						dev_name(dev), dev);
 		if (ret) {
 			dev_err(dev, "failed to request alarm irq\n");
-- 
2.30.2

