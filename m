Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4244DD89C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiCRLA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiCRLA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:00:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E52D7A8F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:59:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so1902348pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JMgc3wka+o++Hf45XXTdLFL85p2TEAv1xtfwOX1r76c=;
        b=AuNJiLAsKwFcK6iA+Zi89DPL7jrMeQNTswTDATRhGHGQ6i7F9xQiXUlp7F+CYjEFQX
         zTH3aYxX7+Q40QPfHH0UxJjXD+YIh9mvxnlhPtYWKF//98nmVmKNVSnY51Jf4Dq47c/E
         LDsdOpdkPsP9bC85I0Ppris6hlxo44ZsvKVk81trvQwK1FsXptjqOud45EHUkFZvK8Gq
         GQKXJ151mXTravr/px/gbbsrpd4qZh+9hkZBRbCLlh/sHzY5RcqgY7VTqA6F8kRvX0TK
         cSSlemwmfwiIlssb/lTzfIo2dWSUtoGRCih/hiQqoC+blPetmdWpIuYQ3KHZe6g/xZzI
         n9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JMgc3wka+o++Hf45XXTdLFL85p2TEAv1xtfwOX1r76c=;
        b=TlKT9Cs066y51V4MUzge+xQBtsg6klyHn3t/C+JdTOR6zsphNjXvD5GXNkGj2f8Xnc
         S4/UZO8YEwtHgD0PZEmpoa1KNYRJylUuPFi8QJ7tua7URMA/xp4i9nP/Ge/5tfGTNVDN
         BGiJjmzB1we/DQEpxA7HEzjMRS2jHUMu4PrgaQ4igoE66EycSCr3pdB4i/UvX9vO1Xnt
         mu7X6cdpMrYsVN7PLwqPLAEHYUhLlz4O5Br/0+P/Q5Lp0kDkhDiqySAlFgXBB0YV5pkN
         9+6wEbDnKUljWC0wStgeei3EeevGnOOlpdRp5RJhXyFQBfo4p3rt9lesHGyZ5VqqJ/W6
         DzmQ==
X-Gm-Message-State: AOAM530iJ5y0wMzfvi/CYofNCy9TQlzOMyDFaGvXXSiKtWkfpK9URu9R
        Kwkqbux8VRaMQALgLrnyoF8=
X-Google-Smtp-Source: ABdhPJwbsNlyjNQOdLY45VJtqKPS4IVi89HNLEj8CmVBUk5EsrBeA3YP8NMjNusRYeviVq2HoajRcg==
X-Received: by 2002:a17:90b:4c44:b0:1bf:f00:3735 with SMTP id np4-20020a17090b4c4400b001bf0f003735mr21180733pjb.168.1647601177091;
        Fri, 18 Mar 2022 03:59:37 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id z12-20020aa7888c000000b004f3fc6d95casm9420298pfe.20.2022.03.18.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:59:36 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Igor Grinberg <grinberg@compulab.co.il>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] ARM: pxa: Change clk_disable to clk_disable_unprepare
Date:   Fri, 18 Mar 2022 10:59:31 +0000
Message-Id: <20220318105931.18480-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316022122.7426-1-linmq006@gmail.com>
References: <20220316022122.7426-1-linmq006@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The corresponding API for clk_prepare_enable is clk_disable_unprepare,
other than clk_disable.

Fix this by changing clk_disable to clk_disable_unprepare.

Fixes: 7a5d9a913f91 ("ARM: pxa: ulpi: fix ulpi timeout and slowpath warn")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- fix typo in commit message.
---
 arch/arm/mach-pxa/cm-x300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 2e35354b61f5..fcf5b8fa5b9f 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -538,7 +538,7 @@ static int cm_x300_u2d_init(struct device *dev)
 
 		err = cm_x300_ulpi_phy_reset();
 		if (err) {
-			clk_disable(pout_clk);
+			clk_disable_unprepare(pout_clk);
 			clk_put(pout_clk);
 		}
 	}
-- 
2.17.1

