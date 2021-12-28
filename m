Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860A9480842
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhL1KL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhL1KLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:11:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k18so649203wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7uqoTKpq+D1932lWi4R+j2Cpn0lqrO7AJ2oZ+FkUIc=;
        b=GVkRRsSBZH2Sx4dnkSf9dBo6SlxUShXBGtS8qUAdFiXZZ+xmSe7WnC2sX5jtrULMbw
         +bLvgEw42GmGznPX7mv3VID/g327UuY4Ob8RD9z6Ha6eP0ynmryPR3ijmhCp+bOymr5L
         3w/O8n1L8Bp7IRvpn6iyzVdude+y64Q5FRzgiGCDRYN71l5NzXvagqlynxsRBc5QJXtO
         Isat7StxIgJEeIEqnF0mv+eswcfar7gx/jp7oxxrVijZ00JQKVSSBejzIqosuPlUuKnO
         iDMQ1/CZNKaP7JxPhAzl/3FbsX/LuTyyW4MXl8oyauEflw2ESiifR/AhMGtejk6JLO7m
         hJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7uqoTKpq+D1932lWi4R+j2Cpn0lqrO7AJ2oZ+FkUIc=;
        b=q9f1GJ3QMW/mSrf3r8mLaPut4hRelFwXMyd+NKZtdtAejIBAlKUGC+oYCvufohyDGZ
         wkB7bkm+8zfs4cgMjMStvDLQlhMP0p9G0KoaMas1E2M2ZGikd1ujEP2PVxbspvU91mC0
         5fvY9APBnBKIveiGg5eOykkb1X6q7PPyA8UaILmn800qJCfuGdJhr9++GCSUradNTJHQ
         N9y8imX7sve+GUoK43kZZbs7hAyeoL5SfJfcPk72VzdWwDAFOa3zj3IqhUfNiUWPP1S/
         i52/3NRvXH76ERMyUiKZj9i07CfiPfwY2JTi04aduMLVrAdyxFjULO1HzHk7C2g8CytF
         cs1Q==
X-Gm-Message-State: AOAM532mfU8t8L3IYn4efWobPtxSAj5TRc6vp3am25GlvS7lGC/eZAls
        3O0mpnVMAX0vkIfAgLYbr0I=
X-Google-Smtp-Source: ABdhPJxVq0Q+bBVGVIxyuuOEesl233rv+pQay35hHKJCZos2FL9Sr2unQc1PxiLvwdVzSO4bkmZk9g==
X-Received: by 2002:a05:6000:18c6:: with SMTP id w6mr7844132wrq.449.1640686307485;
        Tue, 28 Dec 2021 02:11:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id d62sm21160984wmd.3.2021.12.28.02.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:11:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/10] staging: r8188eu: FAT_State is always FAT_NORMAL_STATE
Date:   Tue, 28 Dec 2021 11:11:16 +0100
Message-Id: <20211228101120.9120-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211228101120.9120-1-straube.linux@gmail.com>
References: <20211228101120.9120-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver pDM_FatTable->FAT_State is always FAT_NORMAL_STATE.
So the check 'if (pDM_FatTable->FAT_State == FAT_TRAINING_STATE)'
is always false. Remove dead code that is executed only if that
check is true.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 1fb2d9a16fea..9de16383cb2d 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -251,15 +251,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
 
 	/* Smart Antenna Debug Message------------------  */
-	if (dm_odm->AntDivType == CG_TRX_SMART_ANTDIV) {
-		if (pDM_FatTable->FAT_State == FAT_TRAINING_STATE) {
-			if (pPktinfo->bPacketToSelf) {
-				antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
-						(pDM_FatTable->antsel_rx_keep_1 << 1) |
-						pDM_FatTable->antsel_rx_keep_0;
-			}
-		}
-	} else if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
+	if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
 		if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
 			antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
 					(pDM_FatTable->antsel_rx_keep_1 << 1) | pDM_FatTable->antsel_rx_keep_0;
-- 
2.34.1

