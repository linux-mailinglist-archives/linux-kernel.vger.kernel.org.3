Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF904E6042
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348897AbiCXIXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbiCXIXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:23:31 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 360D19AE74
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=X2PkbZuSv9BM7e1K9t
        z2R+SePk62dCZezpam7namyVY=; b=RtMkhZh21Q/LFBYdsgq3eTqWEKIu73tDrS
        u9hQiWZyU4fA3zf3inWnhUrh8H0HmfraMpgu0W3LIAaSHCOR5QkVM3HujlHlKzmB
        5oD2rdvKPqmKtjsrl8peyXYLJHV9DpMGUYsb92E3+wd8kVxDzuzMYde8ZVyPzWBE
        vLr7M+/9Y=
Received: from localhost (unknown [159.226.95.33])
        by smtp12 (Coremail) with SMTP id EMCowAAn5B1iJjxiNR7tAg--.21428S2;
        Thu, 24 Mar 2022 16:05:54 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] clk: socfpga: Fix a potential memory leak for kzalloc()
Date:   Thu, 24 Mar 2022 16:05:53 +0800
Message-Id: <1648109153-32756-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowAAn5B1iJjxiNR7tAg--.21428S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry3JrykWw1fZryrWF1kuFg_yoW3Xwc_Wa
        4jgr97Wwn8CrWUCr1qy3Wavry0kFs5urn5XFnaqw43Ja4ruF1UAFW2vrs5Wr1xKrW09ry3
        Zw1UAr17Z39rCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUzBTUUUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/1tbiNALNH1aD-KonPgAAs+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() is missing on an error path to free the memory allocated by kzalloc().

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/clk/socfpga/clk-gate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 53d6e3e..0ca5e00 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -188,8 +188,10 @@ void __init socfpga_gate_init(struct device_node *node)
 		return;
 
 	ops = kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
-	if (WARN_ON(!ops))
+	if (WARN_ON(!ops)) {
+		kfree(socfpga_clk);
 		return;
+	}
 
 	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
 	if (rc)
-- 
2.7.4

