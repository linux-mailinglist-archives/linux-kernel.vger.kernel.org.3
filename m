Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B46C54E5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377570AbiFPP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiFPPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:25:59 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49A382E09A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=coaM8
        pDPv4WD3NukZ62DQq1/+jhgGiORkl6++lYLC+A=; b=kvNLnPsMxg6w8VfQG0Wni
        R87cgA0/bdv8rT0HQXa/n0U1QbNMuiWptvIOh/a90GyuDzV+IP6Mvn4LxHxTLqX2
        freGqkMMMfTX/ezKoQMT7SU9b6R+Y3EvGGy7756Imrw2BNcDmF8hr+GJxMnTRvHL
        ftDozWBOy7m74trbS7M/+0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowADXc5VSS6tizrX+DQ--.15781S2;
        Thu, 16 Jun 2022 23:25:06 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm: mach-imx: Fix refcount leak in mm-imx3.c
Date:   Thu, 16 Jun 2022 23:25:05 +0800
Message-Id: <20220616152505.3989451-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADXc5VSS6tizrX+DQ--.15781S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3Kry7trb_yoWktrc_Xa
        9agwnrtr4rCF4kur4DZw4fWay2yws5uF15Jr1jv3ZrtwsxZF17ArsFyF9Fqa45Gr429rW5
        ArWDZa15A342kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjnYwUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhMiF18RPTmfQgAAs-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In imx31_init_early() and imx35_init_early(), of_find_compatible_node()
will return a node pointer with refcount incremented. We should use
of_node_put() when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: add missing put for both imx31_xx and imx35_xx
 v1: only add missing put in imx31_xx

 arch/arm/mach-imx/mm-imx3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 28db97289ee8..d333a8fdb731 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -107,6 +107,7 @@ void __init imx31_init_early(void)
 	arm_pm_idle = imx31_idle;
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-ccm");
 	mx3_ccm_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!mx3_ccm_base);
 }
 #endif /* ifdef CONFIG_SOC_IMX31 */
@@ -144,6 +145,7 @@ void __init imx35_init_early(void)
 	arch_ioremap_caller = imx3_ioremap_caller;
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx35-ccm");
 	mx3_ccm_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!mx3_ccm_base);
 }
 #endif /* ifdef CONFIG_SOC_IMX35 */
-- 
2.25.1

