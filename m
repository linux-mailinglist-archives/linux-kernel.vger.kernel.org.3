Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9234DCFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiCQU5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiCQU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F71544BF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so3804140wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mu9PNXccAJdhVTexskBbnqVFS7DSWYIvwlxUPxT8X/M=;
        b=20FqSq7+Gz98jUhIdLLoZKY4NQ4nwWdB2FhOdxY4KWxv2Oty4wuU1LzfpgHH32VYrP
         fwhyeMoyXMGQO10ha//eGEFRjCo00OKekoJn2xTX/Omr3n3HhhztcKsVxQTZOxLVj1mN
         BhwAFc5mTOvNF3gN2VqrSDZ3qKycRhHyS6Ov1k/ibiwsd6anmqbbpVaEf/mwaK+o3EyA
         qZE1eCTa1NXz8YZDDGTVaay6NewAnXN3sCRd65ij1xwFV5QlSyCdn5BzHBhWymaEq6DQ
         HO3ZnSH+Kyi5f36IETcEB7sMOHdnMYriahS65OsRs5XEdRALC8faNwXPi6r/E9eXMQ8o
         xUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mu9PNXccAJdhVTexskBbnqVFS7DSWYIvwlxUPxT8X/M=;
        b=EPEEgAiCKAEIfFO88Q1ETv5qviNUztD+ww7E+3PTWYYuC3XT5Lul8uCglFkQ1tTPnJ
         38VuoJ3xzYiqXqMkm2jPtLLiemTYnPt2ha/NhcfCyoh0mwrzrYMWAYzglHd2iS0VqzZT
         rRP8k5hewlH8UoWocm+ml5+VKDjzgFLE2e90GVNl5TQfretDTI0W4X3psTpDmGwwzVVe
         mUvfNhPer+bEVj9ARatvnd40tkOdDAMhq6EE3hT/ywJOTKxSOpnknIYb2hwWtodJBVAf
         Y1j5ZdOlgy6xM55YYZA1aANHx+roFUMDgO7GGjRzdvaZkP9MyMA0eZ/J4Ezl2NfEoFaH
         23bg==
X-Gm-Message-State: AOAM533unbPcedUuxjXCJAjNed1x0HmvtBYvV2hXqp21lD6ABJRT+L0W
        T75tsrUPhvpSChSlyLFs86xIUw==
X-Google-Smtp-Source: ABdhPJwPCZcP/c7dsS44hNuURWEY5qBz3XyOo6LK/OCQ/ZdXbIYkZNYma1Wjm/vCLxwccdX1oQGzCg==
X-Received: by 2002:a05:600c:651:b0:381:3d7b:40e0 with SMTP id p17-20020a05600c065100b003813d7b40e0mr13220460wmm.17.1647550575007;
        Thu, 17 Mar 2022 13:56:15 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:14 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 05/19] crypto: sun8i-ss: handle zero sized sg
Date:   Thu, 17 Mar 2022 20:55:51 +0000
Message-Id: <20220317205605.3924836-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317205605.3924836-1-clabbe@baylibre.com>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sun8i-ss does not handle well the possible zero sized sg.

Fixes: d9b45418a917 ("crypto: sun8i-ss - support hash algorithms")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 1a71ed49d233..ca4f280af35d 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -380,13 +380,21 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	}
 
 	len = areq->nbytes;
-	for_each_sg(areq->src, sg, nr_sgs, i) {
+	sg = areq->src;
+	i = 0;
+	while (len > 0 && sg) {
+		if (sg_dma_len(sg) == 0) {
+			sg = sg_next(sg);
+			continue;
+		}
 		rctx->t_src[i].addr = sg_dma_address(sg);
 		todo = min(len, sg_dma_len(sg));
 		rctx->t_src[i].len = todo / 4;
 		len -= todo;
 		rctx->t_dst[i].addr = addr_res;
 		rctx->t_dst[i].len = digestsize / 4;
+		sg = sg_next(sg);
+		i++;
 	}
 	if (len > 0) {
 		dev_err(ss->dev, "remaining len %d\n", len);
-- 
2.34.1

