Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5C55710A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiFWCZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377824AbiFWCYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:24:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B710403F0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:24:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d129so17785342pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GIwgs9N4bBMvvxMqYn9jQ+VVwblxOxFZPXSHiSI6CI=;
        b=MrZn3gi15FHEA6GZRBRyFhCCS1LMfftSQH3a5Kpg6bl+kdanOHSIuZtt6bnugAkAKP
         zroGFotkiIuLlOGzWQeRMphIb6PikUx7DnBNTvb1KeSjwvvsYjkf7Lnj0oUAj1njujQO
         c3P65LP7W0Jbp9Y47ZeRNulmKxbloSDFYwUEcRhSwAufrzqMsFZldcBtUF5ZE1jorNNA
         K4W9qdCwm5zDEZbFGcS4FJci1zJJybcN3dKFNigKIBc/O0oVNAVops3t95pETGMtwaef
         CxvR3UGTsFSunHFZF3cNGjLscxNaW+xVUnXhqCDmVHw00AugJpT7qDH8OUCXg6xYbpFU
         NxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GIwgs9N4bBMvvxMqYn9jQ+VVwblxOxFZPXSHiSI6CI=;
        b=MJQj1ZOW0RkPtf6Yy+8ocRdnj+j6Sm11vobT9bQOef0bm1+uxQPVPrGgtu6aYdeZDd
         9le9w8G5Mhq4Yh3snWKBJBje+eZ2qNfhpEGpnynPWqCyr6i1TfUY6Lfvqn+Muhs1XDdx
         zoQy9YupWusBL41HNo76Eaeon7Fw7r3dXuZZ0CQsfw7BdigLlwZvhT+2sBBhiTPjpbM4
         ClTanfTuS0ghaboGJ9RPWhjt7sjHDN1z4FZCfkmUur5THbIuaXQQy29zrdEu7WHyCJP1
         Q0iKxPu/7r7aD8Lmw97pRuH0QXGNHWmjTz2p1241rGvT9+SIxzgfn66+s7S8WXZTjjQG
         GfgQ==
X-Gm-Message-State: AJIora/9nhlu/n1eZJJbCaxTF62rPuJ95xj9rvuBhpHCKXXGBEnNp5z4
        o1bkNF1hXuQ2Leg8o8p9qdY=
X-Google-Smtp-Source: AGRyM1vb7Dl3ZFY5YBzJtriFxbVesli6ucO0W07ahpux11iJqX54+BagZDriirQpsbfLx3OCcxIGog==
X-Received: by 2002:a05:6a00:1690:b0:517:cc9e:3e2d with SMTP id k16-20020a056a00169000b00517cc9e3e2dmr38699096pfc.0.1655951090760;
        Wed, 22 Jun 2022 19:24:50 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b0015e8d4eb273sm4252922pll.189.2022.06.22.19.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 19:24:50 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH] staging: r8188eu: Make rtw_signal_stat_timer_hdl a static function
Date:   Wed, 22 Jun 2022 19:24:25 -0700
Message-Id: <20220623022425.395000-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make rtw_signal_stat_timer_hdl a static function instead of a global
function.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index cc91638a085d..599d3e55be76 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -24,7 +24,7 @@ static u8 rtw_rfc1042_header[] = {
 	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
 };
 
-void rtw_signal_stat_timer_hdl(struct timer_list *t);
+static void rtw_signal_stat_timer_hdl(struct timer_list *t);
 
 void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 {
-- 
2.36.1

