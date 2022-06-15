Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7B54CBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiFOOxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiFOOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:53:20 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C87063A8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pKeTw
        5oKPR30JCLvAB+f0zG9vLVnAZ+mozqxhnpiZlE=; b=TcE3wpoPA+mjSSyt6GgRq
        awM9CUxumcpudb7oXf8WVYkjqYcMkyv/E3tlW4lOcfrlNVW6GEKqHgdLFrF3dw8R
        3jhwZ3Irs/TIV14M9c/ugWZXwBdAtFGfp+ucazGyP76BlyYxUebQV+LJi3w/7yfI
        biD0BuQbEE77n9ms27NWcc=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowADHzzcS8qliIdu4EQ--.720S2;
        Wed, 15 Jun 2022 22:52:02 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arm: mach-imx: Add missing of_node_put in cpu-imx27.c
Date:   Wed, 15 Jun 2022 22:51:59 +0800
Message-Id: <20220615145159.3969334-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowADHzzcS8qliIdu4EQ--.720S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3trW5ZFb_yoW3Xwc_ZF
        1Sgw17Ar4fArnYv3srCa15CF43tw45W3WrZFyft3WYywsFvr1DCrnFvrn2qry7ZrZxKrW3
        J3ykCr4Y9w1SkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREPfH3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hMhF1uwMNYJuwAAsA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mx27_read_cpu_rev(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-imx/cpu-imx27.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/cpu-imx27.c b/arch/arm/mach-imx/cpu-imx27.c
index bf70e13bbe9e..220622c9d2f0 100644
--- a/arch/arm/mach-imx/cpu-imx27.c
+++ b/arch/arm/mach-imx/cpu-imx27.c
@@ -28,6 +28,9 @@ static int mx27_read_cpu_rev(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx27-ccm");
 	ccm_base = of_iomap(np, 0);
+	
+	of_node_put(np);
+	
 	BUG_ON(!ccm_base);
 	/*
 	 * now we have access to the IO registers. As we need
-- 
2.25.1

