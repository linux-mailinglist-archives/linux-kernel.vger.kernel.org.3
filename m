Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787814C3F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbiBYHrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiBYHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:47:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53C512743;
        Thu, 24 Feb 2022 23:46:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i20so1138018wmc.3;
        Thu, 24 Feb 2022 23:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZJz7ilUAFhZB5h3mtiWNq9VmQAi0QbvNYr3itVvsTJg=;
        b=MKzfemHIAI0oomIvEWcUKAgmDE6r7RBjTwJzbe+j0Ek8LD7Tn6ZSnH5ydbe9z1kws8
         evFnTEVrBNvbhVWGmS/yGPxG7ukcgthwVjVD2ZTt2nQQOf6InMQ81faemR2egcNGglCY
         Dc5zf42rdJjIUykqqPyNiX7P/ka0HTyv0WdMoFIn8mRZDCc9bTm8qYpgr0GYcH54Bdw8
         7jGcH6G10nfRF3LpfErIA6GcgGmoHmJzizPZDcGwYk/zzePWNI6cAzEdo5h4nRVXNNUM
         RMR7OiFS9PluJzDRz1dGIUcgNxTUMZH83CyRbbya4XSHF62Poq9Z0Fm35FUfz8DP4fXA
         5t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZJz7ilUAFhZB5h3mtiWNq9VmQAi0QbvNYr3itVvsTJg=;
        b=PQUKJJmsus1upUp+7Td810jcAjhBpPDH7an4FMR+O5ap8RekNviOveaj2dTL6LZFur
         pafLpX2et1qpn1Hh1BsJ6k42NStECqnW62GfF1VFafU/gaiFGpimrctViSKCoA2F81mJ
         iCGW6M4+7+C74eqwmC3IL/2Eg4hLdONsH4vDxorsEZOujtJgcqdgmc/6ZopIODXNumZs
         ZNGz+48rDfXhuPkH1EaROXnzNm/ZCtESiWm8QMeAsfWS2qaHCPms6LaZqhAKUv0OlILO
         iKiaEIHqggXHKZCLLWfSCw7CxQne61cKdeEZz12NueL6MGo+UVy/Lqt5roCUrPqJwMGE
         JErw==
X-Gm-Message-State: AOAM530HmO6d3UMIyaqEqPT6D+WIdL53NGaBWnt2VtlFFc3QWHMZ5Hir
        PFMOX3X1JEISZFv5O7yfDiGwukukkDUDHg==
X-Google-Smtp-Source: ABdhPJzOrUiwz5a28B3CSjYhJ6wA/4t4S2AvTtKNQ4TyvQflbHkee0hLEcY71PFDK24q/OKgZKpmRw==
X-Received: by 2002:a05:600c:2d01:b0:381:1ffb:5095 with SMTP id x1-20020a05600c2d0100b003811ffb5095mr1563685wmf.113.1645775195378;
        Thu, 24 Feb 2022 23:46:35 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5308000000b001e3139a79f9sm1448269wrv.40.2022.02.24.23.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 23:46:34 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] crypto: drbg: check the return value of crypto_shash_init()
Date:   Thu, 24 Feb 2022 23:46:23 -0800
Message-Id: <20220225074623.17276-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Then function crypto_shash_init() in drbg_kcapi_hash() can fail, but
there is no check of its return value. To fix this bug, its return value
should be checked with new error handling code.

Fixes: 541af946fe13 ("crypto: drbg - SP800-90A Deterministic Random Bit Generator")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 crypto/drbg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 177983b6ae38..51feb9538701 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1725,8 +1725,11 @@ static int drbg_kcapi_hash(struct drbg_state *drbg, unsigned char *outval,
 {
 	struct sdesc *sdesc = (struct sdesc *)drbg->priv_data;
 	struct drbg_string *input = NULL;
+	int ret = 0;
 
-	crypto_shash_init(&sdesc->shash);
+	ret = crypto_shash_init(&sdesc->shash);
+	if (ret)
+		return ret;
 	list_for_each_entry(input, in, list)
 		crypto_shash_update(&sdesc->shash, input->buf, input->len);
 	return crypto_shash_final(&sdesc->shash, outval);
-- 
2.17.1

