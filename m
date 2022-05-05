Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B617C51B5CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiEECYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbiEECYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:24:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F049C89;
        Wed,  4 May 2022 19:20:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fv2so2889762pjb.4;
        Wed, 04 May 2022 19:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNxRZjPsLxGtvu4jqqbMJl1peYsf82mPfHpY5Wt/9NM=;
        b=U7of+IyeNWIoWfwrDy3FFvAGacCPeD5+Yq3OyPIZVOxmpzNO154UkJP5mzG7PXbhMv
         Ial0ITVa67FRkYqGTvyh27Yxo0Kg5eJZXFLqNsokgvLBO7M2MlLTuP1cgq00EK8h/tON
         K86HqvTq5/X2sJbli7DT7tJ+hoPxI1pL8cb/qJCd4VpmlN7jg6v6Xbv3ivvbUxeC9r6g
         oG3D3opiSUjc6OMZbIsc0eBcQU2HuDz4icNlmQZHGwjtAdAFbdOfXOXx4KtDCBd2N2jt
         x9IQX/PhhNhw2DoR5o7FQXkMPk0L5Yj6IV9XXdstD0eyJBSEAW3MnCAMjNpP1q84VtkA
         LHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNxRZjPsLxGtvu4jqqbMJl1peYsf82mPfHpY5Wt/9NM=;
        b=cewlzybC6cvme2TcChGRMDoSso9LLNsyuOTBObcRC5yfwW7abW6xw5NZvp5qgMAepN
         hn93LSZuDqWIKY9X5cTbpbAnWBls4FOY7RmZZBwXNAVg86NMdkBGfsTzeuZRdXGWQKeW
         isCm3dRr1hs4p8J5ZhSaPWiBpS9nSRv3kUZVUMi/VYBZnRX2yB3cDzmCFhs7oLdAbiWV
         ADNjltsNCFfE3pN8luvfKorIcvvwCQ5sPUVuHFUyp67ise0mseE+qxslhSzytPN9RiwA
         n3pv/QGZruyWr6juf26ugv41rIw/vw0VIB50D0mW2fX7F+5VUZ2EF64UcsaiVumEgzZ5
         eGSg==
X-Gm-Message-State: AOAM5317FMD+I6pR5w9cuHw2dZpmqdSi8QO2/kk5Ia7XLhbWmmMPHSJ0
        bVoVBjNpXB7jMIPDGVbcCPQ=
X-Google-Smtp-Source: ABdhPJxxkplJqxShrGBVhiiwV4wDAmTzqef/PIHgbEK/FxkOV4pp1Kz4V6oB91OzUcUhTzAp2ZHjOQ==
X-Received: by 2002:a17:902:ea06:b0:15e:8367:150b with SMTP id s6-20020a170902ea0600b0015e8367150bmr24274391plg.167.1651717232671;
        Wed, 04 May 2022 19:20:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090ac98200b001cd4989fecdsm3943686pjt.25.2022.05.04.19.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:20:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     bbrezillon@kernel.org
Cc:     arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] crypto: octeontx2: simplify the return expression of otx2_cpt_aead_cbc_aes_sha_setkey()
Date:   Thu,  5 May 2022 02:20:24 +0000
Message-Id: <20220505022024.54586-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index f8f8542ce3e4..67530e90bbfe 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -896,7 +896,6 @@ static int otx2_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 	struct crypto_authenc_key_param *param;
 	int enckeylen = 0, authkeylen = 0;
 	struct rtattr *rta = (void *)key;
-	int status;
 
 	if (!RTA_OK(rta, keylen))
 		return -EINVAL;
@@ -938,11 +937,7 @@ static int otx2_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 	ctx->enc_key_len = enckeylen;
 	ctx->auth_key_len = authkeylen;
 
-	status = aead_hmac_init(cipher);
-	if (status)
-		return status;
-
-	return 0;
+	return aead_hmac_init(cipher);
 }
 
 static int otx2_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
-- 
2.25.1


