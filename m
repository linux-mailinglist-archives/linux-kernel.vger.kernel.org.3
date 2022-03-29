Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDDF4EA900
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiC2IMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiC2IMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:12:44 -0400
X-Greylist: delayed 1082 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 01:11:01 PDT
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2074B21C;
        Tue, 29 Mar 2022 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=a81h0Gq2WHNyBZSI3c
        IfKvhqk2zSuEwED0Bi/9DLrxg=; b=CUGzoTEMIBWRoHybOR5JeOiUDSpQ/KvHl5
        eWbU94CCub4qr2zNjmLlkgZO8gcVI0b+FRvFgakbX6jxd71pE/0+eZuigY8jbHrl
        cbQ2z4zVLLYVehP82bjhUBdEnSqCUj5TQ/TJmKuQiAEQNyylxRZ3NQZvL8VIojEU
        1NdO11CEI=
Received: from localhost (unknown [159.226.95.33])
        by smtp10 (Coremail) with SMTP id DsCowAAHVV01ukJi5UkzDA--.40878S2;
        Tue, 29 Mar 2022 15:50:14 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        yanaijie@huawei.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] pinctrl: ralink: rt2880: Check for return value of devm_kcalloc()
Date:   Tue, 29 Mar 2022 15:50:12 +0800
Message-Id: <1648540212-9790-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowAAHVV01ukJi5UkzDA--.40878S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF15XFW7try8Cw1xZr1UJrb_yoWfJrXEkF
        yxt3s3JryUG3W3uw1qya1UZryFkFs7uFyvvFnIqa43CF9Fvan3ur1kWF4UKw1kWr47tFyD
        Cw1YqFn5Zw47CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_5Ef5UUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/1tbiXxbSH11534uUsQAAsR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory allocation function devm_kcalloc() may return NULL pointer,
so it is better to add a check for 'p->func[i]->pins' to avoid possible
NULL pointer dereference.

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/pinctrl/ralink/pinctrl-rt2880.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/ralink/pinctrl-rt2880.c b/drivers/pinctrl/ralink/pinctrl-rt2880.c
index 96fc06d..308610e 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt2880.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt2880.c
@@ -266,6 +266,10 @@ static int rt2880_pinmux_pins(struct rt2880_priv *p)
 						p->func[i]->pin_count,
 						sizeof(int),
 						GFP_KERNEL);
+        
+        if (!p->func[i]->pins)
+            continue;
+
 		for (j = 0; j < p->func[i]->pin_count; j++)
 			p->func[i]->pins[j] = p->func[i]->pin_first + j;
 
-- 
2.7.4

