Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60D4EDF75
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiCaRSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiCaRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:17:53 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A70B7F7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:16:06 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so26071635fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=E2B7e9Nsff6vEEB8CGolskzuKU2fo78rxOBgNPm56To=;
        b=U7LBSYL6HIVSspJoiOLvlKynDF6Zmebcv/GLYzAKmuuK7Q5N8CU0P8TyxZ+SWVEuW2
         pnEROGtN5q8cgfHyuMKslmF9sPneaQZjgxIOldjcz9UNExH54pElzdkjpe9WLGeFQhdL
         1wBO54AATcbEL4mGxrqEWRBB8oAO5UAll16Cg+7sGbx9O0nememGlKn/+BhVkKDG666Q
         xN8fPXW6yNcFczeRmargFZ2jcvCqAcJPR3YWTqnb++7jHWW5Dm6bJYmA1hSFaTClA2rw
         lX7ntc1ZxqLyEeuHbDBTG2frqI4xxFUDHe9Tmt5S4TYyEfufxg6eedqNAECrhjir3KwJ
         V5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=E2B7e9Nsff6vEEB8CGolskzuKU2fo78rxOBgNPm56To=;
        b=LJMyBvmnGytOfl1enuieBGVoVoFpzlwBHOTk9lbUFQm9SqNvKh6//LD6n/0k8LrksO
         rNXAO/fIx3LG8A8Vd+EH8eD1qkaDGHt3T0+AqFSRwDo4MxvQ1sSZRO7MZzQ/zrOfxHUt
         CPoTkEiB6Sp9setAMly8+uDesZrEVghgpl2uFWhxOtjxLzdgD+BctNnNPvC8/f2qONXw
         OZhCjeFIOYpeYvNk0TNf0zGwT4nsKDMxkj30lcpPoFnYCCgnxHRyVJd3VN/Ztmvpu//A
         enE1jHQzeFu+ePggzv2XI1G9p25HHDkEBbptO/t8TUJZKuQekHQy/+mEqF7yUR1BPzj0
         oSAQ==
X-Gm-Message-State: AOAM532EBeuicrlhhGMgA9nhij586q9fXSvIHnCq4i6T/v8cDVHmZOM/
        MwxQeOM5Uq4NP/Dz9M5WHJbJZJrArO4TYQ==
X-Google-Smtp-Source: ABdhPJyqptgy+yT9/xcHTi9XsIDEf3bVMd77udOoeBcKUb6NXEqH4iR8dKH+1tMVS6C1g0AfsopU7w==
X-Received: by 2002:a05:6870:45a4:b0:dd:b08e:fa49 with SMTP id y36-20020a05687045a400b000ddb08efa49mr3208332oao.270.1648746965353;
        Thu, 31 Mar 2022 10:16:05 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id hi21-20020a056870c99500b000defdfbee5bsm6551698oab.28.2022.03.31.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:16:05 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:16:04 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v2] staging: r8188eu: use sizeof(*pvar) for allocating structs
Message-ID: <YkXh1HBqaHwT38UC@bertie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sizeof(*pvar) instead of sizeof(struct var) when allocating memory.
This conforms to Linux kernel coding style, improves readability,
and decreases the opportunity for bugs if the pointer variable type is
changed. Issue found by checkpatch messages of the following format:

CHECK: Prefer kzalloc(sizeof(*pvar)...) over kzalloc(sizeof(struct var)...)

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
Changes in v2:
- Update to latest staging-testing tree.

 drivers/staging/r8188eu/core/rtw_mlme.c     |  4 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index ee48dfd09fb3..f94b1536a177 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1506,13 +1506,13 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 	struct	cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	int		res = _SUCCESS;
 
-	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	pcmd = kzalloc(sizeof(*pcmd), GFP_KERNEL);
 	if (!pcmd) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
 
-	psetauthparm = kzalloc(sizeof(struct setauth_parm), GFP_KERNEL);
+	psetauthparm = kzalloc(sizeof(*psetauthparm), GFP_KERNEL);
 	if (!psetauthparm) {
 		kfree(pcmd);
 		res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 643f9f8a7a3d..94d494cfd457 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6424,7 +6424,7 @@ void report_survey_event(struct adapter *padapter, struct recv_frame *precv_fram
 	pmlmeext = &padapter->mlmeextpriv;
 	pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
+	pcmd_obj = kzalloc(sizeof(*pcmd_obj), GFP_ATOMIC);
 	if (!pcmd_obj)
 		return;
 
@@ -6474,7 +6474,7 @@ void report_surveydone_event(struct adapter *padapter)
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	pcmd_obj = kzalloc(sizeof(*pcmd_obj), GFP_KERNEL);
 	if (!pcmd_obj)
 		return;
 
@@ -6516,7 +6516,7 @@ void report_join_res(struct adapter *padapter, int res)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
+	pcmd_obj = kzalloc(sizeof(*pcmd_obj), GFP_ATOMIC);
 	if (!pcmd_obj)
 		return;
 
@@ -6613,7 +6613,7 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	pcmd_obj = kzalloc(sizeof(*pcmd_obj), GFP_KERNEL);
 	if (!pcmd_obj)
 		return;
 
@@ -7013,11 +7013,11 @@ void survey_timer_hdl(struct adapter *padapter)
 			pmlmeext->scan_abort = false;/* reset */
 		}
 
-		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
+		ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
 		if (!ph2c)
 			goto exit_survey_timer_hdl;
 
-		psurveyPara = kzalloc(sizeof(struct sitesurvey_parm), GFP_ATOMIC);
+		psurveyPara = kzalloc(sizeof(*psurveyPara), GFP_ATOMIC);
 		if (!psurveyPara) {
 			kfree(ph2c);
 			goto exit_survey_timer_hdl;
@@ -7555,13 +7555,13 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 	int len_diff = 0;
 
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
+	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
 	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
-	ptxBeacon_parm = kzalloc(sizeof(struct Tx_Beacon_param), GFP_ATOMIC);
+	ptxBeacon_parm = kzalloc(sizeof(*ptxBeacon_parm), GFP_ATOMIC);
 	if (!ptxBeacon_parm) {
 		kfree(ph2c);
 		res = _FAIL;
-- 
2.32.0

