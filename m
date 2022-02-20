Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962774BCDB0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243721AbiBTKDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:03:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbiBTKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:02:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3683B28E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:23 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p14so25540898ejf.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOF+6ocqxTqypgBTBzKCjDrqeVxrdZjcFH/y4rV+6HA=;
        b=jWVjxzOvrWx/nCcXQkfKa5ZYV0BhFa/OpARjipv5jeeUMj2V+BCu3bMb1Br8u4KoBp
         Rj5oGwE5dYbbtfqhrepm6IBbc/gsCitFbCX8W7TPStDKoZTvO7qV0foEweN8IbQ75hF8
         DR2uuUkWPnn5X2zDLSsseuNEzzLwCGC3y8qEN/RudodAZ11ySQZ+lASKqzFUBMxmJ6r+
         2uH4DTVj5JlmKbcHP77fN6OSET+W2UkJMLGZcgQIhudeyFTJkUHkk9+e7MNVr8vP+xSa
         zPiYIZIl0/hDa8feObC9Pgib0KPIJ7VQYsHfFOmv8o5uGCFIaLPUNjQ18ZUvX20lApRo
         ztvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOF+6ocqxTqypgBTBzKCjDrqeVxrdZjcFH/y4rV+6HA=;
        b=3VXjrmWyyGI5UPXmNsQkUV+YddfxpxPpt+f17eYXLQokCMp8Yhn7rB9cU2WAC1u9xI
         5lNhju4yfov30hHLOOvf3j8hTNcYrXGFkr/ycQqKIU5VOHzYAwn7u/47oMOjfaQOECze
         d6n2/S+wOt2asBujEW4tsHfxbMbPhF+maxzmfA0BGRU/2zInRsUgZvA4KVcq3T1i+u4k
         o4xPYG4WmJwc/rAk07dMdDN7IJZy/olTrkh83G4E0gt6WQ1CGvdYkYxTbH0K7cTlA3qU
         yL+C+JhE7PWH/AoAgBGxnuleJsJNtpXu8ld6egYRNhIIA6Iu0n9GT28/WckZh6wkUTNZ
         OnZw==
X-Gm-Message-State: AOAM532Vy3zwIuY7/wES2cKIL4DtGqQAyV//gTjJFP/rf1fyuc9ORZID
        d+ykLxdQJ1SRrNhLYl0itsY=
X-Google-Smtp-Source: ABdhPJzTNKLUK1Pj6FLjvvc8LuILPzRu9yu4COr58vWn7XHhfmKipJuWAeT5U6DwjS2tTHE+w7n+BA==
X-Received: by 2002:a17:907:7845:b0:6cd:f2f4:cf00 with SMTP id lb5-20020a170907784500b006cdf2f4cf00mr12102761ejc.388.1645351342191;
        Sun, 20 Feb 2022 02:02:22 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id dx7sm3265223ejb.23.2022.02.20.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 02:02:21 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: convert type of pBandWidth in odm_dm_struct
Date:   Sun, 20 Feb 2022 11:02:11 +0100
Message-Id: <20220220100212.7466-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220100212.7466-1-straube.linux@gmail.com>
References: <20220220100212.7466-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable pBandWidth in odm_dm_struct stores constants from enum
ht_channel_width. Change the type of pBandWidth from u8 pointer to
enum ht_channel_width pointer to get rid of a type cast in function
Update_ODM_ComInfo_88E().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 2 +-
 drivers/staging/r8188eu/include/odm.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 082104c9b2e8..df0b412c52eb 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -40,7 +40,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	dm_odm->pWirelessMode = &pmlmeext->cur_wireless_mode;
 	dm_odm->pSecChOffset = &hal_data->nCur40MhzPrimeSC;
-	dm_odm->pBandWidth = (u8 *)&hal_data->CurrentChannelBW;
+	dm_odm->pBandWidth = &hal_data->CurrentChannelBW;
 	dm_odm->pChannel = &hal_data->CurrentChannel;
 	dm_odm->pbScanInProcess = &pmlmepriv->bScanInProcess;
 	dm_odm->pbPowerSaving = &pwrctrlpriv->bpower_saving;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index fed12203c558..7a10f57b9bd3 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -324,7 +324,7 @@ struct odm_dm_struct {
 	/*  Secondary channel offset don't_care/below/above = 0/1/2 */
 	u8	*pSecChOffset;
 	/*  BW info 20M/40M/80M = 0/1/2 */
-	u8	*pBandWidth;
+	enum ht_channel_width *pBandWidth;
 	/*  Central channel location Ch1/Ch2/.... */
 	u8	*pChannel;	/* central channel number */
 
-- 
2.35.1

