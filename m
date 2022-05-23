Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09F4531305
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbiEWPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiEWPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:20:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515085DA79;
        Mon, 23 May 2022 08:20:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w200so13983169pfc.10;
        Mon, 23 May 2022 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/Inwr04zz5evYrUoXhEX7FCvYRzx8i5GqA3k3ATkNs=;
        b=U8EA5fTmJXhERlLZ4BOZWIAaMdCQQGa+myhcNaM9kllBj7/CnKkKIObXyKQa1PNiG7
         1jnE/Eqygwm8GayKACdjKiZtfFvEZCFuyRFgwEFkQFPJpDGxOV8zPkBb111RAmZC65mV
         CHQWaLGPLrlX0PGEhi8Gyy21gtZwS+Cb/FVq1htf2/jfpFyYO9BVO2GiGQkypWiQMIcF
         tkq+JgF0Lc90WOUsv0moDrs9jzyZJfA2WAtsaufMT6c5HJ1bhNWBOMWT/M6xUhwO6rK0
         xDBXKrX5a6XvlEDPD3ZWCR5V+1wy0fx5N2r4omxifvSgDnk4eidRGni6h1b2ROaAQKbg
         AP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/Inwr04zz5evYrUoXhEX7FCvYRzx8i5GqA3k3ATkNs=;
        b=xmN8DbGNSmuW9NpUQwEn631PF7j6CerdcHXm91oS4A/4mQlHC3WuJrIMdq8FnbgevN
         FXktgT7RLMYWdu8zZKjuJAxrLfp779K/lRpHUc8at6l1UNx0IK2eVu0V6PLkeRanVR22
         BlK3QGpGgyNzHEr6ScdhxAmLvTyTo6YX75ClRUN5n0n1MM369S884fn/VjaNodwyiq9S
         4tJybJPE21G3BdqhAgzS99G3kP8TpCM1c8NvXFqkQRjjTyrQCrEDV6HN15BkJ8zJbnh/
         2VrjlrkhoKi9Mq0XUbikbrnLvAvdMA1yBcJ8TrIcicuhpAm4pdB+u7y9hyVR5eHRmRiD
         Gy/Q==
X-Gm-Message-State: AOAM532UizrzVgiAIg8MH9mH0pZXo2CYBd+lSiFwHXEpyuCDVCfNLIl6
        psRRkoWbDIqYpP44pWnXWjZotbTyVdOYwQ==
X-Google-Smtp-Source: ABdhPJxvvXJG0l5AKxskSnSV89HBpYiemGVnoAQea8WztiAzfZ/nSLNRoxvgYc0KgSejg1XFfxGELw==
X-Received: by 2002:a05:6a00:1826:b0:518:4c8b:c5db with SMTP id y38-20020a056a00182600b005184c8bc5dbmr19660600pfa.22.1653319246872;
        Mon, 23 May 2022 08:20:46 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id a2-20020a1709027e4200b001620db30cd6sm4714465pln.201.2022.05.23.08.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 08:20:46 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Joseph Lo <josephl@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: tegra: Fix refcount leak in tegra114_gic_cpu_pm_registration
Date:   Mon, 23 May 2022 19:20:36 +0400
Message-Id: <20220523152037.16078-1-linmq006@gmail.com>
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

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 7e8b15dbc392 ("ARM: tegra114: Reprogram GIC CPU interface to bypass IRQ on CPU PM entry")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-tegra/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 4e1ee70b2a3f..d51bdd46219e 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -73,7 +73,7 @@ static void __init tegra114_gic_cpu_pm_registration(void)
 		return;
 
 	tegra_gic_cpu_base = of_iomap(dn, 1);
-
+	of_node_put(dn);
 	cpu_pm_register_notifier(&tegra_gic_notifier_block);
 }
 #else
-- 
2.25.1

