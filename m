Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3348271A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiAAItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiAAItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:49:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B4C06173E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:49:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i22so59660160wrb.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbTLV5Bfca2xgmvPMQbusqJj771BWIhHOlR3Rbqv4og=;
        b=HxVL6urLyJ013tVQPhN0jkvV/1Z+cCKHsb2VhwP1lPo23HHH2mVEqwA4PivmGlUrrZ
         eaDycPhQJjn6lv8qfnm5EEAHXoTyqq2YfuoU63Q38e0yTJdWhWztx3rInDIK2ZDnkZrF
         Iy1d4ZBX9BBbz1O+MvU0+J+5B0lXyRGD5mD/5boEN4BAvuKrYNNFUbsZUZab/mKjOK2e
         Z/qy3hbT9zGNz7ZyZ2Qo381xxeSZMVxHy6rM2rfxKy8BndSjin2zI7JJBBveJljXi7Ju
         irdMO9KnGgai3R89XhIIs80SGlHJQSOk0yl/7WBLEvlMgpPQUKz6z3yYvtex+4Nj0QEb
         5CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbTLV5Bfca2xgmvPMQbusqJj771BWIhHOlR3Rbqv4og=;
        b=1zycWhK/1TSt5bTJT+suN+JEv8sby8pwRRhzGTGmhy/ni1DkQFZuho7Wpol01cAkfR
         Sw+YBEygqJbfPM4cPd9SgFk+PpZleFDnfhw0VN65KYkP3Km5DwXy34rSzffSw4cnI4N/
         iJDbciXMMT6l3NPHzaiQsQC9qKoUp+65/6K9F43bPAG+rDYgTpwETkaJr3wot3nncESV
         v9IfYEaSVEqkK0hUIGjjwt+2jK0hTvC7PGxmohYaWO/jtOJ+O+NCtBS48z5H+9t0K4rv
         MWHifNIGbsYC/OlCZtxzotXKpZNlPDNny6wRXDiqH6KDwqvG2c/0Z06Epbw+8WWW+bhc
         WIBQ==
X-Gm-Message-State: AOAM533l2rdrquH1RrkCdNM7d+LFk3r3U9Q2268RR3Bah8kmLxZmFMqF
        bMaIcdHQj9q+Nz8h+3un1v0=
X-Google-Smtp-Source: ABdhPJxbpw+qEbVexHxloGMc0GmrBwUKsBQZc/ZK+EEzC45glDJqFE52JOQhyEip1qCasDmMq1+IfQ==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr30601277wrh.43.1641026989807;
        Sat, 01 Jan 2022 00:49:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id o9sm14806578wri.97.2022.01.01.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:49:49 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 1/7] staging: r8188eu: bRDGEnable is always false
Date:   Sat,  1 Jan 2022 09:49:31 +0100
Message-Id: <20220101084937.3411-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101084937.3411-1-straube.linux@gmail.com>
References: <20220101084937.3411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bRDGEnable in struct hal_data_8188e is never set. It stays
at its default value 0. Remove bRDGEnable and related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
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

