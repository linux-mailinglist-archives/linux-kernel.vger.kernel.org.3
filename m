Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D334495671
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378114AbiATWqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiATWqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:46:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18BFC061574;
        Thu, 20 Jan 2022 14:46:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F2D1B81E89;
        Thu, 20 Jan 2022 22:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA52C340E0;
        Thu, 20 Jan 2022 22:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642718768;
        bh=fdSAFRvqmhbMcbD/TihbFGAN81CMJEMp6Widv9tEMRQ=;
        h=Date:From:To:Cc:Subject:From;
        b=JFhkN479sXx1J9LQsgx+M1Vg8kuj6cGz6XxwjqEFvYfEcd3ClfMhtiuxLlDPXVtUH
         /GD2Jd2BIL4EKOvvPTsMu3QPOikvobu6Bx9R7ENvYNW/MuPBkYyGwU72srIhibTJZf
         jGJzOgGSR3sxdtx1FtWPih+25ed9nUDTTAYo4tAHnTswPs+iLeuPReN7+tKBAaqEEy
         cIgzBa3tOBF9D0ciaNh6zrefe9PdZ7tnqySXatThfVe6UkoGxq5Mk5aQLXY/c5Z0cI
         CwyrsfstB3oh8jlYur642lvHAEVQKRtxr7Y4GRcLwZ2JxwPCVkhQ2NnnrkVlOKonB3
         BURD6097dlfsg==
Date:   Thu, 20 Jan 2022 16:52:43 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] iio: hw_consumer: Use struct_size() helper in kzalloc()
Message-ID: <20220120225243.GA37225@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/iio/buffer/industrialio-hw-consumer.c:63:23: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 87d9aabd20c7..fb58f599a80b 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -52,7 +52,6 @@ static const struct iio_buffer_access_funcs iio_hw_buf_access = {
 static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
 	struct iio_hw_consumer *hwc, struct iio_dev *indio_dev)
 {
-	size_t mask_size = BITS_TO_LONGS(indio_dev->masklength) * sizeof(long);
 	struct hw_consumer_buffer *buf;
 
 	list_for_each_entry(buf, &hwc->buffers, head) {
@@ -60,7 +59,8 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
 			return buf;
 	}
 
-	buf = kzalloc(sizeof(*buf) + mask_size, GFP_KERNEL);
+	buf = kzalloc(struct_size(buf, scan_mask, BITS_TO_LONGS(indio_dev->masklength)),
+		      GFP_KERNEL);
 	if (!buf)
 		return NULL;
 
-- 
2.27.0

