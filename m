Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961905572E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiFWGKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiFWGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:10:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B463BE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:10:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k14so5787899plh.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8tI85riZMOHfa3k8p/ytOZ+RJHDFY9LmShQDBd6b6I=;
        b=SARoOkbEBf5QYfK+kRxLw37L+QQB/x0IGUpe+lXNKkPPiKNupFPO+530fzS1KWdgi6
         TrCm+F6wWiCV0QkfuRhEmM/gmZ+WfjgE06mqgTlCMKSrwMTM9XSXGiqe9Pqi01eGNsob
         RUHT3oXSWiMOJXbP9jYtrMglqweDdrOnyAeQSSSdaAbzmgF1l28jeGhPebgZk9W8GqmH
         4sRga2f8V3IA+2Nrn9j4/kPc8watpE8yNcdGHRYCB8908vRO/7wABbP90AUXYPosfKId
         Yr3p67UFSZjkXVcZdMPlkgQyOhs1bD0EH0AEuk8BuIG9v2dlEPBndM6TfKZ5qnaclGQ1
         R6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8tI85riZMOHfa3k8p/ytOZ+RJHDFY9LmShQDBd6b6I=;
        b=DlKRQcUOrLafD7NrV4m9GCMNKZOglC7K8F8lRJJy7nsj2pB0pC8wicv/Usk/KyIC0z
         MSSu360aQcDyBS9YC/2PS4k4BMV7mEe2nhKybfHcrKeLm2iE+U1elOIpZ9Q8aeJiS27o
         M9xa3UCtsDSerBuLRd+AVRrQI7tfs6ScTL0HRakmSqlgIQqbFKxxgWeVx19ss1KwAZF3
         NNK5dkDkNXEYTAy4T4B7qCOlM5+uI4XXc1v8rZ2cTPnnaMe371m4q5yTxKKzUcibz6BM
         f+EOhHHtM3of8w1Jk658Ryy6fvAzoMAq0PBo6umRa7Owfb7D3QbBmps895f5FAQturPb
         +y5A==
X-Gm-Message-State: AJIora9gaJUdlf6l+w9WnPSgxC1Mb6pD9UTsL/EuB2AjwDSnINUiergg
        HFJiUdavkfbcxrWPEuXoBeQ/U9a/q0vC7Q==
X-Google-Smtp-Source: AGRyM1tURR2mWC91RwhGJJ7NdxfnCWsglo8eyFMK8qSWXsfbR3txPvvVUsY0tq+OhaZBG3rVIzzzXA==
X-Received: by 2002:a17:902:d2cb:b0:16a:2efb:d03e with SMTP id n11-20020a170902d2cb00b0016a2efbd03emr15555823plc.81.1655964600838;
        Wed, 22 Jun 2022 23:10:00 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s3-20020a170903200300b0016a11750b50sm9782080pla.16.2022.06.22.23.09.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 23:10:00 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com
Cc:     mst@redhat.com, kbuild-all@lists.01.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        berrange@redhat.com, pizhenwei@bytedance.com,
        lei he <helei.sig11@bytedance.com>
Subject: [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
Date:   Thu, 23 Jun 2022 14:09:47 +0800
Message-Id: <20220623060951.77641-1-helei.sig11@bytedance.com>
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

This patch supports the ECDSA algorithm for virtio-crypto.

V1 -> V2:
- explicitly specified an appropriate base commit.
- fixed the link error reported by kernel test robot <lkp@intl.com>.
- removed irrelevant commits.

V1:
- fixed the problem that the max_signature_size of ECDSA is
incorrectly calculated.
- make pkcs8_private_key_parser can identify ECDSA private keys.
- implement ECDSA algorithm for virtio-crypto device


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
 drivers/crypto/virtio/Kconfig                 |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      | 259 ++++++++++++++++--
 include/crypto/internal/ecdsa.h               |  15 +
 include/linux/asn1_encoder.h                  |   2 +
 lib/asn1_encoder.c                            |   3 +-
 12 files changed, 361 insertions(+), 28 deletions(-)
 create mode 100644 crypto/ecdsa_helper.c
 create mode 100644 include/crypto/internal/ecdsa.h


base-commit: 018ab4fabddd94f1c96f3b59e180691b9e88d5d8
-- 
2.20.1

