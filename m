Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D558FA90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiHKKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiHKKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:15:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DC1900C;
        Thu, 11 Aug 2022 03:15:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBEAF6601CE2;
        Thu, 11 Aug 2022 11:15:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660212929;
        bh=zKeoj5xNpf9SpJXxagsMyA/3VCmfRNytMGTc1lfMEqQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KLLHM19vgXRVv5ngGvek04gSMK60da91pwuHP5UnRlci9lBenNN2wZ7JyV588lvdw
         bIG5UhQN+dmzJaTGAC6UUahXmsN1yM5B+XPVL3juXhEjCmY3zm71og/w5g3HojTwsK
         Lb0lNzzr6UsAwn/3sZ5LtrXV2YC/aKr4ePf7A5503k65+KF70CqJNYB3g8NVAewp1A
         2dwkoUi7dGlu8Tj1GWAg4o21BWcR84dBRfLkH2/bhM/3slkyPWGCeVBT0aaL33zI2L
         hRINel3ykOoKTjskdinFavxtbP1HW9Eft9unAvmCF2u3jhfulFQS9aTxf9xnTQzGbe
         h2lrLOxnmtikw==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        krisman@collabora.com, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] iio: light: Add raw attribute
Date:   Thu, 11 Aug 2022 15:44:43 +0530
Message-Id: <20220811101443.499761-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IIO_CHAN_INFO_RAW to the mask to be able to read raw values
from the light sensor.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/iio/light/ltrf216a.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index e6e24e70d2b9..a717bf99bd2a 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -93,6 +93,7 @@ static const struct iio_chan_spec ltrf216a_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_PROCESSED) |
 			BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_separate_available =
@@ -259,6 +260,18 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ltrf216a_set_power_state(data, true);
+		if (ret)
+			return ret;
+		mutex_lock(&data->lock);
+		ret = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		ltrf216a_set_power_state(data, false);
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PROCESSED:
 		mutex_lock(&data->lock);
 		ret = ltrf216a_get_lux(data);
-- 
2.30.2

