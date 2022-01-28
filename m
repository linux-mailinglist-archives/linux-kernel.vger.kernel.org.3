Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915D249F8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348305AbiA1LzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348266AbiA1Ly7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:54:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39384C061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:54:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so9470310edn.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9cza9dSqPk0L2+uMxlWPbP0uhx5TQLbq0PHDy2GAGI=;
        b=gBwQn0Dc69hhlkMzoTB559FJzXv2XYymnc1LjJWJg39Wf0Jt07Ekg3ING+cZpqw8C+
         Ocm2Tu/YxnPRUbqSy3EdqTPZ567d0cZs8iEmCZm+msl+qHf6QJzPsIlW3tUp0ZrpZbuX
         v8E2EVHcULS3HTlzPBYKWD/0QPHPe82WpY1YfyrbsXcFKfnU8CIYYfw6jdnLpWOL1Q+i
         4rT/7VAhYz8sz9t2zx+aWCvxNFTU5sbyjg5fIQTY4hmyJfT30njUvZ8vURuQP5RXVyOr
         DWnWho2evY/cTxDxehewPGhAX110cU+8HgLxzIGpKxF3rH3amDg+iC4qeWwwIvZAl9SJ
         mvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9cza9dSqPk0L2+uMxlWPbP0uhx5TQLbq0PHDy2GAGI=;
        b=lBd89AptSSF8Z9Jeyllhxv3uXfoI7AHJUHeHR4IWqIxsrwu7FyPefaXzBdydaSnHWM
         PA1pKYbTQXhKq2vNd2hwmVsrGkVvyYi+YTSw7xmqDtrgZyngrFa6A8JD7p5PwRE0dfKA
         qTLItJ1Rq7cNr90Y6IRgC18Pjj0kYlgx+zKT672f6Pv+mzp8SkeFvvnR8D8SP+AUHczF
         RJ78LxYQkvOrKWe4lTJxJ6K7XJG2hvth8V0E33Nu+JFVKA012Vlgrsi9r8Tfz7tdJLlN
         zcXJfDG4V/FKwFBHuGKLbuFJJR53HPPzjqNGMcV/N4UrYoJBvgugvi0WdFIL5KRB/WoE
         Q/FA==
X-Gm-Message-State: AOAM531F+sosRywYgDobMlAREP9aVVWgIEQ7oGyvFfRB9AWLmefo9nkQ
        AQ36yK8ZkZuTYaRaYMZA7Ik=
X-Google-Smtp-Source: ABdhPJwtB8qiP2MjAq5mpzfVzNx01EBjcBYJkBbdCfLRKJXp/TmFcOQmXJaFxjPz+6WfSnjaqlDqYg==
X-Received: by 2002:a05:6402:345:: with SMTP id r5mr7987043edw.269.1643370897861;
        Fri, 28 Jan 2022 03:54:57 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9e.dynamic.kabel-deutschland.de. [95.90.187.158])
        by smtp.gmail.com with ESMTPSA id h20sm12494261eds.9.2022.01.28.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:54:57 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: convert SetHalDefVar8188EUsb() to void
Date:   Fri, 28 Jan 2022 12:54:44 +0100
Message-Id: <20220128115445.6606-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128115445.6606-1-straube.linux@gmail.com>
References: <20220128115445.6606-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of SetHalDefVar8188EUsb() is not used. Convert the
function to void.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 6 +-----
 drivers/staging/r8188eu/include/hal_intf.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 7a640fbaaca6..3aa5289a61f0 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1651,10 +1651,9 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 }
 
 /* Change default setting of specified variable. */
-u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
+void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
-	u8 bResult = _SUCCESS;
 
 	switch (eVariable) {
 	case HAL_DEF_DBG_DM_FUNC:
@@ -1692,11 +1691,8 @@ u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 		haldata->bDumpTxPkt = *((u8 *)pValue);
 		break;
 	default:
-		bResult = _FAIL;
 		break;
 	}
-
-	return bResult;
 }
 
 void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 96016e175cb5..9b4d1650b4b5 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -101,7 +101,7 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level);
 int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 				struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt);
 
-u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
+void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
-- 
2.34.1

