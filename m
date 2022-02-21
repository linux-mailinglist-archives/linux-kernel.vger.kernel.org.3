Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40A24BDBED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357568AbiBUMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:12:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357359AbiBUMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:09:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC7201BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so26669054wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbukRrC7Ov9F7pBcIG9IeTY2nydApA5tOh+cl5c9cGc=;
        b=SdKLSu27cu2/hHwLhVv7Jo5NLGz2GrSxYcsgEyyOgzdrRUyITQbKY4U4C1U7WkLqFC
         qe6XvaUjxo8J+U50MFASy3E1yA0PwR15dPQnsDWRTVAC+ricUxOKvuthq3wG3aDjC6tK
         dKTfpKygLdl7yWXFNyH0r0r2OoqY6poyYz2Q1LAoIjmPuaK9OFuJBAJ79aGvmHNnaO7V
         KCLzl7lZC1NEBrYXotzVKPVaYafTQB2+4MY96hhBOrR6G4EXfebubkZlfg7Vz5DTDxCV
         PdxZovQ+CBNr264//qDUeHDh8VLnbSD7TSMK1D9etdED/q6eWCNJ04f6eI6/N5DmSQvQ
         Jb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbukRrC7Ov9F7pBcIG9IeTY2nydApA5tOh+cl5c9cGc=;
        b=ELmZUAMHwqenrTI4QzQieMdqTAa8QTwirKCQAPOx7lvm/ZMoX9gqRickZU2DT1q6ER
         WcZvedfcbiR40UUjeUCDycC+7eVNqOes0nWEKFSdq7zh9HuWrRsA7ftBgYaHRfsnCUWf
         14iZJ2fh9EZmZD372rNXNvIoudsOnZKXGWIIsYUWOW2gAz1A0etzXz7PeFVsSMkYBfpI
         cDvZpVukamy308ONNWsYDH1YAmv7Z45SAMU9M7Tae6Z2vytssBzY7PCwNkCJnG0xlebm
         TrFW9MttREXY9boajsBPWWLGzvvFSCfFyDLyKGSJ9G2cJAv3aKcMbPBAxrmHG89j5QaO
         mUHA==
X-Gm-Message-State: AOAM533h90MT8sMLwgPR3aAj25swdK1PkOHSvNvw2TBvFjQgGvvmzJOu
        jHlfLy+69QoYN140qe2Yw13j9Q==
X-Google-Smtp-Source: ABdhPJy/cSnpe98uh3pMY3LAxU5hDt1WIksiv02kviAW0TkeCF3/8ErsTgLm6Koq7SSLTrdT4sgkuw==
X-Received: by 2002:adf:f312:0:b0:1e8:f4bb:5a5c with SMTP id i18-20020adff312000000b001e8f4bb5a5cmr14695631wro.668.1645445321994;
        Mon, 21 Feb 2022 04:08:41 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a8sm11821546wra.0.2022.02.21.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 04:08:41 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        linus.walleij@linaro.org, narmstrong@baylibre.com,
        ulli.kroll@googlemail.com, wens@csie.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/5] crypto: sun8i-ce: call finalize with bh disabled
Date:   Mon, 21 Feb 2022 12:08:30 +0000
Message-Id: <20220221120833.2618733-3-clabbe@baylibre.com>
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

Fixes: 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 3 +++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 7cc496c03084..0b1ce58bdeb9 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -11,6 +11,7 @@
  * You could find a link for the datasheet in Documentation/arm/sunxi.rst
  */
 
+#include <linux/bottom_half.h>
 #include <linux/crypto.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
@@ -272,7 +273,9 @@ static int sun8i_ce_cipher_run(struct crypto_engine *engine, void *areq)
 
 	flow = rctx->flow;
 	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(breq->base.tfm));
+	local_bh_disable();
 	crypto_finalize_skcipher_request(engine, breq, err);
+	local_bh_enable();
 	return 0;
 }
 
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index fd7f1db863d9..5b6c51b78dde 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -9,6 +9,7 @@
  *
  * You could find the datasheet in Documentation/arm/sunxi.rst
  */
+#include <linux/bottom_half.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
@@ -472,6 +473,8 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 theend:
 	kfree(buf);
 	kfree(result);
+	local_bh_disable();
 	crypto_finalize_hash_request(engine, breq, err);
+	local_bh_enable();
 	return 0;
 }
-- 
2.34.1

