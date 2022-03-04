Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E244CCEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiCDHVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiCDHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:21:16 -0500
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 960D515F094;
        Thu,  3 Mar 2022 23:20:26 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAAXOJmzvSFi5Na7AQ--.20466S2;
        Fri, 04 Mar 2022 15:20:20 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] rtc: snvs: Handle error for clk_enable
Date:   Fri,  4 Mar 2022 15:20:18 +0800
Message-Id: <20220304072018.557237-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXOJmzvSFi5Na7AQ--.20466S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47trW3Wr13Kr1xAFW7CFg_yoWfGrc_uF
        W7Jrn7Xan0yr40krn7Xry0vr9YvF40qF1rur40gas3KayDZr1v93y7Zw4qvr1DWr4jyrnx
        GFWDZFy8tr17WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
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

Fixes: edb190cb1734 ("rtc: snvs: make sure clock is enabled for interrupt handle")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/rtc/rtc-snvs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index bd929b0e7d7d..f273f7d873f8 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -269,8 +269,11 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	u32 lpsr;
 	u32 events = 0;
+	int ret;
 
-	clk_enable(data->clk);
+	ret = clk_enable(data->clk);
+	if (ret)
+		return IRQ_NONE;
 
 	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
 
-- 
2.25.1

