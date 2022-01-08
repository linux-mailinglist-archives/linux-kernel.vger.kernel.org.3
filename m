Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13FB488036
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiAHA4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiAHAz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:55:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7AAC061401
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:55:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v6so14082985wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 16:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HAlFSP/txm9kID3HVIKgkV7x7wASPTmapxOHoe9+Co=;
        b=fEk4d51O2nhhwquJacGaVq5A1HjhjBwKPQg0u893X027/cZwwzdGqPZvHSTvk8echw
         +d1dywaLKaKE12zVXVfVdqa5QvLd5dRlh4AZeRSsNxYSe3r7pvKXuNlsoBCtdhOk+yLB
         VACEnth4FZIVsAE4+DwDSCfkJ5OPSN0LPy99NIu71FiVp9tDqFzVsVoJF9jM1opzHO+z
         /ayQ8ldnW00Ls6Z2M9e2wdsQoMOEXfWjGfnxhKz4w3DgHDSDjFH5IIH45Zu9mp9FgF56
         rMamt2KGAok6SXgLU+/oCrfPYhYa3tZFbVrB8v6SBIcIsz23xtx2Bnp4lvbCiY9jhGwh
         OamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HAlFSP/txm9kID3HVIKgkV7x7wASPTmapxOHoe9+Co=;
        b=MP6uRsK6h+FInRYpiaQDyRPyWkeToOY9mDyeSqrjzgAVX26H+eFsm0HkZLZqhr9fhu
         X/FoNrf1y2j9YZl64tJAwAuYETbIbDo2ZnxTPeX3joxCWBxFk55tj21aQcfaRtwHGhs6
         Kj9mT69F60vvwG5qi0CZWvEIMCypJul/2ry4qox0jHKsabH6UykgP2zpRvfGXl7056w1
         0R3y4+81uxiLiv6i0izsN9Qhwdv5IIqs+CbUhTHvzKrSMdOnuoUDwZe3hh5QRpTI2Rxx
         QyeIxmo3Zay90dFiz64d1qa8S/lG3V0RkEqyOffB0NkZQLH6N5/5Dz9TmbNTzcmghP2Y
         gFqA==
X-Gm-Message-State: AOAM532J1OtV/g/KWz1RmJIScH8ZIBJWLksKqy3rRyd1wEK7lkFfttS2
        Muj0Y0JPWkMPzd3QS+t/7/CvYg==
X-Google-Smtp-Source: ABdhPJzsimLrDKBSblclUMJDP+v2NN9+1/uBSZdmzz7RD7rg1cmgh5lsCywW0m6GW/nc48Tx0s3MhA==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr6139139wrx.218.1641603354225;
        Fri, 07 Jan 2022 16:55:54 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id c18sm238853wrn.81.2022.01.07.16.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 16:55:53 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: r8188eu: convert DBG_88E call in core/rtw_cmd.c
Date:   Sat,  8 Jan 2022 00:55:49 +0000
Message-Id: <20220108005550.26264-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108005550.26264-1-phil@philpotter.co.uk>
References: <20220108005550.26264-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro call in core/rtw_cmd.c to use netdev_dbg
as its information may be useful to observers, and this gets the
driver closer to the point of being able to remove DBG_88E itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 8bfb01c2ebb5..712fd6e536c4 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -952,7 +952,9 @@ static void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 
 	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
 	if (txdma_status != 0x00) {
-		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
+		netdev_dbg(padapter->pnetdev,
+			   "REG_TXDMA_STATUS: 0x%08x\n",
+			   txdma_status);
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
 	}
 	/* total xmit irp = 4 */
-- 
2.33.1

