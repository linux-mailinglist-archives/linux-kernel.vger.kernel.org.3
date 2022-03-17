Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD74DC76E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiCQNVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCQNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:21:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664F61760C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:20:02 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK74l4vC7zfYwF;
        Thu, 17 Mar 2022 21:18:31 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 21:20:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <shawn.guo@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] irq/qcom-mpm: Fix build error without MAILBOX
Date:   Thu, 17 Mar 2022 21:19:56 +0800
Message-ID: <20220317131956.30004-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If MAILBOX is n, building fails:

drivers/irqchip/irq-qcom-mpm.o: In function `mpm_pd_power_off':
irq-qcom-mpm.c:(.text+0x174): undefined reference to `mbox_send_message'
irq-qcom-mpm.c:(.text+0x174): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `mbox_send_message'

Make QCOM_MPM depends on MAILBOX to fix this.

Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 680d2fcf2686..15edb9a6fcae 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -433,6 +433,7 @@ config QCOM_PDC
 config QCOM_MPM
 	tristate "QCOM MPM"
 	depends on ARCH_QCOM
+	depends on MAILBOX
 	select IRQ_DOMAIN_HIERARCHY
 	help
 	  MSM Power Manager driver to manage and configure wakeup
-- 
2.17.1

