Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657BE467303
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379083AbhLCIFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:05:01 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:45552 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350557AbhLCIFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:05:01 -0500
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowADn71fDzqlhyu4dAQ--.56664S2;
        Fri, 03 Dec 2021 16:01:11 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] usb: chipidea: msm: Handle error codes
Date:   Fri,  3 Dec 2021 16:01:06 +0800
Message-Id: <20211203080106.1559983-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADn71fDzqlhyu4dAQ--.56664S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW7Kw4fAF15tr13AryxZrb_yoWDJrb_CF
        1xWrWxuFya9F1Skr1DtFW2vrW0kwnY9Fn5WFs2g3WfKa4UZF1xJay09ryxt34UuF4Fyrn8
        GayvvwsxCFW8CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
        WxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMKZJUUUU
        U==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of of_get_next_available_child() and
of_device_is_compatible() is not always 0.
To catch the exception in case of the failure.

Fixes: 47654a162081 ("usb: chipidea: msm: Restore wrapper settings after reset")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 46105457e1ca..13218f0a2bed 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -246,6 +246,8 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	if (ulpi_node) {
 		phy_node = of_get_next_available_child(ulpi_node, NULL);
 		ci->hsic = of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
+		if (!phy_node || !ci->hsic)
+			goto err_mux;
 		of_node_put(phy_node);
 	}
 	of_node_put(ulpi_node);
-- 
2.25.1

