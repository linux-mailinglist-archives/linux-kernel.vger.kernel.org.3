Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE6554C497
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbiFOJZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241256AbiFOJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:25:36 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B98E315A2D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HZLPZ
        kq0CUwiq/ms7aqKgr3One1GE6Q1hovUYq8crzw=; b=IqQGItwxR76BqII9u8szo
        LTlcLA8bPW6ShusoL6Zr+n2UGpk/ruqUeiq4ptsjsIm+A8g7gJMog2T7UAPamOla
        ozognHgogHpvLl3+GSitQNHlsRxkbZLazXqld7ULK55PjaneDBdiLQ1aFeKgy+dX
        0LRUm+uwJ6BFnTdkxf+GOk=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgD3moB+palikCIfEw--.43577S2;
        Wed, 15 Jun 2022 17:25:20 +0800 (CST)
From:   heliang <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-versatile: Add missing of_node_put()
Date:   Wed, 15 Jun 2022 17:25:17 +0800
Message-Id: <20220615092517.3962075-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgD3moB+palikCIfEw--.43577S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4DuFWUKFW5XrWfJr4fZrb_yoW3ZFbEqF
        1xX3y7Ww1rJ392qrZ5uF43GrZrAw18Crn8Gry8AFy3C3W5XFnrCrsYq3saq3yFvrWfKrW3
        Xr4xXr4Yka17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_znQ7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QAhF1pEAM9VfQAAsi
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In realview_smp_prepare_cpus(), the second of_find_matching_node()
has no corresponding of_node_put() when the node pointer is not
used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mach-versatile/platsmp-realview.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/platsmp-realview.c b/arch/arm/mach-versatile/platsmp-realview.c
index 5d363385c801..059d796b26bc 100644
--- a/arch/arm/mach-versatile/platsmp-realview.c
+++ b/arch/arm/mach-versatile/platsmp-realview.c
@@ -66,6 +66,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 	map = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(map)) {
 		pr_err("PLATSMP: No syscon regmap\n");
 		return;
-- 
2.25.1

