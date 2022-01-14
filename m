Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DDF48E470
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiANGve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiANGvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:51:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E19C061574;
        Thu, 13 Jan 2022 22:51:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c3so12536805pls.5;
        Thu, 13 Jan 2022 22:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/FuM/QD+EctsS/kjOLzGFdhAH/fX2Jrazs1qclcw3iw=;
        b=D+bM9I19GX24QqOi2zLpVE4+xk68Z8mboXS4xh34YEhYfxs2hnr/UDOP7OGHAdqnHf
         U23s8uJynnbYJ4itaVH9IhQVoC5LDh6w76VoiCTVy3AO7pp+n2VoD6O9DUVjrgO07so/
         OIdsl0e/auOmdE3v1D6DfuffjFCWj6DT/f+TM80EZ8Hb5cii6qNbpIgokrCB5Se/Lw5W
         5FwMnz5Lsm6+/hOlmpfO7ClaEwNltTYI/JviWZO4BphoBfNyUfCgX0JnBSoENNSFqRn9
         uN/D19oVbvP+pX+WctZ2rZqhAbIa9YfNp2FaKulY1WZrRcZUlyYJlD0SQZc1K86fsKNe
         ZPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/FuM/QD+EctsS/kjOLzGFdhAH/fX2Jrazs1qclcw3iw=;
        b=5WPPah+vrw3e7Nzb6p0gIUSczpYW/qKZg5M8qRv0VR3sm/xcDYLcVMR4ah9mbAg4ss
         1XKmBZHbWmjbUcRHtJHvI9YZBMS8f/gDKvt+1xg3yJYdTNl6Ax3V8j5jqxXf+marwhNv
         Vc3tFTmrfZTZgZJnrnlX/JlMfn1spY8FKnMcQnki9WCm9Iq7PDX5Y/EpxcpCFqgIq0tp
         gtrf3ZQTVZJXZJzc+jmfYJppxRjzFU9xsi9dvrUZlgHTsFrfly0C52DlH+hsqHY3EFHg
         u7svDDugOKLVEfzth46A+lXIZ3qgbzO4srtgIr+OslSTD0AhycrhQIrT7NL1plPzT/Gh
         0fjg==
X-Gm-Message-State: AOAM530WuMRv8RlvPELCsvu5ybaSHn6eWtNNp08jZ1AHQ+CQfMt6h1Cf
        4TmKW0TJkCttKowQ+pOuBhw=
X-Google-Smtp-Source: ABdhPJzHNmLpxruW/RVPRtt4U7cfP9PeRVU9Al79sBEOvSgBQAC7iuTKpbviJHpCte6NzNRCX+zWfQ==
X-Received: by 2002:a17:90a:7786:: with SMTP id v6mr18589187pjk.11.1642143091193;
        Thu, 13 Jan 2022 22:51:31 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id r13sm3718606pga.29.2022.01.13.22.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:51:30 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] gpio: idt3243x: Fix IRQ check in idt_gpio_probe
Date:   Fri, 14 Jan 2022 06:51:24 +0000
Message-Id: <20220114065125.21208-1-linmq006@gmail.com>
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

Fixes: 4195926aedca ("gpio: Add support for IDT 79RC3243x GPIO controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpio/gpio-idt3243x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-idt3243x.c b/drivers/gpio/gpio-idt3243x.c
index 50003ad2e589..08493b05be2d 100644
--- a/drivers/gpio/gpio-idt3243x.c
+++ b/drivers/gpio/gpio-idt3243x.c
@@ -164,8 +164,8 @@ static int idt_gpio_probe(struct platform_device *pdev)
 			return PTR_ERR(ctrl->pic);
 
 		parent_irq = platform_get_irq(pdev, 0);
-		if (!parent_irq)
-			return -EINVAL;
+		if (parent_irq < 0)
+			return parent_irq;
 
 		girq = &ctrl->gc.irq;
 		girq->chip = &idt_gpio_irqchip;
-- 
2.17.1

