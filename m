Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665BE539C60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349591AbiFAEtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiFAEtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:49:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9152B31;
        Tue, 31 May 2022 21:49:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b5so675396plx.10;
        Tue, 31 May 2022 21:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQQdqLGDEyEaJ0q3XFvWz51XQwcwBB1gnP9grs45a0A=;
        b=l0N4Jd8kgXKz6N4pPkce+78dFAQxuAbgMSVylHnUGhpEqPXBAVOiY0OoZwRy5c+IkW
         xB5+7Z7sSTibAAqsd7xVrOEMfm+H5pjtwKLOra+t1UhalNkdExB1AJI7wg+LtrywJL2J
         6BJ9617aJ/gmk/K+56QdPBx1Tod7f1z9qvoFmmrJkDLbTcc+IMnjp/gRKbF9dfuTKc4Y
         pU7p8gDqZGCsW+6GQxDEu6Hr5+aexGgCW9ZbewgZMBWSmtSeIKb+598CNaU+TPuviGfl
         vMsoxFcvkd8XFj6gWz/pNEhNAZEUUt0MaU0xa038JYJD4NRoRhhrN3r4O0nk1rxkhw05
         cmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQQdqLGDEyEaJ0q3XFvWz51XQwcwBB1gnP9grs45a0A=;
        b=urj3kinUDPUjP2MFuEOOaV/8pQ7O/03P+5uJvz3RSKgfsECdbpjqXlp0iSFRsX39d6
         tyAlBICh7iyxvZ/3yUGRf19hqP7UxoxSitdhdCTAoZAtocwFICMzSXYy7MvBa4BJFyOl
         QAyjaL3oub+zvbo4sdqDZBl+HwoAZn7+iJeEcYYSXjYpb5GY+XFByeBOgIs2K3O/N58I
         jTr8vldYvU8GUgxQ01NGlDZffslBd2VuagnT0hlx9DWmb90pAoIiGg8POT/MOooGs6yf
         nbhe56fqB2RMUbtaelhAIxNHerNY0zcO2noeawsKCtVFy/dakFYSqBw7V0POSGyhGQot
         MoPA==
X-Gm-Message-State: AOAM530qnRMC5YDTGWaPYKAkB27dhu7vR1UiPEWS4LI7Y3HdqDH7IViH
        43amG644Pm/4OKp+QQZcKaw=
X-Google-Smtp-Source: ABdhPJxaDmfiU+rYQUhJxxGHahVE4aT3yrHtc2NV7ORrbgG83abmkaleOSY268WQG3kwgqwvVdi5zw==
X-Received: by 2002:a17:90a:de0b:b0:1e3:33e9:6665 with SMTP id m11-20020a17090ade0b00b001e333e96665mr7862047pjv.27.1654058947423;
        Tue, 31 May 2022 21:49:07 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id p126-20020a622984000000b0050dc76281e4sm315672pfp.190.2022.05.31.21.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 21:49:07 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: OMAP2+: Fix refcount leak in omapdss_init_of
Date:   Wed,  1 Jun 2022 08:48:58 +0400
Message-Id: <20220601044858.3352-1-linmq006@gmail.com>
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

omapdss_find_dss_of_node() calls of_find_compatible_node() to get device
node. of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() in later error path and normal path.

Fixes: e0c827aca0730 ("drm/omap: Populate DSS children in omapdss driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-omap2/display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 21413a9b7b6c..ed2cb2649cf6 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -259,11 +259,13 @@ static int __init omapdss_init_of(void)
 
 	if (!pdev) {
 		pr_err("Unable to find DSS platform device\n");
+		of_node_put(node);
 		return -ENODEV;
 	}
 
 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
 	put_device(&pdev->dev);
+	of_node_put(node);
 	if (r) {
 		pr_err("Unable to populate DSS submodule devices\n");
 		return r;
-- 
2.25.1

