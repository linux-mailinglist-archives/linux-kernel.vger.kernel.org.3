Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF304F2182
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiDECVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiDECVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:21:16 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116033E9404
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:15:58 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j83so11897180oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzJuXZ9eAb1KbZEWv1/dEtK+XWHxhBleYz6kLAiV4gY=;
        b=DrvygdXalZezWv1MQ0WRDEj5UYJ64eGH5HWGqltOYGkdKAnx/lPrgsAzLeDlQlfReh
         DLqg5JQUTauq8DJ9XI3od9xUX/XR6rjV9ix4i3/LCFQyrVljE4DUEVF2yrIOrt7BQ5iv
         eq3r4dTrEsVrQSEXFFacl93v7o+8bElG1jD46buEPbSGemMOD+6uYUipRQADDtyijF3a
         d6s5ILB0McS8+A9XY6n35Dg0+KouaIpGxGdNXk+upukO8Hou36++SYmi1MSuiz8cRdF4
         EiXBnZaH+CEYggJQ4lwbRQQEgmBjVqRK62KmdWKfX1C71bb75zSrdYRhyKNzORnej2Lt
         719g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzJuXZ9eAb1KbZEWv1/dEtK+XWHxhBleYz6kLAiV4gY=;
        b=FwRAjNi02PAVKCT4wSXUbM0mHoLtWC9ifNF9dLuOcd1UZxyZUgQGwRlExAgWAmTFsQ
         afDu4sKZbVm3xNrKnOYuJOK9g2nl4tMXAfUZJfnpPQUXB2fC3/BUHvsWVlDwU4JPW3En
         5EvVGHFNWvnEaW3vhZmQJMwWgYIYeVR9pKjX5hamJGa+dMQgdpNalBsirXwbAZAfaNHk
         YN42RETOuwXvbxvI/UJNWUBTBxnUzSMmJvNI+KK91OOKC8g7jf+VqlPX4I4TRtMoMJ3b
         CcIuItj2E2fHMNCxUw6biSZifeKMxuERxVMT+8egOlVtrtgI4s1g8t0WphIjrwqdX5Lf
         VSag==
X-Gm-Message-State: AOAM5331mgD9DhnLoMQNKU4X/2g5Hz1oT/BaDeKa1OaCW/Y2mQNJ9+D6
        Dw67lBbiT/8HCavN3yez+T4=
X-Google-Smtp-Source: ABdhPJyotuFQtGaDCSLIsEJnKpCvz+zqmaRK8vQTtrNMYpSYYIZHAm4+PGP/+cy0cBO4nvHgtiffvw==
X-Received: by 2002:aca:2b0b:0:b0:2da:3ed3:f862 with SMTP id i11-20020aca2b0b000000b002da3ed3f862mr479814oik.65.1649121058510;
        Mon, 04 Apr 2022 18:10:58 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id j4-20020a9d7384000000b005b23499b66dsm5243274otk.23.2022.04.04.18.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 18:10:58 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] staging: rtl8723bs: combine both sides of conditional statement
Date:   Mon,  4 Apr 2022 20:10:44 -0500
Message-Id: <23cfd782614e09f57a514aab68407183702b0a2c.1649120568.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649120568.git.remckee0@gmail.com>
References: <cover.1649120568.git.remckee0@gmail.com>
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

Both sides of conditional statement are the same except for the comment.
Additional instances found with git grep.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index c16a2b644296..b4170f64d118 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1885,11 +1885,9 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	if (pcmd->res == H2C_DROPPED) {
+	if (pcmd->res != H2C_SUCCESS) {
 		/* TODO: cancel timer and do timeout handler directly... */
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
-	} else if (pcmd->res != H2C_SUCCESS) {
-		_set_timer(&pmlmepriv->scan_to_timer, 1);
 	}
 
 	/*  free cmd */
@@ -1915,11 +1913,9 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	if (pcmd->res == H2C_DROPPED) {
+	if (pcmd->res != H2C_SUCCESS) {
 		/* TODO: cancel timer and do timeout handler directly... */
 		_set_timer(&pmlmepriv->assoc_timer, 1);
-	} else if (pcmd->res != H2C_SUCCESS) {
-		_set_timer(&pmlmepriv->assoc_timer, 1);
 	}
 
 	rtw_free_cmd_obj(pcmd);
-- 
2.32.0

