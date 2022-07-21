Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8757C306
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiGUDwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiGUDw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:52:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E123B946
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:52:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gn24so431820pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQW5nE25CHVm8VEawfIVGFUrSWUWqh3HmVxegFkvxow=;
        b=AYuJZr9wq2go3piCOFO2k1Pw5/5FV6UFo2QcmlLsio85wLlePB6xgeL5y1mi/ZYfVG
         o8Tu5bvNHfkF66i9EJqK+czFjzBiNdmurhKhAN8YDZbXGPbSCU0ZOVkaUZ4XLCfrKxyL
         3JfBFgFmHa8Jh8f9MP9E6YftNsRHNXrC4loOfvrdwOunuuj8fOnn31yKS16Zz89BXlde
         R4GhLlZdpbJZ686WGgG1P+HaCZ2BZK4WFDFzkZi2lWQrMj1saM79mvJt/ThvjuCrxINm
         ruFsh697yY4X41oZhMX0A77dByb6gVn0m2E9tUfpF5dLTk97a4hAqO7fz8M5KYUm0hjd
         TiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQW5nE25CHVm8VEawfIVGFUrSWUWqh3HmVxegFkvxow=;
        b=nweAjluMFiVj0soh9tYrJAt4Ios2r3dncDUPFyqvbY3w9zTzypVCsNvi12/boR7fhn
         /mbh1vMcw4Z5Jcg2shFRTd0V3oaUIKr2WYzBE+nmXeUjLZ0b55LMF9hJ7gHNG2mxgGZ6
         WWE3KnO6/rCbvlpVxVrXcAzR3jZGlY3/sYhKM0G2T1058++ZHK6cXDzRbHKJc+dJfioT
         VliI2MkrcPle7g+PFFTFBngE+kMRqH6FPqjsZGKHH5j/aYODJWZUQ8fgD0Exu7Y8/68X
         YVYAuY2xiMy3S2YWT3QsyZI3qcZOVfub5hfxRsPK6lsc6jNtP2qIMPMo4E127m3TadGS
         xDQA==
X-Gm-Message-State: AJIora8R1i3UiYu3ijz9dXDrozpMt5pctcVBOLVU3w2HIN+I510f5xaV
        M1QxDi4zv/d1eqGxoMJlfE8vQSzrTiTa86ECd20=
X-Google-Smtp-Source: AGRyM1spm/i8vUrmDSn5ax+V2bsi7iLLPEOhGw+xPyn3X77iZ/dLJLvRahYmFO9gCXoJ3sq/kj+4CA==
X-Received: by 2002:a17:90b:3909:b0:1f0:386e:c0a1 with SMTP id ob9-20020a17090b390900b001f0386ec0a1mr8937588pjb.64.1658375546989;
        Wed, 20 Jul 2022 20:52:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d01c:7038:d847:8f04:2f5c:26b2])
        by smtp.googlemail.com with ESMTPSA id b13-20020a170902d40d00b0016d231e366fsm373879ple.59.2022.07.20.20.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 20:52:26 -0700 (PDT)
From:   Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     abhijeet.srivastava2308@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Inserted empty line after declarations
Date:   Thu, 21 Jul 2022 09:20:39 +0530
Message-Id: <20220721035146.11719-1-abhijeet.srivastava2308@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a2747f00-99b8-10a2-edf5-7dd6fd7a1f8b@gmail.com>
References: <a2747f00-99b8-10a2-edf5-7dd6fd7a1f8b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script. Resending this patch after
correcting my Username

Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 5b6a891b5d67..6fbf6e4234cf 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -25,6 +25,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 
 	while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
 		void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
+
 		if (c2h && c2h != (void *)pevtpriv)
 			kfree(c2h);
 	}
@@ -323,6 +324,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	/* prepare ssid list */
 	if (ssid) {
 		int i;
+
 		for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
 			if (ssid[i].SsidLength) {
 				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
@@ -334,6 +336,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	/* prepare channel list */
 	if (ch) {
 		int i;
+
 		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
 			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
 				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
-- 
2.34.1

