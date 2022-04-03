Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293954F08C5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356496AbiDCKj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 06:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbiDCKjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 06:39:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488E2AE3C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 03:37:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ot30so4488300ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7AklIE8B1vYygpUOxvh3w3+3byLOzac1fnd/Uj/h2s=;
        b=NNifbRwg4S4cxDrYPUEDGKfpijweCcI/DZLG/ft6bUUna9Wv9r1MFcZcUXu4PWeeWg
         zsKBJsogRpnKDxxUn/FcEGuXKsx+Woymlp/qy944kB+N9+GgLL54rl1WWH441lrCUpav
         LLnfKYaEfpwMf/Wxejz+qB73H5TKAI8IQ//0uGiE9ze53KCu78DjSuztiwiQB5KM5mAv
         Q/gmCfKutPKIXU8JClYdhHLFIgSjiYDAMQayGb3L9QJta9P6RM22QWTa8/UI5euKeoJl
         4mGeQC+ObMAqBumLDmReI2v/G/7AZT9vomUMm7qz9kv5do9utzjRaq5BoJ8ryg9sW0gp
         qpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7AklIE8B1vYygpUOxvh3w3+3byLOzac1fnd/Uj/h2s=;
        b=LaRGWap+0WgZGMq4vkK7aRpAS793CYi4h+SRQQ0lICyiQiZ5S13UJc9UyuBzcWhnOT
         FL8i36FJR5DAtSTweq/DfH+7OLu/SM+g8lOR0q/iwGvdagJPa9tvYQ6pA3brJ8SGtCy2
         QgDipWsZIE7aBcEID28+4qbjc6YfUFxodV9TmxbnuGwkFyMP/HKC6kSYva5rP6XHuc6o
         arWtAftQluf/yOyUnv2dSKkN1M3sX0sjUJkaA7tlAAgbvB13yRN6a4OUQ8h9pmRKjM01
         G5pHZxMJxaxIqizmil/QueNHwEM1fLwGFV+2ElEnKPJJ9AOH6E4xRe6zxdteMhhtf26v
         E4Kg==
X-Gm-Message-State: AOAM530l015lrQx3p39UJqrQ/m7/9TEDLmQNyvlbOxlPSowqE2bPaiOX
        NscpgTRwWqVKSg0roEVKuXQ=
X-Google-Smtp-Source: ABdhPJy3LW1iCrohUAkw/yg8t/AEStCsWy9OScO6T4SDi1PU9JJw0z9ucPSrULegT+7ruB2vQlUmfg==
X-Received: by 2002:a17:907:9705:b0:6e4:b769:286f with SMTP id jg5-20020a170907970500b006e4b769286fmr6585311ejc.728.1648982245655;
        Sun, 03 Apr 2022 03:37:25 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b006e1382b8192sm3130751ejc.147.2022.04.03.03.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:37:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: remove macro rtw_pwr_wakeup()
Date:   Sun,  3 Apr 2022 12:37:12 +0200
Message-Id: <20220403103713.12883-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403103713.12883-1-straube.linux@gmail.com>
References: <20220403103713.12883-1-straube.linux@gmail.com>
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

After previous cleanups the rtw_pwr_wakeup() macro is just an alias
for _rtw_pwr_wakeup(). Remove the macro and rename _rtw_pwr_wakeup()
to rtw_pwr_wakeup().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index ee324c18a1b9..6f97c7a879a5 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -352,7 +352,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 * Return _SUCCESS or _FAIL
 */
 
-int _rtw_pwr_wakeup(struct adapter *padapter)
+int rtw_pwr_wakeup(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index fd301a9f117a..4cc365aa3fa7 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -121,8 +121,7 @@ s32 LPS_RF_ON_check(struct adapter *adapter, u32 delay_ms);
 void LPS_Enter(struct adapter *adapter);
 void LPS_Leave(struct adapter *adapter);
 
-int _rtw_pwr_wakeup(struct adapter *adapter);
-#define rtw_pwr_wakeup(adapter) _rtw_pwr_wakeup(adapter)
+int rtw_pwr_wakeup(struct adapter *adapter);
 int rtw_pm_set_ips(struct adapter *adapter, u8 mode);
 int rtw_pm_set_lps(struct adapter *adapter, u8 mode);
 
-- 
2.35.1

