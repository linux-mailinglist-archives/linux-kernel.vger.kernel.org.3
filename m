Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2454CBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbiFOOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFOOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:55:34 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EED827CDB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6b1QQ
        5pX99UVwMZZIVKUN/ej+cHkqQXln4EdGZwejTQ=; b=OwWnoSNG2ajUu4JtqVsVu
        szWtn92oa4nGIJaW2yXLFRU3R+cThHKz6dzuc5ZRQnhZhSa2b4z4VDPNkaX8ft2U
        iw8LzzdN3BCC+/agRi3UCDRVAX+s3yGr4z7squvFrwk+S4MJ+A7WTkAIF0tPywPb
        sR5MMhSwUTcH9DJ6HB4b70=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgAHD7S58qli4Y01Ew--.55748S2;
        Wed, 15 Jun 2022 22:54:50 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arm: mach-imx: Add missing of_node_put() in cpu-imx31.c
Date:   Wed, 15 Jun 2022 22:54:48 +0800
Message-Id: <20220615145448.3969508-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgAHD7S58qli4Y01Ew--.55748S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3trW5ZFb_yoW3Gwc_Ar
        1Sg3s7JF4rArnYv3yUuw45Wr4Yvw4rWF1rAas2yF1jyw4j9wnrCr9Fyr92qry7Xr43KrW5
        GrZrCF4Y9w13GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMpnQ3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhohF18RPTHCVgAAs0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mx31_read_cpu_rev(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-imx/cpu-imx31.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index b9c24b851d1a..cff6be524626 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -39,6 +39,9 @@ static int mx31_read_cpu_rev(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-iim");
 	iim_base = of_iomap(np, 0);
+	
+	of_node_put(np);
+	
 	BUG_ON(!iim_base);
 
 	/* read SREV register from IIM module */
-- 
2.25.1

