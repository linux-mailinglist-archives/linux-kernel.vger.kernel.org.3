Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713D24DD2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiCRCMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiCRCMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:12:22 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13532B5AFD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:11:03 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 18 Mar
 2022 10:11:04 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 18 Mar
 2022 10:11:01 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <giovanni.cabiddu@intel.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <marco.chiappero@intel.com>,
        <fiona.trahe@intel.com>, <wojciech.ziemba@intel.com>
CC:     <qat-linux@intel.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] crypto: qat: Fix unsigned comparison with less than zero
Date:   Fri, 18 Mar 2022 10:10:59 +0800
Message-ID: <1647569459-18376-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
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

drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c:67:5-8: WARNING: Unsigned expression compared with zero: ret < 0

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index 6d10edc..0143835 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -52,7 +52,7 @@ static const char *const dev_cfg_services[] = {
 static int get_service_enabled(struct adf_accel_dev *accel_dev)
 {
 	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
-	u32 ret;
+	s32 ret;
 
 	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
 				      ADF_SERVICES_ENABLED, services);
-- 
2.7.4

