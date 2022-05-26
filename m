Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0AA534B41
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbiEZINv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiEZINs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:13:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5823A5EA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:13:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s14so849278plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBEKGmkjoE28MCTQbjd5ORFpa77bz/agL9nSVVFspD0=;
        b=U02aOGk0NHNgLEItlnR/QPW5AvWVU5/iXwA8+xraVYrHhGXGs4D8A9oemFul3CRDFm
         Gt2101IPsae1+c3fOcEO7oelNwh0RBOar/s8RgV5r/ObBLNGuQPlAqfPsR/s9iRQzP4z
         WnQfvK3RGHPcxf2SgCQSHORkoo+TIjKSqyZN5Mho/H7WU2D4Rln8imTv5CF0rK/rPwZZ
         lQxmSkh8REdO1WXzm/032CE8YqTVrI/vXRldYWBrGbnVh2V4l2FiyIPhnDTAe95lfLIO
         JVtluiWrCItcVn+GTC99TAQPh3839qq5fxie3xX4EiJ15cHjgQBHzVPWjg+nl8WukVh8
         qo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBEKGmkjoE28MCTQbjd5ORFpa77bz/agL9nSVVFspD0=;
        b=UXr1z1ti9d570gN4s6x9KJm1lNEIV5u0twChJgGnl9mfYpaFfe3NGc963V9DEKdM0E
         bnsxJHhAHzU/GjMACxESdPuk9zfmcjGYfbGGpx3EBQ1CJglrU9avuhJ6mV0nF40x8Oki
         DqbNWBBFRxhY8sWbBXri75/12pgHqCJhdxGblpVFEcNc+uBzEndXEULgKg9Gkb6HS8Vk
         kQKU67E9z31yrctibYglIKOpz2udsh53wujZJCTI/A+J55c4B0/sDxk4vw+TbAljpANR
         BhZXOWcJhU1m1SMG8KQXsYGlqOe8yNXDeL0bLVASak8iD0CPfRO01PzxPz+muIMt6IVt
         F8Hg==
X-Gm-Message-State: AOAM533dB6sG6x82CsGHpYzIsvAPAfKbC/VLRc7Y2FS1syaIZaPl2/fp
        J9aDupCNLkijZrc6wiFnkzU=
X-Google-Smtp-Source: ABdhPJwmyYXrCMYA89cDjci7YDwwnifRlFdnDsevNvEB4OhCP+IR2OqScWdmufnVH87NwZY/G/KuIA==
X-Received: by 2002:a17:90a:de15:b0:1df:63dd:9cfc with SMTP id m21-20020a17090ade1500b001df63dd9cfcmr1394721pjv.200.1653552826328;
        Thu, 26 May 2022 01:13:46 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id bg16-20020a056a02011000b003c62fa02f08sm904246pgb.43.2022.05.26.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:13:45 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Christian Daudt <csd@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: bcm: Fix refcount leak in bcm_kona_smc_init
Date:   Thu, 26 May 2022 12:13:25 +0400
Message-Id: <20220526081325.30954-1-linmq006@gmail.com>
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

Fixes: b8eb35fd594a ("ARM: bcm281xx: Add L2 cache enable code")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-bcm/bcm_kona_smc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index 43829e49ad93..347bfb7f03e2 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -52,6 +52,7 @@ int __init bcm_kona_smc_init(void)
 		return -ENODEV;
 
 	prop_val = of_get_address(node, 0, &prop_size, NULL);
+	of_node_put(node);
 	if (!prop_val)
 		return -EINVAL;
 
-- 
2.25.1

