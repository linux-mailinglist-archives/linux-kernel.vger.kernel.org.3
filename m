Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE44A30A4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352839AbiA2Qdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352848AbiA2Qc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048DC06175C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b15so8881443plg.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HB3rD200TcYiLs5tsvdXeI+ibi+B/S+l18YmlgU5fCE=;
        b=FF2HNd+zuYsbL5g/5i0PUuE/ezTQauFPKnMkcuHyUpOqAdAwCchqRXMueOaHkx0NQZ
         zQa/r14k1efRYzFBX/9va6h7buyryd2qCHowI4pQ6meFEEP9W/4WINrUV0K967c+1b1R
         rFn1Nhq5VLKzmxzBpngECcLDPYMYZWO7GOeP2t+U7l0zZWE5GSF/oCEe0G/jdCCuIVfy
         dkn7BwizAj+c5mvHdKHh9dGzs9ebOrdyR15GDBYGFw9PbsD0dR7TBSQHmA1w0KHb0cER
         cdRGIfuf3ythKCscRz4IkUpseDFmbIMpifltGQCfgJNcttJPr8gmXZK8WxnJppX713V6
         Dzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HB3rD200TcYiLs5tsvdXeI+ibi+B/S+l18YmlgU5fCE=;
        b=UC6/SUYWSDqpUaiJUZILSJZTziV/2594CysOpyvU1yuBjW/0BZ/Xc1pDKEOoyutUjM
         elaO860piPGIm8BDUxSSxTOY5hftwhhsReAKf9RDtwAcJOT5P10+kC44CEODVe5Ciav/
         R3tcyGdlYIisAheC1vnFc3cH9o8OIFBO6nNIuTDdcqYm3ucxEnj4i1ET+WtdSM/X4Wyy
         9O08Tn2Vux2RqxVogdWUUyxzcjlUPVXfJWzkCTzgB6JXTGRPHIU+cTaS8sbh0p7Xha7Q
         p3r2YIJRbmsIEUXZGmJSqJdeUwRRs92p1W8VBBe3+DovH3pMMuOTR0bmt79t5BaUAzxA
         yZxw==
X-Gm-Message-State: AOAM530hDFbNncXQX+XCcLz5wjxcOjEg7okjEQdQa+bgcQuuyr14zBFP
        DXOJh+1UB1/7INPETnrvCDM=
X-Google-Smtp-Source: ABdhPJwzF4IZ8/LW/oEI2adx+41W+RVXEkFWhs93pWHft5RlATLB++QwJKhjwvXdCOrCOg3y50ndvg==
X-Received: by 2002:a17:90b:1983:: with SMTP id mv3mr15877594pjb.222.1643473958680;
        Sat, 29 Jan 2022 08:32:38 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:32:38 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 23/23] staging: r8188eu: convert rtw_p2p_got_wpsinfo to return void
Date:   Sat, 29 Jan 2022 21:58:15 +0530
Message-Id: <f63e236e3a338789265172990fea049216115105.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_got_wpsinfo always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 1af8b2c068b8..c54ec5602ddf 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3301,11 +3301,10 @@ static void rtw_p2p_prov_disc(struct net_device *dev,
 /*	This function is used to inform the driver the user had specified the pin code value or pbc */
 /*	to application. */
 
-static int rtw_p2p_got_wpsinfo(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_got_wpsinfo(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -3326,7 +3325,6 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
 		pwdinfo->ui_got_wps_info = P2P_GOT_WPSINFO_PBC;
 	else
 		pwdinfo->ui_got_wps_info = P2P_NO_WPSINFO;
-	return ret;
 }
 
 static int rtw_p2p_set(struct net_device *dev,
-- 
2.34.1

