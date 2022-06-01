Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F43539F15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348759AbiFAILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346307AbiFAILi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:11:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE7F64D11
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:11:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s14so1075267plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3He5zqQafCaqxIZZoOREzUNxsIzRMeOPPdePDkzSSxg=;
        b=qq9VhWsouBy8dPsUw0DdBt28a/qRbqk696UR/zScNQXa6Pi7KY2McPssAJ1mKoUkv7
         uVrRQm6pZstAqrdUSPKX87knMJV4KXUA3Aeb/Tt+7hczVx/aSq5wQazrO/5unjQ1r3df
         pb/pROCHQc7RQwCBCEa/bCDOqDzviTCL1mRVgUbNg7bJxIPlGlr3D6l0FI4xvrUjdZRN
         hv4WsyIDc/y+LByUw3u1AgTorxoUq8AVsG60WdihRWp5u2/ceoThtMTxZJihoZ8MAcY/
         OnIaoliAV5+me8384xFFMQRbW57UORsgKmj1ZDNILAnvckpLK7YGwh1osExA2jMN2+X6
         7z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3He5zqQafCaqxIZZoOREzUNxsIzRMeOPPdePDkzSSxg=;
        b=Lg/5XuC0KxCK7FmWAtD6dWUdszpeaEr5ZNBJDKOv3OjiMMX/3CQCYn5teofUPZoch+
         Qaxcaq23Or4RGElbwkJVuJF74A0B5zmmAhV5YZ14Wr6LRNCRvhVJdD+GDFndZtiebXMX
         fI2DCxns0QxfayB1zeV3SG1IMpjfYnlE9H3GacpNGqzKbYh5jX2Bf4Xr6yeVkZU/GSrd
         eghF4yWljJn15stnXeNbAXHCwTfSwn7lr01jr07fuQIZAQDYqXsdWOmCEqX8jQKirzjU
         K9mx065CZA+EuMUETGlPIgHmcaYP32ZZLrT6OsH1W45k6yJ37k/rf50OvalPfvq4Ok86
         nDBg==
X-Gm-Message-State: AOAM532SzZ3kg14HwOECY3DKuDeM15+d7d+8yCVaaT/1ZSX9c1nEDtYz
        a+WRqy9goNdZb9AleSZN00E=
X-Google-Smtp-Source: ABdhPJzBCG24CTqcAbxbuUX+p7x/yKqMY2QNv/dS6wzJy4NlNTOe030W2heDInH+ViGtU8VE+LwDmg==
X-Received: by 2002:a17:902:e484:b0:164:1c:57a with SMTP id i4-20020a170902e48400b00164001c057amr8152447ple.12.1654071097415;
        Wed, 01 Jun 2022 01:11:37 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090ad0c100b001e2f3831102sm792288pjw.17.2022.06.01.01.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:11:36 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 2/6] irqchip/apple-aic: Fix refcount leak in build_fiq_affinity
Date:   Wed,  1 Jun 2022 12:09:26 +0400
Message-Id: <20220601080930.31005-3-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601080930.31005-1-linmq006@gmail.com>
References: <20220601080930.31005-1-linmq006@gmail.com>
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

of_find_node_by_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: a5e8801202b3 ("irqchip/apple-aic: Parse FIQ affinities from device-tree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 12dd48727a15..478d0af16d9f 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -1035,6 +1035,7 @@ static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
 			continue;
 
 		cpu = of_cpu_node_to_id(cpu_node);
+		of_node_put(cpu_node);
 		if (WARN_ON(cpu < 0))
 			continue;
 
-- 
2.25.1

