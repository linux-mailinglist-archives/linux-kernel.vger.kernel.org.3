Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C314BD6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbiBUHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:34:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346260AbiBUHdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:33:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729FA13E93
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i11so25738445eda.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vwiIAmZ+C5zWK8Si6mo1Eo/U2yGxbtvFyTLYxn/HBQ=;
        b=mSth5mYOd+JbeN6ChnQB18eVFGPVZYyVEOOm+a9pQwwf2xeVpbEDsi/M7QCex6nfOw
         vDP0Qa9ivOu6kycYSxLbT9+NawEFFkFk1JhnCo4ftONlit/4hNIVjI/QmrBluOmXCVa9
         RvHXwuyRxC+m3mYksXqcKwTKsv+RckTRJ/q65AEEgnrzH17FRKH7BkpQvcRb4iyuZTmr
         0mChZUcuF4buchFbG0cEUXdur6JN015BzwvzwBJDU1UtW/U2z+tKt6RwiFuWQmz+xUsQ
         RX2ruytPUf0GiCjxwSqaJKWwcMOlf1DLxuEmy6SyZ1oAU9Q/hUEOY3raNILkLqnlFPkG
         JWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vwiIAmZ+C5zWK8Si6mo1Eo/U2yGxbtvFyTLYxn/HBQ=;
        b=PIDf2EE+6W5PZ1Styqg6q1PRhOAWlbnstH/s8cXEQEw8Y18WLQSAHh98q4D2Abp1z6
         EMB3ejqGJ3d0d7HfRwejREuYRSM5clKXKYxCNoVxXcjz2grK35Bgj9LEAoqjk9qhD7c6
         NBMPOHB/nYWcOHXVUD/b9yJ3hPWZSNvKjbpHo4vyB0vYLFVYbzOfHibKitwWbBDIekU8
         lPurvLxI5wEJxGYaQSln602EfhDKHtNdPUbORFt/YXkQ5uG5GxIbSgNFU+8CFxZZtgOE
         V//uczKIPru+xUUTUPcODZ19LMI4DxCd35px/81c3lGdnbV6scPoj8jHCqrwmnVJfNSC
         IsNA==
X-Gm-Message-State: AOAM532hYAFs0xJcCr7VMCs48cJjzvnsPfBIkXwH1lBLDqya8q7gFVeG
        pUfmGtdFluMGQo8If3wwDts=
X-Google-Smtp-Source: ABdhPJwWIvRI3iTGAk7rrx2uPOIatpxQhFfdhaoaWVxn0WgBWu2YL+jyz/FARb9qKVij+ttwEy+9Gg==
X-Received: by 2002:a05:6402:144b:b0:410:b990:a68a with SMTP id d11-20020a056402144b00b00410b990a68amr19939616edx.25.1645428797947;
        Sun, 20 Feb 2022 23:33:17 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id c11sm8673128edx.42.2022.02.20.23.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:33:17 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/5] staging: r8188eu: convert type of pBandWidth in odm_dm_struct
Date:   Mon, 21 Feb 2022 08:33:05 +0100
Message-Id: <20220221073306.16636-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221073306.16636-1-straube.linux@gmail.com>
References: <20220221073306.16636-1-straube.linux@gmail.com>
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
v2:
no changes

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

