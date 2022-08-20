Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89D259AF86
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiHTSQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiHTSQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC2630F68
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r4so9128516edi.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MiGVrw4JALqFboIbdo0JNwpxU3evPgpPsmBSJG0+KfU=;
        b=iJI5prIZyNpks5TyznfeEWp2hYghqEdV+Xt/0Sgb1PurTzOm+1bVNpbSXH0MajAbzn
         q3+CfLRPpkT2S5OWFX0PBvkob7HLl0+K8G1pwW58SsAA5gJ/2vdw7MRswQfpphFxKwGz
         dNF9iUqarZLj39LWt/2DjIacoUeCmz1tnoo315mDAIprdJHAEnOkIE1Q+nme/ghF7LkR
         hmrN+4kDm+ueoYZPCIT1N/cQ+MddjpzXwfdjBmXrxv3JQiN3wpy0bDsXFBgOYVQlyCrS
         09m6G5j1fAWA8+gY603vJGEIGfvDsOkEx5A5M9nIUZM+tbo4oAuUUWssjwPjvgRns4zR
         Lc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MiGVrw4JALqFboIbdo0JNwpxU3evPgpPsmBSJG0+KfU=;
        b=1Izm5mjYgXXEKohfiT+X/rhINSEvYsShN4rjhd8POmTzWQRJELOFWSAmQQgkbY0THa
         E9GSygrjq+4ph5EXPaVN8hOUWree5I+E/lVx6kAhlkCD+Ox0q72SiO5jUt+X25n2a0z9
         /vvZNTNZ+EzOrDqeTnjAotej1/uF1G16p2cOrXSnYADZz0awyLQGV7SwZ/UzqOAThm9c
         bAMhy6515asDsekslg/GHvSRY+OhyH1rOmL/KZd4Ld0pyFvWnKwPvk7hqG9CNj/PDhjp
         O/RXFunlV1dZ5fLx3SLJO5/jZeDO0knIfmi7u3TOahoh7xoXxEAOUUUbXix9B2MGITlc
         lwAA==
X-Gm-Message-State: ACgBeo0aiCESL8EGezdKcNL/cyk1S8iiSZBaKvHQ4jOkt730Y6j3QdSa
        mA9ma2M2mt+JTZPrJTUiZO8=
X-Google-Smtp-Source: AA6agR7t1pTTzCt11SKy5ZAq0leRubnuSHeY4d/dJh7WN7mvzLRaXh9ytv/Qnqkd+l/MD5qHxBysIw==
X-Received: by 2002:a05:6402:14b:b0:43d:a7dd:4376 with SMTP id s11-20020a056402014b00b0043da7dd4376mr10098052edu.89.1661019398268;
        Sat, 20 Aug 2022 11:16:38 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/19] staging: r8188eu: rename rtw_os_xmit_schedule()
Date:   Sat, 20 Aug 2022 20:16:07 +0200
Message-Id: <20220820181623.12497-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
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

The function rtw_os_xmit_schedule() was moved from the os_dep
directory. It looks like the driver was originaly written to support
different operating systems. Obviously we do not need an extra 'os'
in the function name that indicates that the function is operating
system specific. Rename it to rtw_xmit_schedule().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index c7f69f7918b8..9e7e0034d352 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -641,7 +641,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
-static void rtw_os_xmit_schedule(struct adapter *padapter)
+static void rtw_xmit_schedule(struct adapter *padapter)
 {
 	struct xmit_priv *pxmitpriv;
 
@@ -736,7 +736,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		p2p_ps_wk_cmd(adapter, P2P_PS_SCAN_DONE, 0);
 
-	rtw_os_xmit_schedule(adapter);
+	rtw_xmit_schedule(adapter);
 }
 
 static void free_scanqueue(struct	mlme_priv *pmlmepriv)
@@ -1134,8 +1134,7 @@ void rtw_joinbss_event_callback(struct adapter *adapter, u8 *pbuf)
 
 	mlmeext_joinbss_event_callback(adapter, pnetwork->join_res);
 
-	rtw_os_xmit_schedule(adapter);
-
+	rtw_xmit_schedule(adapter);
 }
 
 void rtw_set_max_rpt_macid(struct adapter *adapter, u8 macid)
-- 
2.37.2

