Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504FE4A30A3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352806AbiA2Qda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352784AbiA2Qc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:27 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864CC061755
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:27 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id e28so8979939pfj.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BnoXAnXc7/IIDarFMwEmp9tL1k9KPEgWxwtn8l7GULc=;
        b=Zsa/gs4ZU47pZFFCHFUEFfOWyOLuFJ1RiRoMESPYwpbEzhHcyzYSELyD4qM1Nq9t5K
         K7NBPzURaI6f9zk4s98j07QJ24qwCSKwbHtjwuiG8mY7EhhL/hxeCe/lhSN0sQ/CYAaL
         ZFQf7kgWh6KE/42Wgq0BGfpQYCFqe543B8tP9cqaBbzi7tdWAHBkUVdqDLc6lucH9gVb
         55ciqv/u2GnqPhBvVU5ipGf6o2NykKk/m+lpOLzlnVizcgBQvUXPRdyZYQmxnsEPBNY9
         UtnbBHHIDUfkkTTFc6AAfBnRHcDh/ED4M24HigLcxB0yHB5yUpE5/AVbwUHp0vXd586b
         gbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnoXAnXc7/IIDarFMwEmp9tL1k9KPEgWxwtn8l7GULc=;
        b=Ut2Os37lgU2V7MnXSXhkQTNtPnQC4BIWcEB86q/oDUyxax2HPcMvLWLpkmOJTPLEXH
         ErP1avm3UzFvIhPgPzD++aURqFI1Jui+lOM7jUZwBdl4QMTTjDRjkRH99jIWRmXnUfTM
         5zuI/+dN0EaCbOFPhsHPWmv4AXG0yalmDsLXs24FRPjBWOl0Zeo58EIg/lIKcSDXwazN
         1iS+x/GiNgUKHfBozz+FCFrRCAhRdotUC7JGtYPkOiHQGvbN3sMnxhksROwZGNLIf1/W
         GTQOKBOA9A6mRWXBayD6r7wKpxA9aCGOZyzu5V1MrigoTBmqtXreerV3vLBEj6+Sk6as
         zoKA==
X-Gm-Message-State: AOAM532s3W+xeDRQ/w1vQjAlWyJblk8Jf9QLo4ZG+rLv8A64gXEPEMDs
        VW6lm5KNgB+cXtwgWRwg+MI=
X-Google-Smtp-Source: ABdhPJzRcGKjBKM430X6B5REQ9rLilY5C1qwlhWgHKtdvey+khbdxfzmo+T1DQ5zuZfN5OqiqiiNgg==
X-Received: by 2002:a65:51cd:: with SMTP id i13mr10666141pgq.412.1643473947056;
        Sat, 29 Jan 2022 08:32:27 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:32:26 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/23] staging: r8188eu: convert rtw_p2p_invite_req to return void
Date:   Sat, 29 Jan 2022 21:58:12 +0530
Message-Id: <059a21d40a5c6cbe621ca969f9d32ea89bc9a977.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_invite_req always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index f533f709ead5..6375b3776168 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3037,11 +3037,10 @@ static int rtw_p2p_connect(struct net_device *dev,
 	return ret;
 }
 
-static int rtw_p2p_invite_req(struct net_device *dev,
-			      struct iw_request_info *info,
-			      union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_invite_req(struct net_device *dev,
+			       struct iw_request_info *info,
+			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	int jj, kk;
@@ -3065,12 +3064,12 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 
 	if (wrqu->data.length <=  37) {
 		DBG_88E("[%s] Wrong format!\n", __func__);
-		return ret;
+		return;
 	}
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
-		return ret;
+		return;
 	} else {
 		/*	Reset the content of struct tx_invite_req_info */
 		pinvite_req_info->benable = false;
@@ -3143,7 +3142,6 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 	} else {
 		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
-	return ret;
 }
 
 static int rtw_p2p_set_persistent(struct net_device *dev,
-- 
2.34.1

