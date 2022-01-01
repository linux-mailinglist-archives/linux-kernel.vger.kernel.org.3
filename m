Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356CA482705
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiAAISH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiAAISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:18:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3BC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:18:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w20so50617985wra.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dyAlzOohNwnAjxD5jG0//dHME7ZhYBT+DvDH2X9pgaU=;
        b=QQc25IzK8IPVhEqsb3ZK80AwVLRmnlQRIh7IdICYlwaRCHfNlmSwGkjEs2hYcpXb/r
         TVZNWFKGqHZeBlIVqS6H38k7EZgXzNkbYDpriNaecs6xR2AX9Pa7gDxhF3TLju2tETxL
         owvlBNDTZZFVlTDXFqeBLlRBGAjxhGSXnsVndYGH/zSHXBWI8vlf/AVgFDaDdTpTsook
         pAdGijuK2GQSXjLQw8BicaQgjtAgIyKcIEvN2GhAJk2X7Far87HaFVBhWbAFfTmEkCoD
         de/7sTDT9CsVPAroePAPYsrqO3nTDpQS6dewUI6t+M3pUOIeNYWkBXaZDvDCCCRAS04D
         +EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyAlzOohNwnAjxD5jG0//dHME7ZhYBT+DvDH2X9pgaU=;
        b=aTmG+jDdf1sYWv//2iVGhFGJsLse9X5Vrm1pgwsm1s0I8i0q46QXt+xc1BN+NX8Aum
         4veIjnOmxfwD3TMt8rL/U/2WRWGw+Rk/2e2hFAKClQyVrIHJHFqMdsrUAVQjCgCTMgaq
         Fo3MFy2r2kAPcyAEQXQ1UH9aw691cVVWedeL4H0xreNxEbbBQYj7KBYwFNCLPViTcA7V
         wDrwpFQVYR188gKS++oE4GX4xUFIub8jzQJH8czvDusr94zbxhy/ckAfl78+yaoactVj
         eUF+kOO4Irv1JgvBPzXaIr/qI5aWUB0m6rdCulCsdjSXIF4OdthbCcHYb1EYSYBXuUP+
         kYEQ==
X-Gm-Message-State: AOAM532xa4SYt+nhbmmRyZuAp31DGoxvd25ekGIBUHb6LDQfn+GA8KRQ
        1ZOQGFsj4cSWIP0/bDnVeK0=
X-Google-Smtp-Source: ABdhPJzapFx0oe3HhEZKXjEF6XsDgiZqdAh8zkrYFst0mZq9OpPraT/ADSPbztlN960M+rvVnEqD5A==
X-Received: by 2002:adf:e88a:: with SMTP id d10mr31547425wrm.114.1641025084924;
        Sat, 01 Jan 2022 00:18:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id u9sm30693651wmm.7.2022.01.01.00.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:18:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/7] staging: r8188eu: bRDGEnable is always false
Date:   Sat,  1 Jan 2022 09:17:52 +0100
Message-Id: <20220101081758.9716-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101081758.9716-1-straube.linux@gmail.com>
References: <20220101081758.9716-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bRDGEnable in struct hal_data_8188e is never set. It stays
at its default value 0. Remove bRDGEnable and related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 drivers/staging/r8188eu/hal/usb_halinit.c      | 10 ----------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d5c7e8bf1f38..104705ef170e 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -384,13 +384,6 @@ static void _InitEDCA(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_EDCA_VO_PARAM, 0x002FA226);
 }
 
-static void _InitRDGSetting(struct adapter *Adapter)
-{
-	rtw_write8(Adapter, REG_RD_CTRL, 0xFF);
-	rtw_write16(Adapter, REG_RD_NAV_NXT, 0x200);
-	rtw_write8(Adapter, REG_RD_RESP_PKT_TH, 0x05);
-}
-
 static void _InitRetryFunction(struct adapter *Adapter)
 {
 	u8 value8;
@@ -712,9 +705,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	value16 |= (MACTXEN | MACRXEN);
 	rtw_write8(Adapter, REG_CR, value16);
 
-	if (haldata->bRDGEnable)
-		_InitRDGSetting(Adapter);
-
 	/* Enable TX Report */
 	/* Enable Tx Report Timer */
 	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index b42af86555cd..e8cb093abb62 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -236,9 +236,6 @@ struct hal_data_8188e {
 
 	u32	RfRegChnlVal[2];
 
-	/* RDG enable */
-	bool	 bRDGEnable;
-
 	/* for host message to fw */
 	u8	LastHMEBoxNum;
 
-- 
2.34.1

