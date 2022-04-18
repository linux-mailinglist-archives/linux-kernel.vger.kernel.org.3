Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA1504E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiDRJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiDRJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:07:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3536F75
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:04:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t13so17797742pgn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouz4DgKg6HX7//LGRrUD97CctBPhdyzV/9EeFTiygxk=;
        b=6TWHPFn0LN6u1Gtv/IJ/FZUtIkxZGYRSlYL1xUuSQwz6ytLfUxUHzEhiZogx/oPjrb
         5IOYrTilRPWoHpCRSg3pD9hxYZzJxQhgFu7oMUXgRdkrpSBD8H8p9b2MjNWFFbRV/0fk
         JqtHVC/Atk4oTpbgL809sb6GZ48czjib99D2vLy8PKSaX5Q4H53WLL5nFIul/nggKvzB
         QyCC5TIlf1UwqjmQzzFfYQICmDC+k+WILzeWkCdunjIwypfSFlv0ZFqUS9k7G5oLbxB2
         6oUiQeUOEd1aB+8ADGQyVZYhbF9eyXJK0CCrBZfsSUMAUUktSQsB/HwqoQFmhdVi8f4r
         H9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouz4DgKg6HX7//LGRrUD97CctBPhdyzV/9EeFTiygxk=;
        b=wWcTDgn61HpCDnl4VhtD6PX23c+9xsGahBjEDHdRbNK7sYbGuAhIxH3Hhsut2UobgU
         4QKfmEvop2w1GnT42JPnhTsitQPKkoSBCDtD1FseRTgMRbLQnLPDyj9GOzsV4St17BIp
         75cuBV1CH9uaWb7MgJpkpvJ98rF2s+S4k07mmxqwnh6T+Mj0aE2PFjvEkD/FytazkfHM
         gJ+Fl9RRs21Bp0nQ2u9upd9IM16ZKIPQMS7wVusvrwKIyAyl7WKD3SMpjIVemOgCXBzN
         3MKPBJxuMpnmFeJ6HLi2695WGCCU1kf7gApNhPd2aelRlWiOp/uCIEPGSTk4Fa6ECgJA
         TXrw==
X-Gm-Message-State: AOAM532ptoGCOe3XyTE/2slmcfjYBa6Fhz1ThLjZUzC/XKqEvCEc6KPu
        B1yTsDz8+bQQsFbvVYkK/z3huA==
X-Google-Smtp-Source: ABdhPJz7+O43bQjw3Qx8+8pHjS0RYIso9TqOCGaesGbw3hn8vk87HPcB2H/bsqdEGcpfWIhWqakxhg==
X-Received: by 2002:a63:34e:0:b0:39d:8d96:a947 with SMTP id 75-20020a63034e000000b0039d8d96a947mr9503958pgd.105.1650272688180;
        Mon, 18 Apr 2022 02:04:48 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm16408071pjl.39.2022.04.18.02.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 02:04:47 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net
Subject: [PATCH v2 4/4] virtio-crypto: enable retry for virtio-crypto-dev
Date:   Mon, 18 Apr 2022 17:00:51 +0800
Message-Id: <20220418090051.372803-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418090051.372803-1-pizhenwei@bytedance.com>
References: <20220418090051.372803-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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

