Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304AC480845
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhL1KMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhL1KLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:11:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i22so37320033wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yX6WsvFj3mzN8+krDEd2nQc532OtlqFbEGHYa+8owtg=;
        b=CHqtD85QiJVOrksiY6idhWxmYujhHyOhKTQI7XM9wP4NbStnJumSS2PoIywdrz2tWB
         0TuCLwFgOPv3VrjrwEvgEQ8JNungyWnloDxjZYXoENP6jgfRKZPNaPivRm/3xNJx1cj8
         iV0U8R2xJE+2Fvb44pUeapqDxTLd+EVVX8DMT8QBSutSX+uSYhISEJkT0ry5AQu6UKXT
         QCO9uIuk+I424oHn3wQ3Fjv+wkd5UA9nhJDLXU9u48I3WNkkynQQ3/HHNMlpgdkfbtBh
         l7SMuwWRtytA6//x5XOXmnON450PNLk7FmXlkdFhvTaJFSBR8z8SgTA6E1QmfSHLkDdF
         LyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yX6WsvFj3mzN8+krDEd2nQc532OtlqFbEGHYa+8owtg=;
        b=FPE6hp0/GMIFRjR/blIR645h+oV9FIJiu0tk6fl/F7/M1Yy5MjcHJATPOkHSPlHGY4
         Sw8dOE+p93P25MInUq6oAmlpeBmWG1HwxLt4/kMP3rFi8hPsolGdMAWopWrb8zazLGXn
         4Cv6QViQ3QX5g1/Pk4wA7qcaWI1fR/GHgdnYnlidWkLXDoNj2CaV9NyqBBRDzRnGlC9j
         Naoqx5rcMo1Wr0lSEKjo02Uv8DtEr444ukeb6k/Bdz6jNI5KUGNkfztmk8bFiWCEDRnW
         caK6C0/H9XfHfn0YNwRwQDWaAIqj6940O1+qf4wKqKr8wUkgZknpz7c7xvzE8njGANHQ
         UE8A==
X-Gm-Message-State: AOAM531y4R1Dl4kM67rpdZToXb1DpZPat+YoRbJhlzl8P/4rX+9TNNnp
        NDas/6mEaB/qUE9FYYMGOpk=
X-Google-Smtp-Source: ABdhPJzegxx5hMNs0p3/9iYzdbhROmlLk6Bx1Oc3qbdik5CJOyuzgGdLldW4RGhoSQXoAcHfbacrSA==
X-Received: by 2002:adf:ea8c:: with SMTP id s12mr15894183wrm.342.1640686308890;
        Tue, 28 Dec 2021 02:11:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id d62sm21160984wmd.3.2021.12.28.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:11:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/10] staging: r8188eu: TrainIdx is set but never used
Date:   Tue, 28 Dec 2021 11:11:18 +0100
Message-Id: <20211228101120.9120-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211228101120.9120-1-straube.linux@gmail.com>
References: <20211228101120.9120-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field TrainIdx of struct fast_ant_train is set but never used.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c | 3 ---
 drivers/staging/r8188eu/include/odm.h      | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 1dcdf6a131fc..eefa448d2002 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -57,9 +57,6 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 {
 	u32	value32;
-	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
-
-	dm_fat_tbl->TrainIdx = 0;
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, 0x4c, bMaskDWord);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index db72eea83382..a037d7b863fb 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -387,7 +387,6 @@ struct fast_ant_train {
 	u8	antsel_rx_keep_0;
 	u8	antsel_rx_keep_1;
 	u8	antsel_rx_keep_2;
-	u32	TrainIdx;
 	u8	antsel_a[ODM_ASSOCIATE_ENTRY_NUM];
 	u8	antsel_b[ODM_ASSOCIATE_ENTRY_NUM];
 	u8	antsel_c[ODM_ASSOCIATE_ENTRY_NUM];
-- 
2.34.1

