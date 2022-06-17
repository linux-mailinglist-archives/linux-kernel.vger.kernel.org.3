Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1063B54F164
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380386AbiFQHIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380379AbiFQHIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:08:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE06350A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso3843317pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lk5TQemGz4PyySED1h1MgKjL3fjCTm3RMzKUK+BNj/8=;
        b=48cJHCpC+kdwm41s7RKBZpaVl+QSSQRhazKV8kkkj73Xuu0QfibG5U+rMFk1mPQbnd
         jZ6LFuEifpMJkyjYZCZGZhNKkVqNookFx3a7dYC1rdIlmmeWd2DLr9EtEkxVgomliEUb
         WwyZGRq0/l3L+mjygQ38gHSCjsAIJ+BOupQmvLd7zioM/3Vhcw1QveLccjlDobfxjpqb
         W0N6Cht9/ThiD5dHPwiJh0Wjo2nV4L4dDCty9E/A2ue7CzI1ULNbHROMt89HFHqkIqaN
         P4FsEJcSzVOJcGT5xqUHOFYGagQ9AANYp9MGa2D1A/8HQpIAD+uvMiVZmdoiJ6qKgLGY
         B3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lk5TQemGz4PyySED1h1MgKjL3fjCTm3RMzKUK+BNj/8=;
        b=f+INd0pbv/f8xDkMLv5/h4QdR/BBUmUNntsS1zTIZaWz/Hs5BpeGVohsNzEPvgijUr
         0limvSxAi1d1rKsIkcE1B4ZFCQ6jCV9TFuatEedIahoNREkfMdSNTjR9zcV8imudABQe
         S/o+Ig8g01eugkkHII2yp3tRdvlXDoO71Su0VkWg20TBFx76irqeamPyB2lfcLjLJyWT
         H3zS1RaAKF2Nph2kQpqDJPMKdWIm7FSNDoAXFf3DIgKJ41rnEJTO0J6SdeaQ7Ketnijq
         SnaP/6/tWl/0ihcmxlgsM3MaQ5Zj9NdMrnLm6rTOhVF6bCIZXvQ7fDb7bw08dHD8xpIY
         P7pg==
X-Gm-Message-State: AJIora8D/x40wDgEfFsJVCylcnp3Wbs5JBvtfqvliRuOUT/7aigsSzoT
        kQ7FYH+HceXcCrOKzwwCVKvcXA==
X-Google-Smtp-Source: AGRyM1uShlsBG6cg32B4UqtkQrFFeu6daHuFrC5T456ZKsJaJxX4yiKett4P5mZ3krl4Nq80expTng==
X-Received: by 2002:a17:902:e5c9:b0:166:34ff:72a3 with SMTP id u9-20020a170902e5c900b0016634ff72a3mr8318177plf.80.1655449689047;
        Fri, 17 Jun 2022 00:08:09 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b00163d4c3ffabsm2757868plr.304.2022.06.17.00.08.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:08:08 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mst@redhat.com
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, helei.sig11@bytedance.com,
        f4bug@amsat.org, berrange@redhat.com
Subject: [PATCH 0/4] virtio-crypto: support ECDSA algorithm
Date:   Fri, 17 Jun 2022 15:07:49 +0800
Message-Id: <20220617070754.73667-1-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
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

This patch supports the ECDSA algorithm for virtio-crypto:
1. fixed the problem that the max_signature_size of ECDSA is
incorrectly calculated.
2. make pkcs8_private_key_parser can identify ECDSA private keys.
3. implement ECDSA algorithm for virtio-crypto device

lei he (4):
  crypto: fix the calculation of max_size for ECDSA
  crypto: pkcs8 parser support ECDSA private keys
  crypto: remove unused field in pkcs8_parse_context
  virtio-crypto: support ECDSA algorithm

 crypto/Kconfig                                |   1 +
 crypto/Makefile                               |   2 +
 crypto/akcipher.c                             |  10 +
 crypto/asymmetric_keys/pkcs8.asn1             |   2 +-
 crypto/asymmetric_keys/pkcs8_parser.c         |  46 +++-
 crypto/ecdsa.c                                |   3 +-
 crypto/ecdsa_helper.c                         |  45 +++
 .../virtio/virtio_crypto_akcipher_algs.c      | 259 ++++++++++++++++--
 include/crypto/internal/ecdsa.h               |  15 +
 include/linux/asn1_encoder.h                  |   2 +
 lib/asn1_encoder.c                            |   3 +-
 11 files changed, 360 insertions(+), 28 deletions(-)
 create mode 100644 crypto/ecdsa_helper.c
 create mode 100644 include/crypto/internal/ecdsa.h

-- 
2.20.1

