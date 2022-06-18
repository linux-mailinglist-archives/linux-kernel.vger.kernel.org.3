Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB95B550201
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383748AbiFRCcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiFRCcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:32:13 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 222E453A5D;
        Fri, 17 Jun 2022 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=15/2m
        5b9DkPoq5VMhf35vdAS3TadjnHl3Svk5O3dXF8=; b=km7q3X3h50p8WaXTao/pI
        bWVtdWTOr7M4pswE4iN9mv+WuZNdomIOQ32ErGMx4vnd67pZy6siORu4FTUiQAFb
        MOClRjyXXkdzeo7oibnFigcnXRNBoyPK2zg2YKAmSrEP2WdKap5jThG+C3w0Hmdp
        aLNCzeKrRqXA/SP3pH4DO0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAC3hvIlOa1iDEugDg--.23192S2;
        Sat, 18 Jun 2022 10:32:05 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     gregkh@linuxfoundation.org
Cc:     windhl@126.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: renesas: Fix refcount leak bug
Date:   Sat, 18 Jun 2022 10:32:05 +0800
Message-Id: <20220618023205.4056548-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAC3hvIlOa1iDEugDg--.23192S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fWry3Gry7Cr4UZr15XFb_yoWfKFc_Ww
        10grsrAr1UCan5Kr1DXrWSv39Fyan3ur1kZF1kKayfJa4YyrZrXrs8ury8Xw429FW2yFZ0
        yws7A3s2kF1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUyrW3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gYkF1uwMOiRSAAAsF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In usbhs_rza1_hardware_init(), of_find_node_by_name() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/usb/renesas_usbhs/rza.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/rza.c b/drivers/usb/renesas_usbhs/rza.c
index 24de64edb674..2d77edefb4b3 100644
--- a/drivers/usb/renesas_usbhs/rza.c
+++ b/drivers/usb/renesas_usbhs/rza.c
@@ -23,6 +23,10 @@ static int usbhs_rza1_hardware_init(struct platform_device *pdev)
 	extal_clk = of_find_node_by_name(NULL, "extal");
 	of_property_read_u32(usb_x1_clk, "clock-frequency", &freq_usb);
 	of_property_read_u32(extal_clk, "clock-frequency", &freq_extal);
+
+	of_node_put(usb_x1_clk);
+	of_node_put(extal_clk);
+
 	if (freq_usb == 0) {
 		if (freq_extal == 12000000) {
 			/* Select 12MHz XTAL */
-- 
2.25.1

