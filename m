Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62906528B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiEPREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbiEPREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:04:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB357245A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:04:31 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so14680001pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvUgUjmvE7sy7yIPoGJaEuswuZK60S9OzDycOOYXOCw=;
        b=oOWKBT+xAcSWpcFAPqotHHwdYzvsiqsyJXFbrfLVoW92ooyiIKY6CSnCWv3uBhttdr
         SwnItytBoeiQm+82vWK9W0QK0AEnFfprXN1/9HEApBvEmVG1bzF52Y8C8EXC6OHGb6hE
         PFidhATRBAm6nbcd/pnL3ySDaS+cavO6C4zQI6BhIyj+14km+BLrC/fP6ONwGOquCZwm
         X8TjZu2PoPMJ3Pwc/aSsBOsxOUmP3Lfc0AyagBTblrX2TCi2X/IKL1b+YfALIAWLbPuJ
         9MoSoWb/Fz4uk2Z7We8rpDbKX9bk9ofweVna79LSvSSpKe6tXM/mzKsHk3iDM4Xaij47
         qPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvUgUjmvE7sy7yIPoGJaEuswuZK60S9OzDycOOYXOCw=;
        b=YDrClg+bhx3K9JDp8pCY/5+azpsUPlE64a52ap37MDED1+C2vhxwOsoZ02MaTof1pT
         0cHDFz5LfP2AwwJb8wiQeM5bp+3re7JOb0xustR75oxmPSocRlXGa6RUNrixgnLKFMOB
         yl1SbRzjj3F/TSFFG7od5z7q8q7LhS06jxfZ5A+zSwosvbq4Kw+8CCwAkZCGGHfd9/vt
         ZOKJ3hVW0Td9i+86tkXQDujxoh5CgGDbV3Brt22ADhrq6wePuV7PBIZgy+17QFdiaXPl
         m9/eb/A6fWwYSfgfQ3LaiPM4uKf9sjZOalLvMpbpHgG5tOm5IcLZOM3K8P0iHEgdO1w4
         N72Q==
X-Gm-Message-State: AOAM5303pwHJdFL+LIIqT5omoAmAsqgDpO+t8oJy5kbC4cEwTD/KSFoF
        DQ5JVpGzkOBqjlKBYLJPQYs=
X-Google-Smtp-Source: ABdhPJyNvbMC5UC+Z+pRk3lXpCiWByKdTknRa+8lqvEnCluwugZ2vJC1xGcEAB9Tr6LA4rNH1zgNgw==
X-Received: by 2002:a05:6a00:a0e:b0:4fd:fa6e:95fc with SMTP id p14-20020a056a000a0e00b004fdfa6e95fcmr18377072pfh.17.1652720671411;
        Mon, 16 May 2022 10:04:31 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:6465:4732:de67:bb26])
        by smtp.gmail.com with ESMTPSA id b190-20020a621bc7000000b0050dc762819csm7141292pfb.118.2022.05.16.10.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:04:31 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: fix checkpatch.pl warnings in rtw_p2p
Date:   Mon, 16 May 2022 22:33:04 +0530
Message-Id: <20220516170306.6008-2-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220516170306.6008-1-makvihas@gmail.com>
References: <20220516170306.6008-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code to fix following warning:
    WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 59bb1bd12..c3884c49b 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -872,7 +872,7 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 				}
 
 				psta->dev_name_len = 0;
-				if (WPS_ATTR_DEVICE_NAME == be16_to_cpu(*(__be16 *)pattr_content)) {
+				if (be16_to_cpu(*(__be16 *)pattr_content) == WPS_ATTR_DEVICE_NAME) {
 					dev_name_len = be16_to_cpu(*(__be16 *)(pattr_content + 2));
 
 					psta->dev_name_len = (sizeof(psta->dev_name) < dev_name_len) ? sizeof(psta->dev_name) : dev_name_len;
@@ -1213,7 +1213,7 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 				if (attr_content == P2P_STATUS_SUCCESS) {
 					/*	Do nothing. */
 				} else {
-					if (P2P_STATUS_FAIL_INFO_UNAVAILABLE == attr_content) {
+					if (attr_content == P2P_STATUS_FAIL_INFO_UNAVAILABLE) {
 						rtw_p2p_set_state(pwdinfo, P2P_STATE_RX_INFOR_NOREADY);
 					} else {
 						rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
@@ -1891,7 +1891,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 
 	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
 		/* leave IPS/Autosuspend */
-		if (_FAIL == rtw_pwr_wakeup(padapter)) {
+		if (rtw_pwr_wakeup(padapter) == _FAIL) {
 			ret = _FAIL;
 			goto exit;
 		}
@@ -1905,7 +1905,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 		init_wifidirect_info(padapter, role);
 
 	} else if (role == P2P_ROLE_DISABLE) {
-		if (_FAIL == rtw_pwr_wakeup(padapter)) {
+		if (rtw_pwr_wakeup(padapter) == _FAIL) {
 			ret = _FAIL;
 			goto exit;
 		}
-- 
2.30.2

