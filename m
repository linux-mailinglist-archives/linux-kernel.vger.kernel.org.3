Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFA50C090
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiDVT6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDVT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:58:31 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78C20250B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:42:13 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id bi49so4308146vkb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZuIM4H3I0u7C5gWHQSYMoqDFBwcnj1tL4ssQv+FDjg=;
        b=C5zEIjuqLhF0O8OKX9K3xRWoxxaX+MOE9Ljz8iGorUw8xRiMnnoQ+N6zMUdHp+R4bz
         XUqG7zUmnB7keraNYNpA+u8FegVcu89NqRIVShyydZvHVFAJL3TzjPV+cIi0MtsfqtJm
         xCDtdDYK1ixaLhJrwfGmKs1LiHox8dQvj9mcsFEm4mYSk2efgLph5d517g9hn2ubTCcZ
         ahGV56nMA5IObW2QiQ6UuEdOmzxrHOaWbYn/bxMcw85fHfiNOBIq6Ze/C316rNCSqGZ1
         NxRkvaCrN/IvWXZOTV4bCaty8D0D+Ldsl+2ubaMG3D8dZDXuzEEY3sDXecPilgMXMUxL
         3r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZuIM4H3I0u7C5gWHQSYMoqDFBwcnj1tL4ssQv+FDjg=;
        b=FiWxfQvP5BYjDFtdUKfzQoaVbpLo/tV/2iLyyt3MOAW8JraTruaymp8g+T9u3qsITB
         heuswiBa+GACjoboOeky7YJq9oAF+kO62cu5WchXRqlsjnnlUHOCuwT/XeBXgM2Yxs5m
         JglRKVpQerNhdSbQ4jrg+KhINworK4gBsC84AkgRNj/YrpFHSVH9OWaVMAcrZFCR0iOd
         XYzLYjuGF84ISFCjxuVkhiqAWi2KGKvZ50NbF7XfUarApMxJeQ1eUye0GQeFCZXh2+3z
         U0x0x85tusnRfDmTCdegYuhvuid6RAnqRLdUYCE9i8fSGyA9Dq3T+KS/fxmfgriyQSbe
         WFig==
X-Gm-Message-State: AOAM532HDY2RKrVTd3SygJ2fRyB9Jr5OfOdxu+51A6nc3ZQSZPMiIbxe
        5UG+KlHroeWLsPvh1YWU8dud5APz0CdjfA==
X-Google-Smtp-Source: ABdhPJylTXse+Ff0tFYd/5CXjfUZ59tlKiBuN9JUvi6oAr0HbyHIegGeg/CVnJp4qYUocR2Z79wWaw==
X-Received: by 2002:a17:902:b7ca:b0:15c:df6a:be86 with SMTP id v10-20020a170902b7ca00b0015cdf6abe86mr1095811plz.70.1650655957313;
        Fri, 22 Apr 2022 12:32:37 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bfe0:e8c0:bea6:ee63])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3518932pfh.83.2022.04.22.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:32:37 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v3 1/7] staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
Date:   Sat, 23 Apr 2022 01:02:17 +0530
Message-Id: <20220422193223.11948-2-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_free_cmd_priv and move its logic to
rtw_free_cmd_priv.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ebe2479d1..32589e76e 100644
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

