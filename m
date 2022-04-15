Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6645025D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350762AbiDOGs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350716AbiDOGsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:48:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB937B0A51
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:45:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k62so591403pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouz4DgKg6HX7//LGRrUD97CctBPhdyzV/9EeFTiygxk=;
        b=gMCyNTTL33kI18vJdBqOu9Mcm2fImvGdxj+ka3vkQktHDiY/CK6mvTSSga/VonfgCK
         G2yDrY4zAQ73dGXaCnliYP1Sy/I4SgZ0iyzTWjhjjHSEigW4fxdNA2tP2Wf0uxbksfhX
         cBHCROmEIoL5iGVlxzgLAUEjeRiwP80HJL4kjIiu0Ul8xGUMQGmqpnFWq7dE7QrLdKSO
         69iqyiKk38F14+E73N4tvDHBGN2U4xpNoI5fXGuTfLl7tLH4+PRaN5ohLpVXe45yFSXv
         GER/mPzklCwMsqFB3YjPtmkoDrHVR4kVx5qMb1cFyLLTHiTjMubqehbQDnte90iuhh6h
         Bb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouz4DgKg6HX7//LGRrUD97CctBPhdyzV/9EeFTiygxk=;
        b=XmdMc6U9Zi0nShoSjmk6y8Wj3f0Dy2bjCBjrDPhcHgy1nHlo+2mPpg1QzTQmUn0UA+
         tGhr+GQvPSt1aUo5p6JpDwjNKaMMe2UlqupwNmLoqQMMW9jD+xqXds74yRMxU7uwjFW+
         1Wwpx8Mq1atbFHv2do1Mk1kJgh8ZSJkO1/8pwR/nNjJF5CGvRzVF5v4Ge2OYe9OLOx+h
         3ZO/Xz9+ELOsjzhU95Do41clRa/5xYlZaua+F+LgpQTIXLbr87gVZYplxuczS144QWnV
         TRCCXMCPxLJhgHfV7yZy5nItMjXOpP4QpsUiNYIp82XrTpxUq6ojc0jBcnQRuTLEF2AL
         iy0Q==
X-Gm-Message-State: AOAM532UOn6T6721r5WCF8Y0StmRjcpdpCSQm4qbKEYt1ceWXaOJwTtI
        gK3gBD9ufZVjPTjrFaw2npWpuw==
X-Google-Smtp-Source: ABdhPJwyfNEEO9oK4pBktYn2c0uxMeRu2wWbIGD1BpxdATL+9+KfkFN82SS1+bpSVF2rQMXvUC8AAw==
X-Received: by 2002:a63:6a88:0:b0:398:54fb:85ba with SMTP id f130-20020a636a88000000b0039854fb85bamr5311202pgc.88.1650005132521;
        Thu, 14 Apr 2022 23:45:32 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm1867385pfl.15.2022.04.14.23.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:45:32 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net
Subject: [PATCH 4/4] virtio-crypto: enable retry for virtio-crypto-dev
Date:   Fri, 15 Apr 2022 14:41:36 +0800
Message-Id: <20220415064136.304661-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415064136.304661-1-pizhenwei@bytedance.com>
References: <20220415064136.304661-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

Enable retry for virtio-crypto-dev, so that crypto-engine
can process cipher-requests parallelly.

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index d8edefcb966c..5c0d68c9e894 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -62,7 +62,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
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

