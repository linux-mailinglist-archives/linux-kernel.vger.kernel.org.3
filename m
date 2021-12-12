Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379D5471A35
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhLLMyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:54:05 -0500
Received: from smtp-34-i2.italiaonline.it ([213.209.12.34]:37160 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229675AbhLLMyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:54:03 -0500
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([82.50.51.121])
        by smtp-34.iol.local with ESMTPA
        id wOMammqwPUpmcwOMbmGyJH; Sun, 12 Dec 2021 13:54:01 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639313641; bh=5cQItZFlPLSWjbLUBhR1OrUoG0HfywhVMmQfcpeIMjE=;
        h=From;
        b=N+HYvyoFl59BN+J3iuKgwpvzvXAp5iQ/GJWbfpFLMjGQNj3aufglWm6B0Z10Zfsgm
         /4PMDXo6TfCTohG8bWE89xnO2P/m0R3mrtfv7k3pkEvxIzEgAgNKALQVdF81p6bWoP
         aHvpJdgNJq4WX+ejpS6MGbDCMyXZKU6SzAIxfBwMdjfYJZlCM66BVpO/yul0KSLDuY
         TwpS3iD6JcOKRvnjkSALbHgANoxARaq9zQWpIhThYeO7XH0tbaWJjT+WtOIQMoLkMN
         dnzG8TmwW7rUWKYZqhOQ5B014CtdzV5fZKR30wOQfriEJvgqC+MP9eL+wwoisDIMbS
         R5M0kJ/7mxK9Q==
X-CNFS-Analysis: v=2.4 cv=VsDmv86n c=1 sm=1 tr=0 ts=61b5f0e9 cx=a_exe
 a=xtCFBUu/Ze6RtP+zVSd77w==:117 a=xtCFBUu/Ze6RtP+zVSd77w==:17
 a=Lf7JvCFZlXs7EqoJDM0A:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>, Felipe Balbi <balbi@ti.com>,
        Rachna Patil <rachna@ti.com>, Wolfram Sang <wsa@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jeff Lance <j-lance1@ti.com>,
        Zubair Lutfullah <zubair.lutfullah@gmail.com>,
        Vignesh R <vigneshr@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Brad Griffis <bgriffis@ti.com>,
        Dario Binacchi <dariobin@libero.it>
Subject: [RESEND PATCH 1/3] input: ti_am335x_tsc: set ADCREFM for X configuration
Date:   Sun, 12 Dec 2021 13:53:56 +0100
Message-Id: <20211212125358.14416-2-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211212125358.14416-1-dariobin@libero.it>
References: <20211212125358.14416-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfF4DdcLXCoY0YJggC1A/zGE1daSGJ1y0kOs+yr+ynnqmiltxHTucCBzBzUM3j8rSF+afXC7fFIrMEb7VZPf14ll2rYq/oIjzYe01ENK2Cunk9N9K40a8
 0vGNZsDTAWemdfQrxurvg7mXqRwX65N6KSXJ1vkOQxSwXBSIeM3XK3H3CVVBA02rha5mhY/waY9oxkH+otEiiz8dP86rcJYzt5M+eAj9UWhDzsAjcY1Mpl3L
 fHgLpYsVE/DGVSaYmeTTU/l8aEMcVvpwnEDQwfghExludvLd/ixCiQ6EAQe7ppcbDJ/YfDO/JlTKKJ/0LRompFwtVhzJ6HkzBQtwKDS4DLUrP2IkB/15MRxg
 wHsUTXkEpwMQRcnYy32xGqP3b1zGFvI8YEgpL1CpvNtBmBA8q2FSb4Rfwb+nZ5Vpy4BhqiEbzNFI86SBK1dnHdmuBH2wxbJWp0q9Zz/b8sdQbIPdPrBicnSa
 zOHNKiouSltzA1IUHra3c2hoXir9rnYmaVdqCFllJBYRB1ik/h61uCJxDXpH+jQVYoVRq9xewiit/dLZmBTrS5EpJUu3OFi0m6+OyHpaYLvkEBgAYNp2VBY0
 0rPu2OE9aLmLVRtpN3Tu1C0EUymYSE2AqPiHNYmunYT2JApyQeobrYbjlXQAbLAOS4g=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by the STEPCONFIG[1-16] registered field descriptions of the
TI reference manual, for the ADC "in single ended, SEL_INM_SWC_3_0 must
be 1xxx".

Unlike the Y and Z coordinates, this bit has not been set for the step
configuration registers used to sample the X coordinate.

Fixes: 1b8be32e691 ("Input: add support for TI Touchscreen controller")
Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

 drivers/input/touchscreen/ti_am335x_tsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 83e685557a19..fd3ffdd23470 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -131,7 +131,8 @@ static void titsc_step_config(struct titsc *ts_dev)
 	u32 stepenable;
 
 	config = STEPCONFIG_MODE_HWSYNC |
-			STEPCONFIG_AVG_16 | ts_dev->bit_xp;
+			STEPCONFIG_AVG_16 | ts_dev->bit_xp |
+			STEPCONFIG_INM_ADCREFM;
 	switch (ts_dev->wires) {
 	case 4:
 		config |= STEPCONFIG_INP(ts_dev->inp_yp) | ts_dev->bit_xn;
-- 
2.17.1

