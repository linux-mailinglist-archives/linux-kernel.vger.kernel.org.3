Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E444485940
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiAETey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:34:54 -0500
Received: from mail.hugovil.com ([162.243.120.170]:38876 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiAETex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=f+UuEnMxTVqpzxOb1LP/W65bh42k1E6+C/VjtXgdTb4=; b=g
        LxFSZAbAXh4UjCu1ynYXRRD356LT1OfPMbTt2gZsrw1m/gS6M3wJwj/IGP9pVOOLKZtRed0B8He+1
        KowIYj2z/h4kJHLrxIMt2pvqjSZ7DsE/3mx4eCi8Cpjv5VtS18Gv+gIAuEpXUL7KPWX+RiFnOobjv
        w69mjzAN2A6p40tQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53874 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1n5C3c-0001ym-Mm; Wed, 05 Jan 2022 14:34:49 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed,  5 Jan 2022 14:34:39 -0500
Message-Id: <20220105193440.151359-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: dimonoff.com]
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH] rtc: isl1208: avoid unnecessary rc variable tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The rc variable doesn't need to be tested a second time when the <if> block
evaluates to false.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-isl1208.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 182dfa605515..c7f04df5a0b6 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -880,15 +880,17 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (rc)
 		return rc;
 
-	if (client->irq > 0)
+	if (client->irq > 0) {
 		rc = isl1208_setup_irq(client, client->irq);
-	if (rc)
-		return rc;
+		if (rc)
+			return rc;
+	}
 
-	if (evdet_irq > 0 && evdet_irq != client->irq)
+	if (evdet_irq > 0 && evdet_irq != client->irq) {
 		rc = isl1208_setup_irq(client, evdet_irq);
-	if (rc)
-		return rc;
+		if (rc)
+			return rc;
+	}
 
 	rc = devm_rtc_nvmem_register(isl1208->rtc, &isl1208->nvmem_config);
 	if (rc)
-- 
2.30.2

