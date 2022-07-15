Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAF575FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiGOLK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiGOLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:10:45 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43E8487C33
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cydZm
        lZhSk+JBLjhav67ZXf+fCTQCxLg7ins/X8dtkw=; b=h8u2hiIgIZXunSdvJXs2W
        6K00/s6JWQ7n9GMmoX4s6vI5sTkHoeAjicuDfkneZncOftQt8d2a+T9DZa2Qdv0j
        Js2Hmf9/k2XBjXZ4YUbGqX+v1ADJ8FHlfWZU8cDOdjqtBd+TdjcFvjLu1E0VgflW
        Lz6xXlG8kW0dBF7u67c+8c=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowAC3x_8jS9Fi0vOyEw--.59040S2;
        Fri, 15 Jul 2022 19:10:28 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] regulator: of: Fix refcount leak bug in of_get_regulation_constraints()
Date:   Fri, 15 Jul 2022 19:10:27 +0800
Message-Id: <20220715111027.391032-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAC3x_8jS9Fi0vOyEw--.59040S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy8tw43KF1UXryrXFy5urg_yoWkAFcEkw
        nxG3WxJrsrZr47GF92va1qy3s8tr1vgF47Xa1xtFWfJr1jya45Jw17Z347A39rZ3y7Ar92
        vwnrJwsFkr1Y9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRWWl97UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QU-F1pEAZ3xlgAAsl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should call the of_node_put() for the reference returned by
of_get_child_by_name() which has increased the refcount.

Fixes: 40e20d68bb3f ("regulator: of: Add support for parsing regulator_state for suspend state")
Signed-off-by: Liang He <windhl@126.com>
---
I think no matter what the 'suspend_state' value is, it should call
of_node_put() when 'suspend_np' is not NULL as it will be replaced
in 'continue' to next loop.

 drivers/regulator/of_regulator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index f54d4f176882..e12b681c72e5 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -264,8 +264,12 @@ static int of_get_regulation_constraints(struct device *dev,
 		}
 
 		suspend_np = of_get_child_by_name(np, regulator_states[i]);
-		if (!suspend_np || !suspend_state)
+		if (!suspend_np)
 			continue;
+		if (!suspend_state) {
+			of_node_put(suspend_np);
+			continue;
+		}
 
 		if (!of_property_read_u32(suspend_np, "regulator-mode",
 					  &pval)) {
-- 
2.25.1

