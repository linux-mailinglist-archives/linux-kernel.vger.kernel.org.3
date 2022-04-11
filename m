Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B814FB972
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbiDKK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345488AbiDKKZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:25:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF0A44A28
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s14so3845072plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lgjywWBVQmpZrn9ZKLreOJoALlRHPio16ACwlfnaJI=;
        b=d7rxJ+WZDC/jumO0M6nhsIm/EvJFwzJlyjaIVOFxY4HjphZSBQxsdtT960isCe5iit
         K6iZXL1Vq+bP1qtBM8muP7wtGOE2jbM0pgK7d5g6hwbXyMdtJwf3o4f1GIO3sa7tAd5d
         nvw2lWVy+CtXSVi1a76Pz7tA6qmTnAdlX0oiKJ0FqWOnbPDp1mjPViotd/ICEasQHM6c
         Y9NCQYx5wlY8LGhchJofcdURg7hU6eu8982d0nLflSfIm6P2O9IFUaIkhWH3hPgtIWSg
         a6QS9DeawegMypCz3ZvxhiYktBMRl4Nq/IYmp+25x1Ot4cVNs7TTw1pFUiEcGIdw2CbR
         nWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lgjywWBVQmpZrn9ZKLreOJoALlRHPio16ACwlfnaJI=;
        b=IEWZIhCcHXbQN2f96CnluF3It6a1J0s8a59Ti3Vuz01/1AnLMNxd+nFlhH5o24XUdN
         WdSBeFPIvtc0shmFPD9II6/K11ObszjXFe6ViRhHZJbfsvkPtOW+N6wPAOjD6paRhQ7S
         FvAWUTKc1/GwKInb9NHshT50yxABYT62AyJgYWmCdJQkNegu/KsOV4Nx9oKGmNClVO37
         JHrCD58it5Nhc6kIG8D1qlJaChqF38Mkt6K8AeE/vzcETsB0I5/v4yaDfjoVs9HC0ph8
         GpgzYXNwRLZc3DcWn8q1ngSESgfuyqoj4RzMfAMTYQKWBv7EY4IJVLJ1sgRyEj3Qjph7
         B9lA==
X-Gm-Message-State: AOAM530jADbsmVB01JCXTfcddRFxQxnQpc8wwzrFKroSKRrYHlVRcoSP
        byFE9uGE/Ze0j+u9pHn6SVDZ0UdPtU4QIpL/
X-Google-Smtp-Source: ABdhPJyeaS1sxH+615n08xEVAzTOHEZPU/3I6q1yhe6Wg0OVgR5ePq0jgn/eRBNwPrt9PVkSdvsKBg==
X-Received: by 2002:a17:902:cf05:b0:156:2aa:6e13 with SMTP id i5-20020a170902cf0500b0015602aa6e13mr31406752plg.137.1649672525858;
        Mon, 11 Apr 2022 03:22:05 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:4376:c658:ae1e:1781])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm4886318pjd.54.2022.04.11.03.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:22:05 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 3/7] staging: r8188eu: drop unnecessary wrapper _rtw_init_evt_priv
Date:   Mon, 11 Apr 2022 15:51:32 +0530
Message-Id: <20220411102136.14937-4-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_init_evt_priv and move its logic to
rtw_init_evt_priv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 27 +++++++++-----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 3d1fdc852..3781706f7 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -17,22 +17,6 @@
 
 static void c2h_wk_callback(struct work_struct *work);
 
-static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
-{
-	int res = _SUCCESS;
-
-	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
-	atomic_set(&pevtpriv->event_seq, 0);
-
-	INIT_WORK(&pevtpriv->c2h_wk, c2h_wk_callback);
-	pevtpriv->c2h_wk_alive = false;
-	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
-	if (!pevtpriv->c2h_queue)
-		res = _FAIL;
-
-	return res;
-}
-
 void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 {
 	cancel_work_sync(&pevtpriv->c2h_wk);
@@ -133,9 +117,16 @@ u32	rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 
 u32 rtw_init_evt_priv(struct evt_priv *pevtpriv)
 {
-	int	res;
+	u32 res = _SUCCESS;
+
+	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
+	atomic_set(&pevtpriv->event_seq, 0);
 
-	res = _rtw_init_evt_priv(pevtpriv);
+	INIT_WORK(&pevtpriv->c2h_wk, c2h_wk_callback);
+	pevtpriv->c2h_wk_alive = false;
+	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
+	if (!pevtpriv->c2h_queue)
+		res = _FAIL;
 
 	return res;
 }
-- 
2.30.2

