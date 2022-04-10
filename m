Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCBC4FAEE8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiDJQeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiDJQeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:34:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA711142
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:31:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 12so136390pll.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yu+DOzbMStngixhP79yoddJQGuRy4inbocK2zOrcGto=;
        b=pCBhWJqmkG0mgoQPc+uUcPxA8D+8AD22e3F3/BZ25oBw6cCRjlJk7ImQxzrRG5L1px
         +qlffMHhPNyftxtKIRaokWzKVYSSCWsB2cThwTDKaIV4xx+6RoZygWbogU6DLrUfRcJG
         54uQWXnhFcoAB1Fj8VBRGN99O4qv1Tbl6K7rvxiIsn8E7kUK/MSpmBY5bgp1xZU7IsVd
         zu3ZhOAhaBKdlos3Fh1Hi41ftSfH0S2PS84uISdkZJ+taXlQ3udZ6WHQV6ZslZVk9Zqh
         NBtwMb1pzJae+DUoT2HtZK61UHz2kSmF+gA5WNK4XyHfo8tOIJqIwqBIfkGmojkJnseH
         J22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yu+DOzbMStngixhP79yoddJQGuRy4inbocK2zOrcGto=;
        b=BTd6nF9s1Jzp9CS3Jedgd+7U6D9ZRDwVK4q/zUjT7IycAI0Cb/6dbQer2sczfkkPm6
         34b7uBM0MB3bUa9uFA6GpVVAsoU2rubXw1F3j9d/Fm91UTOSEzq6KHYyRuR4MWkqkX9c
         rQqzF22ejDR8LH7sckavv3mrlaVEhOaCouQFxKl5C2vHJNpWIGdlFQHOP2fxoLyqsYha
         pJStrRep7kW2i5XtMJ0QA026YJls+vej1KUkcc8YqklA6Gd5nQCBGX6/DT/G+Nklj8Yu
         DDGexdstZxwcw6vLc6h2qISA9oqnjXhkieaFK+499vLMHRvnpWwe2TnFQrnn3EklkbXC
         KpEg==
X-Gm-Message-State: AOAM5302W+0r0z2u0ge02jsFd9TK8s3ITkR4wiHMOjU+VmB57JXlfink
        HPExumm3KpJHuPfjVxDJkmo=
X-Google-Smtp-Source: ABdhPJy2YFIzY4kdYR8dLnADsAt5RhTaoQDlRcF3K0qZQBq0LdjOi6dvjWhh2kjDU4gUSuB0uDDENQ==
X-Received: by 2002:a17:90a:5d0b:b0:1cb:42a7:8af5 with SMTP id s11-20020a17090a5d0b00b001cb42a78af5mr13831325pji.170.1649608312624;
        Sun, 10 Apr 2022 09:31:52 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:606b:10e4:2085:6825])
        by smtp.gmail.com with ESMTPSA id f12-20020a056a001acc00b004fb37ecc6b2sm31940021pfv.29.2022.04.10.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:31:52 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: drop unnecessary wrapper rtw_free_cmd_priv
Date:   Sun, 10 Apr 2022 22:01:12 +0530
Message-Id: <20220410163117.3964-2-makvihas@gmail.com>
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

Remove the unnecessary wrapper. The logic of rtw_free_cmd_priv can
be moved to _rtw_free_cmd_priv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 7 +------
 drivers/staging/r8188eu/include/rtw_cmd.h | 2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c | 4 ++--
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index f036a980e..4d88bc847 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -87,7 +87,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 	}
 }
 
-static void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
+void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	if (pcmdpriv) {
 		kfree(pcmdpriv->cmd_allocated_buf);
@@ -157,11 +157,6 @@ u32 rtw_init_evt_priv(struct evt_priv *pevtpriv)
 	return res;
 }
 
-void rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
-{
-	_rtw_free_cmd_priv(pcmdpriv);
-}
-
 static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 {
 	u8 bAllow = false; /* set to true to allow enqueuing cmd when hw_init_completed is false */
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 6b6d560d7..d3a20dc23 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -83,7 +83,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd);
 int rtw_cmd_thread(void *context);
 
 u32 rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
-void rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
+void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
 
 u32 rtw_init_evt_priv(struct evt_priv *pevtpriv);
 void rtw_free_evt_priv(struct evt_priv *pevtpriv);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 390d1cc0e..702e5b350 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -534,7 +534,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	rtw_free_evt_priv(&padapter->evtpriv);
 
 free_cmd_priv:
-	rtw_free_cmd_priv(&padapter->cmdpriv);
+	_rtw_free_cmd_priv(&padapter->cmdpriv);
 
 	return _FAIL;
 }
@@ -572,7 +572,7 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
-	rtw_free_cmd_priv(&padapter->cmdpriv);
+	_rtw_free_cmd_priv(&padapter->cmdpriv);
 
 	rtw_free_evt_priv(&padapter->evtpriv);
 
-- 
2.30.2

