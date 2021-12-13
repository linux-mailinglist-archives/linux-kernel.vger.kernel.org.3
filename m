Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F70472DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhLMNvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:51:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49009 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbhLMNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403491; x=1670939491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wUeEYEPhDkhIE88VVyIbkTbuZnTPC/eMEm62GBFIfCg=;
  b=Rp1vpYAtpvVWgL74OdS0uR4f789cG/9d4zL90vilPcyhmciEyeqVmzpi
   07P3P+PtaDBpfy+gLX6PwRBHg/yAvyu+qDQDiaHnunZ37YuvBlohBcKzV
   TQQK6vsvMNOdIwskCxETQv1M/k1Meib0T8fqTiG0tWhZI5+JV2fT0/hV7
   IvIblzxfu/duxGR/L6mqlZNmovLrEyZsfGAo5t+CXtRbdBjMbjnocnmLu
   PFErhjzLU21N2Zp/Lls1tJj6krlM6GqIRsQUrRFqMDvEmBDgMOtrwOaOJ
   +AsXTG2OIVC1zSIE6COm+Qpo4b70oE2Cqz7+l42anBrqdQVQE4aOh+MZw
   w==;
IronPort-SDR: iOWr9/qqMBII2EZvciMl6OLfP8OcjV8d9+JYUbxQ+HXntaGSD9iu17KBbTTA48ZdrKC93SF+Nx
 SrQ25ZTmVmoIwW4bJYC2HItmuHYpTIbm5popNb1TwPb4CJCj6KPA6uNqUNZdr7x4jBZDkCN6pz
 VGF9KW1nhJwPYEFD1jU+dyIr038HJLphaz325sOHniykyz10IQMt9S+iED50yd//p8UWLroyuW
 a/3jsyLQtmm8gBB9LGLgHCiIzTqkZhgHob6BExIJV8bXbwE3QzQ/HlU2mr7UFiyM818yoq4fcI
 +V9wFXIXh396DQRxNtLS1zsC
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="79361579"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:51:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:51:29 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:51:23 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 06/23] media: atmel: atmel-sama7g5-isc: fix ispck leftover
Date:   Mon, 13 Dec 2021 15:49:23 +0200
Message-ID: <20211213134940.324266-7-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ispck is not used for sama7g5 variant of the ISC.
Calls to ispck have to be removed also from module insert/removal.

Fixes: d7f26849ed7c ("media: atmel: fix the ispck initialization")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-sama7g5-isc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 5d1c76f680f3..2b1082295c13 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -556,7 +556,6 @@ static int microchip_xisc_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&isc->v4l2_dev);
 
-	clk_disable_unprepare(isc->ispck);
 	clk_disable_unprepare(isc->hclock);
 
 	isc_clk_cleanup(isc);
@@ -568,7 +567,6 @@ static int __maybe_unused xisc_runtime_suspend(struct device *dev)
 {
 	struct isc_device *isc = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(isc->ispck);
 	clk_disable_unprepare(isc->hclock);
 
 	return 0;
@@ -583,10 +581,6 @@ static int __maybe_unused xisc_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(isc->ispck);
-	if (ret)
-		clk_disable_unprepare(isc->hclock);
-
 	return ret;
 }
 
-- 
2.25.1

