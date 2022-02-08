Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308644AE04C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384419AbiBHSEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353460AbiBHSEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:04:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240EC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:04:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso2297998wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdlsppHiLZTOsM13z6W1Cp7fdsqKE9BaC7RMZ/J9wUY=;
        b=aiNV3vVZiXuLBKybeAPgsiWUsvt6pmq4xQAxUtys8cJQTrTNpeXd03r0zhH3GajZad
         LcGU8gmuoCruJvOB0A9A339LxEdh94m6W4k6iLGT3X1WpvJ9m4xmHbwCT/ewrUNiwMeM
         /TVG2P6AB3OQKgXJdxPxAVXCEtrGIUbWn1cTk6s7KGAWjQTEvL7rl9c33VrkMiW/B5T3
         NapcckAB7O2wMj2hE8tz5D6fOpU2QhRLkqsr92N4HK54h+aNZ40nIh0CBCrZTP/jcu65
         dO6B+ZuOIB009eV4MrogSOLrOokYmQWIopdmH02laCxzeRsy7ZKlyQrZsJjZhzeEi3pz
         qIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdlsppHiLZTOsM13z6W1Cp7fdsqKE9BaC7RMZ/J9wUY=;
        b=iCST0UYXYJOReCZl8iYI8ePCss8c5BkZFo5edWvsGxt6Ebt2V/NZy8HCjISVjAUBYv
         05jh4u7niJWwEQl1Hub21mb2UW+3k5onUsaJq2LeVRc+se8RMZEzPEYjLh/CaoC5yR83
         RpXhglh0YZonFvdyniYgKgusk9ZEZ5u6HfEiXOozIAAsSRaUI3Ig5oAHQrgev6TM2KwA
         BbolZDIO6NsL4uQmtzWBkmSj/KKCQpVJQMbydEcFrMVN5nqsahNJN2f9tCYpz1+iYVSO
         q8drDSVD9Fiv9w/T8+netQ4jfEj+Kyd8KbMelFMO70pM6lWrT34cWKHscGezOd/FUo2v
         LSfw==
X-Gm-Message-State: AOAM532vhIFfMt6zGdRGyMheVatq+rEiTjcf7/JoVk3Z0LahkkES0BN2
        /c2QJQZIO7Ihtqd8Lo2NnSo=
X-Google-Smtp-Source: ABdhPJwDfPSnlQNtt4HwMMQ8J71qo1hxlwHsxo4zZE5//41TRPJYCa2mS1yiwpIBiagXaSHHrQPLEw==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr2083514wmk.140.1644343477019;
        Tue, 08 Feb 2022 10:04:37 -0800 (PST)
Received: from localhost.localdomain (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id n26sm3176872wms.13.2022.02.08.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:04:36 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 1/2] staging: r8188eu: Use sizeof dereferenced pointer in kzalloc()
Date:   Tue,  8 Feb 2022 19:04:25 +0100
Message-Id: <20220208180426.27455-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208180426.27455-1-fmdefrancesco@gmail.com>
References: <20220208180426.27455-1-fmdefrancesco@gmail.com>
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

checkpatch.pl emits the following warning:

CHECK: Prefer kzalloc(sizeof(*pcmd)...) over kzalloc(sizeof(struct cmd_obj)...)
+       pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);

CHECK: Prefer kzalloc(sizeof(*psetkeyparm)...) over kzalloc(sizeof(struct setkey_parm)...)
+       psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_KERNEL).

According to the above "CHECK[S]", use the preferred style in the two kzalloc()
of rtw_set_key().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 038bddc361c3..f5b2df72e0f4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1600,12 +1600,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	struct mlme_priv		*pmlmepriv = &adapter->mlmepriv;
 	int	res = _SUCCESS;
 
-	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	pcmd = kzalloc(sizeof(*pcmd), GFP_KERNEL);
 	if (!pcmd) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
-	psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_KERNEL);
+	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_KERNEL);
 	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
-- 
2.34.1

