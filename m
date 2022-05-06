Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACEB51D8E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392420AbiEFNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392431AbiEFNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:25:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F446971C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:21:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o69so7005822pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5edDtm3ClDj2Ih4shfC7v+UW75qeVSKJFNdIatinSe4=;
        b=Uk0uXOW5WRqRK2VTpgFyRJQIfmCllW+gzKZ2xs8e38Byyi/sOBdnh8zgRA2lcnrGCp
         MbpJ6070kITrxcF0rmmRClG32eCpQhdvZnLOw7NLyTPxN17z9kfcUDGoISZ+d6HUt5GC
         GVJC143IRGMeIeiMMdCszdGtCr5lKVFZAUq5kJjXPyWZJcE/9kdtn0fobMio59+w9sa2
         V/jA6HOPPwfzAulbD2NmBLMojuItt8BegWaY3H53J4ZqG4FkyZNtgmc4blc4AX3OYc9I
         JFHSNhwzkd2cerBOdCNcSJ/O1sx3tYQCe2VhoYJcoIR2cwtxRpscHgemetzFMfVdAioF
         n3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5edDtm3ClDj2Ih4shfC7v+UW75qeVSKJFNdIatinSe4=;
        b=kx/Zrq3RHyxcpcRS5KqlGGu5Ro6BbROedjOs6RCqhXJn9VIbUCBDseEFdpa5Py7TnH
         zhP9yox43TJJaEuzxw3wMubrj8nMnWBaZMDQANDZw4mNvTQ5ZcWZb034HA1dpYwt6r3A
         5OgJFZlxqKxzQnPRMWeZWh/DBkQxev5CetBQ9tYgZ4igtoDs9YjXAs1CDo0uFqcxAzbd
         6LyVpZtVKpbpkZ9pWgXlvjYxulxAxd/O+LK72m83My+5rlGPlFUsv+i+vok++FDIxm5c
         CIwssYLFSmIyIogIqDRGlgKJPnAL58ZWLlfwICuyPoMwWqtfJ5oNVdeOi6bxMars/XvO
         WqtQ==
X-Gm-Message-State: AOAM532BzC5PAb/DzHuy0Jx0FHYd8i8n2IcAk8mzekz+h6ovDYBqC7jq
        1Jlr3q/W9DT2Y1TIrIAQ2jmVQg==
X-Google-Smtp-Source: ABdhPJwmOLNxQkSjP7G9cCAfAFBzJustpWCljWo7emBIKpuY9vdl/bdTDNTkpES1Me8znMuFza7RlQ==
X-Received: by 2002:a17:90b:1c04:b0:1dc:4dfd:5a43 with SMTP id oc4-20020a17090b1c0400b001dc4dfd5a43mr12535457pjb.160.1651843273430;
        Fri, 06 May 2022 06:21:13 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id i22-20020a63e916000000b003c14af50643sm3256986pgh.91.2022.05.06.06.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:21:12 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        pizhenwei@bytedance.com, davem@davemloft.net
Subject: [PATCH v6 4/5] virtio-crypto: adjust dst_len at ops callback
Date:   Fri,  6 May 2022 21:16:26 +0800
Message-Id: <20220506131627.180784-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506131627.180784-1-pizhenwei@bytedance.com>
References: <20220506131627.180784-1-pizhenwei@bytedance.com>
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

From: lei he <helei.sig11@bytedance.com>

For some akcipher operations(eg, decryption of pkcs1pad(rsa)),
the length of returned result maybe less than akcipher_req->dst_len,
we need to recalculate the actual dst_len through the virt-queue
protocol.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 382ccec9ab12..2a60d0525cde 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -90,9 +90,12 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 	}
 
 	akcipher_req = vc_akcipher_req->akcipher_req;
-	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY)
+	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY) {
+		/* actuall length maybe less than dst buffer */
+		akcipher_req->dst_len = len - sizeof(vc_req->status);
 		sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
 				    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
+	}
 	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
 }
 
-- 
2.20.1

