Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04264F0C47
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376328AbiDCTT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376308AbiDCTTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:19:24 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7838D9E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:17:28 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-e1dcc0a327so3783388fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsazcajhwAV1pXduS7vg1S4Bv/a0jWiLu0YfVDB4Bpc=;
        b=fD8XtscC62a8RjjvUesg11cshBRy2kBxbHskMpib/MzQ9FOgvf7cHyh8QcNxhdMypf
         tW0BxL0psdUKT0v5VoFGFiYGhxy79v/Ek70I848q9TNL1Tchadv04Tcah2LMHHO61FwW
         n+DzV5BP/TWXXil5iFO2DY9d1SFcjSx+DP5nKaMKeng4zk9riZSPWDCEV9BlCAQ9hiU0
         4EPzGpF4qiPkz97BE3crZvbpuftS7hfp8DNi9nuphTPIhI1xhAcWpVHvnG+n00lFKKdA
         65XaQNgY28zJ/OqMB1I9qD+X4VJ40Tjzx1oqpzUyYU1bDz+x0ewiRzwVQLwILPnyly1K
         f76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsazcajhwAV1pXduS7vg1S4Bv/a0jWiLu0YfVDB4Bpc=;
        b=KesBkM1PKxmJYtZA/lXhp1Uffgb8ejL+ztxrcCHtw39JvJoLUUH66SsG1tjingkNIP
         K/jaGCgQxAt4E7se3H/TeWN/MWJ1MZeQmwffCvLFBqDXPMXY4EcxXmVWvqSMZw5DIJLt
         AzZ3XrBfdoIQ+PZG+wb69vSYC6hf1JCen2xHm4WfVJoFGNItEaVvIFlWfg+1MXjfEyWy
         cLjTSD4EV3tllBJCZDXo43iEny6ZPywPXW6fvNYG48dZ7pI3ioEOfIFRFNgQOHbt0v2v
         mS70vgssM96rHpfblRwORSCrvS4sw8wjxb2roXelbfe5qKpdY3Gg5fo/hWFLymu81Ugo
         GSWw==
X-Gm-Message-State: AOAM5333Wg0rXTtmOH3FOYq9qce+iLEjTyC7aW+8QynaJ+XPlvydXdRD
        9ecQbz3RDNjdKXqDIHjn7Jg=
X-Google-Smtp-Source: ABdhPJwGX4CftSqnUovbKALARqMBw6hWHNEfEj6l0gI+yMEG/eiqtanlkfbDx2i0Tt6Ta4ZH/sDo8A==
X-Received: by 2002:a05:6870:61c8:b0:e1:a94d:d5da with SMTP id b8-20020a05687061c800b000e1a94dd5damr6961613oah.271.1649013439676;
        Sun, 03 Apr 2022 12:17:19 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id m5-20020a056870194500b000d9a0818925sm3305786oak.25.2022.04.03.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 12:17:19 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/3] staging: r8188eu: combine both sides of conditional statement
Date:   Sun,  3 Apr 2022 14:17:05 -0500
Message-Id: <d33c51bc3a20fa25e4737b258f3b1c42cc8124e3.1649011311.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649011311.git.remckee0@gmail.com>
References: <cover.1649011311.git.remckee0@gmail.com>
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
Additional instance found with git grep.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index da455eb4d8cb..2d316a6c8294 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1411,11 +1411,9 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
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
@@ -1445,11 +1443,9 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
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

