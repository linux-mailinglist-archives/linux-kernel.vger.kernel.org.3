Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8341E4A3099
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352700AbiA2Qbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352674AbiA2Qbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E5FC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:49 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h14so8883298plf.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Th8PVyYelZWCsFcO3s4hWSpijYoiPjQX9yudaKFZQco=;
        b=UTdYPZZph8EsAJuRqYnss+oruj9Z7o1I+TKpquPsJv5MGwF93vsHmNWTUr/hutsjJg
         Dge+8mILBYWEOKQMnzqXz8x5W3xIRUdZYk6x0YabTfDtCQAt/ddIpaE+op9XV+fk9MMe
         PER/0j6n9askSdZgwS1tPC/MOWkQe94pMafJMb9vpuJ+0CzxnC6dpOYpDc5cxyNDDqQw
         vwRrVaSvgpxK24Vn2orj2sDPZ2WoIwVARu0kBBkIpCHX7t1cn+eqXonzJY06hzV55Ryu
         MjCsP3/B2y8dvNqpgJxr0D0P6fAp8QIk9BQ3QBatZ00HTvcOx0uHKd+uS/REfV4h33++
         14pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Th8PVyYelZWCsFcO3s4hWSpijYoiPjQX9yudaKFZQco=;
        b=IRv+Bj+FesFdW4a6KN9X/WonMIFwlv5oTrDXdeE/LJAbR4jPeJIvCGlXv1JI1XFRGo
         8TTBHa7tXC1lxNKclzBAcTzZ8c7Ki/Lj1JBBYHgxeHlYOTD2X2C2G7wIrmJJBl7JMQrd
         2Oyte6Z2M3kBuiOn0ROZPqBsx0v293r9H81+58qN2BKXIWet3umMeNDPmLzB1mFrZSmu
         7CLdrEpJPiYOISLLz4b1EVb5WmEkauxCZZusi40m599XRYzVYMUQbbP+wH6liRw+96Xx
         CAqKfXL1Ad9y0S6sTgytfiGluwQTO5aMUzwt2CjzoDN9mQwIrK0Ll4lU44fAqKuSMMSz
         JA6A==
X-Gm-Message-State: AOAM530jyOxYnX1w0yYKD9Rz2nR5yyFrM17eXX4oXS1iiel4o2AlEE/R
        NRnX5D+uAQA7Y2DNsEozpzI=
X-Google-Smtp-Source: ABdhPJynPVtFor8dKoPc0tEvfK703tA77lIEm8g7DHSvdjqcOn/m9uN8N6N1EB9qisseLzWkLIjj7w==
X-Received: by 2002:a17:902:758c:: with SMTP id j12mr13491819pll.34.1643473908565;
        Sat, 29 Jan 2022 08:31:48 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:48 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/23] staging: r8188eu: convert rtw_p2p_set_go_nego_ssid to return void
Date:   Sat, 29 Jan 2022 21:58:02 +0530
Message-Id: <90e2b3e4ff99131423c11b8f9206916791f742d9.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_set_go_nego_ssid always returns 0 and it's return value is not
used. Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 99c7f9369d2a..c761c06cf6e8 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2308,19 +2308,16 @@ static int rtw_wext_p2p_enable(struct net_device *dev,
 	return ret;
 }
 
-static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_set_go_nego_ssid(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] ssid = %s, len = %zu\n", __func__, extra, strlen(extra));
 	memcpy(pwdinfo->nego_ssid, extra, strlen(extra));
 	pwdinfo->nego_ssidlen = strlen(extra);
-
-	return ret;
 }
 
 static int rtw_p2p_set_intent(struct net_device *dev,
-- 
2.34.1

