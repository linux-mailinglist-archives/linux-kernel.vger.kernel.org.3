Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619645A136F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiHYOXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbiHYOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FBFB6D53;
        Thu, 25 Aug 2022 07:23:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so18043671pgb.4;
        Thu, 25 Aug 2022 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=D0mrlc97WLTC35mVQPNg2FDISePVldO90IQe9NCWQAo=;
        b=HLBl7S8q8NwrAcQ9VPbejtuopoG8i/TtPLwz02DZ43pOxKfgV0EutKf40+D6vO+S5b
         rplcv/dbPSjgMCZaAlelyBx7dEGYqeUdM7SCp0iu4I9QoXNC+iwdOKvJ+uH2GIJ6Dm/J
         8L1qDmrkQpUg7ElVg9qjUgdTUeB63vy+hF7l7rLUYdv6lPnPGn5NRXxs259gZLjmjic6
         IHBu5QPc8s9Tzi+mX8aE+dcceOpqpdxAXNjMggtYY7F/1vIdMK8HGvM47KO9DCwErXGI
         Pq/pZjths4oiiNTrGtaytzC7EF1LBbi0jcCsP+0osq25Qpl40hYUZsqC9CqY31J3uRF4
         saSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D0mrlc97WLTC35mVQPNg2FDISePVldO90IQe9NCWQAo=;
        b=ED/PVj/rRrpJ4qPxjH6YsQO3SB/IJC+8ITMp/JSjGXd9TWA7hQz9jDleM+0wPn3a6F
         9S80Haw7NsUPSCC+eca3JIk5FQdtiXgt+Ld1LRrwpMzOjwoxZc6THqHXjiEWAopIa9FW
         7uM9pCYz+FZmaSi+R4QdYhbD+frGXQK8jkYV/CpqXy0zsRqgOSlImHTvMxH0IJjAQKUy
         K26xJ2Xj8/Hr6DKI+t0fzFCPUuOIPFAri27VuGP5Yxa5FQRkrRNfXkuo7rMlETPcpDeJ
         lkPTSeKhzQZQblqQC9Gf/CBZq6pk9haPyUaXhI91qqhumtSmOVuiV/SUy0hqeeH/W7pj
         82Lg==
X-Gm-Message-State: ACgBeo34n3AsKjZAszpawGEJE4YtRevjtJJ+GuSQve0ydokIW0HPos+t
        w47UOY//3hMMGCNWLHEk9u4=
X-Google-Smtp-Source: AA6agR7MaGcfnVqu4aDU82IRrDujHR/3z40BAVIlPTysjlaUdaV/93KWgr5+3XPcPdkh1hkjs5K64g==
X-Received: by 2002:a63:4e25:0:b0:41c:62a2:ecc3 with SMTP id c37-20020a634e25000000b0041c62a2ecc3mr3546634pgb.596.1661437399656;
        Thu, 25 Aug 2022 07:23:19 -0700 (PDT)
Received: from linux-l9pv.suse (123-194-152-128.dynamic.kbronet.com.tw. [123.194.152.128])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b0016bb24f5d19sm14962803plh.209.2022.08.25.07.23.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:23:19 -0700 (PDT)
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
Date:   Thu, 25 Aug 2022 22:23:10 +0800
Message-Id: <20220825142314.8406-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

