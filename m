Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665964894AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbiAJJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiAJJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:00:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06EEC06118C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e9so23845404wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vdq1YRATZXZW2zTmJrFcNBwG86kVUBqymJ+QklrHyQY=;
        b=iXPFPewI0GZ1elrbXi5ovlp6lZOKo157t8RaURBq2v/j9IBpNhMDtZfaDILCKIBcIL
         0PmrzvqIwgOPYjT6KfO/YZzDaPbjglOZMZotoZFH5KszCzCnGvc00KbO6tFKdQAYVFVi
         AIQC+UqGWL6HBDlb+GBqBdk4zcCzAGM/SHHqqc/eG3Pv34B78dxp6Udjch3gP3pOkUkT
         DJcXdpp9AEDW+xzLz85DOrD8c4gVa+FptBsLmf9uNE01maC1lB+wBWFJb4CSSAjJZThv
         NJsAkLUaYZ9ZKPJoL4+RlfgGYjTJNk9RVX7XE6fuC1YQWXKRqrRsMoIaWd+oDRqACWHO
         fosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vdq1YRATZXZW2zTmJrFcNBwG86kVUBqymJ+QklrHyQY=;
        b=5v4AafKWvWwnDGjWOuZtFnz+aJOzc9Vy1flX8x1Vf2jZJF7vEch1Q4Lc1QuQ2BQLip
         cGN+OjZaiQYw0kcG8GJCYLJsbPwojrvGu8pmir8T7MOt/eP4tbkabm+WJDaWEUg2lG5p
         CoyRyC1XeZ5YAMa7b4ZZ1SOCY8fr2O55+3TSiojQWhlXYOEb3cJ4h9LGxhd1CndtAn1L
         NRRDMOdbiibOf1wEebXrXk4cODCsQneDVqYlcmjUt8NjyxZsIZnwBTAczTj1JmvP21QO
         LhUm0BtBrq6N13OWpBeRdNfYfICYQDVypWZXTo01zw64MVZmr1qOkdmn0+9VHlswHm0T
         EUWQ==
X-Gm-Message-State: AOAM533ifwA9ZyxBUMdULMrRuTSk30Gs8JC2aMFhavP6nFml+rQOIVYC
        AdNvCS7wD8mhEKxoayAFtFmiI1hQbAjFWA==
X-Google-Smtp-Source: ABdhPJwM2BPb7k1hwg9ILv4zfpmrE0Fk1nkhO60Ej/mSk1/4v/arm9rU1jXliRptgQzkTwnxG55eoA==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr44403881wri.389.1641805225521;
        Mon, 10 Jan 2022 01:00:25 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m15sm6263287wmq.6.2022.01.10.01.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:00:25 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] staging: r8188eu: convert DBG_88E calls in core/rtw_ioctl_set.c
Date:   Mon, 10 Jan 2022 09:00:18 +0000
Message-Id: <20220110090020.6800-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110090020.6800-1-phil@philpotter.co.uk>
References: <20220110090020.6800-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro calls in core/rtw_ioctl_set.c to use netdev_dbg,
as their information may be useful to observers, and this gets the
driver closer to the point of being able to remove DBG_88E itself.
Also remove one unnecessary DBG_88E call which was already commented
out.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index eadfbdb94dd5..c95ca471ae55 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -122,7 +122,8 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_88E("Set BSSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
+	netdev_dbg(padapter->pnetdev, "Set BSSID under fw_state = 0x%08x\n",
+		   get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
@@ -195,7 +196,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_88E("Set SSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
+	netdev_dbg(padapter->pnetdev, "Set SSID under fw_state = 0x%08x\n",
+		   get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		goto handle_tkip_countermeasure;
 	} else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
@@ -280,8 +282,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	if (*pold_state != networktype) {
 		spin_lock_bh(&pmlmepriv->lock);
 
-		/* DBG_88E("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
-
 		if (*pold_state == Ndis802_11APMode) {
 			/* change to other mode from Ndis802_11APMode */
 			cur_network->join_res = -1;
@@ -364,7 +364,7 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		res = true;
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
-			DBG_88E(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
+			netdev_dbg(padapter->pnetdev, "scan deny\n");
 			indicate_wx_scan_complete_event(padapter);
 			return _SUCCESS;
 		}
-- 
2.33.1

