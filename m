Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4995946AE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377601AbhLFXxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377583AbhLFXxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:53:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94198C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:50:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so688609wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 15:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KkN0+8pgG8zTFzGCoaxzADvB5HXfrcxguAyCm0k78k=;
        b=O2Ma6pGa66iB8IqCj4MpBXx05P/HEMts4YbZOv2kZuyuGdl6Y3niyZFHo3QZhhDAoK
         Ug4ytk5ldqUHS0EgOu4955ZJoaVuhVRj/AWamEwrDOn2xq9YzhujnylCsXop6iB4dx6S
         2+I+SgzhGRnXYuibBqwmLQpCjRrXOKsBK+65B3V7EpyZlMlGzAX+u1lRhbPGmISsx0Ge
         j/Ad7U2LiRkDe1bSdvzauQMF3jWyCUrBaoP3KcqL4iKOvJfvi4t7+A5+URwNQ7m9Pnnj
         Gq3QUv0yZiL7E5kbUHAyneVwVOgQM/8W7f+QL1W4zOd1xqCdVwSkYwXnD5HabFz+ExVh
         IWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KkN0+8pgG8zTFzGCoaxzADvB5HXfrcxguAyCm0k78k=;
        b=ZMKR0VOqnsAS3IYb+4n7dGo95kCW/exChzfju8H5+9IKB+6qnthxWd41A2Ip/kdsqo
         KaQqmQbu/GlO+xeZUBLrbqMNJdU1bqWqSF/NwIizef6/tLGYhgv4gUlR68yvlR8X0Ccg
         gMVp9xUNvFDY6WzSxTfKC05VLN6suRHXOmJq0Hvg6mcWXw1YZhwCfQhStZ55ozPDoA8j
         6zaupq2bBbt+xQ8lzzckO6Qbu0LeQ8osJS26KfBc0slC3SLJ0rfE30D8dMdjKoQfoHY4
         v8KVig8re12nw+h6Mnz6XvCBAWZ/BjzGXthOx3ZvV67L9Mn3hT/WLiTWK7ERdYbRLyXL
         nEsg==
X-Gm-Message-State: AOAM532W4S36aslPy02fTIS7HNzFDnnHXurIomTMvROTun8Ok0nJK0Hc
        HtypwSEBeHFvanzlk81Km54TiMCev5F8FQ==
X-Google-Smtp-Source: ABdhPJygzpTsIqyGq9j+opnYOmf3e2I3/lnZXNZ3UByw7wDsrWs1zUdbLCWyL28wVtWN35QKN+u6nQ==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr2258902wmk.27.1638834603184;
        Mon, 06 Dec 2021 15:50:03 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id k187sm1241189wme.0.2021.12.06.15.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 15:50:02 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: r8188eu: convert/remove DBG_88E calls in core/rtw_cmd.c
Date:   Mon,  6 Dec 2021 23:49:52 +0000
Message-Id: <20211206234952.1238-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211206234952.1238-1-phil@philpotter.co.uk>
References: <20211206234952.1238-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert two DBG_88E calls within core/rtw_cmd.c to netdev_dbg calls, and
remove three commented DBG_88E calls. Considering the original driver
author commented them, it seems better to delete these three than
convert.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index d0a61331b883..ace3a6342e01 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -255,8 +255,9 @@ int rtw_cmd_thread(void *context)
 _next:
 		if (padapter->bDriverStopped ||
 		    padapter->bSurpriseRemoved) {
-			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
-				__func__, padapter->bDriverStopped, padapter->bSurpriseRemoved, __LINE__);
+			netdev_dbg(padapter->pnetdev,
+				   "DriverStopped(%d) SurpriseRemoved(%d) break\n",
+				   padapter->bDriverStopped, padapter->bSurpriseRemoved);
 			break;
 		}
 
@@ -316,8 +317,6 @@ int rtw_cmd_thread(void *context)
 		if (!pcmd)
 			break;
 
-		/* DBG_88E("%s: leaving... drop cmdcode:%u\n", __func__, pcmd->cmdcode); */
-
 		rtw_free_cmd_obj(pcmd);
 	} while (1);
 
@@ -579,7 +578,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	else
 		padapter->pwrctrlpriv.smart_ps = padapter->registrypriv.smart_ps;
 
-	DBG_88E("%s: smart_ps =%d\n", __func__, padapter->pwrctrlpriv.smart_ps);
+	netdev_dbg(padapter->pnetdev, "smart_ps = %d\n", padapter->pwrctrlpriv.smart_ps);
 
 	pcmd->cmdsz = get_wlan_bssid_ex_sz(psecnetwork);/* get cmdsz before endian conversion */
 
@@ -800,8 +799,6 @@ u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, paddbareq_parm, GEN_CMD_CODE(_AddBAReq));
 
-	/* DBG_88E("rtw_addbareq_cmd, tid =%d\n", tid); */
-
 	/* rtw_enqueue_cmd(pcmdpriv, ph2c); */
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 
@@ -1003,7 +1000,6 @@ static void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 		SetHwReg8188EU(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
 		break;
 	case LPS_CTRL_SPECIAL_PACKET:
-		/* DBG_88E("LPS_CTRL_SPECIAL_PACKET\n"); */
 		pwrpriv->DelayLPSLastTimeStamp = jiffies;
 		LPS_Leave(padapter);
 		break;
-- 
2.33.1

