Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102E4ABF30
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448787AbiBGNN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448347AbiBGNKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:10:49 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB632C0401C4;
        Mon,  7 Feb 2022 05:10:42 -0800 (PST)
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 09/12] iio: buffer-dmaengine: Support new DMABUF based userspace API
Date:   Mon,  7 Feb 2022 12:59:30 +0000
Message-Id: <20220207125933.81634-10-paul@crapouillou.net>
In-Reply-To: <20220207125933.81634-1-paul@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the functions provided by the buffer-dma core to implement the
DMABUF userspace API in the buffer-dmaengine IIO buffer implementation.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 5cde8fd81c7f..57a8b2e4ba3c 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -133,6 +133,9 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.space_available = iio_dma_buffer_space_available,
 	.release = iio_dmaengine_buffer_release,
 
+	.alloc_dmabuf = iio_dma_buffer_alloc_dmabuf,
+	.enqueue_dmabuf = iio_dma_buffer_enqueue_dmabuf,
+
 	.modes = INDIO_BUFFER_HARDWARE,
 	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
 };
-- 
2.34.1

