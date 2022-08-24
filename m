Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5ED59F6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiHXJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiHXJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:50:26 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B43F1CC;
        Wed, 24 Aug 2022 02:50:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN7.oF5_1661334621;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VN7.oF5_1661334621)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:50:21 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     zelin.deng@linux.alibaba.com, guanjun@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/9] Drivers for Alibaba YCC (Yitian Cryptography Complex) cryptographic accelerator
Date:   Wed, 24 Aug 2022 17:50:12 +0800
Message-Id: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

Hi, Herbert

This patch series aims to add drivers for Alibaba YCC (Yitian Cryptography Complex)
cryptographic accelerator. Enables the on-chip cryptographic accelerator of
Alibaba Yitian SoCs which based on ARMv9 architecture.

It includes PCIe enabling, skcipher, aead, rsa, sm2 support.

Please help to review.

Thanks,
Guanjun.


Guanjun (3):
  crypto/ycc: Add skcipher algorithm support
  crypto/ycc: Add aead algorithm support
  crypto/ycc: Add rsa algorithm support

Xuchun Shang (1):
  crypto/ycc: Add sm2 algorithm support

Zelin Deng (5):
  crypto/ycc: Add YCC (Yitian Cryptography Complex) accelerator driver
  crypto/ycc: Add ycc ring configuration
  crypto/ycc: Add irq support for ycc kernel rings
  crypto/ycc: Add device error handling support for ycc hw errors
  MAINTAINERS: Add Yitian Cryptography Complex (YCC) driver maintainer
    entry

 MAINTAINERS                            |   8 +
 drivers/crypto/Kconfig                 |   2 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/ycc/Kconfig             |  18 +
 drivers/crypto/ycc/Makefile            |   4 +
 drivers/crypto/ycc/sm2signature_asn1.c |  38 ++
 drivers/crypto/ycc/sm2signature_asn1.h |  13 +
 drivers/crypto/ycc/ycc_aead.c          | 646 ++++++++++++++++++++++
 drivers/crypto/ycc/ycc_algs.h          | 176 ++++++
 drivers/crypto/ycc/ycc_cdev.c          |  86 +++
 drivers/crypto/ycc/ycc_cdev.h          |  18 +
 drivers/crypto/ycc/ycc_dev.h           | 157 ++++++
 drivers/crypto/ycc/ycc_drv.c           | 574 ++++++++++++++++++++
 drivers/crypto/ycc/ycc_isr.c           | 279 ++++++++++
 drivers/crypto/ycc/ycc_isr.h           |  12 +
 drivers/crypto/ycc/ycc_pke.c           | 944 +++++++++++++++++++++++++++++++++
 drivers/crypto/ycc/ycc_ring.c          | 652 +++++++++++++++++++++++
 drivers/crypto/ycc/ycc_ring.h          | 168 ++++++
 drivers/crypto/ycc/ycc_ske.c           | 925 ++++++++++++++++++++++++++++++++
 19 files changed, 4721 insertions(+)
 create mode 100644 drivers/crypto/ycc/Kconfig
 create mode 100644 drivers/crypto/ycc/Makefile
 create mode 100644 drivers/crypto/ycc/sm2signature_asn1.c
 create mode 100644 drivers/crypto/ycc/sm2signature_asn1.h
 create mode 100644 drivers/crypto/ycc/ycc_aead.c
 create mode 100644 drivers/crypto/ycc/ycc_algs.h
 create mode 100644 drivers/crypto/ycc/ycc_cdev.c
 create mode 100644 drivers/crypto/ycc/ycc_cdev.h
 create mode 100644 drivers/crypto/ycc/ycc_dev.h
 create mode 100644 drivers/crypto/ycc/ycc_drv.c
 create mode 100644 drivers/crypto/ycc/ycc_isr.c
 create mode 100644 drivers/crypto/ycc/ycc_isr.h
 create mode 100644 drivers/crypto/ycc/ycc_pke.c
 create mode 100644 drivers/crypto/ycc/ycc_ring.c
 create mode 100644 drivers/crypto/ycc/ycc_ring.h
 create mode 100644 drivers/crypto/ycc/ycc_ske.c

-- 
1.8.3.1

