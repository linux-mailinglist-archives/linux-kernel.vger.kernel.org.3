Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D96502015
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348367AbiDOBXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345690AbiDOBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:23:15 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4152A264;
        Thu, 14 Apr 2022 18:20:48 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 15 Apr
 2022 09:20:40 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 15 Apr
 2022 09:20:39 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] iio: gp2ap020a00f: Fix signedness bug
Date:   Fri, 15 Apr 2022 09:20:37 +0800
Message-ID: <1649985637-18854-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAHp75VfbZhMvs7dHwadvNs6maPsBVOY3Mk5wkKSwZ1RANQQHDA@mail.gmail.com>
References: <CAHp75VfbZhMvs7dHwadvNs6maPsBVOY3Mk5wkKSwZ1RANQQHDA@mail.gmail.com>
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
we have to change u8 -> int.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: s8 is not enough to hold an (arbitrary) error code. To be on the safe
side we need to use int

 drivers/iio/light/gp2ap020a00f.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index b820041159f7..b0e62d3c6fa0 100644
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
@@ -1082,7 +1082,7 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = IIO_VAL_INT;
 
 	mutex_lock(&data->lock);
-- 
2.7.4

