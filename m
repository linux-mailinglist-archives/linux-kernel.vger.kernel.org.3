Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3A4A309B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352761AbiA2QcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352680AbiA2Qbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CB6C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so13877599pjt.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mb5XVHLKhEOk/yXbWKnvcJOWOr308i/Z4c3YSiAFsaE=;
        b=IGwznrlFjCc7Dg4W52xaVzurlktI52HRfbLK9uZGBriiRCmHwDjyrTIDngntLnD5Wy
         tQJ8fV+eI9rQcWg41pGN1UMiCcoStZ1eRc4GTXIpll7qSdAvju7car9E8iM6GJJ9jBMx
         NrHJOPPbjM6qziCidMobsW890nVXnH/O264sHOm77x2BhQe95LlePPsST4coKgPn8C8e
         1tVXZd1zIGOGR1HogxjBn8Ka3u9rVK3Uj7V0bpgSvFyDrgJ+YU+0M8xoa4956KkSMwr+
         p2hxd00y+O/7Vz8lrIM3VfP6iUnxab3uT45rkASZz2i2NIkLt0wVKBM5uFDzq1k7ihWG
         Vdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mb5XVHLKhEOk/yXbWKnvcJOWOr308i/Z4c3YSiAFsaE=;
        b=YzhGQkNw/y7x3vWxxm090MZjmhEbX3oCgfUoyZDhP0CkCAZVKab9di5Z8NKJQTe63I
         ldirln5O6C467i3A1iOPkywhg1wVklxzUn5lbrCDfGW75JkWkiHbNX2R0NGT0aOCelMj
         vDhUUk6Nks/SVc2kafuIP+FZWg9lYh6tgEp72MTKLGeJm0Bu0Q6NI8N3JimMIpWLeqdt
         cJqOE/2UCgDfJnG7wZBlvKmSY596ZT55FzmufXQeCGobC+c9ystg4bkUe6LK/jxku/Ac
         6CZizYUG4jzVfkivlsMz20bv1OhQs/Z91qPg30rwGNQQZeuc4850uw8CTZjB3rVABI4N
         f/Gg==
X-Gm-Message-State: AOAM532MyEt13iruFQr7NZYO89wt0sEeuuyw/D6G8wMFN69MLuRF5V5N
        to9n/beh1okTMVZjfYXxmXM=
X-Google-Smtp-Source: ABdhPJw2IiTmH5NvdXBTOeBunxNR1XG9f7yxZXqajR8wJRRPTbz0cOcO+ge+HIZF+vnHreJxnQMFtQ==
X-Received: by 2002:a17:90b:4b52:: with SMTP id mi18mr15810316pjb.74.1643473915390;
        Sat, 29 Jan 2022 08:31:55 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:54 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/23] staging: r8188eu: convert rtw_p2p_get_status to return void
Date:   Sat, 29 Jan 2022 21:58:04 +0530
Message-Id: <832c53cc201111449fccb40326084d20f676e722.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_get_status always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index daaf808ca23e..d2db2117abc3 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2466,11 +2466,10 @@ static void rtw_p2p_setDN(struct net_device *dev,
 	pwdinfo->device_name_len = wrqu->data.length - 1;
 }
 
-static int rtw_p2p_get_status(struct net_device *dev,
+static void rtw_p2p_get_status(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2484,8 +2483,6 @@ static int rtw_p2p_get_status(struct net_device *dev,
 	/*	About the "Role" information, we will use the new private IOCTL to get the "Role" information. */
 	sprintf(extra, "\n\nStatus =%.2d\n", rtw_p2p_state(pwdinfo));
 	wrqu->data.length = strlen(extra);
-
-	return ret;
 }
 
 /*	Commented by Albert 20110520 */
-- 
2.34.1

