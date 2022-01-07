Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF348792E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiAGOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:44:29 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:59852 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230012AbiAGOo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:44:28 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAAH3aW2Udhh42H7BQ--.18277S2;
        Fri, 07 Jan 2022 22:44:06 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] thermal/int340x_thermal: Check for null pointer after calling kmemdup
Date:   Fri,  7 Jan 2022 22:44:05 +0800
Message-Id: <20220107144405.4081288-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAH3aW2Udhh42H7BQ--.18277S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4rAr4UKF43Xw48tF45trb_yoW8AFWDpF
        WFgr1UJrs5WF1xWwnrArn8XayDCF4vga4UuF4FkayYy3ZxCFWSqFyFyF1Fyry0kr17t3Wj
        y345tF4xZryDJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
        6r1DMxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E
        87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfU8D73DUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the allocation, kmemdup() may return NULL
pointer.
Then the 'bin_attr_data_vault.private' will be NULL pointer but the
'bin_attr_data_vault.size' is not 0.
Therefore, it should be better to check the return value of kmemdup() to
avoid the wrong size.

Fixes: 0ba13c763aac ("thermal/int340x_thermal: Export GDDV")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Use out_kfree to simplify the code.
---
 .../thermal/intel/int340x_thermal/int3400_thermal.c  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 19926beeb3b7..f869aeb087d3 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -457,17 +457,21 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 
 	obj = buffer.pointer;
 	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 1
-	    || obj->package.elements[0].type != ACPI_TYPE_BUFFER) {
-		kfree(buffer.pointer);
-		return;
-	}
+	    || obj->package.elements[0].type != ACPI_TYPE_BUFFER)
+		goto out_kfree;
 
 	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
 				   obj->package.elements[0].buffer.length,
 				   GFP_KERNEL);
+	if (!priv->data_vault)
+		goto out_kfree;
+
 	bin_attr_data_vault.private = priv->data_vault;
 	bin_attr_data_vault.size = obj->package.elements[0].buffer.length;
 	kfree(buffer.pointer);
+
+out_kfree:
+	kfree(buffer.pointer);
 }
 
 static int int3400_thermal_probe(struct platform_device *pdev)
-- 
2.25.1

