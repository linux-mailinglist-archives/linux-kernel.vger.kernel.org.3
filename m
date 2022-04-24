Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C6750D144
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiDXKtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbiDXKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:49:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C0220F9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q12so11033294pgj.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=px4I+RzeTWMMtdZKLYUD3e7jp1xURuzvNJsO7o4S7ms=;
        b=FGf98dBpvjagNdKAx1gz/khVHlDbxcMtXIymcpOlEQTvZ7bDLmKT4Am04RCOVey8Vt
         ieGah75ezFTyLKCImJc/u1A+PEJXMcGbrz5onNQN0C9vxShlPewcKN/5Ryd1YXtSvtIa
         NbsMhtvFrK6Pb855hBBaau4Z+Pwtyom6hj4VMqBa7wWsKrEEc4mw+ACkPzUoN5nGN8aR
         HIG/MNh++NR7fj1uegbKiu5GlAsttsouG6C0RMx8eb9QqW6Zm3lFD010+iPRoOIkDRZZ
         v8LTF+Q1IkD4In2BRjHr/E3Kqm1MOKQiJTTwbuuwjoBldmWmgQMOYfVCoWcTvPyzq/Bo
         vvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=px4I+RzeTWMMtdZKLYUD3e7jp1xURuzvNJsO7o4S7ms=;
        b=nATEgBZayiixyaSlFMkXzCxTDDOmFBdIk/TbyoSSW2mGPaaT0PDW397MCUK0bFcMeO
         wH72Krc++69JOPDPG1BTdvL3KYtvPfSU+Po5osFSffKjgOk+NBdKqyXsu9S7Gh602CUi
         ZMYpsNb7S2cKsjwzH0jeEPNL7aKarp8K8vmo7Oe662T/b7964EEjucrXrGIxjpTYON5v
         K2G+kXY5kbZ8T5fNzcr5zoH9lELFQyOum1HCLahzME9dj2lnprYHvua/HGuSMf+Qx8s5
         LgVoJ9yhzztLjZOLCTZRcHUqslSuy/b+xiDY2NeaUnCjl1kwRyCzR0R/Lw6YnyViiO5m
         QVlQ==
X-Gm-Message-State: AOAM532S+5m1aZ9xMQ+uAVGZZwjsvnfbuDsJw/68Iga2bIDF5fuxen/T
        L03PgfrkCJVCLg541OARouEpHA==
X-Google-Smtp-Source: ABdhPJwJx/jeBsrcyfzqw3BwOB5hWkRSrCnP2UooawE0svZYmbsKlXo42bKGvoqpZSZOVMWjI3ks0w==
X-Received: by 2002:aa7:9041:0:b0:4fe:3d6c:1739 with SMTP id n1-20020aa79041000000b004fe3d6c1739mr13689501pfo.13.1650797154126;
        Sun, 24 Apr 2022 03:45:54 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm8287295pfi.86.2022.04.24.03.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 03:45:53 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 4/5] virtio-crypto: adjust dst_len at ops callback
Date:   Sun, 24 Apr 2022 18:41:39 +0800
Message-Id: <20220424104140.44841-5-pizhenwei@bytedance.com>
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

For some akcipher operations(eg, decryption of pkcs1pad(rsa)),
the length of returned result maybe less than akcipher_req->dst_len,
we need to recalculate the actual dst_len through the virt-queue
protocol.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 1e98502830cf..1892901d2a71 100644
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

