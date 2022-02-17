Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEF4B958F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiBQBjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:39:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiBQBjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:39:36 -0500
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB57201907
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:39:21 -0800 (PST)
X-QQ-mid: bizesmtp74t1645061956t7o1oboe
Received: from localhost.localdomain (unknown [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 17 Feb 2022 09:39:14 +0800 (CST)
X-QQ-SSF: 01400000000000B0L000B00A0000000
X-QQ-FEAT: fJqvVtUVYmkallprhQe0Dx3esin4KVp2QI1g1AdnEcg/6TbqNPwrgmEFDyb57
        ZtWu4QrJcTourjp1cY9f3k3wkAJd8WsKSKRtXMWf1R7MN48QyCNqq4mjd2/GSNlBJ+X/5QS
        oDnVG/+JIy3JTr4qsY/2yDwmf9Ast98WvgcYorceqYKSWR5kxUL9T8dO+WvxgtDuDMToXOu
        28M5CZrg44cin4YziVUbG0jRrgZ+WcbpQTzAxCTsvHxLZ0DY4GQRHr7ztwwGWJee4ESWwUk
        EO9xYzZFG5O3663tZJBVFv7hLnhcyrtnKFILt2P9FJDn5Jp2vn7C1pzI9fRpbGXSqAPfx0C
        BsGBlmzLvtXMqx+OeQ=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     dmitry.torokhov@gmail.com
Cc:     support.opensource@diasemi.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v2] input: da7280: Make use of the helper function dev_err_probe()
Date:   Thu, 17 Feb 2022 09:39:12 +0800
Message-Id: <20220217013912.7228-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_pwm_get() can return -EPROBE_DEFER if the pwm regulator is not
ready yet. Use dev_err_probe() for pwm regulator resources
to indicate the deferral reason when waiting for the
resource to come up.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 v2:Remove the redundant brackets '}'
 drivers/input/misc/da7280.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
index b08610d6e575..65f3e0251b23 100644
--- a/drivers/input/misc/da7280.c
+++ b/drivers/input/misc/da7280.c
@@ -1165,13 +1165,9 @@ static int da7280_probe(struct i2c_client *client,
 
 	if (haptics->const_op_mode == DA7280_PWM_MODE) {
 		haptics->pwm_dev = devm_pwm_get(dev, NULL);
-		error = PTR_ERR_OR_ZERO(haptics->pwm_dev);
-		if (error) {
-			if (error != -EPROBE_DEFER)
-				dev_err(dev, "Unable to request PWM: %d\n",
-					error);
-			return error;
-		}
+		if (IS_ERR(haptics->pwm_dev))
+			return dev_err_probe(dev, PTR_ERR(haptics->pwm_dev),
+					"Unable to request PWM\n");
 
 		/* Sync up PWM state and ensure it is off. */
 		pwm_init_state(haptics->pwm_dev, &state);
-- 
2.20.1



