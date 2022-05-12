Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E15524250
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiELCG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiELCGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:06:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC366F95
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:06:51 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p12so3556615pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5ejgBXTAIUixboB4DJUAMoeq/lr5AGnM16DSQO4iD0=;
        b=fWC+os+5n3q5/oM2q5UhHNUR8KmKwVjjKQfn64+siR+2+lrAqRjVCkyp9Q+pkXlfBz
         lJrhatB9kQcByfRRRra7p7C6S7etFxRUVRMGsSorHmPfK0zW9HpaQHCiPllXxTZITPjn
         Pc1GYf7Z2nvpXE9yI1Z4fU4Oaibv0Wng+1u0O+JtyrO7cAe8zltj5qAtrm0jVouWDKqp
         wxMXtnNaw+UGugaLoMKnhca/+qSPA51U27Y+WPH9LhzTdaPMLJthwqy+o2H/kHGJFU5v
         zcex7eucr8UcmLQnC6Hw8Xt1iKiDNkbv/OqyTLli2z6Mj162j4ytc253hzEt5AbqVh0l
         Md5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5ejgBXTAIUixboB4DJUAMoeq/lr5AGnM16DSQO4iD0=;
        b=MUGtyEqtyvoQAWH4ktK0dVbE7aUzZW40qimqfSM81p7VZeFeEUNJmdGH3MWJXcPcYQ
         LbSzeA7q6sbXYuTxnFKuz/AD01Hz7vADpQ0iI9OE69O1rqhOfpi79MBUgUJHqLo+zB8N
         K6K2/FqDUrXWg6wsnyDw+zfbxlmKyL3GDPZmLCQv7SaUmZHXs3euthGzlsyhZ5Mv1d9Q
         AJC5llQuZCPzCLjdl40qTXiO9J8tNL4Prl/YYcOEPL6Ukgk6z+sHYM6mirqq1/RIYwUK
         jPWNkN6Huolls0O98tGIZMAq/17Un7JDwxAVXFP/R5+dzjcIxYYXQqY8+0fX+TOoW/ih
         r3eQ==
X-Gm-Message-State: AOAM5303nKSJUPCuTZCZp3Qst6vFcvPTBfhp9qNCg16pLL/2PfH9IM7E
        QQEVAL5xv6b74wP49CSr1ZE=
X-Google-Smtp-Source: ABdhPJxxgUYp/Q7pUWclcnmdGsopJnbeev5DMjUldDXikj/BlTisP/Hk4WZo8xQgJnuYpuARQyVVUQ==
X-Received: by 2002:a63:81c6:0:b0:3ab:616b:35b with SMTP id t189-20020a6381c6000000b003ab616b035bmr23545343pgd.256.1652321210709;
        Wed, 11 May 2022 19:06:50 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id a17-20020a63d411000000b003c14af5063fsm520814pgh.87.2022.05.11.19.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 19:06:50 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Anders Berg <anders.berg@lsi.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Fix refcount leak in axxia_boot_secondary
Date:   Thu, 12 May 2022 06:06:39 +0400
Message-Id: <20220512020641.45156-1-linmq006@gmail.com>
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

Fixes: 1d22924e1c4e ("ARM: Add platform support for LSI AXM55xx SoC")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-axxia/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
index 512943eae30a..2e203626eda5 100644
--- a/arch/arm/mach-axxia/platsmp.c
+++ b/arch/arm/mach-axxia/platsmp.c
@@ -39,6 +39,7 @@ static int axxia_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		return -ENOENT;
 
 	syscon = of_iomap(syscon_np, 0);
+	of_node_put(syscon_np);
 	if (!syscon)
 		return -ENOMEM;
 
-- 
2.25.1

