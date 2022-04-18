Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B489504AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiDRCWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiDRCWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:22:18 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E817E2B;
        Sun, 17 Apr 2022 19:19:39 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 18 Apr
 2022 10:19:38 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 18 Apr
 2022 10:19:36 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] iio: gp2ap020a00f: Fix signedness bug
Date:   Mon, 18 Apr 2022 10:19:35 +0800
Message-ID: <1650248375-6334-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220415185205.26a3d352@jic23-huawei>
References: <20220415185205.26a3d352@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function gp2ap020a00f_get_thresh_reg() is unsigned but returning -EINVAL
errcode, and thresh_reg_l is unsigned but receiving -EINVAL errcode. so
we have to change u8 -> int. Also we need to do index bound check at
gp2ap020a00f_read_event_val().

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: s8 is not enough to hold an (arbitrary) error code. To be on the safe
side we need to use int.
V2->V3: add bound check at gp2ap020a00f_read_event_val().


 drivers/iio/light/gp2ap020a00f.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index b820041159f7..f80d30786035 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -994,7 +994,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
+static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
 					     enum iio_event_direction event_dir)
 {
 	switch (chan->type) {
@@ -1025,7 +1025,7 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
 	u8 thresh_val_id;
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = 0;
 
 	mutex_lock(&data->lock);
@@ -1082,14 +1082,14 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = IIO_VAL_INT;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 
-	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
+	if (thresh_reg_l < 0 || thresh_reg_l > GP2AP020A00F_PH_L_REG) {
 		err = -EINVAL;
 		goto error_unlock;
 	}
-- 
2.7.4

