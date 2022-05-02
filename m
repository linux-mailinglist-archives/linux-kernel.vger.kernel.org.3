Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273B55177E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387294AbiEBUXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387279AbiEBUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A21DF24
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d5so20877900wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyBeaEisTTfuBdyCjdFWz6rU+RcrjfHX51t6baBS7eg=;
        b=SjEekoWNBPcf3lpiJQWJK3I3LHwV7RSSCc40VX8rmYY5qQh3xHAqc84yg8k4jN4Vyg
         sTWx1WUExcrE5U7JOuRfjunQYhS6S07xId9kB7NxwcImPY51YARBPZlD4ZFFgTLoBxJE
         Ge4M0uCN/GjxWAfFORKX59Il0yVAbSn6xDNI4Ui+6Eogcz62RKIWQ9CXKpm/CMm9J41L
         /7qetdF9qs2lKq+gGmFqKJzO3otm1KJKm1WfoNLyrKgIAd/kG8vgVVyWRmIm7S9qAqHg
         RHIpGZ57JJIz7SEo18J8nKu73LNk3SkvSrylt5sXGnHdOHO5Ytl/qPoEzSOk944jJeLS
         RkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyBeaEisTTfuBdyCjdFWz6rU+RcrjfHX51t6baBS7eg=;
        b=WJVL/KtKXEzan2IvrlVfrkhKzX290owARWXrUttVtTo+2LnAleIkuHxTN6u+dkhsz3
         QTpVEZXuqVX+ATcdyoYR98AZaNBGUEsoCEc+OGV9+W/p7d+wCTHLc4NTVUQo08kYIWp/
         X0oXFJWCegLodgDi+qy9hnlxeB/klphTRf4GVoTN70oqqeJXZxIAZe2EwWuIhpDaoCNR
         mqWzp9nsStz6e5Rg8XMU7eMNkqkxpv4SGyRSIEZU17p5i5ASoYr7hc2HqMLoGRkYLj46
         iMiYa7v92Zsv9022bSnGNvOeXNLN82D9snb6Er5T+E7J9i7T2U0X4Am6lN36755hK+XD
         LjVw==
X-Gm-Message-State: AOAM530dNCQ2O3KIqQ+VrNMdICWBFcBlhh84m1BCIM8h0nWC+PNkKLEm
        QgJfJmDKsj57/f25ZMe5VDbY5w==
X-Google-Smtp-Source: ABdhPJzU1nZZ771o9FZhdjnbZOE84F+KnOeDrsRL6QyXPle5+aSlX4Tdq0QRmYpQPEcfMtu/UKdpow==
X-Received: by 2002:a05:6000:2ae:b0:20c:57b6:32e1 with SMTP id l14-20020a05600002ae00b0020c57b632e1mr8763861wry.285.1651522780863;
        Mon, 02 May 2022 13:19:40 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 01/19] crypto: sun8i-ce: Fix minor style issue
Date:   Mon,  2 May 2022 20:19:11 +0000
Message-Id: <20220502201929.843194-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502201929.843194-1-clabbe@baylibre.com>
References: <20220502201929.843194-1-clabbe@baylibre.com>
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

This patch remove a double blank line.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 35e3cadccac2..01d032e08825 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -398,7 +398,6 @@ int sun8i_ce_cipher_init(struct crypto_tfm *tfm)
 	sktfm->reqsize = sizeof(struct sun8i_cipher_req_ctx) +
 			 crypto_skcipher_reqsize(op->fallback_tfm);
 
-
 	dev_info(op->ce->dev, "Fallback for %s is %s\n",
 		 crypto_tfm_alg_driver_name(&sktfm->base),
 		 crypto_tfm_alg_driver_name(crypto_skcipher_tfm(op->fallback_tfm)));
-- 
2.35.1

