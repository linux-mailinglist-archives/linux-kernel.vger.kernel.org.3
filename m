Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F8B4D2D22
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiCIKah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiCIKae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:30:34 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81A5D670
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:29:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q19so1603919pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=Rw/pp7CFH5EhW2LRIhOwhzyCXvO4+HLXzhoa8fZG4Vg=;
        b=UwnTNzCC2qThAdKUXhj8GC9fig6H+HILqjgvDTyireA20u+TrUP/ufwZSuSLsflHhi
         iQK1bA5v3FJdCZBN6hy7pI8wpFI0+lSDw9VblSXI3olRzMjbFZ6ymjAd2Url3XGCZEvw
         8VSmTlPP0XpIYelWPpm6II1PbAGeJxVJzcuISXUhIQqHaAgY2JyI19TzE1saEZYP2AWE
         xLTqRfP7kKa3QmiXzUZcXCEquP8qE+miojh2HwQsi0mlxj+WoSq3+XzWrVB8sa8i2jll
         SS5odbQP/RnYBh6fySO+ZZYTmh0v8Q6ymn50Ct3v5rHIWPLcRbS4vlcDPQh9ki8cfsGw
         YHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Rw/pp7CFH5EhW2LRIhOwhzyCXvO4+HLXzhoa8fZG4Vg=;
        b=bBj3Pa2UxlPyd5HbmxYqXlmV/Vb5LbM0YV66mSxr9/2+y8wgyx8kN0YN5Eo7Ora9C+
         sh27XXQH0N00TDjtvgNdLsP4traGViSMn4sp/Ymw2d/xEgG+ZlJJv3WR3xaKOhaPyszU
         bvkR/HUvrd57pBaatlcc0U3spn1adtQabRxrFax2KXJfZzOU9gkFmMbAX88F2S44qEsa
         X1OOaCN/LfIyZEI6w3OMW6zO+D4iAMgVoF6gFlJ9wXxF5qQasLiscHkJWE1RXgAK7CnW
         3ZZXUlyYLivEeU1YNVu/SSmeo7NgHoshbdw1qlAje6m9tO4ifQz04vR/ImRt/Q7F/W6B
         waJQ==
X-Gm-Message-State: AOAM530TIiTbHW+sIcnkAqx3g4FTaRCrcosP/qtLkGT/KwMTI4g2ALbG
        n6p7vV9X2MidK3wBstW9LCQ=
X-Google-Smtp-Source: ABdhPJxuPa44GvUtEMbeoDN2OwzhuAS4wgG/9yy0L5AfmcufRLo1H5gTmU+219QVi6s2KIxiCtoe7g==
X-Received: by 2002:a05:6a00:1251:b0:4f1:2a1:3073 with SMTP id u17-20020a056a00125100b004f102a13073mr22846915pfi.72.1646821775542;
        Wed, 09 Mar 2022 02:29:35 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm2604986pfh.58.2022.03.09.02.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 02:29:35 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <b20788@freescale.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Ranjani Vaidyanathan <ra5478@freescale.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: Fix refcount leak in imx_src_init
Date:   Wed,  9 Mar 2022 10:29:25 +0000
Message-Id: <20220309102929.16306-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() function returns a node pointer with
refcount incremented, We should use of_node_put() on it when done
Add the missing of_node_put() to release the refcount.

Fixes: 9fbbe6890c88 ("arm/imx6q: add core drivers clock, gpc, mmdc and src")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-imx/src.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 59a8e8cc4469..f28bfb653a88 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -171,6 +171,7 @@ void __init imx_src_init(void)
 	if (!np)
 		return;
 	src_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!src_base);
 
 	/*
-- 
2.17.1

