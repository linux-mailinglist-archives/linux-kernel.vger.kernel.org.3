Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD054C4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346369AbiFOJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbiFOJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:40:46 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0B053D480
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5hnGH
        jCwUPZQVgKRaRy5vuDO0rLdxS2Va+HYRlMZSVw=; b=XiH4pkAQWJYbcQjkdAB1E
        hjTrGww7f72KAZpbUrVCVDAyJiJcRxxdmz+DiF98bG7wASKWVIq6XHzk6uw2P8r0
        xJAS48Nvzc8cyTygDeSEWKPzF+Sv17NpPpRMkrbsXFyBuiu8W6Paau4YikB1j5Yo
        +5e5EazPf1GryE+YufTqEA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgAH2EwQqali98+UFg--.44281S2;
        Wed, 15 Jun 2022 17:40:33 +0800 (CST)
From:   heliang <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-ux500: Add missing of_node_put() in pm_domain.c
Date:   Wed, 15 Jun 2022 17:40:31 +0800
Message-Id: <20220615094031.3962708-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgAH2EwQqali98+UFg--.44281S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUCr15GrW3Zryfuw48WFg_yoWDuwcEvr
        97Ka13Gw1xt3WDWrs7ur13Wrn29ws7Gwn7K34Fvw17tr18uw1rGFsIyr4ftwnrury2yrW3
        JF9rAFyaywnF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_YFAtUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhEhF18RPTAZlgAAsl
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ux500_pm_domains_init(), of_find_matching_node() will return a
node pointer with refcount incremented. We should use of_node_put()
in fail path or when it is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mach-ux500/pm_domains.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 427b9ac4af6c..80152e195fdd 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -66,8 +66,10 @@ int __init ux500_pm_domains_init(void)
 
 	genpd_data = kzalloc(sizeof(*genpd_data), GFP_KERNEL);
 	if (!genpd_data)
+	{
+		of_node_put(np);
 		return -ENOMEM;
-
+	}
 	genpd_data->domains = ux500_pm_domains;
 	genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
 
@@ -75,5 +77,6 @@ int __init ux500_pm_domains_init(void)
 		pm_genpd_init(ux500_pm_domains[i], NULL, false);
 
 	of_genpd_add_provider_onecell(np, genpd_data);
+	of_node_put(np);
 	return 0;
 }
-- 
2.25.1

