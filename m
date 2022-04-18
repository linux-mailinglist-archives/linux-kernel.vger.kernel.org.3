Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60A504E28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiDRJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiDRJHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:07:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A81169
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:04:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so32606pjf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zwb8mG+JIzADfsDfu33jNg4PhKLseW5IOVJoEfJh+pU=;
        b=Q51XoRzYcy3Iq4zZECeVxoNnEwswZKxs01rU4rfPh3NYRYFK5llkZQGhFhpG+hYXE6
         7CGeg6r6SHSAUjsXLL42uwwDLyYx+fbpVYGGar9E0ixVUE6JwbV6z13e+KuPwtbm6n9Q
         5+AdJn3h4XNciFzz4QPahKtLkKzWni91j23FntOjP7jX+7ccUdxF0WAROoS6XkhStLVP
         XafEStfMYTX1b4fLoJu85vnIIYxf4S6XjQXLiltE6tlPXwKiuwEZqlElROaU9PdvqlVz
         7O+8coD9+WiZffIuoXsl4SclNoILqlMzNdaNUFawJei16OG3H3NZfEJk1yQRMxQigfK8
         fSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zwb8mG+JIzADfsDfu33jNg4PhKLseW5IOVJoEfJh+pU=;
        b=GzGOQ1SkJ3M/RpUQ3zyOXj5A3qfKMwWRmpU4VmEPaB43ET2/tmUosBF5eCZQ6Vtb6V
         tn8jIWxCzk7fNwmJIQTUX3GNOe+Y5GDJKjnKdsbUyaIPxFEJ0cd8hP4JKCUJBgH536pI
         DMh5lDr/GQEnrU+hP+9wMjTgQhj6DYdwKbfQw4TKbDPnS5xwA1SZ9e3fj+90YzmcqpTa
         zMHC1VE/7y2G1G7sX5P7h9CYK6bQiu/WvjJecIwQzxu4spppTGzDGXHLMKk2rxyk5Fkg
         S7VJGiq3hAldEO+PoAms1fNO9MXqCHM6FyCvNPgHwMAQN52PEdH2BiVe4dRhMxktqTU0
         G9Zw==
X-Gm-Message-State: AOAM531Si9869IjA6D9lX4+Y1yJ/uzMbOVp481Nbq5O+iU+9f656yGjO
        CUs+kXPopmO5kvjYSBZcVR5f7A==
X-Google-Smtp-Source: ABdhPJzUzc4cYn2K0PfMzlKo4MeWwU0ulkQ6wJc7kLElOp+ZdHUtAw0JCPmVHhRUWWSy0Xc583iZRA==
X-Received: by 2002:a17:902:e881:b0:159:828:b6dd with SMTP id w1-20020a170902e88100b001590828b6ddmr1072674plg.127.1650272669849;
        Mon, 18 Apr 2022 02:04:29 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm16408071pjl.39.2022.04.18.02.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 02:04:29 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/4] virtio-crypto: Improve performance
Date:   Mon, 18 Apr 2022 17:00:47 +0800
Message-Id: <20220418090051.372803-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

zhenwei pi (2):
  virtio-crypto: wait ctrl queue instead of busy polling
  virtio-crypto: move helpers into virtio_crypto_common.c

 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      |  95 ++++++-------
 drivers/crypto/virtio/virtio_crypto_common.c  |  92 ++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |  27 +++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  37 +----
 .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++----------
 6 files changed, 224 insertions(+), 161 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c

-- 
2.20.1

