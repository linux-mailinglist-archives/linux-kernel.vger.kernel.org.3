Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4F50C0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiDVVRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiDVVRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:17:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799623955B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:13:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u15so9774634ple.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IoveYgPzkVQxQlEHYjiT25fHGi8jPmqGfk3V2Lj3tG0=;
        b=p0+mBZk4Xc8pDoDk7SDXGalwSRX0py90m6dqVle4PP72Tn684vhS4UbdpKP/r96uic
         QggE8UqQZ9YOhfUPTqUM6wurtooEqpVGGKOYdIYTTBFda7K1kCjkhPPRlTSwJEI7/bQx
         RF8co3a7PaaO39iScZ0+oV7TUYl6pz+xzKjT+4QZHmO1jDscbZe6kzeD0fARclZ+NwH/
         bKagFH67K0/tJHT5i1YovY93R9hD/rOmbK+w3MhphPxW+8uIviqRF+DZnDi0iYH8DJnc
         ABPx4/Pzv1/pvnwxCI29X+reSydFwhJtAXkp71IPj9v8G6yylW7NDFQD8PClhukWhS/L
         jOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoveYgPzkVQxQlEHYjiT25fHGi8jPmqGfk3V2Lj3tG0=;
        b=lGDPHJxm0+g9UyvBcK/nyiXrDsB7c7I6zLlRe7D3yZbzgJW00Mg1cy5M9WSR2u3pyP
         grlwbDdI3oFqZzG3R0wNRML15dvW2XoyL9TstEqD+M9MwrDKnfmlmfm2zFw0tUlLhFtl
         ZpsL4DoyaLEOlXqv/fLukMrIu01vdNddlVDSxEnkmR/VKxVnRlDBQNOtB/FysyUHgI7Z
         R/UcMAgmPtXEvqLpTIm3EsLp181aIOAunz011uxLoTa+nr4qWu2fhoa9ny4wk4uZq+SD
         EOoNRocpyEnPlLXpMba4jZuk6kIZKtGocCR7zeq94S4aUJhvDc0hvSRZcO5a7wsm+VFl
         HOnA==
X-Gm-Message-State: AOAM5313ja7VxEqpcVp+eeCT33vHDjjkDiVtL9q6sZQ9PjtcJAvWC4yJ
        0WJZTRgCkjxpBmwAlVP2FgmbYBtINk8VaQ==
X-Google-Smtp-Source: ABdhPJxLh3K98aNfOR6TCroIxTuAyj+Djkxy+F5QWbVMM7iEsJq/MJRfBO/lMAOzuPWZcmyKGXrAzQ==
X-Received: by 2002:a17:902:b692:b0:14c:935b:2b03 with SMTP id c18-20020a170902b69200b0014c935b2b03mr6057316pls.81.1650655978393;
        Fri, 22 Apr 2022 12:32:58 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bfe0:e8c0:bea6:ee63])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3518932pfh.83.2022.04.22.12.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:32:58 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v3 7/7] staging: r8188eu: drop unnecessary wrapper _rtw_dequeue_cmd
Date:   Sat, 23 Apr 2022 01:02:23 +0530
Message-Id: <20220422193223.11948-8-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_dequeue_cmd and move its logic to
rtw_dequeue_cmd.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 34 ++++++++++----------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ab462eb40..06881a871 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -56,24 +56,6 @@ static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 	return _SUCCESS;
 }
 
-static struct cmd_obj *_rtw_dequeue_cmd(struct __queue *queue)
-{
-	struct cmd_obj *obj;
-	unsigned long flags;
-
-	spin_lock_irqsave(&queue->lock, flags);
-	if (list_empty(&queue->queue)) {
-		obj = NULL;
-	} else {
-		obj = container_of((&queue->queue)->next, struct cmd_obj, list);
-		list_del_init(&obj->list);
-	}
-
-	spin_unlock_irqrestore(&queue->lock, flags);
-
-	return obj;
-}
-
 u32	rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	u32 res = _SUCCESS;
@@ -180,11 +162,21 @@ u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 
 struct	cmd_obj	*rtw_dequeue_cmd(struct cmd_priv *pcmdpriv)
 {
-	struct cmd_obj *cmd_obj;
+	struct cmd_obj *obj;
+	struct __queue *queue = &pcmdpriv->cmd_queue;
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->lock, flags);
+	if (list_empty(&queue->queue)) {
+		obj = NULL;
+	} else {
+		obj = container_of((&queue->queue)->next, struct cmd_obj, list);
+		list_del_init(&obj->list);
+	}
 
-	cmd_obj = _rtw_dequeue_cmd(&pcmdpriv->cmd_queue);
+	spin_unlock_irqrestore(&queue->lock, flags);
 
-	return cmd_obj;
+	return obj;
 }
 
 void rtw_free_cmd_obj(struct cmd_obj *pcmd)
-- 
2.30.2

