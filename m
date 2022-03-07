Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11CC4CFD6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiCGLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiCGLwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:52:16 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAFF6EB35;
        Mon,  7 Mar 2022 03:51:22 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o26so13342485pgb.8;
        Mon, 07 Mar 2022 03:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HTqHyHAKvxige/PSxTTIrGSB+7k0M0gtMTz44wQdR54=;
        b=NqJ7pwyhDUmrQwkEUqbtipOImjyNUT7+ucPtZrpPu1M0I0lkMEpwenZbTOy8vYpXqC
         71oS1bKImehoMFHzJ+EHM9K4djN/eC3TicDalJZs3z0glqHnqH6Gdq0wjxvmlWetu7OD
         jwkiSk8pJR/21ETeqYIU8cxNEJeLYNhjKa3vVkrHkiL1dxE47TRmDgol/F8v3eUzbIVn
         vpxxeMoDWhb9MZrM+WVi8OdPSw7RzQa2lh3RO6/qIsu6SDPVfYYMprZ31EICTCrYweJO
         dfseJuUtM2mdLayX6hc7t6bTM5FsoFIN/MFknf4ThH26hOygZ+iqv4ta6A9T3Y9ParZ9
         2dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HTqHyHAKvxige/PSxTTIrGSB+7k0M0gtMTz44wQdR54=;
        b=QSLKllc1/LE9xPB/YPNix3uey/pTTrARjd6shftJz/I2u+61WE5HTtw2rV72w5oa3K
         wru90yxCYtuNa6dWHIY4O32M5BKZEVkCEluKiVmmz167PHbq6KeHsm1io9nEMhHUFPuT
         WooQauXlCqFfBhhrLbjA2thRNZNSN0UOVQjCP6ffKEpSjhsExUdsNqyKApyV93+/wAd/
         F1XMopm/vvPQBcDSQBl8mbMe4i6a124YVPurWn6DD8tQTVDD+udpTlHmY9on/MoEsaMu
         TWSRmmY1/gSSTVXwTKTqP+rdOBq6l9R4+os9efrXuTGAoNhLKDA1ftYJWRG2jEMygLAL
         Euig==
X-Gm-Message-State: AOAM532kMXm+/8x6cAaSHfBYxnEV5XBeX+NgKyJPAO2oK+pNAZa+HZVL
        S8BZzq01IqpTiJ0lNOwWf4M=
X-Google-Smtp-Source: ABdhPJyfH/yvR4m8poFpDnukyyRhn+9Hdq6N2qrjHsU03URTFwo5csdyqVUyGV6NfW4eL3cfoAR5bQ==
X-Received: by 2002:aa7:9183:0:b0:4f6:d609:af66 with SMTP id x3-20020aa79183000000b004f6d609af66mr11231469pfa.23.1646653881989;
        Mon, 07 Mar 2022 03:51:21 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056a0023c900b004e10365c47dsm15348809pfc.192.2022.03.07.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:51:21 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] pinctrl: nomadik: Add missing of_node_put() in nmk_pinctrl_probe
Date:   Mon,  7 Mar 2022 11:51:16 +0000
Message-Id: <20220307115116.25316-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This node pointer is returned by of_parse_phandle() with refcount
incremented in this function. Calling of_node_put() to avoid
the refcount leak.

Fixes: 32e67eee670e ("pinctrl: nomadik: Allow prcm_base to be extracted from Device Tree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 39828e9c3120..4757bf964d3c 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1883,8 +1883,10 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	prcm_np = of_parse_phandle(np, "prcm", 0);
-	if (prcm_np)
+	if (prcm_np) {
 		npct->prcm_base = of_iomap(prcm_np, 0);
+		of_node_put(prcm_np);
+	}
 	if (!npct->prcm_base) {
 		if (version == PINCTRL_NMK_STN8815) {
 			dev_info(&pdev->dev,
-- 
2.17.1

