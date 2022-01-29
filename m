Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F34A30A1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352879AbiA2QdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352738AbiA2QcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6F5C061749
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id h23so8036974pgk.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpVRaJzkm+JbIjqlEl728sQqMfSlR+afyO5cWMLCT/U=;
        b=ZZQAq/ag6BwNihmNPCYUtvhU11+52KEkNN0Gqs6Q/mrsVMdpr/RVp9bEOEnl7IgWNH
         EIgA02xreBYGRLTBtAnKgXO3RIVM8sTeUQ6BVRTdFQeFpF7fZw1JJFeeT1xVVSFs4A8f
         zD+E/mGoQvNX1Y1Lcslyejr1mvHULEquMkjiSxSMmtsRTMMtl4NC9s0wsd5lUn4RaB1z
         IRGo5WB7gYRfrOzTOJB76AN4T4BWi8EyodgP+KojS1yCu+0GUSQoFwS6uo3HvQ0+FDup
         rJwAND2V5r8AbprT89qgQ/G3TWYDf7ieNwKhwZ9HBTG2KqU9quTFT+2zyAGuhyMZYicM
         cTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpVRaJzkm+JbIjqlEl728sQqMfSlR+afyO5cWMLCT/U=;
        b=w0YkKPfNPicUjTb2GDk2jyhB/zh0B+Qz82jJzFIEC2L+dH4MgN5eIeqCzUfeJgrWpu
         D15RurDy6s64SmKmhlGyT9o2mCjYUeGSmqRDTy37A4hyO2W+1A12COonwcbTKQS+ozJx
         BuLWMrF1Mk9CLmdekLLDW1a7dH/Mcc+CBatgpu+Kou2mH2YMRKyk+FRLhKUGA3C8KFag
         a87YzZKOs4QOg9oqbH94sNc2C0NmKUxzhYNpYuCkBNLkUhlD1TlYlhxzmFSxEVBe7ZZs
         LEMGtyA42yhwtf+6Zmx51IlceLa5CVpMFejowR+WnArfCHTFmhq/0xJmhXiyuaVr+6v2
         Sk/g==
X-Gm-Message-State: AOAM531VUXEU0VEMVa9lzy5s9NamZc6U+V56FvyvaJx1y6Xx2822pUsZ
        QmzC0jgp5wPik2ap6AwdW+U=
X-Google-Smtp-Source: ABdhPJyZgPBeUbsqNw8SEUrpjXlSFPO2IQ+BX9zynOH5EahF7aZT22Ef7+6ytTWwooExE48tL8c6HQ==
X-Received: by 2002:a65:538e:: with SMTP id x14mr10615001pgq.58.1643473939501;
        Sat, 29 Jan 2022 08:32:19 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:32:19 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/23] staging: r8188eu: convert rtw_p2p_get_groupid to return void
Date:   Sat, 29 Jan 2022 21:58:10 +0530
Message-Id: <be08b2d84a7fc836db5aa008d906dee1b282fa54.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_get_groupid always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 9ee647de5ba7..4c47e9bb7fc3 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2564,12 +2564,11 @@ static void rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
 	wrqu->data.length = strlen(extra);
 }
 
-static int rtw_p2p_get_groupid(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_groupid(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu, char *extra)
 
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2579,7 +2578,6 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
 		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
 		pwdinfo->groupid_info.ssid);
 	wrqu->data.length = strlen(extra);
-	return ret;
 }
 
 static int rtw_p2p_get_op_ch(struct net_device *dev,
-- 
2.34.1

