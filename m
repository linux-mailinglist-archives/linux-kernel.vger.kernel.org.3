Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879CC596D38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbiHQK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbiHQK50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:57:26 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56439647E8;
        Wed, 17 Aug 2022 03:57:25 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id 9002B200009;
        Wed, 17 Aug 2022 10:57:22 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 4/4] input: joystick: Fix buffer data parsing
Date:   Wed, 17 Aug 2022 12:56:43 +0200
Message-Id: <20220817105643.95710-5-contact@artur-rojek.eu>
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

Don't try to access buffer data of a channel by its scan index. Instead,
use the newly introduced `iio_find_channel_offset_in_buffer` to get the
correct data offset.

The scan index of a channel does not represent its position in a buffer,
as the buffer will contain data for enabled channels only, affecting
data offsets and alignment.

Fixes: 2c2b364fddd5 ("Input: joystick - add ADC attached joystick driver.")
Reported-by: Chris Morgan <macromorgan@hotmail.com>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/input/joystick/adc-joystick.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index c0deff5d4282..aed853ebe1d1 100644
--- a/drivers/input/joystick/adc-joystick.c
+++ b/drivers/input/joystick/adc-joystick.c
@@ -6,6 +6,7 @@
 #include <linux/ctype.h>
 #include <linux/input.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -46,36 +47,43 @@ static void adc_joystick_poll(struct input_dev *input)
 static int adc_joystick_handle(const void *data, void *private)
 {
 	struct adc_joystick *joy = private;
+	struct iio_buffer *buffer;
 	enum iio_endian endianness;
-	int bytes, msb, val, idx, i;
-	const u16 *data_u16;
+	int bytes, msb, val, off;
+	const u8 *chan_data;
+	unsigned int i;
 	bool sign;
 
 	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
 
 	for (i = 0; i < joy->num_chans; ++i) {
-		idx = joy->chans[i].channel->scan_index;
 		endianness = joy->chans[i].channel->scan_type.endianness;
 		msb = joy->chans[i].channel->scan_type.realbits - 1;
 		sign = tolower(joy->chans[i].channel->scan_type.sign) == 's';
+		buffer = iio_channel_cb_get_iio_buffer(joy->buffer);
+		off = iio_find_channel_offset_in_buffer(joy->chans[i].indio_dev,
+							joy->chans[i].channel,
+							buffer);
+		if (off < 0)
+			return off;
+
+		chan_data = (const u8 *)data + off;
 
 		switch (bytes) {
 		case 1:
-			val = ((const u8 *)data)[idx];
+			val = *chan_data;
 			break;
 		case 2:
-			data_u16 = (const u16 *)data + idx;
-
 			/*
 			 * Data is aligned to the sample size by IIO core.
 			 * Call `get_unaligned_xe16` to hide type casting.
 			 */
 			if (endianness == IIO_BE)
-				val = get_unaligned_be16(data_u16);
+				val = get_unaligned_be16(chan_data);
 			else if (endianness == IIO_LE)
-				val = get_unaligned_le16(data_u16);
+				val = get_unaligned_le16(chan_data);
 			else /* IIO_CPU */
-				val = *data_u16;
+				val = *(const u16 *)chan_data;
 			break;
 		default:
 			return -EINVAL;
-- 
2.37.2

