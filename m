Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE55250D146
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiDXKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiDXKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:49:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973B252B9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so20774167plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhiM3AjN7OQUvaBDZQVzT5dsdkup6eI4sw9Fv5sP5tE=;
        b=voSfwnuz4TazDsGKnkLUa3eLXrQvuZd0CeBraJuFrBeSJjuo6ZZnyyZ6IVf0DMCxDd
         2jO3l101hWUMVw6fE6Q1scUwdoY55AfZrU59fgoeCmBV8NoDnheH2xHW9oOuLNYc32kS
         /Myz9unOyMQgMJYiLy50IfLa0wWwZPsTpzo+uY0oEcuxNFo+Xee80to77j8yDZ+BPT4y
         djGTubGoqSCw75gGJq5Xax5kSqm3psqt0E8BbnH2vId9AoT513Tt6AWKyFwJ+/iitQWt
         z87pqXiqtAqnUt/3mHP9bu0yoOsQRF02y/h4nYScuC/sgGnvBrK48Z2KddBDQnrw0ALc
         uUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhiM3AjN7OQUvaBDZQVzT5dsdkup6eI4sw9Fv5sP5tE=;
        b=w+THnmUIJf68FsjKSnac/T8HOtBBRHwuPUV3cRsv+T4jRtaGColaR6+3IjCZRo1wNX
         ugq+KDONhvgEpW8etFnDsmgG6ORjrvT5litbhqFaoM9UVGj0X4NlUu7wY/Lb4h1nHocd
         iXlrPUDtSRlcFRJA6DSV7TTa8J//L6BM7sKfTdRkbLX+t6pH5EjZZ+ioTm8oil4aFKeU
         XTqMfDChT472nop+dSdn9LnDjay0SvDZM0tUCVEVtKrEZuM0zBIJM0MXw4i8eMIdHgOE
         52L5+gKxz7gc1D9z+sMk4NuVn7RID9e3nOD4pVeyMd1y5AHqpMLxcckjTh23mdkMCQvB
         EFAg==
X-Gm-Message-State: AOAM531fDfQ7MITFmNKdd15lnuGWO8BkwcLOfeOXHoxxmI6We0dg2sVN
        NDvKPM48AR6DFWSKWkp4wLRx/g==
X-Google-Smtp-Source: ABdhPJxsLxoBTSXLJ8lKEHWxix35/c4WKDc8Lc+R21OTU1ppRMOI/MHE4yD26NyDYhl3/dU3YYeX9Q==
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id d22-20020a170902729600b0014b4bc60e81mr12832804pll.132.1650797158606;
        Sun, 24 Apr 2022 03:45:58 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm8287295pfi.86.2022.04.24.03.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 03:45:58 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 5/5] virtio-crypto: enable retry for virtio-crypto-dev
Date:   Sun, 24 Apr 2022 18:41:40 +0800
Message-Id: <20220424104140.44841-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220424104140.44841-1-pizhenwei@bytedance.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

Enable retry for virtio-crypto-dev, so that crypto-engine
can process cipher-requests parallelly.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 60490ffa3df1..f67e0d4c1b0c 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		spin_lock_init(&vi->data_vq[i].lock);
 		vi->data_vq[i].vq = vqs[i];
 		/* Initialize crypto engine */
-		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
+		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true, NULL, 1,
+						virtqueue_get_vring_size(vqs[i]));
 		if (!vi->data_vq[i].engine) {
 			ret = -ENOMEM;
 			goto err_engine;
-- 
2.20.1

