Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10142514049
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353970AbiD2BkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiD2BkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:40:19 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA672E9D6;
        Thu, 28 Apr 2022 18:36:59 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 29 Apr
 2022 09:36:59 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 29 Apr
 2022 09:36:57 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <jic23@kernel.org>
CC:     <baihaowen@meizu.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V4] iio: gp2ap020a00f: Fix signedness bug
Date:   Fri, 29 Apr 2022 09:36:54 +0800
Message-ID: <1651196214-7114-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220428194132.5a02555c@jic23-huawei>
References: <20220428194132.5a02555c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-123.meizu.com (172.16.1.123) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
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
V3->V4: 
1. add fix tag.
2. add check before use at gp2ap020a00f_write_event_val().
3. returns an error we should pass that on unchanged at
gp2ap020a00f_read_event_val()

 drivers/iio/light/gp2ap020a00f.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index b820041159f7..13583e1191d4 100644
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
@@ -1025,12 +1025,18 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
 	u8 thresh_val_id;
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = 0;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+
+	if (thresh_reg_l < 0){
+		err = thresh_reg_l;
+		goto error_unlock;
+	}
+
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 
 	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
@@ -1082,13 +1088,16 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = IIO_VAL_INT;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 
+	if (thresh_reg_l < 0)
+		return thresh_reg_l;
+
 	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
 		err = -EINVAL;
 		goto error_unlock;
-- 
2.7.4

