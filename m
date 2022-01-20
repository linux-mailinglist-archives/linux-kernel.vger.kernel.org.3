Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792BF494C11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiATKul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376397AbiATKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:47:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF8C061574;
        Thu, 20 Jan 2022 02:47:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id pf13so5423587pjb.0;
        Thu, 20 Jan 2022 02:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=68FjrFR3RAqjKzyB55RwMegw/F7hpuSuK3Z6kMQ5ujo=;
        b=Jy0i0rxSQWFnZ9dvw8ADJX4zh1/M2PYcsgwOhj28oB3k+lvPLLswsgu04yP0bgUsZD
         BUG3tF9L2GrjUyi4bOv+6EhWJRC5fahH08O/PahLEyFFlUpAdzSQ6Zo3aVFL9d2qaxHU
         N2vtHGFAPD0YW0scU5Jv732bwxonidvz7PZpknMfPXBkq9olfzc5H/gtQgPJUctPPFQy
         xGKKieX1rDFDiBRCX4bi8/IW2c7KdLJwXwRAFPFcMAf0BOJP/PEqAmnsb7hTIKB6kTMO
         YccsVaE93RYUP6SC3SOX/0CMGsvySHsEDfc398en0lqxFzI8jW+4WEsm7XEFAeqBzakl
         ZUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=68FjrFR3RAqjKzyB55RwMegw/F7hpuSuK3Z6kMQ5ujo=;
        b=ShM4/VGzIr/vs+8bvoAXpFKZPX4JEstblxyDMHDHykqGRNHZnbkP21z/YYk/zF9IFW
         Q2SsbPi63tFU/GAqKsjN3uYOR5oLV0BXYXhFfesFfJao4rixjdGtTbsNAIa9GRsD6tKe
         dB5iN9iH0Dpdsdo/Y41WOEGOHNRkuYIw1mDFlsXVmu6q6AxJuJL9tthzTY2JN66fOwab
         HvhEsranRgpjugtJ2/x66A/4xquN7Z/c+qJ4F5LsOpMPw+pMCcZ/Vw1pDoQOpRffYkTE
         m0wrPZss09vJgAl7Rm5EqXoWjNIDcosZFDQTwm3P0G2L1sSInt0C1uO5shXFRd6Fu/Hy
         oWeA==
X-Gm-Message-State: AOAM533dqa03uGY0NRrSiMf9FRpYqsC23wYmoqbonHEDLACRYJL+Dwvu
        ZizRnxV5Nwup9Ix+nJrjgBI=
X-Google-Smtp-Source: ABdhPJzQe3MgRhhwhK8NOwf4Ko1k9iTRtYxZj3qrTjIccBz0OsVHMg7leRGxVfMXws11YBCNxbscqw==
X-Received: by 2002:a17:902:a404:b0:148:bdd6:d752 with SMTP id p4-20020a170902a40400b00148bdd6d752mr37413179plq.20.1642675619936;
        Thu, 20 Jan 2022 02:46:59 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id kx11sm1572575pjb.1.2022.01.20.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 02:46:59 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] power: gemini-poweroff: Fix IRQ check in gemini_poweroff_probe
Date:   Thu, 20 Jan 2022 10:46:54 +0000
Message-Id: <20220120104654.3467-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns negative error number instead 0 on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: f7a388d6cd1c ("power: reset: Add a driver for the Gemini poweroff")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/power/reset/gemini-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/gemini-poweroff.c b/drivers/power/reset/gemini-poweroff.c
index 90e35c07240a..b7f7a8225f22 100644
--- a/drivers/power/reset/gemini-poweroff.c
+++ b/drivers/power/reset/gemini-poweroff.c
@@ -107,8 +107,8 @@ static int gemini_poweroff_probe(struct platform_device *pdev)
 		return PTR_ERR(gpw->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
-		return -EINVAL;
+	if (irq < 0)
+		return irq;
 
 	gpw->dev = dev;
 
-- 
2.17.1

