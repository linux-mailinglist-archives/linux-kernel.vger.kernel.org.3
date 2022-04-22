Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78250C164
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiDVWBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiDVWAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:00:50 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01F40F78B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:43:59 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id f5so5762620ilj.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEpHLec1VfOXZ957xfGm8Ejr+pJnneWUL+vw0yvfhv4=;
        b=Y21IM1rnk46dBDp5zwaK/T1TXHMTuGORzT5eW8AYSStysCesIgFjYOHUFUS15e5bWT
         OLlD0gyAbpiz3KkteHv1Nqwc8wpCCdvufOl4o/J+QKzULC0QgvH1e5eQBYT1LUnNJah7
         thkLfoYy48I+ubx7Bx8rYchaUA1fXXvWxObBe+lyquCKt9butEJZM7mj9YSLjaPBBK3U
         xWCvbV4wpd1gNa1Mo6SVgRePSZjUVQ4r3jhUqxKO/hO9oSq7Qv/UOc3/MbLx8+qiQhww
         2iWMgYvLS1emJhluirYzm6HwZKBJU9uKVhxf0+uCrs7OCVKMI+g6Jfjk/kgQggOrILNp
         bTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEpHLec1VfOXZ957xfGm8Ejr+pJnneWUL+vw0yvfhv4=;
        b=It2mX8SVW11lDIBHlTqPx4hKDNmjqnbFVjVIOCygFLbyTnjpuLAsEuCKo6qb7inTQR
         ndHrjf0fm6CovSzHCEHsjpDQTYXrhLUY8Yewjkjn5+mYDN3f379/xFSDkO/aGd6tpIRt
         oJdyd8qRFShgskRf9qNfIf1D4v7n4Kds4dUsNfB9HpxD88SHVmHWBrjOs7YLlzn73N2L
         p+Lfr4KSkhUjjS642oS83T0lbhbknrVmRvAojz9YAmAGjsumwoZSZ4HSRKl2Me+C1bxZ
         D9DAD0b5m5kSQbiW2oLaNS/eU4JuOP0rjnZAZtDjw2Atl+tg4JP/9xvyGelusOo+S8xD
         yxOQ==
X-Gm-Message-State: AOAM533RMaMdEfekbVBmL5T1pwn2nDlIieu3Qxe0jHh4F8oe2K8YB5gP
        WYs4/R0ZqrQ2N3Y5aOpTcF3TVRK5NejD8w==
X-Google-Smtp-Source: ABdhPJyq6Pev+frdReFdEQoGFh0hjvvnByHxD+Yshmj8pigE+7KWpHfHfR2682kvF4p8GYrGMZxPzw==
X-Received: by 2002:a63:6ac5:0:b0:3aa:f01e:3280 with SMTP id f188-20020a636ac5000000b003aaf01e3280mr416174pgc.207.1650655960827;
        Fri, 22 Apr 2022 12:32:40 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bfe0:e8c0:bea6:ee63])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3518932pfh.83.2022.04.22.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:32:40 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v3 2/7] staging: r8188eu: drop unnecessary wrapper _rtw_init_cmd_priv
Date:   Sat, 23 Apr 2022 01:02:18 +0530
Message-Id: <20220422193223.11948-3-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422193223.11948-1-makvihas@gmail.com>
References: <20220422193223.11948-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary wrapper _rtw_init_cmd_priv and move its logic to
rtw_init_cmd_priv.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 77 ++++++++++++--------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 32589e76e..fc955fce2 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -15,47 +15,6 @@
  * No irqsave is necessary.
  */
 
-static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
-{
-	int res = _SUCCESS;
-
-	init_completion(&pcmdpriv->enqueue_cmd);
-	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
-	init_completion(&pcmdpriv->start_cmd_thread);
-	init_completion(&pcmdpriv->stop_cmd_thread);
-
-	rtw_init_queue(&pcmdpriv->cmd_queue);
-
-	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
-
-	pcmdpriv->cmd_seq = 1;
-
-	pcmdpriv->cmd_allocated_buf = kzalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
-					      GFP_KERNEL);
-
-	if (!pcmdpriv->cmd_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));
-
-	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
-
-	if (!pcmdpriv->rsp_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((size_t)(pcmdpriv->rsp_allocated_buf) & 3);
-
-	pcmdpriv->cmd_done_cnt = 0;
-	pcmdpriv->rsp_cnt = 0;
-exit:
-
-	return res;
-}
-
 static void c2h_wk_callback(struct work_struct *work);
 
 static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
@@ -133,9 +92,41 @@ static struct cmd_obj *_rtw_dequeue_cmd(struct __queue *queue)
 
 u32	rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
-	u32	res;
+	u32 res = _SUCCESS;
+
+	init_completion(&pcmdpriv->enqueue_cmd);
+	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
+	init_completion(&pcmdpriv->start_cmd_thread);
+	init_completion(&pcmdpriv->stop_cmd_thread);
+
+	rtw_init_queue(&pcmdpriv->cmd_queue);
+
+	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
+
+	pcmdpriv->cmd_seq = 1;
+
+	pcmdpriv->cmd_allocated_buf = kzalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
+					      GFP_KERNEL);
+
+	if (!pcmdpriv->cmd_allocated_buf) {
+		res = _FAIL;
+		goto exit;
+	}
+
+	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));
+
+	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
+
+	if (!pcmdpriv->rsp_allocated_buf) {
+		res = _FAIL;
+		goto exit;
+	}
 
-	res = _rtw_init_cmd_priv(pcmdpriv);
+	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((size_t)(pcmdpriv->rsp_allocated_buf) & 3);
+
+	pcmdpriv->cmd_done_cnt = 0;
+	pcmdpriv->rsp_cnt = 0;
+exit:
 
 	return res;
 }
-- 
2.30.2

