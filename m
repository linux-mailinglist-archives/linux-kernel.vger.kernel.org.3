Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD24855B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbiAEPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:20:17 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58639 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241250AbiAEPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:20:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V127yqg_1641396007;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V127yqg_1641396007)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 23:20:12 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     giovanni.cabiddu@intel.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] crypto: qat - Unsigned comparison with less than zero
Date:   Wed,  5 Jan 2022 23:20:05 +0800
Message-Id: <20220105152005.43305-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:

./drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c:67:5-8: WARNING:
Unsigned expression compared with zero: ret < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index 6d10edc40aca..68d39c833332 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -52,7 +52,7 @@ static const char *const dev_cfg_services[] = {
 static int get_service_enabled(struct adf_accel_dev *accel_dev)
 {
 	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
-	u32 ret;
+	int ret;
 
 	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
 				      ADF_SERVICES_ENABLED, services);
-- 
2.20.1.7.g153144c

