Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944B1576B58
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 04:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiGPCvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 22:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGPCvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 22:51:43 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF67B8E4D0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 19:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QdtRh
        cz3Z5bsklW/JB6Jypy0TZQYgpcSFPOxW1n+Le8=; b=BneFbrvEyCt2i/xpGbr3E
        5G5Ofmv/1YvtPZ26j+ev5/1jSCuEbf9GK80i+b9Qp08V3pLBYGZJx5pKhfEkN8bM
        6eXkU0UGk6J0OOUI0ByczyEK1Wgcw6toxjuiOFPJxpgBrYnibY+Tc03uwL/01POa
        WUiYYGsfTEZdM3y+xoCvAg=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgDnJK2FJ9Ji6xmEGg--.19071S2;
        Sat, 16 Jul 2022 10:50:46 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     krzysztof.kozlowski@linaro.org, windhl@126.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memory: of: Add of_node_put() when breaking out of for_each_child_of_node()
Date:   Sat, 16 Jul 2022 10:50:43 +0800
Message-Id: <20220716025043.447036-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgDnJK2FJ9Ji6xmEGg--.19071S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW5tFyxXw15AF47Zw43KFg_yoW8Jw1kpF
        4xur9IyrW0vrW7Ars5Jwn7uFyYg3W0q3y5KFyIk39Y9rsxGFyrZrZ2kryUArnxJFWfZF13
        GFnYga18X3WxWr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEbyZUUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QZAF1pEAaHSJAAAs0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In of_get_ddr_timings() and of_lpddr3_get_ddr_timings(), we should
add the of_node_put() when breaking out of for_each_child_of_node()
as it will automatically increase and decrease the refcount.

Fixes: 976897dd96db ("memory: Extend of_memory with LPDDR3 support")
Fixes: e6b42eb6a66c ("memory: emif: add device tree support to emif driver")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/memory/of_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index dbdf87bc0b78..cd57af9e5ff6 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -134,6 +134,7 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
 	for_each_child_of_node(np_ddr, np_tim) {
 		if (of_device_is_compatible(np_tim, tim_compat)) {
 			if (of_do_get_timings(np_tim, &timings[i])) {
+				of_node_put(np_tim);
 				devm_kfree(dev, timings);
 				goto default_timings;
 			}
@@ -283,6 +284,7 @@ const struct lpddr3_timings
 	for_each_child_of_node(np_ddr, np_tim) {
 		if (of_device_is_compatible(np_tim, tim_compat)) {
 			if (of_lpddr3_do_get_timings(np_tim, &timings[i])) {
+				of_node_put(np_tim);
 				devm_kfree(dev, timings);
 				goto default_timings;
 			}
-- 
2.25.1

