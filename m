Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB624FAEEA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbiDJQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbiDJQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:34:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D0E13FA0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:32:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k14so12153733pga.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isbZTSF51sQ2FdPVyH6jc9Gphy+CzzvzSabiko7I6mc=;
        b=WQ6NrFWjgSROqckS7LZwaf2sC8rup0FYK90P5hEB5nGjeUppWwR2JJCEwHYN+LsJaP
         02tCUiWEVQaC5PpKqlM0TpO6r1hmFEWQAVAmM4k5XNhtKOxhNoj+P5BiH/Rl8oCQDPlL
         pSM86wRl3fFr6cq/g2nj4LQeW4LiXhQyf4SDLjCAgzptOiKu3ul6+/4zlCh+lXcunRka
         Iol3zQQxHbbaP5q4QOsjOjbT/7chZVGCFFarKZzNDf1xqF3GAgnrT4cbH9xh5PZo5c5m
         2mYdu/UZ9UtDfRKxLx1aCS58JQzhU9+vh03RQwl4XZkCoMk864dhvFNE2NBFBZRwiG2m
         vcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isbZTSF51sQ2FdPVyH6jc9Gphy+CzzvzSabiko7I6mc=;
        b=C94MY3QQJ89p7/0PhAgVdQzYhEWbR7NOKtbPvEJCf2T7jyazG6ugepTF4Vd3mXbqk2
         bDviINuaaeM1Qrp6X9AhY+pPxALCDaV+J6bwRJIRC6YpGEBTtAWVTKOzeEMQfz79iUky
         k53x2yvEoeJ+9uk4D7VxhHBHeiE/IQIg26Wlmhtcp9qfB/iRzwhBhmjhSutQyWaCge5Q
         SvX8LU93Wn82qoHvVmGELqBOSiIPY5PpKHYD25JLYdZOrICbq9VV3VKahzM1iiaIQZ6o
         WnTb2sL0pj1m2/qjn4336M2LU3Q6XeVp3LoDcub2jnoIP3gCddTYmjTEjXw/qRkC0qip
         J8Rw==
X-Gm-Message-State: AOAM533op8bHTHCU2kAkqjKeDMOOc+8mK0/Nd0TrNE1ADH2Bdb4L3Ef7
        3m3HSyPU/7Fm+JANxr/x2kw=
X-Google-Smtp-Source: ABdhPJzsjuokRfZ4sVFRJ05ODDxjzY9aXs4YH+x2yITz4ZIwskSlkbJNeDFx2Fl7jlZhMBVV0LjyQA==
X-Received: by 2002:a63:6c04:0:b0:398:54fb:5632 with SMTP id h4-20020a636c04000000b0039854fb5632mr22918201pgc.78.1649608322658;
        Sun, 10 Apr 2022 09:32:02 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:606b:10e4:2085:6825])
        by smtp.gmail.com with ESMTPSA id f12-20020a056a001acc00b004fb37ecc6b2sm31940021pfv.29.2022.04.10.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:32:02 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: drop unnecessary wrapper rtw_dequeue_cmd
Date:   Sun, 10 Apr 2022 22:01:15 +0530
Message-Id: <20220410163117.3964-5-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410163117.3964-1-makvihas@gmail.com>
References: <20220410163117.3964-1-makvihas@gmail.com>
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

Remove the unnecessary wrapper. The logic of rtw_dequeue_cmd can
be moved to _rtw_dequeue_cmd.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 16 ++++------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  2 +-
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ac6e710e5..9d1beca43 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -121,10 +121,11 @@ static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 	return _SUCCESS;
 }
 
-static struct cmd_obj *_rtw_dequeue_cmd(struct __queue *queue)
+struct cmd_obj *_rtw_dequeue_cmd(struct cmd_priv *pcmdpriv)
 {
 	struct cmd_obj *obj;
 	unsigned long flags;
+	struct __queue *queue = &pcmdpriv->cmd_queue;
 
 	spin_lock_irqsave(&queue->lock, flags);
 	if (list_empty(&queue->queue)) {
@@ -178,15 +179,6 @@ u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	return res;
 }
 
-struct	cmd_obj	*rtw_dequeue_cmd(struct cmd_priv *pcmdpriv)
-{
-	struct cmd_obj *cmd_obj;
-
-	cmd_obj = _rtw_dequeue_cmd(&pcmdpriv->cmd_queue);
-
-	return cmd_obj;
-}
-
 void rtw_free_cmd_obj(struct cmd_obj *pcmd)
 {
 
@@ -230,7 +222,7 @@ int rtw_cmd_thread(void *context)
 		    padapter->bSurpriseRemoved)
 			break;
 
-		pcmd = rtw_dequeue_cmd(pcmdpriv);
+		pcmd = _rtw_dequeue_cmd(pcmdpriv);
 		if (!pcmd)
 			continue;
 
@@ -280,7 +272,7 @@ int rtw_cmd_thread(void *context)
 
 	/*  free all cmd_obj resources */
 	do {
-		pcmd = rtw_dequeue_cmd(pcmdpriv);
+		pcmd = _rtw_dequeue_cmd(pcmdpriv);
 		if (!pcmd)
 			break;
 
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 7edce0f88..d581deebb 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -77,7 +77,7 @@ struct c2h_evt_hdr {
 #define c2h_evt_exist(c2h_evt) ((c2h_evt)->id || (c2h_evt)->plen)
 
 u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *obj);
-struct cmd_obj *rtw_dequeue_cmd(struct cmd_priv *pcmdpriv);
+struct cmd_obj *_rtw_dequeue_cmd(struct cmd_priv *pcmdpriv);
 void rtw_free_cmd_obj(struct cmd_obj *pcmd);
 
 int rtw_cmd_thread(void *context);
-- 
2.30.2

