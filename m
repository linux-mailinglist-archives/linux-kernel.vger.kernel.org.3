Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327735A7AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiHaKFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiHaKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:05:24 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D9C99247;
        Wed, 31 Aug 2022 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661940319;
  x=1693476319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XUwffz74uZ7Ute+FLoHNJJSSnt2Skf2zaVZglgR4zyk=;
  b=RH/X2wRVDfLx6fmgYCYmq5djOa1uOrvTwBGOzUsbtS7ASb9MzPhImSpK
   JQlaHUlplR1rdYDVn2y9rxiC5cw1v/jlnQNb1IXr6+f3oY2uhILME0S8U
   9PgZHTLui7FUh/f5MbAa3Vu9jdc/+126ldXh0Wl/p6f8LzzCxJtYQIQNH
   4/Tfhov/KVzml0xQLMxpNxC2Io1/QkZ3ixt7NLBIa8HKfTzooIOLoY7Vh
   s6w/8/XtB8+k+Ors1x7BRV3q3/+brOYp+CYyUp8apBpymwNtpzTFEAtIb
   xWJbc5L9Jk8q3b/usXzN/+9o/tE2i6WuvccTypJA9ny0U3oaoF1UZglwj
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] iio: adc: mcp320x: use conv_time instead of device_index switch
Date:   Wed, 31 Aug 2022 12:05:04 +0200
Message-ID: <20220831100506.3368103-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mcp320x_adc_conversion(), the presence of the chip_info's conv_time
is used as a condition for using the conversion message.  Use that same
condition when initializing the conversion message and the other
handling for variants which need it, instead of the different condition
(checking of the device_index) which is used currently.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/adc/mcp320x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 77fb4522a378..8ed27df9a0bb 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -429,11 +429,7 @@ static int mcp320x_probe(struct spi_device *spi)
 		spi_message_init_with_transfers(&adc->msg, adc->transfer,
 						ARRAY_SIZE(adc->transfer));
 
-	switch (device_index) {
-	case mcp3550_50:
-	case mcp3550_60:
-	case mcp3551:
-	case mcp3553:
+	if (chip_info->conv_time) {
 		/* rx len increases from 24 to 25 bit in SPI mode 0,0 */
 		if (!(spi->mode & SPI_CPOL))
 			adc->transfer[1].len++;
-- 
2.34.1

