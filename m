Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399A04A3098
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352706AbiA2Qbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352711AbiA2Qbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B52C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso182687pjm.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31GtAtozxIAbYu2fcxuIJ0ssFhQMM45afowSfajVZ7k=;
        b=dfS2BCG1tJ1YlJ8hD0HkFk8j+DSZ4faQbbQrySqr+fx9awuWxbsRaR9+AoIOQyj/oB
         C2Py6wKfw0AIDfbzJUp7DFxSEgiFhZ5LF798yGGVmJ6EEXO9p81yqgyllc7wFOkQ8+ay
         ETwn3V3GopEg4peLiZ11vbOWtiIlqAg2xb73euxynkqHeUqKdIneFymqPS3H6/1ULp85
         NkNMCOMxJGs8JZdFuMfzeAd+VyiqzqIGg+WlrqhtIpqETDAhdd+SYQmHjYErLKABARIe
         bvpABVN/8a/l/yQwtt+cRtXedv8sfNLGWqdZqfLlCczpqVWNu+jbgMtjp7aAG0wfo4HG
         TAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31GtAtozxIAbYu2fcxuIJ0ssFhQMM45afowSfajVZ7k=;
        b=iLJHiOSEI8DoaIJxeiu404YiErJe32qfWKyeAvmo/91UGtOAIXxp01yJBltib8ryHo
         AJHEmiI73VIyLolq8D256iI7yOlDGqTwuce5AOFj1GJ6oA/owwVb697Etj1DWhNlva+B
         +Vw+zSNTSWaKS5F3iT13Gsm5yAFW3ADE/Mi0EYPMvZyOgOFS2/muR7vWVcUF8Rkp+9OG
         TkBCt0xObEI4Jgdi5uUN0UAP44h1wWsqZBOZSlauNk+tyRGcwXvNjsRtCBMFYpZVKMv/
         rKLe3dgZaiIJbGHd6ADKBwS2i0nzxD5ZQLwMpW8h24d4Tnwk7e03Rh4eXWuowkvKouUa
         kmww==
X-Gm-Message-State: AOAM530qGJ9AHqqpmKC4yby4UwwVvhgvt0Hrng92oBAeezh/uXJUilz7
        7xDe2ZfSlBhttFg18dHmeVaJjVANLo8=
X-Google-Smtp-Source: ABdhPJxtO8DiEZcoOTpV5REIv5alM0Q6jY679YqiEc/Mqly/lKm1FbLOkrvIO5JJSdKwBsGTDNk9JQ==
X-Received: by 2002:a17:90b:1912:: with SMTP id mp18mr25454989pjb.152.1643473904583;
        Sat, 29 Jan 2022 08:31:44 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:44 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/23] staging: r8188eu: propagate error code in rtw_p2p_get2
Date:   Sat, 29 Jan 2022 21:58:01 +0530
Message-Id: <818aad89738b66942bb66568081f1953a9494078.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_p2p_get2 calls functions that can fail with -EFAULT.
Return the error code from the called functions.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
- Newly added in V4

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 35f7ba66a7cf..99c7f9369d2a 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3452,19 +3452,19 @@ static int rtw_p2p_get2(struct net_device *dev,
 	DBG_88E("[%s] extra = %s\n", __func__, (char *)wrqu->data.pointer);
 	if (!memcmp(extra, "wpsCM =", 6)) {
 		wrqu->data.length -= 6;
-		rtw_p2p_get_wps_configmethod(dev, info, wrqu,  &extra[6]);
+		ret = rtw_p2p_get_wps_configmethod(dev, info, wrqu,  &extra[6]);
 	} else if (!memcmp(extra, "devN =", 5)) {
 		wrqu->data.length -= 5;
-		rtw_p2p_get_device_name(dev, info, wrqu, &extra[5]);
+		ret = rtw_p2p_get_device_name(dev, info, wrqu, &extra[5]);
 	} else if (!memcmp(extra, "dev_type =", 9)) {
 		wrqu->data.length -= 9;
-		rtw_p2p_get_device_type(dev, info, wrqu, &extra[9]);
+		ret = rtw_p2p_get_device_type(dev, info, wrqu, &extra[9]);
 	} else if (!memcmp(extra, "go_devadd =", 10)) {
 		wrqu->data.length -= 10;
-		rtw_p2p_get_go_device_address(dev, info, wrqu, &extra[10]);
+		ret = rtw_p2p_get_go_device_address(dev, info, wrqu, &extra[10]);
 	} else if (!memcmp(extra, "InvProc =", 8)) {
 		wrqu->data.length -= 8;
-		rtw_p2p_get_invitation_procedure(dev, info, wrqu, &extra[8]);
+		ret = rtw_p2p_get_invitation_procedure(dev, info, wrqu, &extra[8]);
 	}
 
 	return ret;
-- 
2.34.1

