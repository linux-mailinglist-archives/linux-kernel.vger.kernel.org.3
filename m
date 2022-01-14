Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6DD48E463
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiANGsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiANGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:48:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D968C061574;
        Thu, 13 Jan 2022 22:48:32 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p14so12568128plf.3;
        Thu, 13 Jan 2022 22:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=i9LyRM/Cvn/+ZP3AQxRWnhMX0KWeMjk3mtcIWGDqIOY=;
        b=Yu+SIb7UPWWNf98D86v7vRcE53pixxEAAUzjpQsuI98UZloflGLRvoFkiVzFHocyGU
         OqLrJmE8XMYqUKsxrMv+/QY2H4zTkj26a5AUVqKkgeBx/kzguZjJzL6zIp+Wok4+YZJW
         WsmjToMMq371jWtupX73Km4F40GewrZA+MF4VetPFPDXSz6zm+TxV1LydLiXs9ERfCEY
         /3Rbsh32aHRnVmSgPTiPXk22CrqGXU3JGvZgkKgIvT34bqjMG3IbAS6hH1aOiaPr2IRx
         hxyOxWGVa1VSy32mSGKhCtKfFP9YmWYK+HJ6fQXfuJoQm4fPL/KWIcX2VENAG4BSpOly
         dHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i9LyRM/Cvn/+ZP3AQxRWnhMX0KWeMjk3mtcIWGDqIOY=;
        b=iAmPmzLHVDJK1fJe8g588PrsIOtB8l3+vS3QRrm4ttVUjTDJ/grpKKESpuJ0ggHWci
         fcNCxTgdPChCwp8zezH6ZFMqR1Vr7UI1CSaFeNaXPQVU8f2ezU03+Iirk0wbqxatLqF0
         mqQ7Recxxi06zgZ5qZ/DEGv6yDk8cOXBHX42quY3qhYqSEtOyojffr/f0wynnaeywRqt
         36PzgLTKulJUYHPC2n5tcyhiGnBmM2hx6i5BqAerPKDYFaUPdMhl5Z0IV1OoWXWaXj1M
         jGk8oatRBFsr/RUp4rawfCt90HCBwM6JSZEWB0M7iiggIECdVZ2TA54DWWGKH0PADSs3
         QcDg==
X-Gm-Message-State: AOAM532NXlfwNuZ6sUtjIpiXhnsE3rpSFWlbQ7XU1K5GPTvu4Ll4/ZQg
        gLwb8cU9XRQGyjJummMX06VMJ377LyMQ67uL5vo=
X-Google-Smtp-Source: ABdhPJxr3Eu7BCOij8hAseKJMFyZ5bBaDFUsQeVAYjhRhQ2HbzVBrf/L7t1Y743sFpvYe3fPkgjLtQ==
X-Received: by 2002:a17:90a:d901:: with SMTP id c1mr18430192pjv.204.1642142911621;
        Thu, 13 Jan 2022 22:48:31 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q9sm11679568pjg.1.2022.01.13.22.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:48:31 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Ran Wang <ran.wang_1@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] gpio: mpc8xxx: Fix IRQ check in mpc8xxx_probe
Date:   Fri, 14 Jan 2022 06:48:20 +0000
Message-Id: <20220114064821.20200-1-linmq006@gmail.com>
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

Fixes: 76c47d1449fc ("gpio: mpc8xxx: Add ACPI support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpio/gpio-mpc8xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 70d6ae20b1da..01634c8d27b3 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -388,8 +388,8 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	}
 
 	mpc8xxx_gc->irqn = platform_get_irq(pdev, 0);
-	if (!mpc8xxx_gc->irqn)
-		return 0;
+	if (mpc8xxx_gc->irqn < 0)
+		return mpc8xxx_gc->irqn;
 
 	mpc8xxx_gc->irq = irq_domain_create_linear(fwnode,
 						   MPC8XXX_GPIO_PINS,
-- 
2.17.1

