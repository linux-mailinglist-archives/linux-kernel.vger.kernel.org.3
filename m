Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AE54CBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiFOOuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiFOOuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:50:22 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95EA731519
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GUhmC
        E0QdF+MaPuRFhXUNE/xiWyEw7EIPnvVWNb5cP8=; b=UhY10ZOwIo9D6AWEnkD68
        UHbM09IZw3jwcZs7TTlGfNsOMI2tV2DBoIdCxAfEvsWBBC7WKUNLL041pOMOTglj
        JIeuEVT6Vnvi0nFvpMrgBM/p1au9XI9TjwhoQ3cbvdk6DeXpF8xawkqfZiC+yEXk
        NMDBOSDKye3M8hjWA5HNww=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgCXiZ5s8ali+O40Ew--.55428S2;
        Wed, 15 Jun 2022 22:49:17 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arm: mach-imx: Add mising of_node_put in cpu-imx25.c
Date:   Wed, 15 Jun 2022 22:49:14 +0800
Message-Id: <20220615144914.3969151-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgCXiZ5s8ali+O40Ew--.55428S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3trW5ZFb_yoW3WFgE9F
        nag3y7JFWfArnY9rW7uw45GF4aqa18Gr1rZFyIy3W2yw4qvr1Ykrn2vr92qry7Zw47KrWa
        q34DC3yYkw4fGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRA18v3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3A0hF1pEDudS9QAAs3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mx25_read_cpu_rev(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-imx/cpu-imx25.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/cpu-imx25.c b/arch/arm/mach-imx/cpu-imx25.c
index b2e1963f473d..cf03a22bf637 100644
--- a/arch/arm/mach-imx/cpu-imx25.c
+++ b/arch/arm/mach-imx/cpu-imx25.c
@@ -23,6 +23,9 @@ static int mx25_read_cpu_rev(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx25-iim");
 	iim_base = of_iomap(np, 0);
+	
+	of_node_put(np);
+	
 	BUG_ON(!iim_base);
 	rev = readl(iim_base + MXC_IIMSREV);
 	iounmap(iim_base);
-- 
2.25.1

