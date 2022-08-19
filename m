Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADE599C56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349067AbiHSM4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349140AbiHSMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9927B883C2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z20so5524169edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zaChLvpV1bYStSPvXlAV7o8JyBUldM/i5tXZW+WmTms=;
        b=TBuicHKOVm9hxTifLARJZFxZzXDCeuQBvDoE1++0EH5GujtpKT1kgZZsgpesvggLok
         7JG61cCw7kNuPb0k9/rP+6n5hyMXuJB2wG3SwrrgB2i6MMpKRg7GRPbbFj1QNWZJmNt+
         fxfdv49V+pcMpNjAhUihezyuNYRWTImjuFM4BNhWqJXHhuGqxeXcHQc0fikX6Tk72PR5
         CvLyhmjR2CqrVEi8t8ANJPTki+XxeXXzbTQ7Bui9BevwElOi4qTy3dvLjufnB9j/wfA/
         EtsUul/N5KmfSmLmD8UGbIkRE6FgUQ4yfPAXrBm+lCzyh02mKmpWCfLePmqZLxah2fOS
         Djug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zaChLvpV1bYStSPvXlAV7o8JyBUldM/i5tXZW+WmTms=;
        b=6+XuVeDsIt0oa8Aabp1Tr+cWQ32ZU0lX5C3ex7tpezhW7rWehVURNiHm3uhuL6FVm7
         IrNiCOsvsaKoO5JVlhsS+zzvJveNrDbWCBkGJIn4VH3yTidgNi2S2SGQWth3hG055JQh
         MmDV3Mw/seYl45Rb8C8DV8eK8hG4xYY/UpE87yaIRF0KLdnD3tM0WL1UNbvAZnqwtU9H
         PmX0IOIPGqMUstlBXz3/P7r1iGTFVVgSbx4tZ/YMaUimJXfZW3sRdRa6sZXWCAeXRJmC
         aBSQ85Ji+2vpxpmOB0VWCl/BCusIuzfj/sg0zfeQDnVOwVUY4r7VRt3/U3pV2SHb5GQy
         SpdA==
X-Gm-Message-State: ACgBeo1Pii7JleMc83zYDqwGeYlkTraxMec6PPH1rKR+AISVvqRtypag
        P/ge6M4kXP7HbPcWoMlKF1E=
X-Google-Smtp-Source: AA6agR7OprjbhDKxGLyattb47jG+WINF2cy81gni7eGMLHh4O0iL2ao/Rl3jOP8NNApcyyhdkhhcGg==
X-Received: by 2002:a05:6402:3892:b0:43b:d872:a66 with SMTP id fd18-20020a056402389200b0043bd8720a66mr6075765edb.139.1660913684340;
        Fri, 19 Aug 2022 05:54:44 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/11] staging: r8188eu: merge rtw_{os,}_indicate_connect()
Date:   Fri, 19 Aug 2022 14:54:26 +0200
Message-Id: <20220819125428.8412-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819125428.8412-1-straube.linux@gmail.com>
References: <20220819125428.8412-1-straube.linux@gmail.com>
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

Merge rtw_os_indicate_connect() into rtw_indicate_connect().
It looks like the driver was originaly written to support different
operating systems. We do not need this wrapping into an extra _os_
function obviously.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      |  5 ++++-
 drivers/staging/r8188eu/include/mlme_osdep.h |  1 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c  | 10 ----------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 3050c85dec2c..bd86fb679d63 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -851,7 +851,10 @@ void rtw_indicate_connect(struct adapter *padapter)
 
 		rtw_led_control(padapter, LED_CTL_LINK);
 
-		rtw_os_indicate_connect(padapter);
+		rtw_indicate_wx_assoc_event(padapter);
+		netif_carrier_on(padapter->pnetdev);
+		if (padapter->pid[2] != 0)
+			rtw_signal_process(padapter->pid[2], SIGALRM);
 	}
 
 	pmlmepriv->to_roaming = 0;
diff --git a/drivers/staging/r8188eu/include/mlme_osdep.h b/drivers/staging/r8188eu/include/mlme_osdep.h
index 9cee84acff6b..5f63e2051419 100644
--- a/drivers/staging/r8188eu/include/mlme_osdep.h
+++ b/drivers/staging/r8188eu/include/mlme_osdep.h
@@ -8,7 +8,6 @@
 #include "drv_types.h"
 
 void rtw_init_mlme_timer(struct adapter *padapter);
-void rtw_os_indicate_connect(struct adapter *adapter);
 void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted);
 
 void indicate_wx_scan_complete_event(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index d439ffaf9797..105251f250dc 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -38,16 +38,6 @@ void rtw_init_mlme_timer(struct adapter *padapter)
 	timer_setup(&pmlmepriv->dynamic_chk_timer, _dynamic_check_timer_handlder, 0);
 }
 
-void rtw_os_indicate_connect(struct adapter *adapter)
-{
-
-	rtw_indicate_wx_assoc_event(adapter);
-	netif_carrier_on(adapter->pnetdev);
-	if (adapter->pid[2] != 0)
-		rtw_signal_process(adapter->pid[2], SIGALRM);
-
-}
-
 void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted)
 {
 	indicate_wx_scan_complete_event(padapter);
-- 
2.37.1

