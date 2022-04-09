Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C286A4FA996
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbiDIQfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242623AbiDIQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:34:35 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76323F383
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:32:28 -0700 (PDT)
Received: from ipservice-092-217-091-111.092.217.pools.vodafone-ip.de ([92.217.91.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ndE0e-0006Rg-QC; Sat, 09 Apr 2022 18:32:24 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/10] staging: r8188eu: improve timeout handling in iol_execute
Date:   Sat,  9 Apr 2022 18:32:10 +0200
Message-Id: <20220409163212.241122-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409163212.241122-1-martin@kaiser.cx>
References: <20220409163212.241122-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard kernel functions to define and check the timeout in
iol_execute.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 609138887b25..efdadfb61905 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -33,17 +33,16 @@ static s32 iol_execute(struct adapter *padapter, u8 control)
 {
 	s32 status = _FAIL;
 	u8 reg_0x88 = 0;
-	u32 start = 0, passing_time = 0;
+	unsigned long timeout;
 
 	control = control & 0x0f;
 	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
 	rtw_write8(padapter, REG_HMEBOX_E0,  reg_0x88 | control);
 
-	start = jiffies;
+	timeout = jiffies + msecs_to_jiffies(1000);
 	while ((reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0)) & control &&
-	       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
+		time_before(jiffies, timeout))
 		;
-	}
 
 	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
 	status = (reg_0x88 & control) ? _FAIL : _SUCCESS;
-- 
2.30.2

