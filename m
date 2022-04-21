Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87738509DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388493AbiDUKq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388492AbiDUKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:46:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DE626ACE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:43:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso7387814pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbdLvfr3QXslFSKGfbNp8gy/VAj6R0oFm+lWnNgRZEE=;
        b=HkoS371DN3rSB2jIADCgXmgk6xKOztuAL+Iu5gpqJFF2mbsXhPnm/k9b7V+fq5NN2m
         rnVamyYbSirwFxS5yxa5JBJJjkE5J3dlUjgd3s8k2tifbygIVEvv8wsyA4+q06vhXj0b
         ySimouWTBoDI/FRZ0ZsdRgZn616Njg7h/xUkgKAcLhn870Fvp6Rx0cbN7A9+v4fDuuLG
         34gZbAsJsZ4xC//ClZvVEC0UF7H4A4DSE/T+aqUbLc/re/RBg599R3J/k/klpupT8Bis
         rHwwfCVEghc5OYAS2sLZAd294Y/yvPL4O2yARwX7qa7nixxGNTWQw2flHmnCadRiuEpV
         Islw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbdLvfr3QXslFSKGfbNp8gy/VAj6R0oFm+lWnNgRZEE=;
        b=lDh+6MT9lqcbbOiV9yi+hcdrQIYjre6B9SvepKjJbr58r/ibsQRAXR2DfF8cyXbDic
         6jARz8pszszGxTKFxV7R/vYM9CV0SYovzHm3MIR9mVzQHqvDiqIblxhjshfGdtTcxFIx
         h8wUVhQmeDjLvojPQTOi8pDEp+acVv4Oe3sRRwzx0h2GX1IcfpLBVRgtzctoU8VTGIuZ
         LW32v8vqlnv2D/1A12QowBi1/4fGgtrgBMxcz8kjNRuu2xkAvm5cWIE2wDCKGTKyT0pZ
         XNY95Vsl+lYfOmXDYdeqVVp/qH5sIYmYXxUvm4ioK8bQWV9BpNXZ1h428woGmtqQdl9o
         Rnyw==
X-Gm-Message-State: AOAM532pcIXYwB5F/tXMGKpRhqkuBLOovDDHGcrjNysXI6jgtMSqYulK
        tVjfmQgOsBNFwyPsm0hZ6ndang==
X-Google-Smtp-Source: ABdhPJyk6fg01yydytqJRg18e+hOfoK++WdR9/ootTsiE1OipZUW/zqvsPTAzh4cpVm/wPk2PQXe4w==
X-Received: by 2002:a17:902:e886:b0:158:cefc:c041 with SMTP id w6-20020a170902e88600b00158cefcc041mr25472986plg.51.1650537836593;
        Thu, 21 Apr 2022 03:43:56 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.69])
        by smtp.gmail.com with ESMTPSA id w7-20020aa79547000000b0050ad0e82e6dsm3772485pfq.215.2022.04.21.03.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:43:55 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 0/5] virtio-crypto: Improve performance
Date:   Thu, 21 Apr 2022 18:40:11 +0800
Message-Id: <20220421104016.453458-1-pizhenwei@bytedance.com>
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
  virtio-crypto: use private buffer for control request
  virtio-crypto: wait ctrl queue instead of busy polling
  virtio-crypto: move helpers into virtio_crypto_common.c

 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      |  95 ++++++-------
 drivers/crypto/virtio/virtio_crypto_common.c  |  92 ++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |  29 +++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  37 +----
 .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++----------
 6 files changed, 226 insertions(+), 161 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c

-- 
2.20.1

