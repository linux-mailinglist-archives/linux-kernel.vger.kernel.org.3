Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12834A309F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352827AbiA2Qcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352728AbiA2QcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB768C061757
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c9so8829434plg.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBYOJsyQo0pB3WhiZOo7z3RxhrzkZJZf25jJVH/qEs8=;
        b=bU0csZXhAShQ5Mt6KL1xFYVQo0e1TbiTW1dlUovLLfZsYO1YbjGwMgQ67WxCu1dNtD
         w3MuG5YhCVScXkKIB5iiBnK8Y8mWF7PygPQKH0LM4r+H5cuUFCSaZvzGAj1ibWOZWXwy
         whtC4QoCHf+GfiEt2KtKShj59gjQx6LwxXCRtxwHHG+k39EgvvIiQtIVLVPoFWFkmvA0
         AwEkAPNmvG/9Luo27HcanC+dJn/QWAdAvGVkuCfhk58uV4XXp28Fuh3fT0O7K8MF5qju
         Bo3tK11V500KVJ7mdm23ch01hTCf8FDSFX+uRYACgvTje7fjGrwLuAydq9wXqWEO8LSM
         p81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBYOJsyQo0pB3WhiZOo7z3RxhrzkZJZf25jJVH/qEs8=;
        b=NMPcIt+FzmNkxjw8H10JKne2lBvYwaGb8/aMuKGIuMoB+wWNu99SueBNeO/Jfd4H/C
         LOM9+McZMCVnuoO/h7Cd6zLOFq4D4h9VwKxaDXhaY/mn3xbUWzXtXsyIRBmSyvXSFWI2
         E6p9ysVWaukL6Ch3eZNGelKmGy4K2xWm2J3WFvjSDd5SxrhdDzHi5vXDXoeDw7NXQAJR
         OuFtxLMQfLcpjLXpFWy2k9WS5QV4wZOP6Vt43MN6CQZmYJ66VrYR90WOIbgpydIOxZxt
         1t7nBzBbpZbFLNcQhE1ugKTacL5BVsG6xKmQVFHFZxky0DDeFlsFMZiZAnkGRxbfpt5X
         6zMg==
X-Gm-Message-State: AOAM532e2XErlAaCZT4M22FsEMzZzYRf0ieoVoQpE3/TTTUarg+8y3mp
        4yVmAb/Gm2MnzXwva+lRxxc=
X-Google-Smtp-Source: ABdhPJwd9x7z5p8k1SYwXF6Kgtt4b67Lz+PACdx3SAFvvaLqdjz5YlrBmMpslukdZw/Q/OH3VsaPoQ==
X-Received: by 2002:a17:90b:3886:: with SMTP id mu6mr8528799pjb.231.1643473931209;
        Sat, 29 Jan 2022 08:32:11 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:32:10 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/23] staging: r8188eu: convert rtw_p2p_get_peer_devaddr to return void
Date:   Sat, 29 Jan 2022 21:58:08 +0530
Message-Id: <cc077a7d11e4bda521294499c42164db7358b2e1.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_get_peer_devaddr always returns 0 and it's return value is not
used. Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 1f89f4fe4d8e..dfd19a649803 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2531,12 +2531,11 @@ static void rtw_p2p_get_peer_ifaddr(struct net_device *dev,
 	wrqu->data.length = strlen(extra);
 }
 
-static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_get_peer_devaddr(struct net_device *dev,
+				     struct iw_request_info *info,
+				     union iwreq_data *wrqu, char *extra)
 
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2546,7 +2545,6 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
 	sprintf(extra, "\n%pM",
 		pwdinfo->rx_prov_disc_info.peerDevAddr);
 	wrqu->data.length = strlen(extra);
-	return ret;
 }
 
 static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
-- 
2.34.1

