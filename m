Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0823A591FD1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiHNNCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiHNNCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:02:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E362DB496;
        Sun, 14 Aug 2022 06:02:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4736337pjf.2;
        Sun, 14 Aug 2022 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=ALtpbVvXUPxMNMedagoUCg7KNZgTd9ARYDAZ+N1wtts=;
        b=SCTv+sEDkCe4SCFoxoGASblFTl84qe2+qDfQ9jX2m0/BI0XcFVw0kS5Rltf1jEH7SP
         NZSgXHHOn8omzrWM8VN0HeQIxewrAUMM9asG0XWBXOb6lJHU3FvqelMteLO4DrFADWUU
         ArvHQWq4mmMDhiFwpBkp9m6bT+hmI0HtkQx3H+vlcnxr92KapL/LIc41hZIHVEuicEj8
         0LJS6Ujai7KxloRpE02cYubzFqEfKdY9sxp+d961namo7KAClxJUk4ZLwCXI+83Fy5SK
         TfEv9qCJJk4PsQgEc3mJ02YcYYvimbqO/JyxK/qrkeZtMzqASAN0UG3/CbQxGb/ZyQmC
         HSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ALtpbVvXUPxMNMedagoUCg7KNZgTd9ARYDAZ+N1wtts=;
        b=ltokvWvOBbUxhJTJGnXodz5nRhC7lr+XlE7YmDjrSBugn6NuDP4EzWDTLeDUFadbQP
         n8wcxF445nqyN7GW+fng83oSO69ssz6L4Co9gaBoqZvcKjF6XpH1WX7Q2yfvQTdo5p4V
         Tn4440QrhOd1k8ZkQxnqQ5r/gYOqk4TQR7Fp1R4KVlgFZ+j5G8nJZYJWrZSYXyF+G7FI
         ZAlJZsG2BSDsFMvYjpxaEoiSTf4bAs4/M+l92bRLxDE7AFK6i3iBepLYEvE6RwcgXsDU
         mtoRvBt0QbRZpUshA8jrF6v59WD3R512KdyPr7pbSfMZ1eRgaNIXFDX8kC776XHe24+U
         RPlg==
X-Gm-Message-State: ACgBeo3IqKlfBqf0OW0y6dfS+aDuiU/OqiM2cbQltqdDEvTU8Spkv90O
        c7JJMLdRxBnFyl55x2ogOi4=
X-Google-Smtp-Source: AA6agR63n8XDi0DcZnX/nrYDD9eWBT4WDBiK7bUOWMb5ovqe+0pTAjrhL9VqUPsONtbDEcgzaHJ4pA==
X-Received: by 2002:a17:903:41c4:b0:16d:cb15:290f with SMTP id u4-20020a17090341c400b0016dcb15290fmr11975573ple.47.1660482129385;
        Sun, 14 Aug 2022 06:02:09 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090a70c500b001f23db09351sm3028152pjm.46.2022.08.14.06.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 06:02:09 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     jesper.nilsson@axis.com, lars.persson@axis.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-arm-kernel@axis.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, 91tuocao@gmail.com
Subject: [PATCH] crypto: axis: artpec6_crypto: move spin_lock_bh to spin_lock in tasklet
Date:   Sun, 14 Aug 2022 21:00:54 +0800
Message-Id: <20220814130054.6444-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is unnecessary to call spin_lock_bh in a tasklet.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 9ad188cffd0d..b4820594ab80 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -2091,7 +2091,7 @@ static void artpec6_crypto_task(unsigned long data)
 		return;
 	}
 
-	spin_lock_bh(&ac->queue_lock);
+	spin_lock(&ac->queue_lock);
 
 	list_for_each_entry_safe(req, n, &ac->pending, list) {
 		struct artpec6_crypto_dma_descriptors *dma = req->dma;
@@ -2128,7 +2128,7 @@ static void artpec6_crypto_task(unsigned long data)
 
 	artpec6_crypto_process_queue(ac, &complete_in_progress);
 
-	spin_unlock_bh(&ac->queue_lock);
+	spin_unlock(&ac->queue_lock);
 
 	/* Perform the completion callbacks without holding the queue lock
 	 * to allow new request submissions from the callbacks.
-- 
2.17.1

