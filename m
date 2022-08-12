Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EFB590EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiHLKFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiHLKFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:05:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7601CAB044;
        Fri, 12 Aug 2022 03:05:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BB796601B04;
        Fri, 12 Aug 2022 11:05:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660298702;
        bh=7gnNFm9zex7R0Ywkro8rHXyiJw6horg1uTYDOWk7Djs=;
        h=From:To:Cc:Subject:Date:From;
        b=j+vI/9lTxJgFtQY44mZM0r0IwSgwfC5L5v0JEFdRunSZUDhZC9T3xPgsgWMc70w54
         pbQw/kCQVjkW0mxvR2D9hKm7QpyTjGOMppudoNkT6l4scSPVbFBHToG16Diyxcw9Ey
         O7sS2e2uWJ8yM0MU7nCIZi+jsXEt0CpYWB9Hvb/SbFgQhAjiCrltWUHtvXeOjmn6S1
         GOmbTOycp00YijZ/7vFVWBMk1U2rRxBxVSm4J/O9m8ryxja4jSNXW/5g8KQwgF2GBB
         QlFSf7MzzTptB75YEeBgoyirtlxZWV2AtTWLQIdh/JMoAsOAmS2nQ0TiKLhxlfaHbg
         m3L+vhEMM4+Sw==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        krisman@collabora.com, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2] iio: light: ltrf216a: Add raw attribute
Date:   Fri, 12 Aug 2022 15:34:24 +0530
Message-Id: <20220812100424.529425-1-shreeya.patel@collabora.com>
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

The userspace code for brightness control in steam deck uses the
in_illuminance_input value through sysfs and multiplies it
with a constant stored in BIOS at factory calibration time.

The downstream driver for LTRF216A that we have been using
has incorrect formula for LUX calculation which we corrected
in the upstreamed driver.

Now to be able to use the upstreamed driver, we need to add some
magic in userspace so that the brightness control works like before
even with the updated LUX formula.

Hence, we need the raw data to calculate a constant that can be
added in userspace code.

Downstream driver LUX formula :-
(greendata*8*LTRF216A_WIN_FAC) / (data->als_gain_fac*data->int_time_fac*10)

Upstreamed driver LUX formula :-
(greendata*45*LTRF216A_WIN_FAC) / (data->als_gain_fac*data->int_time_fac)

greendata is the ALS_DATA which we would like to get through sysfs using
the raw attribute.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v2
  - Add a better commit message explaining why we want this change.
  - Call ltrf216a_set_power_state(data, false) before return.


 drivers/iio/light/ltrf216a.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index e6e24e70d2b9..4b8ef36b6912 100644
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
+		ltrf216a_set_power_state(data, false);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PROCESSED:
 		mutex_lock(&data->lock);
 		ret = ltrf216a_get_lux(data);
-- 
2.30.2

