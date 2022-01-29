Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D724A309D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352771AbiA2Qc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352762AbiA2QcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED339C061753
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id qe6-20020a17090b4f8600b001b7aaad65b9so3272617pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hU0AyPSwzXrTCpt2UBSbf+u4PcwXegon4P9WmWniS1g=;
        b=IICEJbqNAWzJcp8cdThF7LoXbzH50La22u0YiOoneBeq2Enxqnv9A7w5vC6xMft6sT
         epjSGYgO5VIHAsFw7ZsX4Qi7teSRkrcCK5UlBeWnFuE528FJLwEBaDmgaLBV2Z49l46F
         RxEH9fNXlEeEDyWBCphfup6jcpxZ1vU0eGZH5i7+cwnGgdFNbKyeN2ZvFPPRt/kk4iK4
         22bYR1hyIopigEelA7qrgOmCoJ4+U4wm436hhHVZfQ+Lv0XuqQkGGYeqQl/0C2fEVmY4
         PQB0aVVtR3f+ZC8huszc32kkrmol2CbLrst3NHaPvmc4aypFCAxFSD1o7ShHlCVSXWIR
         KAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hU0AyPSwzXrTCpt2UBSbf+u4PcwXegon4P9WmWniS1g=;
        b=cHiSMjsnBO/r3yB8Xv3xnaYJZhqTS60Rt8CtzOD6DWLF69fDBGn6ESA4Qv0uNw1iur
         IRrJzjso5KjdTbwYF0b82T2zzfbw/YPmekjK0SLIkZaoQSgjxuQzrx9V6z4adfbmfktq
         b14JYe/RI2HzypvZVnXpQBvNwOdCOtgrL8iwn/XCmyhlMAHQ0PhEdY+uqqqk1zHLNpmu
         kjwm5oxT3b1hoI1BzJ+lDJPtsOEbxsDIWjFWVCpEWxus197yO7KmtNC3G4JrlkLSvoXY
         PubWrdsleVo3vnluPij4mxPEFaCQ7Ob8kRMYsGim9c8MDd12MICPtEtFTf73RfFB9k+x
         ygIg==
X-Gm-Message-State: AOAM531EDPxTCoq5+QXA3x5qD+3A12N/bcn3wkgTQpyww+WN3DX9qyOC
        /u8gjxaO8Q5laaH26I/hwqs=
X-Google-Smtp-Source: ABdhPJxwu0xEHWqGbZdvrUpXDJ2Y9bcRKty9vlked20WesWeLW3I0jh3WJseAbC2Rw2R3xTvMFPpxg==
X-Received: by 2002:a17:90b:1e42:: with SMTP id pi2mr15927775pjb.176.1643473923554;
        Sat, 29 Jan 2022 08:32:03 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:32:03 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/23] staging: r8188eu: convert rtw_p2p_get_role to return void
Date:   Sat, 29 Jan 2022 21:58:06 +0530
Message-Id: <dcd4bba9910b172031ccc0f138c78e8471e36d91.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_get_role always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index ba0f42ca36e3..343b4ad6ce65 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2501,11 +2501,10 @@ static void rtw_p2p_get_req_cm(struct net_device *dev,
 	wrqu->data.length = strlen(extra);
 }
 
-static int rtw_p2p_get_role(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_role(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2515,7 +2514,6 @@ static int rtw_p2p_get_role(struct net_device *dev,
 
 	sprintf(extra, "\n\nRole =%.2d\n", rtw_p2p_role(pwdinfo));
 	wrqu->data.length = strlen(extra);
-	return ret;
 }
 
 static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
-- 
2.34.1

