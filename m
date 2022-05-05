Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9034A51BC2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiEEJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354466AbiEEJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:32:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E76653B5C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:28:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e5so3215695pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhiM3AjN7OQUvaBDZQVzT5dsdkup6eI4sw9Fv5sP5tE=;
        b=7pLxwHXxcvVshGXn4uHVSVCm5smt0n8fUCsFCOFPzxzzbMx9xGwFC8KvsSw5ALEAQc
         YtSU16tQmkLgjSPzKZcLVcI5XY2JX4J8x+8n2BcStEZYz241qYt9POCYXssiCowaOCnD
         SmLvMlcKl5dnebFgxc4xwOxBqQrkvHBeuy5+jj97DytTTQWkKiwnyh3c2mgzF5/fpd0y
         cohIs8wSJ51+B9YoK748fTSvOCWCNBu1kkX9DYjIvItRZSfXb5CnAoy2CObgRC0aE0c0
         sqGBDL8LH/OF01q0pOa86ID9gEQECiLfKxnxDW4tw/9Ra+EJ54XueksS/HRBpCnq/uN5
         MqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhiM3AjN7OQUvaBDZQVzT5dsdkup6eI4sw9Fv5sP5tE=;
        b=ojbpu8GEvWoObbNKVSCqH2hX3AF3sv+4HLj1X4yMHNSiiIg1J6vy/NAac4NJ0MdTna
         /c627KI/kEuDVvVkNCGf2XGH54qwUAUm5yvC7Ci2oJo81KXyIjzHJLgZREqAlHHcEadO
         Z52t8w1If7lVr5L8XGNIPES1e93SSFWZYSMdlMve/QK5jD+iZvxStc2e93RxsJCk+5bg
         tal4VEOBN7lL7D7ovdbn0KgqL89sJJUfvWNtt4JTfIqXuYvDSHKnv0IOB768fZYZNmnu
         JLn0k4Pol8T1HdBtOaM5tTrQD6FS0PgwnayzNHmPKRsJktJ9iKrtF/CmAFj3iSveh7Nj
         MIVw==
X-Gm-Message-State: AOAM530IQ9Le5nCjwTaCJqPtmYbKaKYh4I/+OwFgTos8iZTLacY8MUGJ
        BP15I8GnO2oYiDS8VnYJkBFzyw==
X-Google-Smtp-Source: ABdhPJxfhS9sNn9cwwCynTPr683iYd3vLNFKRz6cyWRcDnnmWCepvXGvvpQ/wv+sEubyXPwG47WkRw==
X-Received: by 2002:a63:310a:0:b0:3c5:f9ba:b010 with SMTP id x10-20020a63310a000000b003c5f9bab010mr4724700pgx.143.1651742909075;
        Thu, 05 May 2022 02:28:29 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t68-20020a625f47000000b0050dc76281dcsm884224pfb.182.2022.05.05.02.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:28:28 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        pizhenwei@bytedance.com, davem@davemloft.net
Subject: [PATCH v5 5/5] virtio-crypto: enable retry for virtio-crypto-dev
Date:   Thu,  5 May 2022 17:24:08 +0800
Message-Id: <20220505092408.53692-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505092408.53692-1-pizhenwei@bytedance.com>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
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

