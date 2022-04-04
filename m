Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396DE4F10D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354459AbiDDIYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbiDDIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:23:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4ED3B54E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:21:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so18202772ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MrgMLReyj9DEtjJrW6Fmcw5+9Z047O6Pl7Cse8bO7II=;
        b=oj+4MUjPCglwkn2+ftlkh1nxFR3M6fQV8y+6gZWVeQDtMldx0xHujOc0OLXqBMGHGi
         DqFcePhJnD+O/LFjRUtsPXxqvjrsAlFrTA/yE/HPcDXkPsjoAf470RRz/aDcQN9Orzzl
         cIrZxPU1TDkt9kUVzabsZFQHrcXDKdvnVZXd0U0A/a4mxFfpoYh5hfUoUqiWL2Axrgvp
         XzlXRruC62m3AYYL3Mzl0hRoM4qr22X1h4YD6+gzEkXzmBuyKWGC4tpyaBthSbNHGJPi
         vp6YY2bMs1wE2b8E8X1FIJetlBfYgRv39VX4bG1oQ/M8HJGGx6bOdIdkB637oq1o626q
         /uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrgMLReyj9DEtjJrW6Fmcw5+9Z047O6Pl7Cse8bO7II=;
        b=6tDOONOBVGWDHwgEbpXHQU+n3qURexY24TNbW1oyP17FyS5sDy/7MlrWxaAtA08oQL
         cxeLjju9/4I47grAbiM+93iWRoLmy5zqV2QdhYtKILRS0xXWl8o9W6OlJxxWSD1JiAjj
         Ym04/WZ9JBwV+wCCjNsmcbNfa3DmpLI9gneFtbRzT/mwGbpaYB/7/4MojZKYK3UUTmje
         em0F2PQ7TbTnt5byQVF0wtLSqyUQvipxiS/9Cpn0caZdQwqWaokfDqqGmJ143QaFdo61
         +jd3nu4kUed8+scnwfXgffKpHyWxmCXupZht75yMDI5fqnmbeCiBfrDWS32qk17zl5+w
         +1PQ==
X-Gm-Message-State: AOAM531T0e7lor92toE8evS58soHcOmqTL6eymlyUgfC9GfwdMvWuIIK
        h4pgUB6XEd0xuaNYB4LGTEg=
X-Google-Smtp-Source: ABdhPJxb9Lsvb7g5s2goW3nmb1HVqira1y4gyyfKEOObm8coZrEzPqM6DBtofIUuu9Wzgc1pQfs2pQ==
X-Received: by 2002:a17:907:8a0c:b0:6df:8b04:1a65 with SMTP id sc12-20020a1709078a0c00b006df8b041a65mr9559967ejc.331.1649060510235;
        Mon, 04 Apr 2022 01:21:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm4047336ejh.204.2022.04.04.01.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:21:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: ps_flag is never set
Date:   Mon,  4 Apr 2022 10:21:42 +0200
Message-Id: <20220404082142.4639-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404082142.4639-1-straube.linux@gmail.com>
References: <20220404082142.4639-1-straube.linux@gmail.com>
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

The field ps_flag in struct pwrctrl_priv is never set. It stays at its
default value 0. Remove it and remove related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 2 --
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 162792988910..1d7dba853c40 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -70,8 +70,6 @@ struct pwrctrl_priv {
 	struct timer_list pwr_state_check_timer;
 	int		pwr_state_check_interval;
 
-	int		ps_flag;
-
 	enum rt_rf_power_state	rf_pwrstate;/* cur power state */
 	enum rt_rf_power_state	change_rfpwrstate;
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 5a9374957e3a..390d1cc0ecb0 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -625,12 +625,6 @@ int _netdev_open(struct net_device *pnetdev)
 {
 	uint status;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
-	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
-
-	if (pwrctrlpriv->ps_flag) {
-		padapter->net_closed = false;
-		goto netdev_open_normal_process;
-	}
 
 	if (!padapter->bup) {
 		padapter->bDriverStopped = false;
@@ -674,7 +668,6 @@ int _netdev_open(struct net_device *pnetdev)
 
 	netdev_br_init(pnetdev);
 
-netdev_open_normal_process:
 	return 0;
 
 netdev_open_error:
-- 
2.35.1

