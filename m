Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D895AABE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiIBJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiIBJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C3CEB34
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s11so1909610edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XufPAMebi+TQKK75DKApzVpkJqGpncDvct45lHXgg7c=;
        b=VSAW1KYwHOYPot9JTY8QLTMtsYCkAkx+nRTw7kEwhLX56cvbty0VZVK4dqqevFGhXk
         jlrEts/mFkoVzDH/Lr44Z13J4pj1LfGeLG/WAiG4w2cFSbhBe0l3XwEbm3+ORZkhHLEJ
         IF819CSDWTV3isxNAj2NbPUKyKFq4hsns7pvaHxtbikzEArsczys8uLIjvN7bIDY8Dn4
         Z3LThqa/GRajG+E8OOGyVLuOPTvBM2rilQUnVcFFCUpXGr/tgzHejy3Ighfj46QXYOhz
         TiciQxs9DQVyf/RTESEHJkiK2BQKjgpg55Q9fy/zdNB3uue6a10sMJUIJx7ZBrqTncqC
         gjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XufPAMebi+TQKK75DKApzVpkJqGpncDvct45lHXgg7c=;
        b=UdREEjUapC4yyVH1fkpt2by/ezMo5OJfvf09ygKUCnDsrafy1w2VsZeBqojfZWwaaJ
         GHs7MttoP/nVdcWWmLTG5sAYw3P/bGlI0wJAk3PVnPt81dnprPQJKthxbMlxsfWNtslF
         9qDC4dNWRaCMyjUdcmtAFugfHWm5wgf436izs/wUznUkVh2ip3Agh3MC5g6lV+TtKWS4
         5XyaJTZfbIOPFm0ZRMfKwwl5P8Mf7PLdiiCEAD9t/lIdxE7yKj1vEVoWD9Hql28/Ipal
         Qsk1p5QygwvN681DEXqXZzWIQbbheXQfB+2u5+4YZRpy3+aHSyfUd0Rx9TWifAfUgPT/
         Fsvw==
X-Gm-Message-State: ACgBeo1JRkNXwDtatN/P5kim4YmVi0Z9XevLzJmhYku1Hmu2PP6AFF9H
        WWapGoArQXniOp2AYThAQOk=
X-Google-Smtp-Source: AA6agR5UZtDyXut2Lp/DzM6pR7l9tsw/Vb1GjnyX/GqJQ0/NV1v1YZRDJTuRprdEzRFBVNcdp8ns2g==
X-Received: by 2002:a50:fc97:0:b0:449:1fd1:25ea with SMTP id f23-20020a50fc97000000b004491fd125eamr9397623edq.301.1662112359059;
        Fri, 02 Sep 2022 02:52:39 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:38 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 07/10] staging: rtl8723bs: remove hal_btcoex_SetManualControl
Date:   Fri,  2 Sep 2022 11:51:57 +0200
Message-Id: <ae83ad941013d7a6c47d06f70c0f43087fe2c84f.1662111799.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662111798.git.namcaov@gmail.com>
References: <cover.1662111798.git.namcaov@gmail.com>
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

Remove function hal_btcoex_SetManualControl because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c     | 5 -----
 drivers/staging/rtl8723bs/include/hal_btcoex.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 9acd49323c7c..e36f8c369a04 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -1283,11 +1283,6 @@ s32 hal_btcoex_IsBTCoexCtrlAMPDUSize(struct adapter *padapter)
 	return (s32)GLBtCoexist.btInfo.bBtCtrlAggBufSize;
 }
 
-void hal_btcoex_SetManualControl(struct adapter *padapter, u8 bmanual)
-{
-	GLBtCoexist.bManualControl = bmanual;
-}
-
 bool hal_btcoex_IsBtControlLps(struct adapter *padapter)
 {
 	if (!hal_btcoex_IsBtExist(padapter))
diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
index 78599d3521bf..fb167642da01 100644
--- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
+++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
@@ -45,7 +45,6 @@ void hal_btcoex_HaltNotify(struct adapter *padapter);
 void hal_btcoex_Handler(struct adapter *padapter);
 
 s32 hal_btcoex_IsBTCoexCtrlAMPDUSize(struct adapter *padapter);
-void hal_btcoex_SetManualControl(struct adapter *padapter, u8 bmanual);
 bool hal_btcoex_IsBtControlLps(struct adapter *padapter);
 bool hal_btcoex_IsLpsOn(struct adapter *padapter);
 u8 hal_btcoex_RpwmVal(struct adapter *);
-- 
2.25.1

