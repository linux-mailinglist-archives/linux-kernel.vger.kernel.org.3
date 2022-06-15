Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3854C43C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiFOJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiFOJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:05:47 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEF1C3A734
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=m3QcT
        W/lZeAJnaksoHMUlocc+Y9Uw/FS+TMacmhO/3E=; b=UiNo61SD8RKmWL2GiBMrk
        ZIXdsDgyhjkCuktOBDp8bb3E+dG1aavOuZU+P1MuKZ9aRMPiSPR95244O1tUz+Lu
        p6RTNviBzKinR0GF8fxlmq+TjPd8QMdZDykMlb31njKvvvPSk0VpFU0L0HF4gaSx
        26w5PG5TN+CrYkdiHq+dSU=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgA3JGnPoKli0ReSFg--.42622S2;
        Wed, 15 Jun 2022 17:05:19 +0800 (CST)
From:   heliang <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-versatile: Add missing of_node_put in integrator.c
Date:   Wed, 15 Jun 2022 17:05:17 +0800
Message-Id: <20220615090517.3961621-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgA3JGnPoKli0ReSFg--.42622S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUCr15GrW3ZryfKr47XFb_yoWxtwc_t3
        Z2g3ykJrn5Ja1IvryDCr4akry7Zwn7GrsYgry8Ar17G34aqr17Cr4vqryIk348uwnrKrW7
        X397Ar1av3Wa9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_znQ7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7Q8hF1pEAM8zhAAAsy
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cm_init(), of_find_matching_node() will return a node pointer with
refcount incremented. We should use of_node_put() when the pointer is
not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mach-versatile/integrator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/integrator.c b/arch/arm/mach-versatile/integrator.c
index fdf9c4db08a7..fba19357171a 100644
--- a/arch/arm/mach-versatile/integrator.c
+++ b/arch/arm/mach-versatile/integrator.c
@@ -76,6 +76,7 @@ void cm_init(void)
 		return;
 	}
 	cm_base = of_iomap(cm, 0);
+	of_node_put(cm);
 	if (!cm_base) {
 		pr_crit("could not remap core module\n");
 		return;
-- 
2.25.1

