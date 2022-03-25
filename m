Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB274E6EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349389AbiCYHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348234AbiCYHb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:31:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B53BF035;
        Fri, 25 Mar 2022 00:29:54 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KPttB1rvxz8wyk;
        Fri, 25 Mar 2022 15:25:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 15:29:51 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <linus.walleij@linaro.org>, <j.neuschaefer@gmx.net>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <tangyizhou@huawei.com>
Subject: [PATCH -next] pinctrl: nuvoton: wpcm450: Fix build error without OF
Date:   Fri, 25 Mar 2022 15:44:50 +0800
Message-ID: <20220325074450.3228840-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If OF is not set, bulding fails:

drivers/pinctrl/nuvoton/pinctrl-wpcm450.o: In function `wpcm450_dt_node_to_map':
pinctrl-wpcm450.c:(.text+0x404): undefined reference to `pinconf_generic_dt_node_to_map'

Make PINCTRL_WPCM450 depends on OF to fix this.

Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/pinctrl/nuvoton/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/Kconfig b/drivers/pinctrl/nuvoton/Kconfig
index b48d32912bef..852b0d0eb08e 100644
--- a/drivers/pinctrl/nuvoton/Kconfig
+++ b/drivers/pinctrl/nuvoton/Kconfig
@@ -3,6 +3,7 @@
 config PINCTRL_WPCM450
 	tristate "Pinctrl and GPIO driver for Nuvoton WPCM450"
 	depends on ARCH_WPCM450 || COMPILE_TEST
+	depends on OF
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
--
2.31.1

