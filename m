Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469DE50D136
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiDXKsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiDXKsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:48:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E23315FFB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so9928783pfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hgm0iMTcbJlWpJC7de8Vsbhe1vIzSyz1TGNEgDqQz+s=;
        b=ikRtpf8MarBHAoBqvMR+OoxFFlHT4UonYiMPc6JtqDOyLGlKd7Yxjo+Ysp+CehIzUE
         Gbt2nTdm3Q7mqK5pKyBxG/qVQc/ZRKsv/NrGCJQhoDnRj/ppQqaKvnaZFtVxJIK9x7qq
         tZl+vXUNMrpAMC5rV1pALvQzfNAxPxDhLnrVh8OP5qDN409ngYEauF0+fJTexGKTnZE5
         P/KtbNfkp8PJ171jnacykY093Kn8MaAkLSgZur2IQa/YDk/9vqnRrXLaLtTaDqwZ86oP
         n2iYLh9HUI/mOLxpILAybQoiGZ9AJuyMZDI91eVjoFwrIW+AXFfx1vtC31ARhlZRq+cw
         1Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hgm0iMTcbJlWpJC7de8Vsbhe1vIzSyz1TGNEgDqQz+s=;
        b=HVpvV7DdcXaDCbeju5eYIYztLVsINl8LlGKHvQR6Pe0JI6WfXKf8m7yNLd2zSMtCFV
         NslDNPfxmyiLGoOOGad1x4rDrFjDNIptH3FGAgyLVhbYUyD8ffJCGIMaFtGaeeIsLwjN
         M7J74b5pTjvYKkObqVQ6NC3y80//SjSQKudwcBUYDfzngHELhNOAFzD2hd4b5TiLo/nK
         rmx5ChkQtcemZk+9JXzxc5xwkn2+rx0VGw4L18HRUwL23mPrpGRJoBexirP1/+xdjySx
         I8D50QGTwX0vW/fG5OQu637VCMw8/hwmKvEfoaVVamjOeXNvU7Jp3KS6EpslSMR5JrqU
         GhOg==
X-Gm-Message-State: AOAM532QBIqooiQRdMFvIM+orlMVAO2Ysgu8MFU8lg1gbz9k2644B4mO
        O5I4z/yGW3xu44kcejBWgKKf0A==
X-Google-Smtp-Source: ABdhPJzIq0JOsGhq12ZVie8DTSsfCThiz74j8+by2Hiziw6U0PFUHueUFgGrCYA3vhcWggPqU6xmoQ==
X-Received: by 2002:a05:6a00:ad0:b0:50a:51b3:1e3d with SMTP id c16-20020a056a000ad000b0050a51b31e3dmr13758409pfl.18.1650797135837;
        Sun, 24 Apr 2022 03:45:35 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm8287295pfi.86.2022.04.24.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 03:45:35 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 0/5] virtio-crypto: Improve performance
Date:   Sun, 24 Apr 2022 18:41:35 +0800
Message-Id: <20220424104140.44841-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

Hi, Lei
I'd like to move helper and callback functions(Eg, virtcrypto_clear_request
 and virtcrypto_ctrlq_callback) from xx_core.c to xx_common.c,
then the xx_core.c supports:
  - probe/remove/irq affinity seting for a virtio device
  - basic virtio related operations

xx_common.c supports:
  - common helpers/functions for algos

Do you have any suggestion about this?

v3 -> v4:
 - Don't create new file virtio_common.c, the new functions are added
   into virtio_crypto_core.c
 - Split the first patch into two parts:
     1, change code style,
     2, use private buffer instead of shared buffer
 - Remove relevant change.
 - Other minor changes.

v2 -> v3:
 - Jason suggested that spliting the first patch into two part:
     1, using private buffer
     2, remove the busy polling
   Rework as Jason's suggestion, this makes the smaller change in
   each one and clear.

v1 -> v2:
 - Use kfree instead of kfree_sensitive for insensitive buffer.
 - Several coding style fix.
 - Use memory from current node, instead of memory close to device
 - Add more message in commit, also explain why removing per-device
   request buffer.
 - Add necessary comment in code to explain why using kzalloc to
   allocate struct virtio_crypto_ctrl_request.

v1:
The main point of this series is to improve the performance for
virtio crypto:
- Use wait mechanism instead of busy polling for ctrl queue, this
  reduces CPU and lock racing, it's possiable to create/destroy session
  parallelly, QPS increases from ~40K/s to ~200K/s.
- Enable retry on crypto engine to improve performance for data queue,
  this allows the larger depth instead of 1.
- Fix dst data length in akcipher service.
- Other style fix.

lei he (2):
  virtio-crypto: adjust dst_len at ops callback
  virtio-crypto: enable retry for virtio-crypto-dev

zhenwei pi (3):
  virtio-crypto: change code style
  virtio-crypto: use private buffer for control request
  virtio-crypto: wait ctrl queue instead of busy polling

 .../virtio/virtio_crypto_akcipher_algs.c      |  83 ++++++-----
 drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
 .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
 4 files changed, 180 insertions(+), 119 deletions(-)

-- 
2.20.1

