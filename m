Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CA74A30A6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352926AbiA2Qd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352790AbiA2Qcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:32:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45582C061741
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so9403262pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgVStoddJ2w47VmtVxqI0lQhmbBW93rYRLMmc+SnhhA=;
        b=dZ2KT1HoDao2BU7s+nRlVVTxk67LlW7tVY2D9+NzUgmfbrcJLsJuoJnrNpsq/tKPPf
         iW2X+7Upl5AIsACBgMXIXYqzoH0M2G02SPWEz9ooXvbJjiuR8ChropZBxbZoo3qlcEFI
         vNY9UcM9Z8stYlzPxupg4am9gbkA7liF0Q9nW1b8hT3U0Lz48dWy5P/yRgDRDgvfteIs
         4C4kJUdE0ktoTfPAMFNZfBA+vdkWgZV/SlG7Z+2YNnsgtOx4bA9LIJcpgq5jFJb21GpB
         JKzPO7iyRyow/wbo28tCk3eKtXToSgykkwa/nngH/GXchhMIjmsBoKyFdaGgwgSkOLH3
         bh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgVStoddJ2w47VmtVxqI0lQhmbBW93rYRLMmc+SnhhA=;
        b=iLrvjrksnl7XRBODh0oOhib++hRjW+TQQJvxqst5J5yXj5fUQ09rZRFzCJmRtZt4eM
         D8BSTLBp/TWY9TCFew7TkF4SRjN6hEYumA16vQuQlmf2Ch2fpeaakwiJpjTHjf/ADJIJ
         VUiIuN9lb5wnlF/j0mpIonK1vLH1YToWU9HVmn52TtVe92XzOmdKiitAIlrmIrUtPBrI
         3Xo9yD4uAs9QOn/iWUb7h1woBX6PpGaEdbRoL8aCR1rsrg7nIcstxjT+XQpYoOyaSkiW
         R9RrVVjw9woRf95ejmBnTgTU26M5xiM2oNcdSW9ikGXDIecGZH82CFp9mB/eMd9AnXlT
         X7Tg==
X-Gm-Message-State: AOAM530c2OEefMezkTOw9NMLYwrfTkmoyKJvg/EYKadqxNbIsg5svHAX
        1MiWOvLV0gsVAOozE7EnHHE=
X-Google-Smtp-Source: ABdhPJzrR1aBjCtdoMyzZpJiMv34QFkG2JXs5DuRUtQ86k4ciiGJBedk3DvpJ0S3xxraUZ0oxzt42A==
X-Received: by 2002:a17:902:ab46:: with SMTP id ij6mr13774843plb.164.1643473950855;
        Sat, 29 Jan 2022 08:32:30 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:32:30 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 21/23] staging: r8188eu: convert rtw_p2p_set_persistent to return void
Date:   Sat, 29 Jan 2022 21:58:13 +0530
Message-Id: <2f23981bcdf4177327b9a29e88540380ef627aab.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_set_persistent always returns 0 and it's return value is not used.
Convert it to return void.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 6375b3776168..4c778cf92680 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3144,11 +3144,10 @@ static void rtw_p2p_invite_req(struct net_device *dev,
 	}
 }
 
-static int rtw_p2p_set_persistent(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+static void rtw_p2p_set_persistent(struct net_device *dev,
+				   struct iw_request_info *info,
+				   union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -3160,7 +3159,7 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
-		return ret;
+		return;
 	} else {
 		if (extra[0] == '0')	/*	Disable the persistent group function. */
 			pwdinfo->persistent_supported = false;
@@ -3170,7 +3169,6 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 			pwdinfo->persistent_supported = false;
 	}
 	pr_info("[%s] persistent_supported = %d\n", __func__, pwdinfo->persistent_supported);
-	return ret;
 }
 
 static int rtw_p2p_prov_disc(struct net_device *dev,
-- 
2.34.1

