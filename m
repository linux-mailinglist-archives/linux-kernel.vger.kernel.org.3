Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF32F52485E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351584AbiELIyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351859AbiELIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:53:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5A6A02D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:52:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso7264578pjw.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vpL1t0Gds79zok3GkOwdARYiSTxkflwM+27BDmbSYY=;
        b=Uqw3a66NQ6q48VkV7qyg9aQTCDRPUz1MlRyQt8djR7jTV5U8yOnkCJSl93cw3u1D9+
         j3GYAp0NeiYQ9CtRrl2N40D5gXK4LSbnl0eFsWQ0KyvE2e/GQefTzXKjLsc25gv6yEJ+
         qWpBJsqnmSkLS0DxG9cXseTP0x6wjN1XuwTGG1/0jd9zrgsFX1ZOKs0g4du/0y24/3rK
         Ao7Bg9Ns31cSCKfh7jehPkZfOAytFuJVbfGOXmJMRfG9UeCFcMf4gzHej76HhMaImWN3
         ESlsSaoDlzD0TozGkTDHh5OdWp2AomyBE6syHNWv29s4xEU2sSeMtOBDzL9CAEt2pWue
         s9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vpL1t0Gds79zok3GkOwdARYiSTxkflwM+27BDmbSYY=;
        b=qbjWRbsvmBvVBR0BDJgqxzFIw4+h4dCDg1BSb+0P0XkGspdya0m60KZqYXJR3RHWDV
         pLC0XoGoDqeNDAUsi2i4aRwKWw3xsvlH/91vRmoJdzRWchxfUvfD3ROqPUTPbPcwTXe6
         OCAxy+TDXbmG/Fv6UQub7WVGpP1w77QfmXXxpO3Smie5/AQd8xwkf15iHLC3PeDjaQb4
         6RYQqBp3Pnmq0IrqLOhqDWwthFSpozx7daiJVanPcFmHmIoczW8w/UStEE/XsPo6xG30
         7kFJvQ5RpNnfl1hK6HOOb3v+b8I/p0shfAD8t0R3djYR2CltIEgVIutRPMZCdL63KMCl
         Pe3Q==
X-Gm-Message-State: AOAM532s80h7kdHvkAYCFHlJW2mr47Efipf30d23KnIU9btB1nMtBbAW
        POVrQRn8EF8UVo0BjUwykJo=
X-Google-Smtp-Source: ABdhPJzK4EZAUk/2owdPhXu1aU/+SeMB5J1vuQZ4lQB+ZdMno82cUI4IGQdQZZirNyt1gQifXGrT3Q==
X-Received: by 2002:a17:902:d415:b0:15c:ea4b:7b8e with SMTP id b21-20020a170902d41500b0015cea4b7b8emr30098380ple.86.1652345572862;
        Thu, 12 May 2022 01:52:52 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 123-20020a621581000000b0050dc76281basm3299780pfv.148.2022.05.12.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 01:52:52 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mxs: Fix refcount leak in mxs_get_ocotp
Date:   Thu, 12 May 2022 12:52:41 +0400
Message-Id: <20220512085244.30265-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 1bff2d76ac88 ("ARM: mxs: move mxs_get_ocotp() into mach-mxs.c")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 25c9d184fa4c..4af4c3dcfa85 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -99,6 +99,7 @@ static const u32 *mxs_get_ocotp(void)
 	np = of_find_compatible_node(NULL, NULL, "fsl,ocotp");
 	ocotp_base = of_iomap(np, 0);
 	WARN_ON(!ocotp_base);
+	of_node_put(np);
 
 	mutex_lock(&ocotp_mutex);
 
-- 
2.25.1

