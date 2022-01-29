Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269514A30A2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352892AbiA2Qd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352754AbiA2QcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A49C061751
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so9403085pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YT3Q4CQUgdlYmGODWsqMTkvALuQeDNDukSqX/SKoEs=;
        b=UJ9gHF+mZhKou88TjeyQUzHoDkNLxfp5fo2k8OhyxVsJWI6Xhl9ucMZhNJcIZ4CC5E
         /fZK/VH2++EuTiOSuQevZE37cLPg9I7tHUVJlLZulJ++wwu3W1Xq3KVY4MS+wa3unclo
         /MDnXfXWJX13tOMsp/IyOWwH5cC0DmQcSPSEW81vFk+5oecEUijY3Ir28Mp072ZCDVcL
         q4z2gQeHVM1YltwR6O7Rx/spxNekLZDeuwvR7R/+3W290AZ28LTs/AcrndGWNoAHsh+U
         t5XvMlEr5vlySue0Vw/he0eIsUgyhEHoQCie95Nu1jnaYtLZWYUp76svAUdfInP4QmIX
         6q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YT3Q4CQUgdlYmGODWsqMTkvALuQeDNDukSqX/SKoEs=;
        b=TfX7/E6dDG0PO37vV58KVe7TKBnqTfzqJryTdekEHd+3ddbbt+9C5p+VH06CVD5tRG
         9Mo5c6nZGEpNyyRh5ZofaVKxrnRAZql+0Qh3yRuznsDc7T8Y9eJWatGMxsFrc3AOu5ZT
         vxAY56Nf7FGwU5Cq8zpuNfZg/FxuUK+7IuFSYber8zQAoitb3RZjfkPFfl4E2cAgjncM
         6ehbd6x56azEl+O261Zj5CQa//0sCHrORp24mg+xSpxs/FXKPe4DMLN+pCfmoCUeB/2x
         +bhMCfssxWUIq5XzL4Fdo5Ydd2o38UOGHHrpCI6h9Nxws0MOSp/hFYvIyJ5ktm+A8vxM
         sEow==
X-Gm-Message-State: AOAM532JNlbjMeXAWWhrD5j+L8ZrUCyrCkfDtvnCMYMSTz5NNVcMIAgg
        e4/3RZdNBGBWTVUsy0x9SmE=
X-Google-Smtp-Source: ABdhPJxowfEqLA8zSYaQUOWqpgaObNqnKf143vzS75ugBMx1F8ZqDp8AlbsLF5VwCLq3T2W7sT++OQ==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1mr13593010plo.20.1643473943346;
        Sat, 29 Jan 2022 08:32:23 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:32:22 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/23] staging: r8188eu: convert rtw_p2p_get_op_ch to return void
Date:   Sat, 29 Jan 2022 21:58:11 +0530
Message-Id: <c94caa66e738f254b7b1d967b3016975aa0df5d0.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_get_op_ch always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 4c47e9bb7fc3..f533f709ead5 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2580,12 +2580,11 @@ static void rtw_p2p_get_groupid(struct net_device *dev,
 	wrqu->data.length = strlen(extra);
 }
 
-static int rtw_p2p_get_op_ch(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_op_ch(struct net_device *dev,
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2593,7 +2592,6 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
 
 	sprintf(extra, "\n\nOp_ch =%.2d\n", pwdinfo->operating_channel);
 	wrqu->data.length = strlen(extra);
-	return ret;
 }
 
 static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
-- 
2.34.1

