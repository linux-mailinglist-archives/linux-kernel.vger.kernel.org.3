Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061C948A5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbiAKCcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:32:43 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:27021 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244191AbiAKCcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:32:42 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4JXvqY0rrNzMc;
        Tue, 11 Jan 2022 03:32:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1641868361; bh=WKN/FQV7IT3C9XOGXTWW2li26hron8KQagK41I7nUPg=;
        h=Date:From:Subject:To:Cc:From;
        b=JJdeSVBf1alHhHu5M5Yhqr2RFA4nfNOeLRNCmTPh1laPUaTmjG8nJ5tztpqDfJaWc
         ELVkPV+ST41a6Vrxkwab6hWAe/qTDhbBswlMatk1BOFz5AlF0CBzrOr+ichjCzHzFd
         V2zqI8uH6gSxSFWkZW3Jsdj6p6Gw1OFBWcI6CQ9gSEBEQVPnZ52sRnwrivE3V3W/OK
         vCAKkUnTNYe2SMudYYuVYboPYKfSy4KxuIg0/WVQPdtTaVhpFdH/M3WLwotR48xzSn
         zjCSdAyksafFG+BjGf5BYa1ZQ/cahQoca4Rrfhk541DS3Bx9gQoeo589syBbjDLtUz
         e8IxAnOTAKq4g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.4 at mail
Date:   Tue, 11 Jan 2022 03:32:40 +0100
Message-Id: <680a4c737950f59e787f64887402e3ae247e89dd.1641868274.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] power: supply: ltc2941: simplify Qlsb calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace two divisions with a subtraction+shift for a small code size
improvement and less brackets.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 09f3e78af4e0..c0cbf4cd59ee 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -490,13 +490,13 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	if (info->id == LTC2943_ID) {
 		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)
 			prescaler_exp = LTC2943_MAX_PRESCALER_EXP;
-		info->Qlsb = ((340 * 50000) / r_sense) /
-				(4096 / (1 << (2*prescaler_exp)));
+		info->Qlsb = ((340 * 50000) / r_sense) >>
+			     (12 - 2*prescaler_exp);
 	} else {
 		if (prescaler_exp > LTC2941_MAX_PRESCALER_EXP)
 			prescaler_exp = LTC2941_MAX_PRESCALER_EXP;
-		info->Qlsb = ((85 * 50000) / r_sense) /
-				(128 / (1 << prescaler_exp));
+		info->Qlsb = ((85 * 50000) / r_sense) >>
+			     (7 - prescaler_exp);
 	}
 
 	/* Read status register to check for LTC2942 */
-- 
2.30.2

