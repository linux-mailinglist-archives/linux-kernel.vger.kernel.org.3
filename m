Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAD4BDF21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357604AbiBUMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:12:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357362AbiBUMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:09:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422AD201BB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d3so11041367wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRwXQ22zhUvx1o2PZ7ENLpRDM+5TmK2L3Q+xebz6RZg=;
        b=qmw5zddLshVBKDNx9LmeyGeFD06unJdxUalh9qYp20aANFXunS0qfedH7kKreKAi1B
         TuZ66MDF1UKDbxZfJtTct+TBv4WAKrXribxlOnzuChMAnS3sDdKtTRU18+ju9/hFQSxs
         EhLx/h9ZR4eCkZxp1ViV4aDidIOXtwLywqNfVkjll1JeohtBMUWIZN98n1+RDri/GkOj
         vLCnqS9rwSkHDW6XYSZV9Oe834ro/eJCV+XoXF40hYLL4DMMubP/riKiaLy7jIuAEmp7
         wi+n0NwOGdXFC6avheY2YvwGHhX3elgBsAo6php6McGHit+QF9Qq9ovwKve12Rs6xaT7
         cVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRwXQ22zhUvx1o2PZ7ENLpRDM+5TmK2L3Q+xebz6RZg=;
        b=s7QmV7oWePT3bn++SYS3l9xlS6xl0t+pa6TS4AqaC6P819cUtjCxrwWKZCDI8N5ASP
         3BnfxoV9MxWE/aUkSofTic7fKXDi5s5FG4KIYDM0OddCLkvCsxfFRTT6zbcxl5WVApLv
         BZmohqPPRKmbCeUgNa2uTywIe+43t906Kjgx3sA9d4YIa36wAqp2IIImhbJ4+7mhksll
         Z6+HwueHFdw2RhI0y/A2aI1Rf6RaRQMw+dfXnCCyC34vFi38ByJAY7DghdGo/n2/OLCa
         rvjy4JIwBrKGhrJbkVkSzNRuE10agOAQUUPipkXCJm8x+TrBCrqqRxP9fnP6P9B2w8ik
         66yw==
X-Gm-Message-State: AOAM532jvM9yMcDM10TOUmJy7pKcdTqlnSiD+JL5MUIZaXoKivNlb2NZ
        9D94vehPSJfY0j/x+1FpheOdHQ==
X-Google-Smtp-Source: ABdhPJy6vbpLlKF2o118HSZXUs4RfBWx6RmuHRbHpvyirVgJKBWwM1e3MmCtrMzPWWHPKMXOLsmeIQ==
X-Received: by 2002:a05:6000:154e:b0:1ea:7622:64ec with SMTP id 14-20020a056000154e00b001ea762264ecmr676608wry.600.1645445323857;
        Mon, 21 Feb 2022 04:08:43 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a8sm11821546wra.0.2022.02.21.04.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 04:08:43 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        linus.walleij@linaro.org, narmstrong@baylibre.com,
        ulli.kroll@googlemail.com, wens@csie.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 4/5] crypto: gemini: call finalize with bh disabled
Date:   Mon, 21 Feb 2022 12:08:32 +0000
Message-Id: <20220221120833.2618733-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221120833.2618733-1-clabbe@baylibre.com>
References: <20220221120833.2618733-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing ipsec produces a spinlock recursion warning.
This is due to not disabling BH during crypto completion function.

Fixes: 46c5338db7bd45b2 ("crypto: sl3516 - Add sl3516 crypto engine")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/gemini/sl3516-ce-cipher.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/gemini/sl3516-ce-cipher.c b/drivers/crypto/gemini/sl3516-ce-cipher.c
index 53e3fefb81de..14d0d83d388d 100644
--- a/drivers/crypto/gemini/sl3516-ce-cipher.c
+++ b/drivers/crypto/gemini/sl3516-ce-cipher.c
@@ -264,7 +264,9 @@ static int sl3516_ce_handle_cipher_request(struct crypto_engine *engine, void *a
 	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
 
 	err = sl3516_ce_cipher(breq);
+	local_bh_disable();
 	crypto_finalize_skcipher_request(engine, breq, err);
+	local_bh_enable();
 
 	return 0;
 }
-- 
2.34.1

