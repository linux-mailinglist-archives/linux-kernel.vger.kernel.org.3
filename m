Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F83596D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiHQK5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbiHQK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:57:24 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E1773908;
        Wed, 17 Aug 2022 03:57:23 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id AC28820000E;
        Wed, 17 Aug 2022 10:57:20 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 3/4] iio: add helper function for reading channel offset in buffer
Date:   Wed, 17 Aug 2022 12:56:42 +0200
Message-Id: <20220817105643.95710-4-contact@artur-rojek.eu>
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

This is useful for consumers that wish to parse raw buffer data.

Tested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/iio/industrialio-buffer.c | 28 ++++++++++++++++++++++++++++
 include/linux/iio/buffer.h        |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 228598b82a2f..cf23736610d9 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -691,6 +691,34 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 	return bytes;
 }
 
+int iio_find_channel_offset_in_buffer(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      struct iio_buffer *buffer)
+{
+	int length, offset = 0;
+	unsigned int si;
+
+	if (chan->scan_index < 0 ||
+	    !test_bit(chan->scan_index, buffer->scan_mask)) {
+		return -EINVAL;
+	}
+
+	for (si = 0; si < chan->scan_index; ++si) {
+		if (!test_bit(si, buffer->scan_mask))
+			continue;
+
+		length = iio_storage_bytes_for_si(indio_dev, si);
+
+		/* Account for channel alignment. */
+		if (offset % length)
+			offset += length - (offset % length);
+		offset += length;
+	}
+
+	return offset;
+}
+EXPORT_SYMBOL_GPL(iio_find_channel_offset_in_buffer);
+
 static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 418b1307d3f2..b1db74772e77 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -16,6 +16,10 @@ enum iio_buffer_direction {
 	IIO_BUFFER_DIRECTION_OUT,
 };
 
+int iio_find_channel_offset_in_buffer(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      struct iio_buffer *buffer);
+
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
 int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
-- 
2.37.2

