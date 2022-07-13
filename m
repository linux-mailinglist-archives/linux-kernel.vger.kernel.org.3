Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E875572C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiGME0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiGME0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:26:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D174506E;
        Tue, 12 Jul 2022 21:26:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g126so9222644pfb.3;
        Tue, 12 Jul 2022 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=D0mrlc97WLTC35mVQPNg2FDISePVldO90IQe9NCWQAo=;
        b=W97Ks1uhm0iaddeK597krnrP5r/ntXt3VMZuBwrAXItNSw8uvYScVJ2CVtUKL79osk
         /FUHk9jyvUbz5opAwYkp+fPl92LKef1YHjW83Dh2t5UnLHf7dahkZI6cOHqAJ4ydoxp8
         sfpyTxjp3dn8/WQ6aRrKBwWZ+ayKElTRx8oCbcdNVWBZW925zHYgo0HKfU1GvkePtDYm
         0j8tzYNTjyD4wLD735Chx0BpxOF0AZ30GGZ6LCqwjJ37coCWBXI6KWM+qalNFM67BWrX
         2YAjQw1cwXUu2ZsXh86ffvEByHSRrvUXeQvGIP3UaKAVGee7n2GAP0w3JsbgI8z4IGLa
         LGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D0mrlc97WLTC35mVQPNg2FDISePVldO90IQe9NCWQAo=;
        b=XbNCU8mkeixMLW2/1XvBvEI03fW6Kr+/OPJwEdeEqupXavhJhWr/ZN0JeOHvDmc8lt
         Z2iEbbImRA6ZMsbzpDaJgQtkWPiVEkP6/IOy/TOcOa0mmRVkeLZSFJ+UdS2ME01Oo2Za
         2xwVIkU0tcMq2QhtOjMiiDCjHiNf4iFf5SS8gCBK+lFaa03i6KgtESbhumAm2koqqQZj
         ioo1DE5ZMHFEN2zd0YlbRpTAr1BiLF/ebCRVY5bvaYWuVdNyTKxUmBmhHAm2Wu7xvQcS
         XzK8tJ6gAcgSzpllrsHw+ApKXe7ZeIPh4RAaGhyXaVxbUNqNUNveD4JFd4IDXJbAM4xN
         z9eQ==
X-Gm-Message-State: AJIora/YMt5rag0CXy1Ii1Tq5e1yybzW1idFU5DKEqHyoJxd5bkv+3e+
        aXnhvEk6fWgmKm8ujw6AJMk=
X-Google-Smtp-Source: AGRyM1tutc7Pb5nj/14ZEkSaVmwH8TaXMbi/NefGgjUMAy61m8czG480gBF8+UcDwCzZeBYJxyBXyw==
X-Received: by 2002:aa7:9ae3:0:b0:528:d881:9ff with SMTP id y3-20020aa79ae3000000b00528d88109ffmr1464421pfp.66.1657686382239;
        Tue, 12 Jul 2022 21:26:22 -0700 (PDT)
Received: from linux-l9pv.suse (123-194-153-158.dynamic.kbronet.com.tw. [123.194.153.158])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b0016c4f006603sm4732513plh.54.2022.07.12.21.26.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 21:26:21 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH v9 0/4] Check codeSigning extended key usage extension
Date:   Wed, 13 Jul 2022 12:24:17 +0800
Message-Id: <20220713042421.21680-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NIAP PP_OS certification requests that OS need to validate the
CodeSigning extended key usage extension field for integrity
verifiction of exectable code:

    https://www.niap-ccevs.org/MMO/PP/-442-/
        FIA_X509_EXT.1.1

This patchset adds the logic for parsing the codeSigning EKU extension
field in X.509. And checking the CodeSigning EKU when verifying
signature of kernel module or kexec PE binary in PKCS#7.

v9:
- Rename the eku element in public_key structure to ext_key_usage.
- Fix selftest.c

v8:
- Fixed the bug of is_key_on_revocation_list() when
  CONFIG_SYSTEM_REVOCATION_LIST is not set.

v7:
- Fixed the broken function call in is_key_on_revocation_list().
  (be found by kernel test robot)
- Use a general name check_eku_by_usage() instead of check_codesign_eku().

v6:
- Add more length checking when parsing extKeyUsage and EKU's OID blob.
- Add 'usage' parameter to the comment of pkcs7_validate_trust function.

v5:
Fixed the wording in module-signing.rst.

v4:
Fixed the wording in patch description.

v3:
- Add codeSigning EKU to x509.genkey key generation config.
- Add openssl command option example for generating CodeSign EKU to
  module-signing.rst document.

v2:
Changed the help wording in the Kconfig.

Lee, Chun-Yi (4):
  X.509: Add CodeSigning extended key usage parsing
  PKCS#7: Check codeSigning EKU for kernel module and kexec pe
    verification
  modsign: Add codeSigning EKU when generating X.509 key generation
    config
  Documentation/admin-guide/module-signing.rst: add openssl command
    option example for CodeSign EKU

 Documentation/admin-guide/module-signing.rst |  6 +++
 certs/blacklist.c                            |  5 ++-
 certs/default_x509.genkey                    |  1 +
 certs/system_keyring.c                       |  4 +-
 crypto/asymmetric_keys/Kconfig               |  9 ++++
 crypto/asymmetric_keys/pkcs7_trust.c         | 43 ++++++++++++++++++--
 crypto/asymmetric_keys/selftest.c            |  2 +-
 crypto/asymmetric_keys/x509_cert_parser.c    | 25 ++++++++++++
 include/crypto/pkcs7.h                       |  4 +-
 include/crypto/public_key.h                  |  1 +
 include/keys/system_keyring.h                |  7 +++-
 include/linux/oid_registry.h                 |  5 +++
 12 files changed, 101 insertions(+), 11 deletions(-)

-- 
2.26.2

