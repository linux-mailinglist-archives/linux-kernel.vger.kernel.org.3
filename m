Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02D74A35DF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350496AbiA3LMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344866AbiA3LM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:12:28 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A0C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:12:28 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d10so33566574eje.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HO/N3phK9Cgv5RkgvHGJMfII6OZKPml7frfeVGhWnc=;
        b=mahg+qJ/yG4RGbk6JOlo66JbXDWodeNzkkJevG3145KRWDxInRtORgAt9VwhEk3HiD
         TJy3tUruSZwkVrOCjV6YkplgSE86niSQlx2XujJF7RoeVqvZgCezmPGwg4MgBcOdy4Fn
         XRmmAXvq/g8NmOkhVthZwN6xM5errYluqiN64Yk+toU45hBcsKTMDUD9suIZTk2Uw36Z
         o43mBcJC2SY0l0pZjxYjMApMqZP3qV5eMOyGAaBOYPqfBuaKLPRkcL3KywsMl/idYn1a
         xdIk9S17ZgEV2TKXB/WRyBZibwHOSlmO/FvL6fUpVb8cL14O0FyyxTDYTZTcRa8XjnsT
         Eh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HO/N3phK9Cgv5RkgvHGJMfII6OZKPml7frfeVGhWnc=;
        b=dLdEe3zUxs//PE3qFtauOj3Pcze0mBJZIGgYl9ytev3/ubJDbmTAnRWnfJf2kjTx7m
         oMkUCU/cUiyg+KdJyIB3zhP9PYyJJ6E/7exBqziuWGO0fuwsm2hzH6xHpkMHUT8w56ue
         dj3d8ai2e3TD2CZqEwTzkocSAUp75b0HQtifp5g/SyRymF/IsnIifbMVofWrjD+wYx0R
         ZVGEMTCcazlPptR0g3jF22Dxas/P5NQdZCKtZwDARALOhg0afPg7SYaZd21K/mah/L8N
         XG0LxhmSxdW6cPANIeBYH61aDcTidHLbQv0KJYlU/RNxIu1c80R6IkoKQKm+30xaBh9B
         rYJg==
X-Gm-Message-State: AOAM531czwPrFXYZGNMIv4tA/DSEt8FwDd5etkh4P/H7f4Xn0KbOA3Tw
        LjnaJz4uYTZ1eI/InILL6Lk=
X-Google-Smtp-Source: ABdhPJyDrcJBHEGmz08stab4Aak+vkpJcchWPLJvt4endsTLoeyt75MYtFpbTMCkt2Sc0SZt4pOUbw==
X-Received: by 2002:a17:907:948f:: with SMTP id dm15mr13497491ejc.52.1643541146720;
        Sun, 30 Jan 2022 03:12:26 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id nd9sm12129510ejc.169.2022.01.30.03.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 03:12:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: remove c2h_evt_clear()
Date:   Sun, 30 Jan 2022 12:12:17 +0100
Message-Id: <20220130111219.6390-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130111219.6390-1-straube.linux@gmail.com>
References: <20220130111219.6390-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function c2h_evt_clear() is just a wrapper around rtw_write8().
Remove c2h_evt_clear() and call rtw_write8() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 2 +-
 drivers/staging/r8188eu/hal/hal_com.c     | 7 +------
 drivers/staging/r8188eu/include/hal_com.h | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 266bb7db5252..c7e8602d2097 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1331,7 +1331,7 @@ static void c2h_wk_callback(struct work_struct *work)
 	while (!rtw_cbuf_empty(evtpriv->c2h_queue)) {
 		if ((c2h_evt = (struct c2h_evt_hdr *)rtw_cbuf_pop(evtpriv->c2h_queue)) != NULL) {
 			/* This C2H event is read, clear it */
-			c2h_evt_clear(adapter);
+			rtw_write8(adapter, REG_C2HEVT_CLEAR, C2H_EVT_HOST_CLOSE);
 		} else {
 			c2h_evt = kmalloc(16, GFP_KERNEL);
 			if (c2h_evt) {
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 7f28fd08f0aa..f83375a389f8 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -298,11 +298,6 @@ void hal_init_macaddr(struct adapter *adapter)
 * BITS	 [127:120]	[119:16]      [15:8]		  [7:4]		   [3:0]
 */
 
-void c2h_evt_clear(struct adapter *adapter)
-{
-	rtw_write8(adapter, REG_C2HEVT_CLEAR, C2H_EVT_HOST_CLOSE);
-}
-
 s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 {
 	s32 ret = _FAIL;
@@ -340,7 +335,7 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 	* If this field isn't clear, the FW won't update the next
 	* command message.
 	*/
-	c2h_evt_clear(adapter);
+	rtw_write8(adapter, REG_C2HEVT_CLEAR, C2H_EVT_HOST_CLOSE);
 exit:
 	return ret;
 }
diff --git a/drivers/staging/r8188eu/include/hal_com.h b/drivers/staging/r8188eu/include/hal_com.h
index 95167f0b327f..4417054c0f93 100644
--- a/drivers/staging/r8188eu/include/hal_com.h
+++ b/drivers/staging/r8188eu/include/hal_com.h
@@ -150,7 +150,6 @@ bool Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
 
 void hal_init_macaddr(struct adapter *adapter);
 
-void c2h_evt_clear(struct adapter *adapter);
 s32 c2h_evt_read(struct adapter *adapter, u8 *buf);
 
 #endif /* __HAL_COMMON_H__ */
-- 
2.34.1

