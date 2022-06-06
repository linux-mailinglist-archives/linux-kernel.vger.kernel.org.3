Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1953EAF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiFFO6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbiFFO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:58:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F56303884
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:58:16 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3468BFF805;
        Mon,  6 Jun 2022 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654527495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdBrGx50GRyG3r2iXeGYuM3SEahX/F4l92MvsJio2dM=;
        b=XjnSLokHGUTArERJGLhtnibxg1snnzGnkfsUyoYRX1v6AXZ579VkSnaJeFqbCxavsH59FE
        hoN2tHLT15aPFGvDMKLWnq3k91TEvChLVd7n+hy+SeNhARtA12dmbQxIxroSK5xLsuEMTw
        lRa/PLirgi5mMeMJuPpHQqKEtrpMG41QKxldxoAxxC6CbxNLDBq0tt9Hpd0UMCa/tx7hiA
        K988esjV4EZjhGdP5b9+AKVC6+bTQFRKSi0PfEVAAxHJPZ10BSqxfgISOx6b50+LU81EA6
        uPG6AX1icU4zK+e/4qqSJG+lNTZQFePgbjABkaZ9fmh3qkHpVCguqiaxKwRerQ==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/2] ARM: at91: add sam_linux_is_in_normal_world() function
Date:   Mon,  6 Jun 2022 16:57:00 +0200
Message-Id: <20220606145701.185552-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606145701.185552-1-clement.leger@bootlin.com>
References: <20220606145701.185552-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sam_linux_is_in_normal_world() which allows to know if Linux is
running in the normal world or not. This function is used by code
which needs to differentiate the world in which Linux is running.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/mach-at91/sam_secure.c | 6 ++++++
 arch/arm/mach-at91/sam_secure.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-at91/sam_secure.c b/arch/arm/mach-at91/sam_secure.c
index 2a01f7a7d13f..1ec8c8b9d119 100644
--- a/arch/arm/mach-at91/sam_secure.c
+++ b/arch/arm/mach-at91/sam_secure.c
@@ -27,6 +27,12 @@ struct arm_smccc_res sam_smccc_call(u32 fn, u32 arg0, u32 arg1)
 	return res;
 }
 
+bool sam_linux_is_in_normal_world(void)
+{
+	/* If optee has been detected, then we are running in normal world */
+	return optee_available;
+}
+
 void __init sam_secure_init(void)
 {
 	struct device_node *np;
diff --git a/arch/arm/mach-at91/sam_secure.h b/arch/arm/mach-at91/sam_secure.h
index 1e7d8b20ba1e..6d8c01f9c5f0 100644
--- a/arch/arm/mach-at91/sam_secure.h
+++ b/arch/arm/mach-at91/sam_secure.h
@@ -14,5 +14,6 @@
 
 void __init sam_secure_init(void);
 struct arm_smccc_res sam_smccc_call(u32 fn, u32 arg0, u32 arg1);
+bool sam_linux_is_in_normal_world(void);
 
 #endif /* SAM_SECURE_H */
-- 
2.36.1

