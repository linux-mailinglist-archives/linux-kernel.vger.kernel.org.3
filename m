Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5435596D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiHQK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiHQK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:57:21 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A657786E7;
        Wed, 17 Aug 2022 03:57:19 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id 35646200004;
        Wed, 17 Aug 2022 10:57:17 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 1/4] iio/adc: ingenic: fix channel offsets in buffer
Date:   Wed, 17 Aug 2022 12:56:40 +0200
Message-Id: <20220817105643.95710-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817105643.95710-1-contact@artur-rojek.eu>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consumers expect the buffer to only contain enabled channels. While
preparing the buffer, the driver also (incorrectly) inserts empty data
for disabled channels, causing the enabled channels to appear at wrong
offsets. Fix that.

Fixes: b96952f498db ("IIO: Ingenic JZ47xx: Add touchscreen mode.")
Tested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/iio/adc/ingenic-adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index a7325dbbb99a..5a932c375a89 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -804,11 +804,10 @@ static irqreturn_t ingenic_adc_irq(int irq, void *data)
 	unsigned int i;
 	u32 tdat[3];
 
-	for (i = 0; i < ARRAY_SIZE(tdat); mask >>= 2, i++) {
+	memset(tdat, 0, ARRAY_SIZE(tdat));
+	for (i = 0; mask && i < ARRAY_SIZE(tdat); mask >>= 2) {
 		if (mask & 0x3)
-			tdat[i] = readl(adc->base + JZ_ADC_REG_ADTCH);
-		else
-			tdat[i] = 0;
+			tdat[i++] = readl(adc->base + JZ_ADC_REG_ADTCH);
 	}
 
 	iio_push_to_buffers(iio_dev, tdat);
-- 
2.37.2

