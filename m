Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44154A309A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352724AbiA2Qbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352674AbiA2Qbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:52 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E5C061741
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:52 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so8084812pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=so3gw6VeXNqJCoBkFVd/9SWWTHocd9ttgxTU3TJ1cFo=;
        b=oRj7oImpt5kKgtkq/LCUN0tJ7NlEILepU9GYvZ5DFC5dRAQu6kJRcLlDWjrfV5/Ni0
         UJLuQoQEIqHVG88zLmWY1Fhi6ibc4strwuB3wH15IjXjbYSaJ0fBig0tQp2yhIIyiYT0
         hsRbIf7PbIsYwnjOenN/RRQKjWzeytRJxnXgjo2z/iYgTI6inEtoR/1Rvi2TRY75Q/78
         4fMtN8wzn47m5g2qpKOrAHl5D2B/cRK/ShFEiOXr1TFCo+9QJQbiZMEXKTPfzx9rn/3s
         VgP4lUoReDS5mwgkWHpo6Y5FEqfk+CxA4RtswHKEHWZVereHfeUAqRWLUb/5CHV3ZIeA
         B2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=so3gw6VeXNqJCoBkFVd/9SWWTHocd9ttgxTU3TJ1cFo=;
        b=7tx00GqwztMrGE9BaJKVswWgLm3ep4yWmeqYmO/k3rFsQQ+5bNMpTEU/QasMwMRHj3
         42IgIecAGpg/1bVz69nqjEyu+ebd3U1POnXdgXnHZqXZ8XhQ7+hdZy6H6qrgWGW3BoHi
         88nUA37Eb/flttZqaqwIEe1iEh4wDBmMXTnkMqmP0ENVGS2lgSYHaiWHroXKtQdt23Gd
         0iS4RlEgF3Q5Pm8IUbf6fh5PUqa6GXQiD1zYRcJqHW0lmvcMYMT7OzhC7EK7AvDoUp/N
         oh0ABO4zu+ZuaaHj5a2fXdiugvd9OXgacsAYlW3lunNhyXnE8XZb46ZoHekJahmU3ydP
         W3BQ==
X-Gm-Message-State: AOAM531Y0pm7K6RnI4rLfsnhrYVro7hl2ZGqzKjpnZHGkQD2ui7CAjS4
        W9R5QMyzbfSO2FP+8aGi3Ws=
X-Google-Smtp-Source: ABdhPJywahgk5tKO254vtnIjqc/UN165qbWeHmM9qQZ35ol/dR9A8AnVb08DAERzjSIEU641plBRiA==
X-Received: by 2002:a63:8ac9:: with SMTP id y192mr10727739pgd.598.1643473912229;
        Sat, 29 Jan 2022 08:31:52 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:51 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/23] staging: r8188eu: convert rtw_p2p_setDN to return void
Date:   Sat, 29 Jan 2022 21:58:03 +0530
Message-Id: <fe4a9f0176c96ec327342c793de1f55c89d16768.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_setDN always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index c761c06cf6e8..daaf808ca23e 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2453,11 +2453,10 @@ static int rtw_p2p_profilefound(struct net_device *dev,
 	return ret;
 }
 
-static int rtw_p2p_setDN(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_setDN(struct net_device *dev,
+			  struct iw_request_info *info,
+			  union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -2465,8 +2464,6 @@ static int rtw_p2p_setDN(struct net_device *dev,
 	memset(pwdinfo->device_name, 0x00, WPS_MAX_DEVICE_NAME_LEN);
 	memcpy(pwdinfo->device_name, extra, wrqu->data.length - 1);
 	pwdinfo->device_name_len = wrqu->data.length - 1;
-
-	return ret;
 }
 
 static int rtw_p2p_get_status(struct net_device *dev,
-- 
2.34.1

