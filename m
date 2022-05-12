Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A5F5243AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbiELDrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbiELDrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:47:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F389D8083
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:47:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c9so3730269plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+CQFJULOsaKE0QcIymzWY3BtTqWCy7rPPABpYb/J1M=;
        b=V6m4b5QbEyPqUQT952TkN1fe+g3GgOV+kFIWzyY1oMQFKHkfgfWQ58fT8E71UzAcOj
         B9JH5Yr0uQcRlS0LXngocF3ZB9ajfdAme9gnHDfq+9muG0Uh08SKbteTOT+CEmTJT5QB
         ospSG9tr2GCwhOtZEcIeTdfxuNz96J+LTxGcV705LlSSTWc0xs5++KBKJfpaIPTAKbuJ
         iuUMgNZ9pDXRlgaKmEulgnyJqbTdIMGUFwn86XnnbguMoqKPwAiHAKzfxEC0mC8ErYw2
         cJj7A/zyW+zeddcQbUE1lJv/yw1tY69DPKXdakQYe4f14GAze66j6k21R3jbBN7DzWWL
         bY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+CQFJULOsaKE0QcIymzWY3BtTqWCy7rPPABpYb/J1M=;
        b=hMvKxLIdMHqyN4h/4xV6HPSYTp+xeO+rNKCMAxiRRBzzyK43Jfsz1NxfKrove0+kIO
         eOwU6d0QAfeS6CX++hwphzz8miDWyJtIex37j8h9Pd1VBDm1icxL8QmV9FprWVEa3IjF
         DMHw9J+LaoRcUODZ3ZDJcN9xR8bE1KdQfQMxhtqsdXeQKGcFglXCoYbwTVt5UY8m+ZWc
         QZSCguKhr2v1GUIegwefdBhf4IRN+XYdoBSyBQBTcOKN/DmiCNIYC0/gqCdZsyfOKZeM
         DTfU/kPAOalbmPk8s7kWBiYOKOZAN1KA1uw+beortec5q6VI7kBQm3wG/JKuahQVOAK0
         1VWw==
X-Gm-Message-State: AOAM533icaevs/gWGnln4nTip8VBI+WX7O5M1i6YrYOcdgo0CsaPkCQg
        vhDPh7BLVkksYX0KbnB9y0A=
X-Google-Smtp-Source: ABdhPJxJ0fEoJq+s06+6zSP/2UThvmCVCffCFNC9l/cXRG01NkbOeVNWx/SjxNS3bito8G0wUcOMLw==
X-Received: by 2002:a17:902:b698:b0:158:faee:442f with SMTP id c24-20020a170902b69800b00158faee442fmr29203392pls.75.1652327220523;
        Wed, 11 May 2022 20:47:00 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 10-20020a17090a174a00b001d5f22845bdsm962677pjm.1.2022.05.11.20.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:47:00 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: mstar: Fix refcount leaks
Date:   Thu, 12 May 2022 07:46:51 +0400
Message-Id: <20220512034652.61134-1-linmq006@gmail.com>
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

Fixes: 5919eec0f092 ("ARM: mstar: SMP support")
Fixes: 312b62b6610c ("ARM: mstar: Add machine for MStar/Sigmastar Armv7 SoCs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-mstar/mstarv7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mstar/mstarv7.c b/arch/arm/mach-mstar/mstarv7.c
index 274c4f0df270..3176998817d2 100644
--- a/arch/arm/mach-mstar/mstarv7.c
+++ b/arch/arm/mach-mstar/mstarv7.c
@@ -86,6 +86,7 @@ static int mstarv7_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	np = of_find_compatible_node(NULL, NULL, "mstar,smpctrl");
 	smpctrl = of_iomap(np, 0);
+	of_node_put(np);
 
 	if (!smpctrl)
 		return -ENODEV;
@@ -120,6 +121,7 @@ static void __init mstarv7_init(void)
 		soc_mb = mstarv7_mb;
 	else
 		pr_warn("Failed to install memory barrier, DMA will be broken!\n");
+	of_node_put(np);
 }
 
 DT_MACHINE_START(MSTARV7_DT, "MStar/Sigmastar Armv7 (Device Tree)")
-- 
2.25.1

