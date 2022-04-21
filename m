Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50546509DED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388558AbiDUKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388520AbiDUKrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:47:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF952D1D0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:44:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q1so3294736plx.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zOuRYVFWDGuC1PrwNUGb6FpSSDkw8m8NU3bhEpx4ck=;
        b=kCpy3srq/EiBanbPyFzUd0w0fdOrd3PL2QHCcbTp7TZh1XfM6gSXBFFrxDXiKzePET
         BwCk62X45XrHU1TRgo+rpF5cPK87lvBqe9Z5X9gX1XXa42IXLMh0wrxSbi/ZzoLCkWyg
         SG7njy+qJTfzPqsl+gQYTHqx+ULb086FwT7Ngo75IOdDDyyoxoL5pgLeUqjDxGNWgG9G
         225aPoSR1vTY6k9fszQ/AZzu6oQaJEoYoAUR+o+wuYp5q30SnukeGjrXpM2hl3VEYIsH
         JgLtg/EZ6VTM4QfR2EGeiOBXfMD7vkr3EurEZ95KVGyPnNSwjYsuJ7l1lwN1LgNM1bFS
         TBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zOuRYVFWDGuC1PrwNUGb6FpSSDkw8m8NU3bhEpx4ck=;
        b=x1JNnUfO7APYEy9lGqFMcrI2P9I8UzvC03s1a0cPYx6pwpTz6QjCYlnODYrb5pwNyP
         vESLH/1LErwbM3QQyLpR+UTkNDt1fhd0MX1LC81eqfc3BAd3ui9XBZrNitJ1gcFWMbDM
         bpyqHg2WL/b05qQH0UwKGDFshzJAphmtrhzFjt+DP7v4KnqqaQSOhHjXzSxY0sjEOP/T
         6z6KNd45986wvDVfda5j6jdhnRdN0EnD08RPkNSLHLdpk8V+fgTxB4rrUdu4Z1RVax+V
         SoYJ6PTSVVfA47n5cYR3+8hiyY+NxvIUF/WFlJgj752kFwOXhe9Gpl3j9qIn6oBgU6Dl
         AUvQ==
X-Gm-Message-State: AOAM533RI3qkTjMSTxhCRLTso00345343oPGxxf012HA3w/XbinuG8rh
        FrbCyBtkxGgzDfFUfKYxkJ+ftw==
X-Google-Smtp-Source: ABdhPJxu/20L6f4UIu3TjxYb9mGaNdxihBAZzHQCrTg/qmpKmPcYQWNqpuUUco8L1qBhWTdWiI8RRQ==
X-Received: by 2002:a17:90b:15c9:b0:1d2:f2f0:e15e with SMTP id lh9-20020a17090b15c900b001d2f2f0e15emr9734310pjb.195.1650537857872;
        Thu, 21 Apr 2022 03:44:17 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.69])
        by smtp.gmail.com with ESMTPSA id w7-20020aa79547000000b0050ad0e82e6dsm3772485pfq.215.2022.04.21.03.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:44:17 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 4/5] virtio-crypto: adjust dst_len at ops callback
Date:   Thu, 21 Apr 2022 18:40:15 +0800
Message-Id: <20220421104016.453458-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421104016.453458-1-pizhenwei@bytedance.com>
References: <20220421104016.453458-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 9561bc2df62b..82db86e088c2 100644
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

