Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E374FAEE9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbiDJQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243603AbiDJQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:34:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA1412758
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:31:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so2330666plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMj05DlNH3/duK3OGv5ITfGzW1UwrXXvGGzncOUobEQ=;
        b=bub1+D+Fm5rOeIqLcFoKetxFrtLwdrbBPZQSSBlmveQnl1H9giDv5FUo2qL31Yj5We
         E1S+MaKLluNaBeg1FHjG9ZnqxINTdrcVpL0bFuutRoW5xVhVy4gPnBfrB0enlMO1bCtm
         IB8hQIFKnSxsQ9qOphQwYNqS/Yit3CE+Z8FqckXdUjJQ6nLteG04HsUabtvUxKXykXKp
         F4ctDaiZozvCgjBZD/JSzibH0RySCb0sS3cQlNO9CIcrfEvXyKsKL5ez5wDqEVhXIoT4
         4GE2WpBfLI1MKVV64HGOvNfLK4/GEfXTI5pIqz0iz9Me1fzOgjtgccsYG2L1eQXhU/w5
         QxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMj05DlNH3/duK3OGv5ITfGzW1UwrXXvGGzncOUobEQ=;
        b=FvGPmfrYefXkaoR1YcYRkTuqFw9naFvbye5lB5Kry4FALJLE0j0tP5cegeh+avIU3V
         I6/+nbLS/gx+1AXV1EmiEUlE7AdU1VT25TBS83fWheIXu92Rp2gNgURSOEW3lTMVPh4X
         LuwEHpIkcjUOEb2VTzpugkoMX7oZ5FA7orv6oAJ6caFvcrti8k/ckzXzc0HUJtIK9MJr
         btQUTp1Y/CT/TLXSFHVqItvl5bCg8Dba9Co9iKs4GLoNKR+KgY5y4IX1XXWGj+CQawf8
         77eVltJziSrzV/w4x6htxKbaB/+xCm7l/a+8o4V59tJvYfBNhcIf9Z0LSVp7Vuu2B1hJ
         M7Lg==
X-Gm-Message-State: AOAM533OsGNp4GnZ+krw0MUbTPCeBEhD5LKUntl7IVNEt1ZgIlZCAdfa
        Oscah79+OEuo4pHeiQRWtQqcEVBd9kvjWy6M
X-Google-Smtp-Source: ABdhPJzB2GG1qcmGG+RG76cxoMtd4oF3viTx/4NMGsMqsA/Jhw1ui1Rop9F/IKTxF9XXEf86z5wTKQ==
X-Received: by 2002:a17:90b:4c8e:b0:1c6:d1ed:f6b2 with SMTP id my14-20020a17090b4c8e00b001c6d1edf6b2mr32127156pjb.166.1649608315895;
        Sun, 10 Apr 2022 09:31:55 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:606b:10e4:2085:6825])
        by smtp.gmail.com with ESMTPSA id f12-20020a056a001acc00b004fb37ecc6b2sm31940021pfv.29.2022.04.10.09.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:31:55 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: drop unnecessary wrapper rtw_init_cmd_priv
Date:   Sun, 10 Apr 2022 22:01:13 +0530
Message-Id: <20220410163117.3964-3-makvihas@gmail.com>
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

Remove the unnecessary wrapper. The logic of rtw_init_cmd_priv can
be moved to _rtw_init_cmd_priv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 11 +----------
 drivers/staging/r8188eu/include/rtw_cmd.h |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c |  2 +-
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4d88bc847..d843e9997 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -15,7 +15,7 @@
  * No irqsave is necessary.
  */
 
-static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
+int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	int res = _SUCCESS;
 
@@ -139,15 +139,6 @@ static struct cmd_obj *_rtw_dequeue_cmd(struct __queue *queue)
 	return obj;
 }
 
-u32	rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
-{
-	u32	res;
-
-	res = _rtw_init_cmd_priv(pcmdpriv);
-
-	return res;
-}
-
 u32 rtw_init_evt_priv(struct evt_priv *pevtpriv)
 {
 	int	res;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index d3a20dc23..ab47d3785 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -82,7 +82,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd);
 
 int rtw_cmd_thread(void *context);
 
-u32 rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
+int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
 void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
 
 u32 rtw_init_evt_priv(struct evt_priv *pevtpriv);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 702e5b350..c611e9246 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -466,7 +466,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 u8 rtw_init_drv_sw(struct adapter *padapter)
 {
-	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
+	if ((_rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
 		dev_err(dvobj_to_dev(padapter->dvobj), "rtw_init_cmd_priv failed\n");
 		return _FAIL;
 	}
-- 
2.30.2

