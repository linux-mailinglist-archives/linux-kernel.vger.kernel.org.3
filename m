Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4311B4B2059
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiBKImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:42:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiBKImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:42:38 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75581E5E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:42:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x15so12626054pfr.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXaTm9zy9W/Fk6sBxh9XpKvs2j0diA8uf4CSWloZl88=;
        b=ZtNN+pwUXhbiBI06+s9oYlR4i6za0OUa9R7GlHnn+4GqxABwPRVmaRF5ri+9lXYJPK
         HLyHzYTxO7EHc2mOcMvsZ34WU71pUl7982FTqWh4jttvulqlX3xzyAZkgvO0uUDILprP
         xAEntQJvx0jfHHaPZhafWF2DmrIW1fD8NUPWmYXf2OmkE4sLtEpIYXlMbe10kb7OoEwO
         TfeMk3tjDlAzEl5DLz9lInToE36S5+UfjpkLoOYfcrZ/ehwM/HQtuFX/Bjhd6tcbMu0+
         jKhheTqY6O9ApVLimMn///QayiwA08eEZOwVZ9BiryCZw8+abHDQIfbHW70ywoF2EKeC
         a09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXaTm9zy9W/Fk6sBxh9XpKvs2j0diA8uf4CSWloZl88=;
        b=XEYGTSLwz8s5tDIZhjwGmLQgnVz/3ygtOMILea3pSGy0m2W06H87KAcLLYfoUWYrAc
         ET98/YC4kS1rxycJuosr5pEsY4CLhtwr3sXMKmrpo1CHpfMgdxFEyCpwKCKzZk8JoO92
         5Ul7U7bUKQNztkafYYQLrA1v/A7CT9o2Ls0wJE1aw3hL7uEH87qksKVrl3qSWIq4lrym
         rguO8O3DUuwfn27dkWJbRs8pLLFIJCAI4K+cx1Bk6bdjfrxCQDRlWGcOzzz8p1mxGUOo
         nf8mZMkaNnweObIEGSzaJsCL0OwUueeJHquzmZ3TynCYTKyDA8TdskNFWIrOHwANiyVS
         XjRg==
X-Gm-Message-State: AOAM531wVCyDWyh+3xFDNHd+C+xjfJcEJbHOFwoAVGHkX6I9Meqc+Hbo
        y5DeoIMM9KbnFqzGYMVO11cLUg==
X-Google-Smtp-Source: ABdhPJzteqwv0pPYrb+FP+UMxU2H2Cxr4mmWBjR561lIMjdAoQSPgdgi2I6VDtwQVm5+Fr4/fkpeZg==
X-Received: by 2002:a63:8543:: with SMTP id u64mr463644pgd.624.1644568957934;
        Fri, 11 Feb 2022 00:42:37 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id p21sm13368481pfo.97.2022.02.11.00.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 00:42:37 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, herbert@gondor.apana.org.au,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/3] Introduce akcipher service for virtio-crypto
Date:   Fri, 11 Feb 2022 16:41:05 +0800
Message-Id: <20220211084108.1254218-1-pizhenwei@bytedance.com>
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
- Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
- Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
   struct virtio_crypto_config directly without size change.
- Add padding in struct virtio_crypto_ecdsa_session_para to keep
   64-bit alignment.
- Remove irrelevant change by code format alignment.

- Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.

- Test with QEMU(patched by the v2 version), works fine.

v1:
- Introduce akcipher service, implement RSA algorithm, and a minor fix.

zhenwei pi (3):
  virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
  virtio-crypto: introduce akcipher service
  virtio-crypto: implement RSA algorithm

 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
 drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
 drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
 include/uapi/linux/virtio_crypto.h            |  82 ++-
 6 files changed, 685 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c

-- 
2.20.1

