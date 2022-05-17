Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C065297EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiEQDYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiEQDYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:24:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645A74506D;
        Mon, 16 May 2022 20:24:06 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2LxM2sqJz923h;
        Tue, 17 May 2022 11:21:11 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 11:24:04 +0800
From:   Jialin Zhang <zhangjialin11@huawei.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <biju.das.jz@bp.renesas.com>
CC:     <linux-iio@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: rzg2l_adc: add missing fwnode_handle_put() in rzg2l_adc_parse_properties()
Date:   Tue, 17 May 2022 11:35:26 +0800
Message-ID: <20220517033526.2035735-1-zhangjialin11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500021.china.huawei.com (7.185.36.109)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode_handle_put() should be used when terminating
device_for_each_child_node() iteration with break or
return to prevent stale device node references from
being left behind.

Fixes: d484c21bacfa ("iio: adc: Add driver for Renesas RZ/G2L A/D converter")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
---
 drivers/iio/adc/rzg2l_adc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 7585144b9715..5b09a93fdf34 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -334,11 +334,15 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 	i = 0;
 	device_for_each_child_node(&pdev->dev, fwnode) {
 		ret = fwnode_property_read_u32(fwnode, "reg", &channel);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(fwnode);
 			return ret;
+		}
 
-		if (channel >= RZG2L_ADC_MAX_CHANNELS)
+		if (channel >= RZG2L_ADC_MAX_CHANNELS) {
+			fwnode_handle_put(fwnode);
 			return -EINVAL;
+		}
 
 		chan_array[i].type = IIO_VOLTAGE;
 		chan_array[i].indexed = 1;
-- 
2.25.1

