Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34326524C42
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353479AbiELL70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbiELL7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:59:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5004D219C03;
        Thu, 12 May 2022 04:59:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m12so4653211plb.4;
        Thu, 12 May 2022 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/Jq44xoX1PX4n3n8Vf2G0RTQLdM4u3R8vUUYgDiB04=;
        b=mlMqYveSz/+4qyhU7Gn2t3oWFvyH+LSNhqreDHRhYlwIHWqahZCFudIHWm6Ja6shfJ
         l6FeEnF5N+f7cfpHAwyX2D2A6Im2Xst2Vt0KatDULbUJMvR/gjU0p6whZWNLymtnRqdg
         XpenVROQ7O74LbOF/JN8z421V3oYlvmaPamURNP0qMVllMgrdgR7WQx0k1yzliiAGDc/
         cu1N8Oiya9M7Ouij7ORwpMcmR5valH7ZFw2ufqvt0khJMMvqGuQBiA299NVzlEwNymzT
         Fmu3DKnijVF6aP7k4Dbi0eWKnD7hm4SYQVcNLVueHvuwGkD28M55+CTWIy3+s1oDCUFV
         sAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/Jq44xoX1PX4n3n8Vf2G0RTQLdM4u3R8vUUYgDiB04=;
        b=QnMJ/W3QTQfW+6vqQYOVc/11LauENffY3wfmXCnClxvZ447ojY+kO+Ts8DqvKjOAqN
         w5Z9J6POpse/wEGYyCnvLoSjRDu6ofdG7fbZ6QWR6t3CQ1QhX90fPLuIOLtG9fucFRmq
         fG0iVNWsvPCPOZZkSKzR7cSE3A3leFkwFDPY6cg49cGulcjwFvGehEziwSXO2FUDQliE
         kFir4DB5AiNLaf6GEQV7Oc5QM5nf96LZwtU/ZOSx7crVxx1Lz8lJJbhAfUEQQTNF+gdI
         UJJFz1IENqlPd3TZ/0MYbF3Nomv626dOJwtj1BMrAikLgYNA+nHnKq3C6WM7MC75+F/8
         2SKg==
X-Gm-Message-State: AOAM533IFhe8YGy9VAdQMIg5d32mgvWEh+hpbD8sNzpTNPrrRcUJQVbB
        dQGLqEaFyGq3hVnmrLeS8qo=
X-Google-Smtp-Source: ABdhPJxUkdcERAaY6EHXM+YWGl5OJizIGEsi9bYKgIcAV4R0PZrxLengDsUUSp2cSZor8m+omxbfVQ==
X-Received: by 2002:a17:902:7445:b0:15f:2eb6:2c3d with SMTP id e5-20020a170902744500b0015f2eb62c3dmr9432973plt.132.1652356762826;
        Thu, 12 May 2022 04:59:22 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id k34-20020a635a62000000b003c14af5063esm1653594pgm.86.2022.05.12.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:59:22 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>, Helge Deller <deller@gmx.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: Fix refcount leak in clcdfb_of_vram_setup
Date:   Thu, 12 May 2022 15:59:08 +0400
Message-Id: <20220512115913.48685-1-linmq006@gmail.com>
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: d10715be03bd ("video: ARM CLCD: Add DT support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/video/fbdev/amba-clcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 9ec969e136bf..8080116aea84 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -758,12 +758,15 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
 		return -ENODEV;
 
 	fb->fb.screen_base = of_iomap(memory, 0);
-	if (!fb->fb.screen_base)
+	if (!fb->fb.screen_base) {
+		of_node_put(memory);
 		return -ENOMEM;
+	}
 
 	fb->fb.fix.smem_start = of_translate_address(memory,
 			of_get_address(memory, 0, &size, NULL));
 	fb->fb.fix.smem_len = size;
+	of_node_put(memory);
 
 	return 0;
 }
-- 
2.25.1

