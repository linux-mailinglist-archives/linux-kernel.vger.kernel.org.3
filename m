Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE17572C89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiGME2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiGME2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:28:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D575C9F4;
        Tue, 12 Jul 2022 21:28:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s21so10327355pjq.4;
        Tue, 12 Jul 2022 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cVU0VI6SHUHssnCSIRaLHSdROjTj9L70izUE69+SVQI=;
        b=VadUZY6UnFi1GZKkPTGWEx6p9p8OtGaFA8ixYPSj5oPo47HbSqaCLJSuzmgeAZ0Vfz
         +hyQsZsfgrH4hv80taG+hAdxskgo57toHAXDrvzDXPBH+denvHxvWQCpaunJP0tJ0xol
         AHvqBkgeUdvJ7aAl/BT37D6kx2g+d34x/9HciKNxvAGHSpjUuwh2LWuhJiLt4h1XuAbI
         3RS9mPHe1IltNeKEfrbJ6aViRlvFoBHDcL586oFZ/Bch29MsjtJYXfttAPizPgiwIlB0
         b6f//RPGXzIJWXRgAd+AHzT37UpzmdOF2osy+3s1FeOiTIfxzCkgEzZd+14TFy6DET4d
         KqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cVU0VI6SHUHssnCSIRaLHSdROjTj9L70izUE69+SVQI=;
        b=SfZPnZtL+aomgADbqkK5RX/pylrCttZlp4jfdlbchmfEDCs/oscqC2eanAm7nqUP/a
         O0RptdliP0Tsd1XpPPVWgp3EQtAlsCfmOcxGDYu/AQXpZJWnDl6M7KzUharAkxx7pAf+
         UN9QMzTeShUNAjG+zpyB6cmlNRWHZKAQLlXbuQncDv39n4Yn3SASF7wh9WFlMhpLiXA8
         xjWmLXehjUC1ppLHaI3EGppVe/e2/Xq0q4tzPVlU7tObAylVuSS8L8dgYsYNHEhE8U+q
         ubbB9lZ+yYPr3yE1Mrf8SuYNcCPlmfiwEgSoHwcjZZRnRa60oTWbYJfdEMk2i10xFXvH
         /M9w==
X-Gm-Message-State: AJIora/hgZFjf6ncwLqv4yO2x5oV0lXlWB51pYKg3CgksSo2WXYAxx4w
        SKfGjTqODkWzzkiYfMGLIFZeHVlRVLg=
X-Google-Smtp-Source: AGRyM1tatiGwuci6RJxBxVvQPCr3zGspVZ/NLawV19EmxifvkxeY8ns2E9FstJPf5054KmMmFH4zqg==
X-Received: by 2002:a17:902:ec8b:b0:16c:1cc2:6794 with SMTP id x11-20020a170902ec8b00b0016c1cc26794mr1290201plg.17.1657686498612;
        Tue, 12 Jul 2022 21:28:18 -0700 (PDT)
Received: from linux-l9pv.suse (123-194-153-158.dynamic.kbronet.com.tw. [123.194.153.158])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b0016c4f006603sm4732513plh.54.2022.07.12.21.28.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 21:28:18 -0700 (PDT)
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
Subject: [PATCH v9,4/4] Documentation/admin-guide/module-signing.rst: add openssl command option example for CodeSign EKU
Date:   Wed, 13 Jul 2022 12:24:21 +0800
Message-Id: <20220713042421.21680-5-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20220713042421.21680-1-jlee@suse.com>
References: <20220713042421.21680-1-jlee@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an openssl command option example for generating CodeSign extended
key usage in X.509 when CONFIG_CHECK_CODESIGN_EKU is enabled.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 Documentation/admin-guide/module-signing.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 7d7c7c8a545c..ca3b8f19466c 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -170,6 +170,12 @@ generate the public/private key files::
 	   -config x509.genkey -outform PEM -out kernel_key.pem \
 	   -keyout kernel_key.pem
 
+When ``CONFIG_CHECK_CODESIGN_EKU`` option is enabled, the following openssl
+command option should be added where for generating CodeSign extended key usage
+in X.509::
+
+        -addext "extendedKeyUsage=codeSigning"
+
 The full pathname for the resulting kernel_key.pem file can then be specified
 in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key therein will
 be used instead of an autogenerated keypair.
-- 
2.26.2

