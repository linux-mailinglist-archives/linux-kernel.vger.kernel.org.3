Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FF4DD341
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiCRCvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiCRCu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:50:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2F1B7C55;
        Thu, 17 Mar 2022 19:49:40 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKT4d1pW1zcb6d;
        Fri, 18 Mar 2022 10:49:37 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 10:49:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:49:38 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <liwei391@huawei.com>,
        <bobo.shaobowang@huawei.com>, <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio:filter:admv8818: Add depends on REGMAP
Date:   Fri, 18 Mar 2022 10:59:13 +0800
Message-ID: <20220318025914.2614812-2-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318025914.2614812-1-bobo.shaobowang@huawei.com>
References: <20220318025914.2614812-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "depends on REGMAP" to CONFIG_ADMV8818, because admv8818 driver
uses structure/symbols such as 'struct regmap_config' which are defined
only when CONFIG_REGMAP is set.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/iio/filter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
index 3ae35817ad82..4bbf10f8692c 100644
--- a/drivers/iio/filter/Kconfig
+++ b/drivers/iio/filter/Kconfig
@@ -7,7 +7,7 @@ menu "Filters"
 
 config ADMV8818
 	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass Filter"
-	depends on SPI && COMMON_CLK && 64BIT
+	depends on REGMAP && SPI && COMMON_CLK && 64BIT
 	help
 	  Say yes here to build support for Analog Devices ADMV8818
 	  2 GHz to 18 GHz, Digitally Tunable, High-Pass and Low-Pass Filter.
-- 
2.25.1

