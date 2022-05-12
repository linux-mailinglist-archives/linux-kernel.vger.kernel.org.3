Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB60D5247A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351298AbiELIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiELIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:10:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FAEE4C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:10:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so5602221pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYxJzIlygzVtOu994zXNVLK64i/sa8H3L0sgERB2T50=;
        b=VRctKcDXv9xMu5JW5m0qsoBjvlr3ctTf+JhmvcxaOLPYGBFDbyPQTnhV8u6eCg0Mqu
         6qQkxwkHtaZTTNk082+S62OFf9aslJZ8cS6p4tgPjg0b9poI3dONCo9PTXjzF7a1A1Mf
         7e7oUKAomP3KFVPzcZRTWzSAFWaabh+xmnKYSF6f2Kvu53YJTzYJUpTnZrMVu0YU7jAN
         80umIx2HFePbizdbEd9F2ldCh81iII5aJLrdwyZPDAFbJkDI6p/tkfJBxBbV1GjTozL5
         tlGx9NyS8LtN7qltNMpZlcR9RKZ9Ya94NrIWmPc1Bo8Y4ROSmV6B2RFdWee4ItFk8Ymp
         BlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYxJzIlygzVtOu994zXNVLK64i/sa8H3L0sgERB2T50=;
        b=gxQjUDWFwGyuJuZDSxgUWTJGx97cAbY+Zcgc7vp2n3bcDE4G23mjsHo7+NIoZ70Mfz
         NX8FLfZSEVFDpRYk+VrYmsA9Hi6iVAKih4BPJSuPf+k2x+K4sCz+tnZEbsj0smo1zeRs
         5pNqAhT8gM4cNqgUB6iiE626z3KVYM9FrzqVl4sa4SIhEMbzOmv83vJDN7uVpyK+7foq
         uuVEWuZ+qwAsuQOeU9e3O+9L0BFxiVz+CREVHnt9UXTyo64Zl7nvUq6qBLBfMY5fYNMf
         CMk9/rxVxO2KNXqaExHWaTDk0hha++cGJf+O3QjCKgXRNP758v+hkRtL+8sUhFfOvf1g
         x3tA==
X-Gm-Message-State: AOAM5311LNfxCl+ORJfb6jylpssZ912VMTtiDemI5z4yWyjnf9kz5GXu
        WXAk3y1oloUQ8vk7sGamDgg=
X-Google-Smtp-Source: ABdhPJxWOE6dWlMK0mfC4ikh55aYQppXtqMkDNX4jcU8cX+Jt/bJ6LBoJnZyFghyC//BgxhUM1KKXA==
X-Received: by 2002:a17:90a:e38c:b0:1de:b43f:f969 with SMTP id b12-20020a17090ae38c00b001deb43ff969mr9691861pjz.126.1652343040255;
        Thu, 12 May 2022 01:10:40 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 10-20020a17090a174a00b001d5f22845bdsm1737745pjm.1.2022.05.12.01.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 01:10:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: hisi: Fix refcount leak in hip04_smp_init
Date:   Thu, 12 May 2022 12:10:31 +0400
Message-Id: <20220512081031.24301-1-linmq006@gmail.com>
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

Fixes: 9cdc99919a95 ("ARM: hisi: enable MCPM implementation")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-hisi/platmcpm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index 258586e31333..e9b5d63ecf4c 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -274,6 +274,7 @@ static int __init hip04_smp_init(void)
 		goto err;
 	ret = of_property_read_u32_array(np, "boot-method",
 					 &hip04_boot_method[0], 4);
+	of_node_put(np);
 	if (ret)
 		goto err;
 
@@ -283,11 +284,11 @@ static int __init hip04_smp_init(void)
 		goto err;
 	np_fab = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric");
 	if (!np_fab)
-		goto err;
+		goto err_put_sctl;
 
 	ret = memblock_reserve(hip04_boot_method[0], hip04_boot_method[1]);
 	if (ret)
-		goto err;
+		goto err_put_fab;
 
 	relocation = ioremap(hip04_boot_method[2], hip04_boot_method[3]);
 	if (!relocation) {
@@ -329,6 +330,8 @@ static int __init hip04_smp_init(void)
 	writel_relaxed(__pa_symbol(secondary_startup), relocation + 8);
 	writel_relaxed(0, relocation + 12);
 	iounmap(relocation);
+	of_node_put(np_fab);
+	of_node_put(np_sctl);
 
 	smp_set_ops(&hip04_smp_ops);
 	return ret;
@@ -340,6 +343,10 @@ static int __init hip04_smp_init(void)
 	iounmap(relocation);
 err_reloc:
 	memblock_phys_free(hip04_boot_method[0], hip04_boot_method[1]);
+err_put_fab:
+	of_node_put(np_fab);
+err_put_sctl:
+	of_node_put(np_sctl);
 err:
 	return ret;
 }
-- 
2.25.1

