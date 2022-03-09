Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9B4D2D4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiCIKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCIKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:44:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5961EB7EC;
        Wed,  9 Mar 2022 02:43:10 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id bx5so1940512pjb.3;
        Wed, 09 Mar 2022 02:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bt4ZemLtOjAhYVYN3C3UPz2pvYP7puf8xAJCLiBgkNw=;
        b=e9B1wDLOf0IBpGci9IPcFDA4oMNKSdRyxP5107p72QEijTIajuJhTQXofC5jCJexCt
         7CvG9btzhJBjZhDgvKjoMZyJfZ8Xpx169D/L8PUtQbtKxbQwICizvntN6Mr6pNskNeKS
         t2yljdxctGr/R8HzFqOh9E9GDU2/AsQZZSVJjGCV1rpj3PiPaC6iwRz6Um/YTUSnntoG
         eb1jY//ACNfwH1FO90zAQWNVCDOOZHEkmIAxKPktWIg/UGuFmIpe4pSRrXkO8AGEgJPe
         fjbqGGlAt5VltemmdX9w3DILkVFViRmIuj7Eh9svTu6pnOSwwKvrRg+H0jDDeHPJuaQ6
         WF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bt4ZemLtOjAhYVYN3C3UPz2pvYP7puf8xAJCLiBgkNw=;
        b=MsiVA0Lx09Gc2pWGU8NPjEvFxL4G/o+pUn9YSCOMctSZZUGNx0YmM/ByLVmpCjT6nF
         j1jy4hyA0/L8EXSKFxdO8CO4g/B1kuWFBWQi2t/mJWcyvWlvyUjdInqtTrIWEQjizsX7
         VUrqYuF0yPcv8NXqGGkGCnHTVjdN5F5pvGzMgNH9qsavSWzP3qze3zDFNIO9e6ow4btE
         ex95Iq3PrLCaA1S6/rPZshznwWe/Iuz26gg91hCP4hbdnqpc48mltUXjZBhxrKTkwoVW
         WfKIwkRPS9hJXx8M5kMGhr4vFDIJ4AnSDQIww1RVImgLFkhi3Yz7yhf8TtUjjWO8o+sl
         9I1A==
X-Gm-Message-State: AOAM530BuXTX6Ug1w1wMxAhgcNHnuQC2986zRx+IEb6Dtm/mogG+xz4V
        4zPTzsjOGyNW2pbgJdLZTr8=
X-Google-Smtp-Source: ABdhPJxFu1likQj+qOnn7a71MxPF9QsD64CJ2bBKawmiVY26O2ssL8I2crrpWf0Yng7mbq8b7mW+3Q==
X-Received: by 2002:a17:902:b60f:b0:151:a83a:5402 with SMTP id b15-20020a170902b60f00b00151a83a5402mr22098156pls.21.1646822589768;
        Wed, 09 Mar 2022 02:43:09 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm2487557pfj.43.2022.03.09.02.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 02:43:09 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: OMAP2+: Fix refcount leak in omap_gic_of_init
Date:   Wed,  9 Mar 2022 10:43:01 +0000
Message-Id: <20220309104302.18398-1-linmq006@gmail.com>
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

Fixes: fd1c07861491 ("ARM: OMAP4: Fix the init code to have OMAP4460 errata available in DT build")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-omap2/omap4-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 5c3845730dbf..0b80f8bcd304 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -314,10 +314,12 @@ void __init omap_gic_of_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
 	gic_dist_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!gic_dist_base_addr);
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-twd-timer");
 	twd_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!twd_base);
 
 skip_errata_init:
-- 
2.17.1

