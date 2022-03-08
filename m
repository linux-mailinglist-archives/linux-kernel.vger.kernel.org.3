Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63F4D115E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbiCHH45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344694AbiCHH4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:56:54 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F9AE3E5E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:55:54 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAAXH_v8Cydi1kunAg--.11175S2;
        Tue, 08 Mar 2022 15:55:41 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] media: s5p-mfc: Handle error for clk_enable
Date:   Tue,  8 Mar 2022 15:55:38 +0800
Message-Id: <20220308075538.1117983-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAXH_v8Cydi1kunAg--.11175S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47trW3CF4kuryrAFWrKrg_yoWftFg_C3
        9rXw4fXr1YgrsIywsrKrySk3yrKFWkuws7XFySqF4fK34rK3W3ZrWqvr47Zw17AF4IvrWf
        Xr1DXrykCFy3CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the potential failure of the clk_enable(),
it should be better to check it and return error
if fails.

Fixes: 1bce6fb3edf1 ("[media] s5p-mfc: Rework clock handling")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
index 88b7d33c9197..392e6fab0a75 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
@@ -106,10 +106,12 @@ int s5p_mfc_power_on(void)
 
 int s5p_mfc_power_off(void)
 {
-	int i;
+	int i, ret;
 
 	/* finish software clock gating */
-	clk_enable(pm->clock_gate);
+	ret = clk_enable(pm->clock_gate);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < pm->num_clocks; i++)
 		clk_disable_unprepare(pm->clocks[i]);
-- 
2.25.1

