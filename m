Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D24F4E21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587865AbiDFAKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390735AbiDENnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:43:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563653E17
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:43:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p8so11971167pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ihb0Oo6uzrJ7i7ES6RnGudcZVN/CipVYf3jNZpUHQLI=;
        b=cOtTwbNQi5IfZUAxRf50Bs1HOneUA1zU2agmrl/ioAeT0pNG68hoBDlfq3E2n5c/lm
         v8Vz/drHW7M/EqTvitrTgJprz83zD6CN8Y5ZxNedn4ZiF7oQdLiGXSPhNe0bnbhEEFyI
         GLeckXj6/jek9wnvFOTbFHCwxWPEJ6PaHEZsyqCqfB9+apiJ3mJMirM9BKGgRFqs6Lav
         862usk14tutu/G40euP+x93V7lpLIeWn/TYYAkaL/ScLPPhMjCh3tmbzRbivvSUTrpST
         /1XDrd79VUwISEPz95aoQNWKFRZxnz4QN3yFvd2ryTAUAWTeiIwv4uQU7yZMHkO0fwxm
         jZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ihb0Oo6uzrJ7i7ES6RnGudcZVN/CipVYf3jNZpUHQLI=;
        b=FPGeQwIje1XTtMhY5FvqLE/nSgEbtiTqs5jE3117tQqa64lnZM4gDaG92OPe6b47eJ
         3TvXsud99dePpCqzhzSrPqQRfkSekHFrzy2Za3eI1o661bT1TTGrIKKjlLhdZCLw7h6i
         +KkE60Z59Fjw/ryy3Qo55qSdQtHjNTtTjjD28Bjr1ucWria7Ty9iwhP1KT87rvpSC6Fq
         B4QFCfZ9rx8cr5QT3P5+nWHPanbIDAF2vtWKKq5fQOljN6Zh88lubs+NV/RnhmF8zkG3
         UXj+q6OQzIC15J7wzLjfEIyIY4ws3MH3E57FojrW9NlIsA2oDlcKrJnU1A2URvEbgbLO
         mRdQ==
X-Gm-Message-State: AOAM531xHAyUHtxSZrdPK7wyrxZMJxkvs7O304Lpzu8LTUMnsA1eQrh0
        CrLySWEkdcOD1t/6HJHXuG4sKS1Mfp+h1w==
X-Google-Smtp-Source: ABdhPJxdx0qvfGREqNKAZXchciButDkbJSdfo8FktryPSKjwwRp7EPJLapSK7+0w1ZkCu7xQo4BqpA==
X-Received: by 2002:a63:2d47:0:b0:399:53e3:5b4c with SMTP id t68-20020a632d47000000b0039953e35b4cmr2741835pgt.165.1649162621998;
        Tue, 05 Apr 2022 05:43:41 -0700 (PDT)
Received: from vihas.localhost.com ([103.85.9.59])
        by smtp.gmail.com with ESMTPSA id nl17-20020a17090b385100b001c70883f6ccsm2760014pjb.36.2022.04.05.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:43:41 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: drop redundant if check in check_fwstate
Date:   Tue,  5 Apr 2022 18:12:39 +0530
Message-Id: <20220405124239.3372-3-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405124239.3372-1-makvihas@gmail.com>
References: <20220405124239.3372-1-makvihas@gmail.com>
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

The if check is redundant. Drop it and simplify the funciton.

Also, drop clr_fwstate(), clr_fwstate_ex(), up_scanned_network() and
down_scanned_network() as they are not used anywhere.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_mlme.h | 43 +---------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 37d217aaf..3b6f70ad8 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -453,15 +453,7 @@ static inline u8 *get_bssid(struct mlme_priv *pmlmepriv)
 
 static inline bool check_fwstate(struct mlme_priv *pmlmepriv, int state)
 {
-	if (pmlmepriv->fw_state & state)
-		return true;
-
-	return false;
-}
-
-static inline int get_fwstate(struct mlme_priv *pmlmepriv)
-{
-	return pmlmepriv->fw_state;
+	return pmlmepriv->fw_state & state;
 }
 
 /*
@@ -487,39 +479,6 @@ static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, int state)
 		pmlmepriv->bScanInProcess = false;
 }
 
-/*
- * No Limit on the calling context,
- * therefore set it to be the critical section...
- */
-static inline void clr_fwstate(struct mlme_priv *pmlmepriv, int state)
-{
-	spin_lock_bh(&pmlmepriv->lock);
-	if (check_fwstate(pmlmepriv, state))
-		pmlmepriv->fw_state ^= state;
-	spin_unlock_bh(&pmlmepriv->lock);
-}
-
-static inline void clr_fwstate_ex(struct mlme_priv *pmlmepriv, int state)
-{
-	spin_lock_bh(&pmlmepriv->lock);
-	_clr_fwstate_(pmlmepriv, state);
-	spin_unlock_bh(&pmlmepriv->lock);
-}
-
-static inline void up_scanned_network(struct mlme_priv *pmlmepriv)
-{
-	spin_lock_bh(&pmlmepriv->lock);
-	pmlmepriv->num_of_scanned++;
-	spin_unlock_bh(&pmlmepriv->lock);
-}
-
-static inline void down_scanned_network(struct mlme_priv *pmlmepriv)
-{
-	spin_lock_bh(&pmlmepriv->lock);
-	pmlmepriv->num_of_scanned--;
-	spin_unlock_bh(&pmlmepriv->lock);
-}
-
 static inline void set_scanned_network_val(struct mlme_priv *pmlmepriv, int val)
 {
 	spin_lock_bh(&pmlmepriv->lock);
-- 
2.30.2

