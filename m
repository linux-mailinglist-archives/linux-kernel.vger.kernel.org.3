Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239164B1B40
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346864AbiBKB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:28:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346834AbiBKB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:28:37 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD1270E;
        Thu, 10 Feb 2022 17:28:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644542915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZbXEwM/1hh5VIPvHIliHbU2s6hK/7WN9wYyQ2YQDsEk=;
        b=LWvsYdgEuvdIol5X0Xsvkr050FhfDnC+wFIZJNcckHYiuD3CO3H6G8Rf/PdAXrEZlEPRHt
        kC+KZqQvugWliwTJAz+652fok/clCWZpVcC+zmcX6FIBFo6ONEzKPMNXFFgB16USwEavnv
        HxMi+o9JjjCnZxCyaZ7cn+W2bGWmEKw=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usbip: vudc: Make use of the helper macro LIST_HEAD()
Date:   Fri, 11 Feb 2022 09:28:07 +0800
Message-Id: <20220211012807.7415-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

LIST_HEAD() helps to clean up the code "struct list_head vudc_devices =",
only to care about the variable 'vudc_devices'.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
v1->v2: update the changelog to explain why this change simplifies the code.

 drivers/usb/usbip/vudc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_main.c b/drivers/usb/usbip/vudc_main.c
index 678faa82598c..d43252b77efd 100644
--- a/drivers/usb/usbip/vudc_main.c
+++ b/drivers/usb/usbip/vudc_main.c
@@ -26,7 +26,7 @@ static struct platform_driver vudc_driver = {
 	},
 };
 
-static struct list_head vudc_devices = LIST_HEAD_INIT(vudc_devices);
+static LIST_HEAD(vudc_devices);
 
 static int __init init(void)
 {
-- 
2.25.1

