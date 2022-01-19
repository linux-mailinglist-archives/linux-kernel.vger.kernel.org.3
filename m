Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179C6493F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356397AbiASR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:27:51 -0500
Received: from mail.hugovil.com ([162.243.120.170]:48990 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356396AbiASR1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=FjYoXQn5cgOEx2kBfibluRCJVVHL6QyDcw2CqgY2fSc=; b=E
        YIO44GJbGigNDklMlRFt1AgnpmDtZaPtZZ9IfVLgE37LaemrH/TK64XCNksjY8Ab8llkDGAFSYE45
        IAiB6MQZnd+hEQD8/9hrQ/T4QfmZv+3xHlfsPh2tlL+EplgNlxSATbDkqzQUoyFvWx854UoqtQmHi
        m6qol7/kx0OL7LUk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54846 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nAEkM-0003wC-DP; Wed, 19 Jan 2022 12:27:47 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jan 2022 12:27:39 -0500
Message-Id: <20220119172740.1856302-1-hugo@hugovil.com>
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
Subject: [PATCH] rtc: pcf2127: add error message if writing to CLKOUT register fails
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If writing to CLKOUT register fails, the probe operation will be aborted
without a meaningful error message.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 3d1f57e54372..823abe2a7147 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -717,8 +717,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
 		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
 				      PCF2127_BIT_CLKOUT_OTPR);
-		if (ret < 0)
+		if (ret < 0) {
+			dev_err(dev, "writing to CLKOUT register failed\n");
 			return ret;
+		}
 
 		msleep(100);
 	}
-- 
2.30.2

