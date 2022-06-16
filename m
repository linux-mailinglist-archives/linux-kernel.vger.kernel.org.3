Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9863A54D8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350287AbiFPDrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbiFPDrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:47:13 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0881343ED9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wC4O3
        2zxiCSNPBbpdQ6Ot+qSmdefzQgUrMjx5711jbA=; b=KQ30ozWq91x9r+S3Y588H
        I9kufrF6rhwTNXIr+E3XqUBrjHtPmR00gN7WM1aKtO7ZIyc/14xyOTbQs8ldKf7A
        2QjM6yaXG0g2yNO9cREfvrKTvUF9CfO4hiiOEsJLd5+VVndG8gD2hciSIrg039zD
        UecQjfqqxFBAeSVgX6sORA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAAX4DAap6piNBj6EQ--.3670S2;
        Thu, 16 Jun 2022 11:44:26 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] arm: mach-versatile: (integrator) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 11:44:26 +0800
Message-Id: <20220616034426.3975965-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAAX4DAap6piNBj6EQ--.3670S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUCr15GrW3ZryfKr47XFb_yoW3WFc_t3
        Z2g3yUJrn5Za1IvryDCFWakry7Zwn7Grs3Wry8Ar17Gayaqry7Cr4vqryIk34xuwnrKrW7
        X39Fyr1av3ZIkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_5l1JUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hsiF1uwMNnZjQAAsi
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

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use real name for Sob
 v1: fix missing bug

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

