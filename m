Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05D5795AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiGSI6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiGSI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:58:12 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3EF33D5B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=84ztO
        1jELCpuCrKQ2Kq4XXvkjIOwyhrDAO6GLq5xnA0=; b=EeBAUSC14mDqjJnR7pJ7/
        XIT5/9I9nfT6xavzEqzEtKJ5RR+uvuvpKDLKlV5Gii/CIfJrbcAygdylzeTc6H1T
        8qztv0ZHMi55rhPV81GYstymegJjinx57kWBqA1tS5POcAR/hKdjcwr+psw8/Wu8
        o4SZG5W8DWL+pGVthIpjeM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgAn+cXJcdZif69rGw--.56295S3;
        Tue, 19 Jul 2022 16:56:43 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2 2/2] memory: of: Fix refcount leak bug in of_lpddr3_get_ddr_timings()
Date:   Tue, 19 Jul 2022 16:56:40 +0800
Message-Id: <20220719085640.1210583-2-windhl@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719085640.1210583-1-windhl@126.com>
References: <20220719085640.1210583-1-windhl@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgAn+cXJcdZif69rGw--.56295S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4kKry8WFWfKFW7Ww1kuFg_yoW3CFc_Ga
        1xXr1DWrsxX3WDGa1jya1fZryvyrsYgr97ZF1Ig3s3G3W8ZrW7Wrn7Xr17Jw1UZFW7AFZ8
        ArsYkr4FyF4rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNCzuDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gtDF1uwMbnVxgAAs1
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

Fixes: 976897dd96db ("memory: Extend of_memory with LPDDR3 support")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/memory/of_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 8e2ef4bf6b17..fcd20d85d385 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -285,6 +285,7 @@ const struct lpddr3_timings
 		if (of_device_is_compatible(np_tim, tim_compat)) {
 			if (of_lpddr3_do_get_timings(np_tim, &timings[i])) {
 				devm_kfree(dev, timings);
+				of_node_put(np_tim);
 				goto default_timings;
 			}
 			i++;
-- 
2.25.1

