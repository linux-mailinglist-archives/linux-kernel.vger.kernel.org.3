Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C02E534C32
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbiEZJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiEZJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:04:02 -0400
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F52D116D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:04:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAD3_4dyQo9iz1N7Cg--.40442S2;
        Thu, 26 May 2022 17:03:54 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     santoshkumar.yadav@barco.com, peter.korsgaard@barco.com,
        hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] platform/x86: barco-p50-gpio: Add check for platform_driver_register
Date:   Thu, 26 May 2022 17:03:45 +0800
Message-Id: <20220526090345.1444172-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3_4dyQo9iz1N7Cg--.40442S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18uF43GFWkAr1DCF1xXwb_yoWktwc_CF
        18uFZrWrn5Kas2kF1jyw43uryIkas5WFs3Kw1xtFyaqa4rJa1xCr42vry3tw17Wr1YvFyD
        G3s7CFWSkrya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhNVgUUUUU=
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

As platform_driver_register() could fail, it should be better
to deal with the return value in order to maintain the code
consisitency.

Fixes: 86af1d02d458 ("platform/x86: Support for EC-connected GPIOs for identify LED/button on Barco P50 board")

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/platform/x86/barco-p50-gpio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
index 05534287bc26..8dd672339485 100644
--- a/drivers/platform/x86/barco-p50-gpio.c
+++ b/drivers/platform/x86/barco-p50-gpio.c
@@ -405,11 +405,14 @@ MODULE_DEVICE_TABLE(dmi, dmi_ids);
 static int __init p50_module_init(void)
 {
 	struct resource res = DEFINE_RES_IO(P50_GPIO_IO_PORT_BASE, P50_PORT_CMD + 1);
+	int ret;
 
 	if (!dmi_first_match(dmi_ids))
 		return -ENODEV;
 
-	platform_driver_register(&p50_gpio_driver);
+	ret = platform_driver_register(&p50_gpio_driver);
+	if (ret)
+		return ret;
 
 	gpio_pdev = platform_device_register_simple(DRIVER_NAME, PLATFORM_DEVID_NONE, &res, 1);
 	if (IS_ERR(gpio_pdev)) {
-- 
2.25.1

