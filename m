Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB23157E43B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiGVQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGVQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:18:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2251DFD4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:18:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g12so4865279pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3JvjBk5rZE8CylMCyXbpA9801AN+xNrDTvZ4epSXkg=;
        b=Zvxq3QTNpkDSkq1tK84gybTjc+mVOOo5e5HuakpNkJdweRp032xFQMkmFvRxEhHMUn
         3aFHS6UETE8+Zj/6VdIBJhwJWSx8ijdOWBqkju379FLK6DjWBvyjQAA2wqhpwUbiEnQL
         nRRrR98+qAC6SYJE7AVbb9biUyAK0ke4bZZboZD6HlneCWhoyQ3d/vKH75K41q3Mo/iW
         fsDxOrVzY0dT3iWrq6eRvRCD7O+aip2ekMgJ0qaPw48UBdLBExl3fRpdJPD83mdkf7c2
         UQyIxCl8NZV+VPNOOgZRV3Slbw3+16/34QSW2sNkfF+JPuOWU5+jQat3/XPx8bkFg/kV
         6Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3JvjBk5rZE8CylMCyXbpA9801AN+xNrDTvZ4epSXkg=;
        b=FaRl98P38OqjC3eKrrd1iq+Z6IqkrbxDZkJiNouj0GQqvKUo8gzGcKMl9QXPqUYG++
         RcJZbYWc0mZnA36SofFQ+8qCQkpPhp3mDhjCMn2xxJV03iVXLaPuL4kaM11h/adgqK6t
         bLcffb4QacG534wAMcP/5/N8/AdTSqPZTssSqBUAGmv6gTH7gaGAmWA7fW110Q7lQ9V8
         VcRdfKrlJG+Onhr3mEpmBOOlKDSq1imcM1Yo8QJeoeMH07/1Qm+0673kfIch8GZxX5eD
         uJomAKQyfUw6UZOdXm8HBR/VOHNTAoTRD9t4khG1wzECXZy2BYQwy8mu2Sz28K8FzV6v
         3KpQ==
X-Gm-Message-State: AJIora+hZ9DqpF7X/lH026FBbnvUhA/axmyvokbwOJQynGnu4IgFh2iu
        7zarm3lI27Ly88JSOWY3ZvG8dEmVtCDPpmXvcCY=
X-Google-Smtp-Source: AGRyM1uXxhWO/DeUEIRwooeBofbzNK9MYQD6dG142de1EM9XYp98gEDWYmIb+zcFNVD1VBtYoOI56A==
X-Received: by 2002:a62:ea01:0:b0:52b:39ec:a72f with SMTP id t1-20020a62ea01000000b0052b39eca72fmr563667pfh.52.1658506684452;
        Fri, 22 Jul 2022 09:18:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d01c:7038:50b4:cec9:4ce:e06f])
        by smtp.googlemail.com with ESMTPSA id x5-20020a170902ec8500b0016d21c1b26csm3963621plg.170.2022.07.22.09.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:18:03 -0700 (PDT)
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
Subject: [PATCH v4] staging: r8188eu: Inserted empty line after declarations
Date:   Fri, 22 Jul 2022 21:46:31 +0530
Message-Id: <20220722161744.14914-1-abhijeet.srivastava2308@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Warning found by checkpatch.pl script.
Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
---
v2: 
	- Fix my name on the patch
v3:
	- Fix commit message
v4:
	- Fix body of explanation
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

