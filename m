Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137C64A58B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiBAIn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiBAInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:43:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A0C061741
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:43:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u24so32341554eds.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nb3xSeie889vi5dtxHuHAsn4Vn6L3IVncsI2Y6Lx56g=;
        b=pc/f/hXsAH1pPlvIHbUnatwUOgKC7TrbwD0E5kJkD6VnNjMdip/URdwwDRoW2XoyBH
         ic1t/NcgZJfEl7Rn5RlrZvWu3ivZYuMLK7YTO3THqOReA2hNV/4hKTp+kDibE2CDajBv
         0ZWKdzGjZ7wTPjO2TiTt/Nmv+9GndisEhT4/qR+gE5gjb0145idQmMM+TRt8ApERzmg+
         2BgCfxM/8PAgKNZ1echww8PK88ctJcpDcoONBt+DGiUuhgsGkJI1YYMzUS92zQi4v5d2
         0AeNG9FPJywnEcoo3tKc8mY4ZgRGNfin6+Lp1OGM4kqZS67knxmbzl3+P6JhKiMFk3lQ
         XSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nb3xSeie889vi5dtxHuHAsn4Vn6L3IVncsI2Y6Lx56g=;
        b=gHpIAeDCaDIcO+8rVi0GxgMnQTdwsntmxibGXvWZmigqm/c8iENQC52a/KnUJ5KjO3
         Z6ZnkhYFmteGgAm9M3WvQLs6AsG6bjqmX9rlyUYs6D/PbarO+TJ06m9U0z4dp6GrncMb
         AQViDbwJ/x+xhmj2TpxHXxXkgPnzRAkH8+tIi1+yfZI6m+R0/ECeFUvzWrrqCPKDRKR9
         Md7qwJA40JLdHry5fs8YdT3hrgr3AenawfnaHgXTI4Gsy1vqlazRsCFoHosQkZiiaSAX
         xskXrGYrZ2wZEPJydb99wwzJNDkJLSO/oRqPCKDVvnYBGsrsRjjl3vDJ5iSz7CeZM4Oo
         MG9w==
X-Gm-Message-State: AOAM533Z7V9fMYytu3U+JLUV6WEha0igsCqtSi3BghXFqgBSKZjpmzQy
        rMmwbKChkl/IjeQGcgFcf6c=
X-Google-Smtp-Source: ABdhPJwLLwl0NLr2DqbcAy45dMyGWuVA6Q9UAw7+6hSkEGEEd4aOVSdXc1deJ6WvMMWhUFXEYWz7SQ==
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr24541386edd.359.1643704993669;
        Tue, 01 Feb 2022 00:43:13 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id c14sm19123431edy.66.2022.02.01.00.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:43:13 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/9] staging: r8188eu: BasicRateSet is set but never used
Date:   Tue,  1 Feb 2022 09:42:54 +0100
Message-Id: <20220201084259.7497-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201084259.7497-1-straube.linux@gmail.com>
References: <20220201084259.7497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The varaible BasicRateSet in struct hal_data_8188e is set but never
used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 1 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 2252e8a1d55b..e6c253122e9c 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1078,7 +1078,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			/* CCK 5.5M & 11M ACK should be enabled for better performance */
 
 			BrateCfg = (BrateCfg | 0xd) & 0x15d;
-			haldata->BasicRateSet = BrateCfg;
 
 			BrateCfg |= 0x01; /*  default enable 1M ACK rate */
 			/*  Set RRSR rate table. */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 88246ef65f8a..7a72b564400d 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -155,8 +155,6 @@ struct hal_data_8188e {
 	u8	CurrentChannel;
 	u8	nCur40MhzPrimeSC;/*  Control channel sub-carrier */
 
-	u16	BasicRateSet;
-
 	u8	EEPROMRegulatory;
 	u8	EEPROMThermalMeter;
 
-- 
2.34.1

