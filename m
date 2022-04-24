Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2CF50D387
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiDXQfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiDXQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:34:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5CB7644
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:31:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d15so7446328plh.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/noh+5Uc1qGrvG4//CeRZx4MibEjRfxJ6hoprNgkUE=;
        b=VNeRnw63/ItAEpzBOVWitrcmRTeccS46J4GatZadFJK7b0ByX4ql7Hm2dQfS4A9ORj
         9bcem5WCbul3TgJrbmgK+vC9mJbWKdLyDGLhcc9OAcKJ+RrCOp4/1/YPQXi6FyIXs1Ev
         FnGhVSeP7Q4T7PxIj64DqQjLzaxKOoTZvXaVrXBxNpDgvRWjFkuW95e36pfVpCwVp7tU
         LFVVGsQwZXJw3hbmiiyjEo4iFL83q5HbEIZBjseCQM0K34+6KYWMFH55ZVANLCJtPw1x
         pRNjbIKdfkmSkLlUrfR/J7zQt2TIg7qhXF5cuIEIdBFImWQ+o5iuHt327eix2vDo10Cq
         T8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/noh+5Uc1qGrvG4//CeRZx4MibEjRfxJ6hoprNgkUE=;
        b=R4vxd6JFoD7czNJYHM+StkEOaUNgF8JWVLMaKbSsf5xqI+EheZqj872qCzfAue91os
         tyefHirnv03/6FlCAzeFWlxIlTZpWZEqcsPpCmmDykdBJDaUmpCmomY3VbahHWaXMjn+
         sXpVs3OVjYbXqgqhd6gQlkWlP7o6OnVh5u8DZwPSQ/7a6rHuLaE3tJwmZ8oPw0yoB4NP
         E8zBy0WIQtG/twj0SVC150YKGl92DaE8HrDQNJmSJ9iOTRcS0tTakVXYY1sY72qf64UA
         Ctq/jcw9Ey0+tFzPySogRFq3qbvny9k4nrgScFaGJ4gCRHfrIHjp7UC+aWcbY7DxJ4bb
         IMhg==
X-Gm-Message-State: AOAM532Iv6ulO5ZzOTMqXcmh+iawIBZ1ANQgK7PhNJ2jxSGpUlvW5Lhl
        s2UkfbS3hJbKmwaQP0BZfvFwZfMBZVeEiQ==
X-Google-Smtp-Source: ABdhPJyZkH83VKTOm/vMgLC9ylS+tM2c+7OtyemNTH198Aozf2c2XTcDMLNYBbmXLPaYXdVUxPgBxw==
X-Received: by 2002:a17:90a:5983:b0:1c9:ee11:76df with SMTP id l3-20020a17090a598300b001c9ee1176dfmr27107739pji.95.1650817913328;
        Sun, 24 Apr 2022 09:31:53 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:b82e:45af:4bb0:4014])
        by smtp.gmail.com with ESMTPSA id i5-20020a635845000000b003aaba2d78c2sm7113472pgm.71.2022.04.24.09.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:31:53 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: fix null check in _rtw_free_mlme_priv
Date:   Sun, 24 Apr 2022 22:01:32 +0530
Message-Id: <20220424163132.37007-4-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220424163132.37007-1-makvihas@gmail.com>
References: <20220424163132.37007-1-makvihas@gmail.com>
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

There's a NULL check on pmlmepriv in rtw_mlme.c:112 which makes no sense
as rtw_free_mlme_priv_ie_data() dereferences it unconditionally and it
would have already crashed at this point. 
Fix this by moving rtw_free_mlme_priv_ie_data() inside the check.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 081c02417..87c754462 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -109,12 +109,10 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 
 void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-
-	rtw_free_mlme_priv_ie_data(pmlmepriv);
-
-	if (pmlmepriv)
+	if (pmlmepriv) {
+		rtw_free_mlme_priv_ie_data(pmlmepriv);
 		vfree(pmlmepriv->free_bss_buf);
-
+	}
 }
 
 struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
-- 
2.30.2

