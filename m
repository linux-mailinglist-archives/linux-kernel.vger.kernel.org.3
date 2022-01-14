Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E6348E455
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiANGoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbiANGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:44:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:44:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso21084267pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=1Nv9cBoTms/HAwsSMh+lrTCJcZ3jwJC/miP/N5++3LM=;
        b=Tfs4fl6qHMuuHwQcDMVPYoDo86+b2M9lggqTgT/Et6qTm+mmefqpHC7XMjUueEuNDH
         ZLBIFPSx2EzW8aK666d+lPVK0uR19prsak1BPbGBey9A5JC0XfvWz2x8OC31GQGBwr4z
         CzUXU7C0fjAB7f6pO7P+N0N5eFVlUGAlAW7EzgikuU5+Lfz1oxYdUcJnXSSl8txpUD0W
         6OuodjwilZlkM6F2QZXyMbWHQ5RukOV7UZhjKfly4mxv12egYIebWd4A6PXsQSgfNtQa
         85YmtLFr6EfoUAjw44BzIqJ29pwgt4TNN2dcHG3xxXEcPVH5JPQDprnXMs4mrGUwq3Ld
         p3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=1Nv9cBoTms/HAwsSMh+lrTCJcZ3jwJC/miP/N5++3LM=;
        b=RkcHhJZZ/kEpTnc1ERxaaeOaCA2bPUwZ3RoACbA/3rOjjlCZvltBYJTCzdrvbQn8vB
         4GEPR/7MVxy8uERfGHcPLATvNjF/jaojgtIFJiWslfEz6zVvtQLKN66awnXhahCogVI2
         DgG5EFUjPbgvkmlCz+Na2xu73E72MNL0Mo9/qJ0l1ynfbbGjo5mtxLmFz0jzpblvWlNr
         KQ29bqYe0z/pGPPqkhvGfDCOo7lm+hctqh8kfXmLCIPfIC7LAKqJfZfSTvQzcyzOxkNC
         Pa1Kxi8gn787FgcatCFmopqWVaDrDjWjBlowEbrq1boOTJ7SFv+A/HipylGPuXFRhxvZ
         9wzg==
X-Gm-Message-State: AOAM533+9WR8TUCNztzT4Bfxhi4zQQKEImOQlrj5z9f+pQUD0AKF/wul
        CuiCZq8raQ2yWiUXzpEr3KY=
X-Google-Smtp-Source: ABdhPJyj9OUFs3Ifg7Q/foM4Lw4if60L1dh8TxGLGhtD4IOaR0ZdfzpiYGEpmw38sjPo4afyX6uhxA==
X-Received: by 2002:a17:903:2311:b0:14a:8068:a6d with SMTP id d17-20020a170903231100b0014a80680a6dmr5337470plh.70.1642142643211;
        Thu, 13 Jan 2022 22:44:03 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id t3sm4821080pfj.137.2022.01.13.22.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:44:02 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Patrick Venture <venture@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
Date:   Fri, 14 Jan 2022 06:43:55 +0000
Message-Id: <20220114064357.18562-1-linmq006@gmail.com>
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

Fixes: 524feb799408 ("soc: add aspeed folder and misc drivers")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8dfbeb..c4a03b3a5cf8 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -167,8 +167,8 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	int rc;
 
 	lpc_snoop->irq = platform_get_irq(pdev, 0);
-	if (!lpc_snoop->irq)
-		return -ENODEV;
+	if (lpc_snoop->irq < 0)
+		return lpc_snoop->irq;
 
 	rc = devm_request_irq(dev, lpc_snoop->irq,
 			      aspeed_lpc_snoop_irq, IRQF_SHARED,
-- 
2.17.1

