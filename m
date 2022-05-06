Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC59951D8E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392376AbiEFNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392450AbiEFNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:25:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523F69CC0
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:21:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c9so6712725plh.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snAq8vOceBJQXNtHaQrKZKIzrWkN2Ytbsg/b/TMNKmk=;
        b=RcbJboymTfiVvIkRHCgMojUfl9bLvh+A2nG+XBtgmx0u4q3MuN7jucM7/yuVKMzlwh
         UnMU2h/tV8bvG7ApiCvCmir6sodCeLyONGmHHscGkU0RofG2yjBLERzmHarv3zKNdn3c
         W1qDNbeb8vuDdLXbyGwpLxh4as5TGCG+DtP5oGtMuiJwcz9+Ocnj6sZ9xOBb211wgbSW
         lsRhEZHd8CZ93wsB7gNlHbWHuwdNKtEIzUYtmdB/cxqBRweoDwfSlHs4aj/ZF7ZTmad+
         TDCC2YheRyFnYFVnvg1YVHCxdu5HESG/g1d4BiK1Ixu56OjuAOLXVlpoBk9MzY19DPQI
         qzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snAq8vOceBJQXNtHaQrKZKIzrWkN2Ytbsg/b/TMNKmk=;
        b=PV/ihsG/eKi4WoKvZAISF1Rjt0QPYa6op1a/isOedTY0euxwEZRogFP/vRl9k+yX7/
         qOiedaFdg761z7QaWgt8TerABHQuAPsKlFozpSNVgVU1EAEmd1AJdqFFatZ1/8IW6ksM
         6AryvKEF9vpDf0fcBGXJsdIzX1qfHaPXvhpYMTNHVn/T5sfzY0xI0hFSsApfecoa0sC/
         XNRqLQDJX+Fv+Y8ySowdLyBzdVpQ3HibaG9xb05DOA16AqnIfGxfjgrn4O4IT/8nfSb/
         pSMGoQ8l/bvHmFq+4+0ROEajEOo32NJDWcn5KRf0KKIsH22HhhIa4pmln01A572cYhG9
         3Jzw==
X-Gm-Message-State: AOAM530pST1tP3Rl+0lw4CiE3uXDlJKy953cFlFXmcnbTnFCAccEr/d4
        G0gmL5ft5JMpXXHlGJI0rG/zgw==
X-Google-Smtp-Source: ABdhPJyFm1OdK877ATfQ8sTTUFDzZf6kwJX19vO8QKfl9vfzuJo5UneDBXKKQgQprvUGJ1o25mQvVQ==
X-Received: by 2002:a17:902:8605:b0:15d:10dc:1c6f with SMTP id f5-20020a170902860500b0015d10dc1c6fmr3781372plo.4.1651843277875;
        Fri, 06 May 2022 06:21:17 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id i22-20020a63e916000000b003c14af50643sm3256986pgh.91.2022.05.06.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:21:17 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        pizhenwei@bytedance.com, davem@davemloft.net
Subject: [PATCH v6 5/5] virtio-crypto: enable retry for virtio-crypto-dev
Date:   Fri,  6 May 2022 21:16:27 +0800
Message-Id: <20220506131627.180784-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506131627.180784-1-pizhenwei@bytedance.com>
References: <20220506131627.180784-1-pizhenwei@bytedance.com>
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

From: lei he <helei.sig11@bytedance.com>

Enable retry for virtio-crypto-dev, so that crypto-engine
can process cipher-requests parallelly.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 60490ffa3df1..1198bd306365 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		spin_lock_init(&vi->data_vq[i].lock);
 		vi->data_vq[i].vq = vqs[i];
 		/* Initialize crypto engine */
-		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
+		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true, NULL, true,
+						virtqueue_get_vring_size(vqs[i]));
 		if (!vi->data_vq[i].engine) {
 			ret = -ENOMEM;
 			goto err_engine;
-- 
2.20.1

