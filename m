Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5002049D411
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiAZVFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiAZVEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:04:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F95C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r126so556033wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxtlnkkXzgY9MYBwxijbABK2S3Zir1EPcNhEeIERW3k=;
        b=uVMO09/XOuXmt4x6PARdjy4vvpLXI1ZXFgAAaumTVy2NmU1V9Si3lx4byYIB3x7chj
         08qFPwH2UMUkXhDW5u4nBlrpLnp9pJ5dKEJRvTCu5PlK24n+cqMnrU1o2WPb+NzFb3Vl
         sGcbk/v5Z3EN1mJu2s8+S0gzCNlEQNLja4JS9JsNNN6W+KCkLOPDnOl8dLK9HRLp5HJq
         IEIX7k6TCn8B/7LseEBCNhhkj9RLE5ZhE5GJOmvu5iBtjGO6ObKMmENvmsLW3Q5c0lZb
         3l24cLpAD2OWv0E3s/wj9x85O/+hfBZdd7q9//l/qodAgHe2kl7Exi/VFCBjTsTVx9tx
         Es+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxtlnkkXzgY9MYBwxijbABK2S3Zir1EPcNhEeIERW3k=;
        b=gkLDTZI9pmY25+t8u219sPbji4Q15gR1985etLT8bSiJ01EgmAF0SUpl5Zb5THA3Gn
         5BiY4oBSam5iPcYUEkvfJAtisZFPowqg8BwmcDTD3KTivk71J0JIbGu4Xjczv80xq4Gb
         tyq7SW+a/8Iyc4xynaYawXuLUod4Y5w0n4/HccmFrNp4AkUy1tmPsGDsgctetwQMQB9E
         vxOKGrsCrdNsnQhd9PGh22ntvNwoLF7JOHgYjbbRMMYNBZDnDP5MMEGjYXsMT968zhjY
         /UFh+Lho69vBDBAgujrmKnOZFh2wq7p8uJ+ZGgRKAxFUMaMcJsuaIXWFhotGTd+f7pWI
         i6WA==
X-Gm-Message-State: AOAM530CcilVha6HvKETzKfjSIjsCPIAYYBTIR4jifQpwUBQdQCeCp4e
        T3UfG06SQjhjEKWB5t85m+lefA==
X-Google-Smtp-Source: ABdhPJyp6AGL1pT2Yn3YZ1lp/S6Ybp9E/UyigNbrZETxbAsiW7nMj83b0b2T42c9NT/o4PKPzyokVw==
X-Received: by 2002:a05:600c:35c5:: with SMTP id r5mr435934wmq.195.1643231092344;
        Wed, 26 Jan 2022 13:04:52 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j19sm4948611wmq.17.2022.01.26.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:04:51 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/8] crypto: sun8i-ss: handle zero sized sg
Date:   Wed, 26 Jan 2022 21:04:36 +0000
Message-Id: <20220126210441.3661782-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126210441.3661782-1-clabbe@baylibre.com>
References: <20220126210441.3661782-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 3c073eb3db03..2557bb3fe7aa 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -379,13 +379,21 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
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

