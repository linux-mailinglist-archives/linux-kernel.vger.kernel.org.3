Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB647A79D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhLTKPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:15:55 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:35364 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230475AbhLTKPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:15:54 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAC3v5+5V8BhwcdlBA--.42591S2;
        Mon, 20 Dec 2021 18:15:21 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     agross@kernel.org, bjorn.andersson@linaro.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] usb: dwc3: qcom: Check for null irq pointer
Date:   Mon, 20 Dec 2021 18:15:20 +0800
Message-Id: <20211220101520.930658-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3v5+5V8BhwcdlBA--.42591S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZry7XFyUuFyUZryxWr1DGFg_yoWfGFX_K3
        s5Wr4xKrWDKF4fKryDAw13ZryIvr98XFn3WFs093Wa93WDWFykXryIvrZ8GryUZF4DWr9r
        X398C3yY9Fy7AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
        cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of platform_get_irq() needs to be checked.
To avoid use of null pointer in case that there is no irq.

Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/usb/dwc3/dwc3-qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 49e6ca94486d..f04fb3f2fb85 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -614,6 +614,11 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 		qcom->acpi_pdata->dwc3_core_base_size;
 
 	irq = platform_get_irq(pdev_irq, 0);
+	if (!irq) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	child_res[1].flags = IORESOURCE_IRQ;
 	child_res[1].start = child_res[1].end = irq;
 
-- 
2.25.1

