Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0774A309C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352737AbiA2QcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352760AbiA2QcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:07 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22FAC06174E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q63so9470169pja.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3R4owqSK8BZyMrVti/Fku5/LEyT/MxkNC0b3ePI8Qs8=;
        b=l+/M0MUhMI5QsI0GpFoQHwMBb4SgBKO+/mxajCAtm1jCQ1dNRzJNbXwYihGCBDFU7F
         9TZVsu7EkDDTltV2A9NsxPXPJN4SXjK5dsqgH3oRClEGnYPrxpnmsJCqviSnPKrPd31Z
         sqlz8eLKR5O00hpwc05vAl8/lqUIICxWPkK1tV+Imm8FPLDZkckMEhs41N7b1mF+jry3
         U11MwbRJYDGFdcx/hTj276sdVHAWBSyMRCfsGmJPbf3+vzCE4J+LfTDgsj/ZfWQR6qk3
         XO1VtRBCKsNhaeU4htYhDrxgwyofBmaB1LITsj6WCmMQzLIpA1zDV1Ry4lMkUayPrgcs
         767Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3R4owqSK8BZyMrVti/Fku5/LEyT/MxkNC0b3ePI8Qs8=;
        b=2LPuMWHG1hhd1QlpdEP49wqH3FZ95U/Ug7KwZ1vyqXXX6d64uwuq2gJKVSu+S0OmS+
         RKYy92wfq37Lev6+5sdbBJcVlguyyo2oRZwfGIwOu1h8D6d0dx6Y8IJvJOFtUn6EEP1T
         H3iRgfvAJvPI7G25dK/wcKepBzH4z5p9n7NXux2SdUE5GkxRklLcIUQUWF/RiAjlWPVv
         SegPg5ve5BjNJCxNzv+QlUMJ2N/QljS5S64SC0e0RmOf0hsPRZ6kNpFqsr7fMKPBeJoj
         i4K/b4w7SIljmrbgDqA3ic13nfYuOvwSyLt4wgNBKyH+BiOVvsXpfeXuQt1BKa4S65gM
         2axg==
X-Gm-Message-State: AOAM533MIjNvsyprt+mC1lqw/dy7AO7qzmjIVURWgxSGjah9IpDkbBsT
        Sza8WaqcKrARF/k0rFJ8EZQ=
X-Google-Smtp-Source: ABdhPJxv7jM9zR68yPUTZ1ABwepRcoIi01irtYsmbM5yehKnXPibQnNeXxRQs8j5IpLbKm+DAHmtvA==
X-Received: by 2002:a17:90b:17c1:: with SMTP id me1mr23507307pjb.182.1643473919419;
        Sat, 29 Jan 2022 08:31:59 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:58 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/23] staging: r8188eu: convert rtw_p2p_get_req_cm to return void
Date:   Sat, 29 Jan 2022 21:58:05 +0530
Message-Id: <a5940e6778431a4ce2d2e67543c59aae90464604.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_get_req_cm always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index d2db2117abc3..ba0f42ca36e3 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2490,17 +2490,15 @@ static void rtw_p2p_get_status(struct net_device *dev,
 /*	This config method description will show us which config method the remote P2P device is intended to use */
 /*	by sending the provisioning discovery request frame. */
 
-static int rtw_p2p_get_req_cm(struct net_device *dev,
+static void rtw_p2p_get_req_cm(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	sprintf(extra, "\n\nCM =%s\n", pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
 	wrqu->data.length = strlen(extra);
-	return ret;
 }
 
 static int rtw_p2p_get_role(struct net_device *dev,
-- 
2.34.1

