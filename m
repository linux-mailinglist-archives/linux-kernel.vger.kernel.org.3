Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096CA4FB97A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345457AbiDKKZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345414AbiDKKZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:25:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FFC44A12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f3so14227080pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDJwfC4bXVfds8p9uj2dvjrmmyg7JkvC30fvf514tUw=;
        b=atCReM7GsEniNQu0eCNJ6aQxRV2SMOdKBHn4gjkvwZaPYYBYmaAoAA09Ho6TWsw2lJ
         UlepctMkONgP33D7RXbn7vHddoESrb/UmCTLYuJ+ZdXlAh8V7eeiSdhkGSP12UPKuy1f
         L+z9Wd8pchqmYJIiU2FxlrVE3kVYIMcrpBiB+iCROQctDLErcjO1bZlp3Za/t7npcBW+
         l6vzKDo+UGuFFfwONCgp78q30rWiwNojvQ/T74pqyUY+6/DkNIaOZt00lhNlicmd01/C
         Rhpaa6Co/kxuSfiWCuRSjJgCnRfrQlqHpMaa8XNj1V4QzunLH6Z4EFGrD22OsEuRBEF3
         ZTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDJwfC4bXVfds8p9uj2dvjrmmyg7JkvC30fvf514tUw=;
        b=Vpsb3rUssTA2eUQyXn1TKkH7t2KM6pCN078ejbjDnYCJfb9XWsDSFvji3BJpJbsqhu
         S07ZTQvhcl8hFqQMKFT4aXflNU7k2nvTUs0RfkK6aN6eKI5G3Ol7H/qy9M8iYK87JJ+1
         aTuGGG5emJ43yAs4Dp00zNSG7R0GpqeqyG1WF5SfYeVd1MpLXcPF3DEzb//EwanqCqNW
         fuw4tiezMVIQXU/yMpZBlD09vpSljhmECmPrm57nS3PTwzETcN4EPEvmfT4NOy8JWO1N
         1Exo4LrlAxgbKI6uVdHLKeRV0JXMwsTy75ZOsBKF9dXnLZ5NMH7fKjO2HDXjun2nzdq0
         s97Q==
X-Gm-Message-State: AOAM533yp/KsevM3XVxaNNkuOhc7ulLyDfOHlI9yJ0GKZhkm1QD8NRsx
        xfHEKOjqF4aqepkynzZbaWk=
X-Google-Smtp-Source: ABdhPJzNPJjwDfyVPTKLgVA7IrxOrALdvl+BXQbDiROT9w1bmwz9EZklAQiEYiv+as26Osv/zA5eNw==
X-Received: by 2002:a63:f048:0:b0:39d:6f6d:47ad with SMTP id s8-20020a63f048000000b0039d6f6d47admr1130450pgj.494.1649672522385;
        Mon, 11 Apr 2022 03:22:02 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:4376:c658:ae1e:1781])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm4886318pjd.54.2022.04.11.03.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:22:02 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 2/7] staging: r8188eu: drop unnecessary wrapper _rtw_init_cmd_priv
Date:   Mon, 11 Apr 2022 15:51:31 +0530
Message-Id: <20220411102136.14937-3-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_init_cmd_priv and move its logic to
rtw_init_cmd_priv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 77 ++++++++++++--------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index d53217900..3d1fdc852 100644
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

