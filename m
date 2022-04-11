Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1124B4FB974
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbiDKKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345444AbiDKKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:25:14 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC8144769
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:21:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k14so13821603pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioOLOPRMwxuocGQiKn3ZypvnZg8gicvD1hlKV7CC/G0=;
        b=WScTtEoPg8rfuBUuUvYtHKVp0wwTmhBMdvNJ3OF1NaBNKpunV+yblivfIzRpwSEYLO
         TC41U82zJnuLIx/l60Ou+clbet6SWmkwv3PDiX46bnipEQ588owetbfOSiDDxftyt+zd
         Dbp+0eWhV54Hs1gwrQ6aOFn9aZAmpjAt9ek/qzC66ynoDPt+YF31lN5hMsIcIbygMizh
         DBrDu4qbfylwp04MCHBSXuZK4yy+DLfI+TNGr4sOzl+OK3qfFz/3yXzICxlLCYA0Mqs9
         1k40WYjdwGckv3bWdF8GvCp3GX2bK/0muGVGJC3KYH8i9v/gQ5BFRvigKCscFqmTuaFD
         oUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioOLOPRMwxuocGQiKn3ZypvnZg8gicvD1hlKV7CC/G0=;
        b=7STpGDSl6oRAZQuXi7Hi25Gi6xbEg0mAeaq19QShh3da0Am7u2oxPeYoMglk4ESSco
         X2PbUkvQQxLRTWDEGLylzmodUOPf6ML+53mZBxkrGkO44fi2HSgdhXN3GT7CKjryyGZF
         GlWYeXxJ5WIpURuYTqI26HZpbsApFUCO4fY8T2h26zcC29ki99QJJ57HTOQT5f7KN646
         b2WOIkp0yLVsH1v8pregkSjpA0RWOzY2O56ZI0h+4dL7SXzh3cGlkgmXyNEmZE6GPBJH
         GPi7PHrKn16krgCC3sOUDvptrGsr6Hr+5oSWNqCwdGoqm41OE0AjA0eDimI3X2qxW+0l
         rAkg==
X-Gm-Message-State: AOAM530bdWukEHPBO38ei4qb8lNCyTAXIBh9XyQ16w3vLpwPFBjX35EQ
        FV6iEwTf3Bi3P6qws5v/nR8=
X-Google-Smtp-Source: ABdhPJxWW43ktUsUtlSzuScY28viShh0aFgK9c2HjNrjsN6GhUbKT3q7NqL0ND9Nn5oRS3U56JX9yQ==
X-Received: by 2002:a65:47c4:0:b0:39d:4f85:40e0 with SMTP id f4-20020a6547c4000000b0039d4f8540e0mr4041654pgs.309.1649672518843;
        Mon, 11 Apr 2022 03:21:58 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:4376:c658:ae1e:1781])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm4886318pjd.54.2022.04.11.03.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:21:58 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 1/7] staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
Date:   Mon, 11 Apr 2022 15:51:30 +0530
Message-Id: <20220411102136.14937-2-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411102136.14937-1-makvihas@gmail.com>
References: <20220411102136.14937-1-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_free_cmd_priv and move its logic to
rtw_free_cmd_priv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index f036a980e..d53217900 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -87,14 +87,6 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 	}
 }
 
-static void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
-{
-	if (pcmdpriv) {
-		kfree(pcmdpriv->cmd_allocated_buf);
-		kfree(pcmdpriv->rsp_allocated_buf);
-	}
-}
-
 /* Calling Context:
  *
  * rtw_enqueue_cmd can only be called between kernel thread,
@@ -159,7 +151,10 @@ u32 rtw_init_evt_priv(struct evt_priv *pevtpriv)
 
 void rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
 {
-	_rtw_free_cmd_priv(pcmdpriv);
+	if (pcmdpriv) {
+		kfree(pcmdpriv->cmd_allocated_buf);
+		kfree(pcmdpriv->rsp_allocated_buf);
+	}
 }
 
 static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
-- 
2.30.2

