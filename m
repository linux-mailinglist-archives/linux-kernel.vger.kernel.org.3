Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EDB4A3859
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355849AbiA3TEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355715AbiA3TDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:42 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC8C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:41 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id d10so36046708eje.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjrS4w62Uxe/qB4XuyiE0X5ZGBxg6belQDWbZp4WXro=;
        b=VcHipuRlcMhw51ycNd0cS+uaV562SgbCeZh1l4+E/UGQ8bh3r9hMFdqJekO/Ov+rdr
         P9ulOSxmhyICgmnAkLAG1i6fXRDd6QLnUuGwKpPlQd1+s5pVMoGwZDi7DyV03oUxjHJq
         i31AZmt7mW6KOpxouuSlCDE2RDY27kyqM/kK557oUXyoLOfHTLJUSvI2in8pttK/XBKw
         ArlBkdRv3D89ZR0pgECjjSo1+22KTYF7emg1Lskp6aOE9cHIWf9zn5KwEc+8Gf1MrgA7
         9AxpIvMR/eigvaKCo9foAC4gktLV0VhoTh7QixAx0AuTW3A4vYr4tMARrySZOY8cQVr3
         jbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjrS4w62Uxe/qB4XuyiE0X5ZGBxg6belQDWbZp4WXro=;
        b=xgcWvmepuJChzSjXpPTkMhSp9DlYP8J0CPedCyPlcy5YZgBwfxzY3dPjwv+Lzq6qIu
         W1qZBwnuWHVxiAqPCs5poaNgfdMjGiL67V3L4as4XPiiW1bwD7LyocMdPetnqrvFTlNS
         aWMGy4ER5rQwu569nR4WgQgpiSP72qwmJJEl5WJkbbf3xUYv1Nv+T4BXnswtYU7A4sJj
         BwZ/qkIuvCEkE2VuVxZtuhKrNbtbnExGV7+BKG67whCMlzYGtSYll33oE077xaniKb+b
         4uvIBbUDAA6x0L/yIqLnvEFr3dmSIkT8Og8BN8+wzdW78FlEKloN2dfBOAgpxgh+9/j+
         IUEw==
X-Gm-Message-State: AOAM532di5XRPfnnaiTWC5U2Tr5gsfbJBonNnboR+cncWTKC1MhspZiz
        EvdnLJ6HS07CPZiL7uBMRlQ=
X-Google-Smtp-Source: ABdhPJzExYBx1f9ZUGVkoQI/n11wz7ig67rmXJmFtWZKZnguPW3vGcxjvZG1LyT1dI5V+pnYOKpaBQ==
X-Received: by 2002:a17:907:9812:: with SMTP id ji18mr10471754ejc.200.1643569420373;
        Sun, 30 Jan 2022 11:03:40 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:40 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/12] staging: r8188eu: merge Set_NETYPE0_MSR() and Set_MSR()
Date:   Sun, 30 Jan 2022 20:03:17 +0100
Message-Id: <20220130190321.7172-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130190321.7172-1-straube.linux@gmail.com>
References: <20220130190321.7172-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set_MSR() just calls Set_NETYPE0_MSR(). Merge the two functions.
Keep Set_MSR() and remove Set_NETYPE0_MSR().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index d28929a95108..a8acec776b79 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -284,7 +284,7 @@ void Switch_DM_Func(struct adapter *padapter, u32 mode, u8 enable)
 		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_CLR, (u8 *)(&mode));
 }
 
-static void Set_NETYPE0_MSR(struct adapter *padapter, u8 type)
+void Set_MSR(struct adapter *padapter, u8 type)
 {
 	u8 val8;
 
@@ -293,11 +293,6 @@ static void Set_NETYPE0_MSR(struct adapter *padapter, u8 type)
 	rtw_write8(padapter, MSR, val8);
 }
 
-void Set_MSR(struct adapter *padapter, u8 type)
-{
-	Set_NETYPE0_MSR(padapter, type);
-}
-
 inline u8 rtw_get_oper_ch(struct adapter *adapter)
 {
 	return adapter->mlmeextpriv.oper_channel;
-- 
2.34.1

