Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3543B4A30A0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbiA2QdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352644AbiA2QcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:18 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF7C061748
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c3so8860433pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mk12BTSCM2+mq3xJbziWeOLcSVGsDqsbYqmoTpChlQM=;
        b=ae1z82YShCLldmO4lu1B2Nf5vJMnS3IS+SkfIuouT3SGDC0i92Joxo5b9sAR3T4s/u
         xMQnB7RCnrAhj3b3w348Ql6yn3+xLjWBotBRShWZjexpKPhom4EUeL0KzUVgEYDNvEOs
         nB3ZR9IHqdXYBEW1n9kzavhQJ1d5w/swDuzgzEbKXNSAHxpnOgnc39NCuq6MpEzBSsC8
         wogeK7lBFtuV6n+XcsFnuThxAb6IWLH7KNqsi/sQ7g8xYoBQq7M/abJm6srYn9EQTGGm
         K2NE0b96HY6MAN6i6FkP4M3MD+4dtJeikuu0k+8mfscxfj03bmt+rLoBrkX3t7vqprsB
         UEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mk12BTSCM2+mq3xJbziWeOLcSVGsDqsbYqmoTpChlQM=;
        b=eax4e3sMJx48l/cLVPCRrAxvA4qmtpbkSBibR90f1RG4G8l+xCzQrr/LQfM2/hw8SM
         opGvQpVwdibs5gSasgrjy/8WnzhY/HvaoDVIkbjkCb4BAEGO+/2sXBwigAb5ehHVG+N7
         5lGoQjjTUXEe8RHwOVVPAy0zp75DafMx66t4tqMwZnrw9YlN7fpSf6bYyStFIr06W1pb
         AtXq+K7Y+SRJa65piRj2PcTFFJSjb6ZjAURzJLQ5ZyhoNd4Xv3dekfg43dOr+o6syX0s
         hibK/ZVqWEKTuxmvGxkKNal56glv+EDIb/c7xzMjasXJMGa3ZgWgV0A56dnyyGZgg4P2
         n3aw==
X-Gm-Message-State: AOAM532VW3PlALN/zYonc39MTBNi9O5N9KPDsBSxeKJQ938PDMBGkwC4
        8Jast6aB672CaWXdej3MlFprXHjxwGw=
X-Google-Smtp-Source: ABdhPJzcbwCW28uzSi7lJtVO/GFRCtdb7QsA72O+86uRV+z2LRZ28M2NQj9hsr9czem5ajQi2YT6yA==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr17242737pjp.129.1643473935287;
        Sat, 29 Jan 2022 08:32:15 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:32:14 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/23] staging: r8188eu: convert rtw_p2p_get_peer_devaddr_by_invitation to return void
Date:   Sat, 29 Jan 2022 21:58:09 +0530
Message-Id: <06e2dce5de14c1abe457a40ec9ca597a06095437.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_get_peer_devaddr_by_invitation always returns 0 and it's return
value is not used. Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index dfd19a649803..9ee647de5ba7 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2547,12 +2547,12 @@ static void rtw_p2p_get_peer_devaddr(struct net_device *dev,
 	wrqu->data.length = strlen(extra);
 }
 
-static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
+						   struct iw_request_info *info,
+						   union iwreq_data *wrqu,
+						   char *extra)
 
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2562,7 +2562,6 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_device_addr);
 	wrqu->data.length = strlen(extra);
-	return ret;
 }
 
 static int rtw_p2p_get_groupid(struct net_device *dev,
-- 
2.34.1

