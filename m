Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F65B2759
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIHUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIHUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:01:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598ADFE48F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 13:01:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dv25so11294620ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fN0GeuFGxW7e+hA0O5FTtJYzMqxXnxGIq7WFnXPSIRg=;
        b=mPTji4z17seEkTNem2KAmdCxCaFbdgJIYNpsLlEJovsSXyYvfY/o+QOIUL3Agi61xa
         rVAHFJ+v8eOKm9GhiAE0rZtvManiFijje4rGO0JfXNF56xn/gpS6mA7wO5YXJ5H3KwFG
         6UuS+ActUTdCK415lmY2OCdXJVAgBJMB99y+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fN0GeuFGxW7e+hA0O5FTtJYzMqxXnxGIq7WFnXPSIRg=;
        b=GqJC2JW3HnV0gfeC99963nSRjbS0IH2KIS5h+aJ3BE/op8YUAWpflDtqe8mCgVtiRk
         02nVqdzaRmiTk29/ovmSyUc5yEpE2XKFDCIzcm/3yhanFFR7gv3F3BS4c/gxL1rmHOxY
         d7rJfZh02bHkGEuO0pZJhmMeBCDnDnPWNw/9CpKwmVy3c8wmTDbxHzPkCiGmBRw20vWX
         Yt+WeK2zPaRyx8EAbOrKjEM8QL8pqlUzuEraXxWYoY0aYl/yr29TSRx7JFA6JXRn0I1u
         Ln56rbMBQnvRXQTuVcH/0dnS5Y0TIAxCExonQ6j9nyUSkQSsVdz2fDIbFR8DhBfuwve/
         bnWg==
X-Gm-Message-State: ACgBeo2xeKDjVg5/5fxOQ5gNlEanI/tc5Y4nmXswmMmAMTTe97EpnXNA
        d6oHHjfU7FyDRh9HJDvf6tHSPA==
X-Google-Smtp-Source: AA6agR6/ZG7wHgtIrjHNEFE8k0AvwlriRp10A/a085EJsxSzD8Gz6NYeFMgFDYu12RMqHavUNiU6pQ==
X-Received: by 2002:a17:907:3e94:b0:741:9ed8:9962 with SMTP id hs20-20020a1709073e9400b007419ed89962mr7406065ejc.482.1662667265819;
        Thu, 08 Sep 2022 13:01:05 -0700 (PDT)
Received: from localhost.localdomain ([104.28.243.158])
        by smtp.gmail.com with ESMTPSA id kx11-20020a170907774b00b00778e3e2830esm521202ejc.9.2022.09.08.13.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:01:05 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lei he <helei.sig11@bytedance.com>, kernel-team@cloudflare.com,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH 0/4] crypto: add ECDSA signature support to key retention service
Date:   Thu,  8 Sep 2022 21:00:32 +0100
Message-Id: <20220908200036.2034-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Key Retention Service[1] is a useful building block to build secure
production key management systems. One of its interesting features is
support for asymmetric keys: we can allow a process to use a certain key
(decrypt or sign data) without actually allowing the process to read the
cryptographic key material. By doing so we protect our code from certain
type of attacks, where a process memory memory leak actually leaks a
potentially highly sensitive cryptographic material.

But unfortunately only RSA algorithm was supported until now, because
in-kernel ECDSA implementation supported signature verifications only.

This patchset implements in-kernel ECDSA signature generation and adds
support for ECDSA signing in the key retention service. The key retention
service support was taken out of a previous unmerged patchset from Lei He[2]

[1]: https://www.kernel.org/doc/html/latest/security/keys/core.html
[2]: https://patchwork.kernel.org/project/linux-crypto/list/?series=653034&state=*

Ignat Korchagin (2):
  crypto: add ECDSA signature generation support
  crypto: add ECDSA test vectors from RFC 6979

lei he (2):
  crypto: pkcs8 parser support ECDSA private keys
  crypto: remove unused field in pkcs8_parse_context

 crypto/Kconfig                        |   3 +-
 crypto/Makefile                       |   4 +-
 crypto/asymmetric_keys/pkcs8.asn1     |   2 +-
 crypto/asymmetric_keys/pkcs8_parser.c |  46 +++-
 crypto/ecc.c                          |   9 +-
 crypto/ecdsa.c                        | 373 +++++++++++++++++++++++++-
 crypto/ecprivkey.asn1                 |   6 +
 crypto/testmgr.c                      |  18 ++
 crypto/testmgr.h                      | 333 +++++++++++++++++++++++
 include/crypto/internal/ecc.h         |  11 +
 10 files changed, 788 insertions(+), 17 deletions(-)
 create mode 100644 crypto/ecprivkey.asn1

--
2.36.1

