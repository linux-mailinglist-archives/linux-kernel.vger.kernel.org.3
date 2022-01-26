Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D869A49C0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiAZBta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:49:30 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:34322 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236024AbiAZBtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:49:17 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowACXe0GHqPBho9zoBg--.31642S2;
        Wed, 26 Jan 2022 09:48:55 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3] thermal/int340x_thermal: Check for null pointer after calling kmemdup
Date:   Wed, 26 Jan 2022 09:48:53 +0800
Message-Id: <20220126014853.2915981-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACXe0GHqPBho9zoBg--.31642S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4rAr4UKF43Ar13CF1Utrb_yoW8Xw4fpF
        4Fgr1UArs5WF4xW3WUAr15Ja98C3Z5Kay5WFyS9a4YyFnxAFWSqFyFyFyFyry0kr17t3WY
        ya4rtr4xZr1DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOMKZDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the potential failure of the allocation, kmemdup() may return NULL
pointer.
Then the 'bin_attr_data_vault.private' will be NULL pointer but the
'bin_attr_data_vault.size' is not 0.
Therefore, it should be better to check the return value of kmemdup() to
avoid the wrong size.
And since the error handling process is simple, it may not use the
'goto' to simplify the code.

Fixes: 0ba13c763aac ("thermal/int340x_thermal: Export GDDV")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Use out_kfree to simplify the code.

v2 -> v3

* Change 1. Revert the code to v1 and refine the commit message.
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 8502b7d8df89..52ac3ee54309 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -464,6 +464,11 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
 				   obj->package.elements[0].buffer.length,
 				   GFP_KERNEL);
+	if (!priv->data_vault) {
+		kfree(buffer.pointer);
+		return;
+	}
+
 	bin_attr_data_vault.private = priv->data_vault;
 	bin_attr_data_vault.size = obj->package.elements[0].buffer.length;
 	kfree(buffer.pointer);
-- 
2.25.1

