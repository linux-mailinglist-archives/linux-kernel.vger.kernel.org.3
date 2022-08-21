Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB859B3C1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiHUM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiHUM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 08:26:22 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9223BEC
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 05:26:19 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout4.routing.net (Postfix) with ESMTP id ED44210056D;
        Sun, 21 Aug 2022 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1661084778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sMFlfeX2aC6HKvCECDsuOs6Q1DactqEaEZuFBtCbb0Y=;
        b=Lsl3RpSxR1yZp6oBr1dPncH6TrrO/TNhABK3gUzPizRxnjkXEXJfI5WG76MOymIg/eorn7
        2LFfo85lR8yIrNZyrPgDEYzZwisnvkbMuiBUgyq/xKaIOJdk0qb2gRk9oVcVJ2uVNkdTIz
        gF145YOaQpOioWoLa3LsEKL2DS9JdHA=
Received: from frank-G5.. (fttx-pool-80.245.78.134.bambit.de [80.245.78.134])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 4639980873;
        Sun, 21 Aug 2022 12:26:17 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [RESEND] rtc: hym8563: try multiple times to init device
Date:   Sun, 21 Aug 2022 14:26:13 +0200
Message-Id: <20220821122613.245026-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: e85dcda5-d8c6-4d98-9a0f-33e88f26627b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Geis <pgwipeout@gmail.com>

RTC sometimes does not respond the first time in init.
Try multiple times to get a response.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
discussion from v1
https://patchwork.kernel.org/project/linux-rockchip/patch/20220608161150.58919-2-linux@fw-web.de/

On Fri, Jul 8, 2022 at 12:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
> FWIW, given that HYM8563 is fairly common on RK3288 boards - I can't say
> I've ever noticed an issue with mine, for instance - it seems dubious
> that this would be a general issue of the chip itself. Are you sure it's
> not a SoC or board-level issue with the I2C bus being in a funny initial
> state, timings being marginal, or suchlike?

Peter Geis <pgwipeout@gmail.com>:
I don't think this is an SoC issue since this is the first instance
I've encountered it. Mind you we don't have the reset lines hooked up
at all for the Rockchip i2c driver, so it's possible that's the case,
but I'd imagine it would be observed more broadly if that was the
case. I've tried pushing the timings out pretty far as well as bumping
up the drive strength to no change. It seems to occur only with the
hym rtc used on this board. I suspect it's a new variant of the hym
that has slightly different behavior.
---
 drivers/rtc/rtc-hym8563.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index cc710d682121..d9d0b6615a07 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/i2c.h>
 #include <linux/bcd.h>
+#include <linux/delay.h>
 #include <linux/rtc.h>
 
 #define HYM8563_CTL1		0x00
@@ -438,10 +439,16 @@ static irqreturn_t hym8563_irq(int irq, void *dev_id)
 
 static int hym8563_init_device(struct i2c_client *client)
 {
-	int ret;
+	int ret, i;
 
 	/* Clear stop flag if present */
-	ret = i2c_smbus_write_byte_data(client, HYM8563_CTL1, 0);
+	for (i = 0; i < 3; i++) {
+		ret = i2c_smbus_write_byte_data(client, HYM8563_CTL1, 0);
+		if (ret == 0)
+			break;
+		msleep(20);
+	}
+
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

