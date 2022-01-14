Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4948E4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiANG7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiANG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:59:54 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EF2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:59:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t18so12511760plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sMiUYednCQJSRHxHtqfSX2as3jVnaRZ2PEvGDirxWYI=;
        b=EfE4BurIjMetXXjYMLosZTegzgC4LlPvGrOq0Px60VCMjdHu4idm1xI8vsfW6X6tWj
         jwssOdlz3aemYbT1IjJC3FMutWBliB0TdE5mF7+uOVTVAeNMRZaec3l5i+kgsroPLcEW
         7nj0qocbn5AXpCcOABz57pl9U1JOJCzPGezPLeTl1gWHJVvGblsEDk9Pr428QECcvhmu
         cmydqvrNFNyylrPtIKpm4Jc1+XBe5Ngzp1s4BCQQDoZfICdXTi4PIfRM6n93B5MqRQyj
         XlVWaeVgStI1WmzNSg2iSwffDjVN98f64z9SjwlLFJkf7YwW4JyUufi4YfBtanKRfwBP
         K6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sMiUYednCQJSRHxHtqfSX2as3jVnaRZ2PEvGDirxWYI=;
        b=7yTWajFoPOJgZ9lNiiUFL/TPzDtZRmXgBEzULnVHVBhfNx/VStq+4A8ZMU+iHNafZI
         RMDXBEDdod/lPSDSW/mcKo9dfcvuPfUzzyRLvpmcF+xMBCamLsLiODaiT53UiIwyK73P
         gHvvxkkQguVq5ZDgcYmZkKoPDp0Bu4e5hc4DdcrSj6UfCzrISuDiPlcwYDOyT9xjUPo/
         XB8904ytYgSRYWCoj9CGva15GvCYPexZBktkTV79OUEMTrxNsEq4E0CGZatQCdqTeE9/
         2Shy+PAPVA6VsXONjgNes4YhW+jkhUMCe4HBLfNniGf4uN11ziC+H/yjoAkcH9ScG3hN
         ZArQ==
X-Gm-Message-State: AOAM5303uQodDEmeCvxlurFU2hrfOnUlsRk5wZagyr9fwfTFgDHnY64D
        XPCKqyPVeS9XPA9C/GuxzcHYqe5iUkt0HKep4Gs=
X-Google-Smtp-Source: ABdhPJzMhzae1DkLdfW1Llg+yDgCGg+UsCkpPfP0HXcaXwbP0Us4sQIiXv23eDt0uAOjqpnXCwN+qw==
X-Received: by 2002:a17:90b:4d89:: with SMTP id oj9mr9209736pjb.64.1642143594321;
        Thu, 13 Jan 2022 22:59:54 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id o11sm3745221pgk.36.2022.01.13.22.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:59:54 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessandro Gardich <gremlin@gremlin.it>,
        Dmitry Artamonow <mad_soft@inbox.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] mfd: ipaq-micro: Fix IRQ check in micro_probe
Date:   Fri, 14 Jan 2022 06:59:49 +0000
Message-Id: <20220114065949.24126-1-linmq006@gmail.com>
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

Fixes: dcc21cc09e3c ("mfd: Add driver for Atmel Microcontroller on iPaq h3xxx")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mfd/ipaq-micro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index e92eeeb67a98..ac042bfd38a8 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -403,8 +403,8 @@ static int __init micro_probe(struct platform_device *pdev)
 	micro_reset_comm(micro);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
-		return -EINVAL;
+	if (irq < 0)
+		return irq;
 	ret = devm_request_irq(&pdev->dev, irq, micro_serial_isr,
 			       IRQF_SHARED, "ipaq-micro",
 			       micro);
-- 
2.17.1

