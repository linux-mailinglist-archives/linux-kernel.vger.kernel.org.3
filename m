Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542F6599C83
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349282AbiHSM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349170AbiHSMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C455A88A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r4so5544576edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MXV4DylOF0ZdaiLo2QJuGxzw6UXL1e8It7jaBClcFvg=;
        b=osiPXDjtr2ryf+P6+tDShDm6e+MFPpDx47vXUDtsOoJPTedOqf/j96FBlkhOYqtROd
         XwPx+LuduCt8UHcnYqZ+hGJDHj3TcNA2Mn317Ng/3QlG2RVrlyUgEN5gtzW/gCFD7nm4
         PTCxowDthgLU/Pa4KL+/G+1jyTwzC2ghWvEsuX17Dn2/AjOCqP5bH8+mP2UTPZiOERHc
         ZI6Bfiwz0rZhtD8TOGmgJRjIv9/IQPFc51Pv+TgQ0qq4PVdgJdYKOSWNhnxWglpVH+i5
         cfuLuiMo5bimaS6P5i5K24pk4PKOEi9HDw6IGvBLvYzv3St9Mn0pRjpYdnNPfbQE7bVf
         NtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MXV4DylOF0ZdaiLo2QJuGxzw6UXL1e8It7jaBClcFvg=;
        b=vSygUP7QsXxXuMkfoytqsLNqoI25+YrF940GLCM8WMrhqxUqBps2o6h4e19UFgrKH6
         KXfAV/3zqMEaSI4ep1wtJEJXQTHhjlcMUxG0CiDO/7Nw2uedLZVWBRzYHcX8OPZltXJH
         Fd8Yw0YdZTBWPne/Uw+RkNUWQ4Ei+jQuKhD3vKIAJfO9TDykALth2/eFwcs3rHHwCRWx
         4y7bs4As+q31jsCg12w767lx1Y43rRd0togkTTIwCHDJSRhYCyCdiQy1Ubs0BKcP+Boc
         5w1id3mD24ljeQJvEh/iotL435NVNLehdbeyhgVWDbyohpUSGMCv/KWZrUHpTHN7IwMU
         ptIQ==
X-Gm-Message-State: ACgBeo2TkZk+XA2v7ZxkYi32hhoJkL1gv9QOgOcShdcz6XxTZR8mJwzB
        pQgVmgWWSy4Ma2RkLhXsPIk=
X-Google-Smtp-Source: AA6agR7Q+W+RLgMxyIBfSNlTMD3yN5X4f110uXeDFuTtojrjd5h0HtViZ742+1fDJKRBkAGgKtZLbw==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr5958364edh.355.1660913684914;
        Fri, 19 Aug 2022 05:54:44 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/11] staging: r8188eu: merge rtw_{os,}_indicate_scan_done()
Date:   Fri, 19 Aug 2022 14:54:27 +0200
Message-Id: <20220819125428.8412-11-straube.linux@gmail.com>
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

Merge rtw_os_indicate_scan_done() into rtw_indicate_scan_done().
It looks like the driver was originaly written to support different
operating systems. We do not need this wrapping into an extra _os_
function obviously.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      | 2 +-
 drivers/staging/r8188eu/include/mlme_osdep.h | 1 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c  | 5 -----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index bd86fb679d63..594bfaf27291 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -894,7 +894,7 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 
 inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 {
-	rtw_os_indicate_scan_done(padapter, aborted);
+	indicate_wx_scan_complete_event(padapter);
 }
 
 static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, struct wlan_network *pnetwork)
diff --git a/drivers/staging/r8188eu/include/mlme_osdep.h b/drivers/staging/r8188eu/include/mlme_osdep.h
index 5f63e2051419..d5e367e2d0de 100644
--- a/drivers/staging/r8188eu/include/mlme_osdep.h
+++ b/drivers/staging/r8188eu/include/mlme_osdep.h
@@ -8,7 +8,6 @@
 #include "drv_types.h"
 
 void rtw_init_mlme_timer(struct adapter *padapter);
-void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted);
 
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index 105251f250dc..5bd2b2c31342 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -37,8 +37,3 @@ void rtw_init_mlme_timer(struct adapter *padapter)
 	timer_setup(&pmlmepriv->scan_to_timer, _rtw_scan_timeout_handler, 0);
 	timer_setup(&pmlmepriv->dynamic_chk_timer, _dynamic_check_timer_handlder, 0);
 }
-
-void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted)
-{
-	indicate_wx_scan_complete_event(padapter);
-}
-- 
2.37.1

