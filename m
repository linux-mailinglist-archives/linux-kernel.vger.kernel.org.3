Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A322596D26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiHQK5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbiHQK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:57:23 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE563F10;
        Wed, 17 Aug 2022 03:57:21 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id E8D9920000C;
        Wed, 17 Aug 2022 10:57:18 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 2/4] iio: add iio_channel_cb_get_iio_buffer helper
Date:   Wed, 17 Aug 2022 12:56:41 +0200
Message-Id: <20220817105643.95710-3-contact@artur-rojek.eu>
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

Introduce a helper function to retrieve an iio_buffer from
iio_cb_buffer.

This is useful for consumers that need to extract metadata about
the buffer, e.g. get the channel offsets.

Tested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/iio/buffer/industrialio-buffer-cb.c |  7 +++++++
 include/linux/iio/consumer.h                | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 4c12b7a94af5..47d6e28b4d36 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -151,6 +151,13 @@ struct iio_dev
 }
 EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_dev);
 
+struct iio_buffer
+*iio_channel_cb_get_iio_buffer(struct iio_cb_buffer *cb_buffer)
+{
+	return &cb_buffer->buffer;
+}
+EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_buffer);
+
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Industrial I/O callback buffer");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 6802596b017c..c28925d5b69c 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -196,6 +196,18 @@ struct iio_channel
 struct iio_dev
 *iio_channel_cb_get_iio_dev(const struct iio_cb_buffer *cb_buffer);
 
+/**
+ * iio_channel_cb_get_iio_buffer() - get access to the underlying buffer.
+ * @cb_buffer:		The callback buffer from whom we want the buffer
+ *			information.
+ *
+ * This function allows one to obtain information about the buffer.
+ * The primary aim is to allow drivers that are consuming a buffer to query
+ * things like channel offsets in the buffer.
+ */
+struct iio_buffer
+*iio_channel_cb_get_iio_buffer(struct iio_cb_buffer *cb_buffer);
+
 /**
  * iio_read_channel_raw() - read from a given channel
  * @chan:		The channel being queried.
-- 
2.37.2

