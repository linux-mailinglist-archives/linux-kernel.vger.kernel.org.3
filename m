Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285175795AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiGSI57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGSI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:57:58 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B49A1FCD1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bFZb5
        3iFBqVElDcNiNFVvqvwqJab5TzeqQEzJe2om6A=; b=X9N4FEyFW1TZNIm8Whs1S
        oRjXR7g0OAxb7dz8evdHo3KqhYfpudbd9nOdU19W2NqXjhGUqhPCaNC5KJJQWozu
        PrHD9WG9NI86KQpLy3pQkbi9dSx9cMafqpCILo0o6cbRCE79hMFS0LA6eNavYt3s
        otHT8ITRtpOf+8hEKFPMqI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgAn+cXJcdZif69rGw--.56295S2;
        Tue, 19 Jul 2022 16:56:42 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2 1/2] memory: of: Fix refcount leak bug in of_get_ddr_timings()
Date:   Tue, 19 Jul 2022 16:56:39 +0800
Message-Id: <20220719085640.1210583-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgAn+cXJcdZif69rGw--.56295S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4kKry8WFWDJrykurW7Arb_yoWDArg_CF
        4fXF17Wrn8WFnrGa17ta1fZr9Yyr4Fgr1kZFn2q3s3G3W8Zry3W3Z3Xr17Jw1UZFW7AFWU
        A39YkrWFyr4rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRA5r43UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizg1DF18RPhVkEgABsF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should add the of_node_put() when breaking out of
for_each_child_of_node() as it will automatically increase
and decrease the refcount.

Fixes: e6b42eb6a66c ("memory: emif: add device tree support to emif driver")
Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: split two fixes into two patches
 v1: https://lore.kernel.org/all/20220716025043.447036-1-windhl@126.com/

 drivers/memory/of_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index dbdf87bc0b78..8e2ef4bf6b17 100644
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
-- 
2.25.1

