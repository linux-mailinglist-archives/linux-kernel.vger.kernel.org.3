Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9D50602D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiDRXUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiDRXUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:20:49 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FE923BFE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:18:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f22so1913488qtp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlRd4j5md/1GciWxxdILk90+l0dQrFXO0akgvKuGKys=;
        b=hOG03vLUq3iZ50ueHjZVfyhoguvGmU1Wah3UxbLvRBUMDP7zKkkkBuYjd7CwcdDpmd
         wvvPtX/TM+hZxbHCcAAw7kNp7MW8z7+1X6+Xn1Ap+JnbWmme+Uhk6SUloc93MCqSiBSy
         dPQSoaoWybf/RQ5HVgmoPZD+Gdyrau6flv0MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlRd4j5md/1GciWxxdILk90+l0dQrFXO0akgvKuGKys=;
        b=Aa2S6gImFyYhkzU2Yev1LxwAgGgaag/wXBtrEeZ1VRhVJ/Y1+fsgLFiBTXlHFspyQ6
         ANTRoQSqM9R8Nn9diNQGxSQK/LSFovUF0Zkl0mnGD0uZT+CSkivpPNu3ODpIMgF8HaUr
         XaC5Cbv0yc81uNZzwty3kxswUzQj/JtvblC74Dcz3qjjuqCx5akMNnHqLFSNV6fs/CrO
         VS82VX7a9zrSkC+f2gnXPXUN/coNWRkBwBBmeKXOullDT4lZZBC0/m79/aZD8GErXlBW
         Rs/9mmuxZgMaTYjS5Qj1GstWqN2mRhNv1D1j5yOWcTOzetwuOn8XGSv+eu8bFtUd24NQ
         TkbQ==
X-Gm-Message-State: AOAM5316P6g+TEzUjJXA/BH3mG5iGzGgZ0K+af/9yyWSbzJ4Yr1CNvG7
        /6NX5Oxeg51/Ffxo8sKf8cgGVQ==
X-Google-Smtp-Source: ABdhPJz4CCSb9zYc5fCCMVLbVMjPO5dyAl5MissvY4yDiiQdYIkuU7OrNjGBrPyf5pI+AKWPBQ6/zw==
X-Received: by 2002:a05:622a:40f:b0:2f1:f97b:7519 with SMTP id n15-20020a05622a040f00b002f1f97b7519mr6638240qtx.391.1650323888201;
        Mon, 18 Apr 2022 16:18:08 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f17cba4930sm8214048qtx.85.2022.04.18.16.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:18:07 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Aashay Shringarpure <aashay@google.com>,
        Yi Chou <yich@google.com>,
        Shervin Oloumi <enlightened@google.com>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH 4/5] net: atlantic: add check for MAX_SKB_FRAGS
Date:   Mon, 18 Apr 2022 16:17:45 -0700
Message-Id: <20220418231746.2464800-5-grundler@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418231746.2464800-1-grundler@chromium.org>
References: <20220418231746.2464800-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enforce that the CPU can not get stuck in an infinite loop.

Reported-by: Aashay Shringarpure <aashay@google.com>
Reported-by: Yi Chou <yich@google.com>
Reported-by: Shervin Oloumi <enlightened@google.com>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index bc1952131799..8201ce7adb77 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -363,6 +363,7 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 			continue;
 
 		if (!buff->is_eop) {
+			unsigned int frag_cnt = 0U;
 			buff_ = buff;
 			do {
 				bool is_rsc_completed = true;
@@ -371,6 +372,8 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 					err = -EIO;
 					goto err_exit;
 				}
+
+				frag_cnt++;
 				next_ = buff_->next,
 				buff_ = &self->buff_ring[next_];
 				is_rsc_completed =
@@ -378,7 +381,8 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 							    next_,
 							    self->hw_head);
 
-				if (unlikely(!is_rsc_completed)) {
+				if (unlikely(!is_rsc_completed) ||
+				    frag_cnt > MAX_SKB_FRAGS) {
 					err = 0;
 					goto err_exit;
 				}
-- 
2.36.0.rc0.470.gd361397f0d-goog

