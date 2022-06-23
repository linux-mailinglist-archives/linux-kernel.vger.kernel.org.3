Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590A3557384
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiFWHGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiFWHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:06:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF13F45530
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:06:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a15so11059752pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8tI85riZMOHfa3k8p/ytOZ+RJHDFY9LmShQDBd6b6I=;
        b=Zigg+v8tn4xENI/p7pUD0A6cgE7IrpDxgNcmmB5fQLmLdR4T6qwybGkaaFx4jK7nJD
         oCCz+CTXYTMTf1P2/a7wmjCZub9xNxZjDA4OziI7XuCCCqTdx+99nZm0KqVpuEDfVn8Q
         oHMhd7qwoBiimFHtBpqioAV2EVIvTCEVVlwMrX8Zfw8I15t0BOZxA17UVIWzb0TD6MF7
         9vVLkDo69BAnBFaeqXDoNICfn/2hN5ux2WHIWwefrUihW3kbG37MIkzg7slwirbm+JPD
         ntxf77ydpogaKGoif+70x8f51ECrQb2ooW8iIRJh0KQFxzm27/qnZ+LL/n4s8KBg6Q+K
         aI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8tI85riZMOHfa3k8p/ytOZ+RJHDFY9LmShQDBd6b6I=;
        b=0LW09/GR822lt+VLngApCR6d916WzzGavfnJ7ob3tBAQJcdH59FxndIDxiljoV0ItT
         c2VioW6vX/UJiEnaWNj47iVGyJKiqxjuP8GuTn30JuAjKszXcoSV6JyY9zDxLa1/WXtO
         2zIvrb8YEMLt5+Uve1A6v7GpyhsOsJ3X75WPtBpQt27NgDB6xgqgEQ8aTj08/OTR+CeV
         s7Dl33Un91j4qZrggkNrt/XkICUfqOtBgtwCSdOETmpvpTgyw4wwPGfUaEyzFkkvMMZK
         Hertm3F1/map7ufCKzIi5nH0/IpQrPAemeoElnV4uNUliReIV1SBx44Ww5FtD3r+U5jj
         sW1w==
X-Gm-Message-State: AJIora8zh9l9Ce7WHdbxVrbeWBmGln9Io56VdV1C/l2k3lz3QNYGfeqx
        pzXKbgJsBLEhLgh84duxh7J/Bw==
X-Google-Smtp-Source: AGRyM1vfDaqjshfAgxboI2egke3KONaPUoAHJUVzd/fMnQ7wfqRIW3ZyJtBquSw8mEz61bOUd6PItQ==
X-Received: by 2002:a05:6a00:f8f:b0:525:537d:69b1 with SMTP id ct15-20020a056a000f8f00b00525537d69b1mr2879416pfb.52.1655967962205;
        Thu, 23 Jun 2022 00:06:02 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b0016a15842cf5sm9125184plb.121.2022.06.23.00.05.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:06:01 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com
Cc:     mst@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, berrange@redhat.com,
        pizhenwei@bytedance.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
Date:   Thu, 23 Jun 2022 15:05:46 +0800
Message-Id: <20220623070550.82053-1-helei.sig11@bytedance.com>
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

