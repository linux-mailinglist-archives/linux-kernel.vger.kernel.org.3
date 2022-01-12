Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16148BF78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349092AbiALIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiALIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:05:51 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F135C06173F;
        Wed, 12 Jan 2022 00:05:51 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id i8so2211116qtw.0;
        Wed, 12 Jan 2022 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rN4LDWU6tXCEv6IijFOaaBHYyKxeOQv4sHOZiQzOxDY=;
        b=glEfc8ex5j5UFU0BrZAfzsXYde3C6nO2oxsT/HraCurQ5eRiKUge5akxpiclI/Q7yp
         bLmP7YSDIScWnaiBwrYZvhauKaWHeIv2TX9josJ7W9ERnYIBJ9GYM4a2DdTVg0v+uqja
         W8s9nU3gn/3ZaLbjM4SHJfxV/GQ82DQ7XR6x4iWbax42TMwTJp4Bt88TEsLX7/2QGxSe
         g2VbQ8c9y1g1V83nPL12/qhy/T8hPfyyICrGyEK2FmwvCJcFWmGV+FPtf02JhXq2wBwP
         0v8xaVhbQT8uUueKJYqT1LQUfGjzzuKC5fJGNsZmQQbDvZeXKUwBR9CWAyMejBwNjktp
         GI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rN4LDWU6tXCEv6IijFOaaBHYyKxeOQv4sHOZiQzOxDY=;
        b=R3BQa68wdTc9KqZb/hTlBaqUlYNMd0YBXpy7iYRxSE9zjiHL082ZLisBCQS1oeH/RU
         7QB/kNN2p2RImedq5RH5sjnCUntYWXSoDAQVq7tZg4gP/k6e5cll/mOI1k51NOPLlfyv
         /9VRNQpRHbl94C0tjgUD67wPcNl0LASyaDau7dwZn3OC+8jyrP/EUSyzR5+/pLJR6BqU
         Y/F6Eea6CRsC/fina0o8Asv7fBWpLJiSMVZOzTp+XpY2D3qlu9qW/xMy6BPG0P0QEJl6
         D/pSn1dJCThw0/XVW8qTIeglhqQODJx7crwr+0AB/G7Ns5TVOrgA0HqDtC3ACFnTZXgk
         migw==
X-Gm-Message-State: AOAM532jJ8KKZET3lHdG6qxk2BsZZ+XGl8an0R6IC0qO1jdL8YO48uJ5
        X308oeymTdyDPSSmyQYj41s=
X-Google-Smtp-Source: ABdhPJxtUsuMKdoZ1s+j2DVuPzfTAEkPkqjkHNG8ZD93Ft3f3I0kNAP3qj35sL+aCPN39YOSK1Iszw==
X-Received: by 2002:ac8:7d08:: with SMTP id g8mr6723143qtb.573.1641974750657;
        Wed, 12 Jan 2022 00:05:50 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t123sm8071535qkb.135.2022.01.12.00.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:05:50 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     thomas.lendacky@amd.com
Cc:     john.allen@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/crypto/cpp: remove redundant ret variable
Date:   Wed, 12 Jan 2022 08:05:44 +0000
Message-Id: <20220112080544.667129-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from ccp_crypto_enqueue_request() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/crypto/ccp/ccp-crypto-aes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-aes.c b/drivers/crypto/ccp/ccp-crypto-aes.c
index e6dcd8cedd53..bed331953ff9 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes.c
@@ -69,7 +69,6 @@ static int ccp_aes_crypt(struct skcipher_request *req, bool encrypt)
 	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx(req);
 	struct scatterlist *iv_sg = NULL;
 	unsigned int iv_len = 0;
-	int ret;
 
 	if (!ctx->u.aes.key_len)
 		return -EINVAL;
@@ -104,9 +103,7 @@ static int ccp_aes_crypt(struct skcipher_request *req, bool encrypt)
 	rctx->cmd.u.aes.src_len = req->cryptlen;
 	rctx->cmd.u.aes.dst = req->dst;
 
-	ret = ccp_crypto_enqueue_request(&req->base, &rctx->cmd);
-
-	return ret;
+	return ccp_crypto_enqueue_request(&req->base, &rctx->cmd);
 }
 
 static int ccp_aes_encrypt(struct skcipher_request *req)
-- 
2.25.1

