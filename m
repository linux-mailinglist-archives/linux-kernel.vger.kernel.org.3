Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251BB4FB977
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbiDKK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345442AbiDKKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:25:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E345061
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bo5so14211281pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVXrBloFtORkonGCujGmdgK1BPi5/BKdnl6pJMRy7hs=;
        b=Q40Tkt7prSxfeUG0mZFUtG9SRNWCCsWmxBgoXKMlowy/nXoUagFtxhayjTlYcgKWjh
         ozjjM9ZwuzkhlR+/XhGWKToKJf+deAihW7QXvFDeYp75aNXAPDLS0p8pNiR+l4H+qfgC
         1L8/QuPPUlszG1+VO3fnsdkM9xIf2TeSMFSGEhv1UnpzESEMblVaLuDF8CaOUyksMLPj
         byiXEqP3nA+hME6WWe/jRXCnHbvT1tlNhFB5avC3VkXa7xJxdIsOcVYXgXR012saBEDM
         3FU04QUm/8aGwV9czYBGjB2SNKbJC97JnlOjvsmcIK2GiTGVX0P+DnWNCd0q68PH4fWj
         hofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVXrBloFtORkonGCujGmdgK1BPi5/BKdnl6pJMRy7hs=;
        b=K6/OjqpH1dgn3t6RLYjtoks8RPFuPDEQtfB1thKIIZM13Sp+FVWeCyFsHzao82n0QK
         JxfPxQZI9k8y02yOUri4JPAkDdRWsSyxw4hlovRhfzdG9TwV0W+4bp4TpBfT6arf7NVh
         3GQ26WdiPGwhEd4hvBfsWpwWwqCVeYNQuk6GzzCc2WEjkn88asJee0ZgU7V3Yww3Ay0F
         +D9uxGYee5xId9s9W4Rnmzdl6S4kj9bQZ0LUD/yP85TVKzcuWxZITW1WiVQDp/CHCwjC
         v3r5VOR++lyfoZD9zmYYwpqNswt8TCYe29dH1HWqta/YufiDjN+F8daGi6urnItS6Fpw
         faFw==
X-Gm-Message-State: AOAM533o1AjpE0/79YaFQjy0RNipmFU3itSdlCaba7Fn8vYtNOhfdg6r
        f4+sOJ/s7BqBm6yqHH63fjA=
X-Google-Smtp-Source: ABdhPJyi/0jnHlVtNF5gztu7grts6sCy3pvGJMA1LOCs5u3Uq2KPFjULHgxllvbbDe9Mxa8xuqXUQw==
X-Received: by 2002:a05:6a00:1701:b0:505:c49b:d2eb with SMTP id h1-20020a056a00170100b00505c49bd2ebmr3991648pfc.12.1649672540250;
        Mon, 11 Apr 2022 03:22:20 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:4376:c658:ae1e:1781])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm4886318pjd.54.2022.04.11.03.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:22:19 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 7/7] staging: r8188eu: drop unnecessary wrapper _rtw_dequeue_cmd
Date:   Mon, 11 Apr 2022 15:51:36 +0530
Message-Id: <20220411102136.14937-8-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_dequeue_cmd and move its logic to
rtw_dequeue_cmd.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 34 ++++++++++----------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 959b69be5..06523d919 100644
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

