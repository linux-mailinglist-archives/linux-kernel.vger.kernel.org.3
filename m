Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05F6539F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350623AbiFAIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350627AbiFAIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:12:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC82494D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:12:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i1so1082859plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+PEPLe6RgZ/co/uaiAinJBginVPw5Z9zDkizQywe5E=;
        b=km40SlpgsEcHZucZJOMM58TzoKmps1pvbmNm/0yqRjeCUeLKj6NHUZPPOJQisuxz+I
         rs9cx7BB0u1eIYLzMLL1UwKxI0Z7njWVlGW+l2GnEWZ0T3MqpChFsOrCE9YptV3SEEfa
         6DKzWT5fd28uC8AzWz1kf+D9xlXYwJrVccOcbMlq3jyROjBzntUh3sOefIJsygyrUO0I
         HElvR9jNp87t4Sw/+ZXDV4uI8+LT+E0qJqg60uNna25YcqOMbWe42urRnYoq1YsFJ8J2
         gGsPMeV37dd5rwRKh7ei0ghgmWKcFyfBshDxi2utkBoGqs747Wp1vPlo+3fqw7StAVIq
         3bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+PEPLe6RgZ/co/uaiAinJBginVPw5Z9zDkizQywe5E=;
        b=n7DTJJE84c6jH4yhCzGljcrngBeaZaHQfIt+8TUlPDu+5oKi9CN/+tDppB8ueVuASi
         WnYv8X7HsiebjqkROCnXlFjPOWk+x4XZ9rntrfkUOiAzDsuIopRfAdW/5fFq20x7R9/7
         SayQEhmTuUcNTWfUyWyMf0tjurG+Ak8sW+/Iz9QfeSEdBL98px3KfZGIAdJGJ1LzFsaK
         rq/xYQjgU/rTLCaP413KeV+YIh7t5Nu6+COr8JdPAhaOPHufTBIHuKe0AY/v/W56YfVJ
         yvmeCf0ZtxBlwnjSDyfjPSPvtp9XNGo3sP8DeCexPXw1POZxSNlUjQNCcwRT+dqnjVgQ
         MKHA==
X-Gm-Message-State: AOAM530fguMTtzCeKcA+7/5dYFB7cdKCnhdnf0e8b/3DwZDVgs4uajTG
        dEr2+OfV+rtq4TGPa9cWsk6gCWu00u7AhPc/
X-Google-Smtp-Source: ABdhPJwFrVaDOS+yHOraldAu8p/JQBxp84sZBopNyIVCcUoYq2dXh8kiVGYqtM8BBG6ywJ4n/pN6Kw==
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9374 with SMTP id u10-20020a170903124a00b00154c7a49374mr65595986plh.68.1654071133567;
        Wed, 01 Jun 2022 01:12:13 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090ad0c100b001e2f3831102sm792288pjw.17.2022.06.01.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:12:13 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        John Crispin <john@phrozen.org>,
        Bert Vermeulen <bert@biot.com>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 6/6] irqchip/realtek-rtl: Fix refcount leak in map_interrupts
Date:   Wed,  1 Jun 2022 12:09:30 +0400
Message-Id: <20220601080930.31005-7-linmq006@gmail.com>
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
This function doesn't call of_node_put() in error path.
Call of_node_put() directly after of_property_read_u32() to cover
both normal path and error path.

Fixes: 9f3a0f34b84a ("irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-realtek-rtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 50a56820c99b..56bf502d9c67 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -134,9 +134,9 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 		if (!cpu_ictl)
 			return -EINVAL;
 		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
+		of_node_put(cpu_ictl);
 		if (ret || tmp != 1)
 			return -EINVAL;
-		of_node_put(cpu_ictl);
 
 		cpu_int = be32_to_cpup(imap + 2);
 		if (cpu_int > 7 || cpu_int < 2)
-- 
2.25.1

