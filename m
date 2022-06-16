Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F1C54D932
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358585AbiFPEP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350334AbiFPEPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:15:54 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41A92580DA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WJip1
        vdgwZXINHeE4TBvMkdfJp3JSJgbKQrJ7sW+WsI=; b=FSQQC3GR7nh2uSAXSLmC8
        GVUawLYN0Ki25I1+Ph9ghmMhgy6jqlDyUmUNdNYR7OmsXFec7iQSaN3mPA+BDUS0
        S23f5t5odAVfjmTJEgb9la5dHz1FIIftebNVA6y15VqkUdP/IMreOCbZRBET8SBd
        6RpAqxE67pFo/hkEF8DLV4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowABHtABnrqpiWINpDQ--.64829S2;
        Thu, 16 Jun 2022 12:15:36 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] mach-ux500: (pm_domain) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 12:15:34 +0800
Message-Id: <20220616041534.3977606-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowABHtABnrqpiWINpDQ--.64829S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUCr15GrW3ZryDJF17trb_yoWkCFbEvr
        WxWanxGa18t3WkWrs7ur13Wrn29ws7Grn2v34Fvw17tr18uF1rCFsavr4Sywnrury2vrW7
        JF9rCFyaywnF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtWrXJUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QgiF1pEANUMfQAAsq
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

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use real name for Sob
 v1: fix missing bug

 arch/arm/mach-ux500/pm_domains.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 427b9ac4af6c..81926b197e51 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -65,8 +65,10 @@ int __init ux500_pm_domains_init(void)
 		return -ENODEV;
 
 	genpd_data = kzalloc(sizeof(*genpd_data), GFP_KERNEL);
-	if (!genpd_data)
+	if (!genpd_data) {
+		of_node_put(np);
 		return -ENOMEM;
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

