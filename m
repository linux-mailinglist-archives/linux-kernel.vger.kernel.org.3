Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A552C5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiERWCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiERWCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:02:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABF99687
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 14:51:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i24so3348118pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlileXECXQwcs4FwBCFGgd9tlzU7JPOtD7+Op7dKw2A=;
        b=Ku1CxZ7SlLE9GBbQ8dzXmhq85kFZNi5vcrvHKOMNhhhVvvOh3k+JTtG1I91mqxOvPz
         LxpEDdwdyUv3b7kshP/C7OV8Xnvt6lTCj47UuL95QjfjiaxUgz2OBHUsP5Srhkx1kCIy
         4K5H099dlnW9vAKbuow+u2t6st3v9RVot6OcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlileXECXQwcs4FwBCFGgd9tlzU7JPOtD7+Op7dKw2A=;
        b=3gb118uJxn27xFpOOb5VgqByIuik38M1PGnmXisyDw7Rpeww5i5OhwK45NhSJ995x2
         U7DECe9A/Y3p6U6gVR7/6QgeXDXcCO2iQniUTA4a/oPxa87qm1EMQXRYlFvJmAVbQ0Hh
         fif1nWCE9JIz1O6Js3n5B4bamtYUkgwhLgzloz30MaUjmJ2fhE83/g1P2nR2D1a+cD1k
         YVY8UGqNRHrdoj3ju18q+XVUIQIFfpSiESXjXcQveV+eRAroWpno1dy0uHX172qWLpqo
         ytpYz6rUGrX8Ortw4q0vWtvGOGtmgUVcxdA8L1pfVhJoK3Xz8GYbqTCQ7xwgzSNplYFq
         S/bw==
X-Gm-Message-State: AOAM5311O+Op1c5/ilxATOvg2RwkB3rUFwQQ+NbwUlBgkNaA63Vsprp0
        EpJAK7bFsC0G5iSboNSM7+2LSA==
X-Google-Smtp-Source: ABdhPJx5zkS+wcjiBUuPi4E4o4+onZ93b/N6GptRLkvIzlS3sA/PCVWVNd99O1FMK2DLDlCQ9qFAWw==
X-Received: by 2002:a63:2c01:0:b0:3db:5e24:67f8 with SMTP id s1-20020a632c01000000b003db5e2467f8mr1256683pgs.372.1652910695229;
        Wed, 18 May 2022 14:51:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a928900b001d92e2e5694sm4153624pjo.1.2022.05.18.14.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 14:51:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] sign-file: Convert API usage to support OpenSSL v3
Date:   Wed, 18 May 2022 14:51:29 -0700
Message-Id: <20220518215129.264872-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057; h=from:subject; bh=QlyfmW5tdA+uLyxr7PSBpgInoqAH8CjIlte2jMmmCSk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihWpg7oF3z/IhRHBvgWCBLQG1wB92GJbkzLV7JT+D Wb5E12+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoVqYAAKCRCJcvTf3G3AJkWnD/ 4n+7O3v/HOHC7LCGNI91a9+Q0utWAK/W5HL/4mZ5izGsoZpD4QoVAQmM2qZVQZMa4cnX2cl8dz3x0d 0wNUq5XM3nEs1aWWWVa4ZHllXFHe+LyXbWCB/zd0sQzIZ2qPALm/H1/uWy685YEyRy1umNXP81xNUn Cyint3G5gCdXUki5OTBXriJMcQTL32nfOscwjeGwnbV0SSRyv7L4aXkvnFkZPe1bLDVwr7gsr8w95h j5raVbRgsFtVHc7t74qEkQC51p5awAFRoziJWA0IiDKlFA8pMmzBblAWI4RQsIeb84EtneWUy2hbmY i80Hr7r1knxsn5vH2ocLDdIv12u2o3jJ9AebZYXN2rvPiw3jkVfP8iaa3x/PqwDbgAxQ/IBDHasYwV rCoU4X/dLo4vSu4PeilPUhrX4xMEjmtsZOm1JGmcCeoQMvXgXwdLpIWmc69VgsroCL+FDu/JrqhQUl SgqNBinCjl7H4k9I9HjxfcURhqV0pMD8vdemQr0i5X1gdXsHIO029Ye3iKhP05Hf5nmNeKrPI+RDwO /DWX61tE6ZZIDbddTAg79kfXIiXztoqMdfq+aVy+PoOl7WWq7XafjBvZkgRYkGI+cuJvlUBaX06x7G iP5KTwpdSTQqPVkOowMgyG1mWzEjBmyP2egZbsDBYRCUnI8TrIFoAU54V72g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OpenSSL's ENGINE API is deprecated in OpenSSL v3.0, along with some
other functions. Remove the ENGINE use and a macro work-around for
ERR_get_error_line().

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: keyrings@vger.kernel.org
Suggested-by: Adam Langley <agl@google.com>
Co-developed-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20211005161833.1522737-1-lee.jones@linaro.org/
v2: https://lore.kernel.org/lkml/Yicwb+Ceiu8JjVIS@google.com/
v3:
 - Eliminate all the build warnings with OpenSSL 3
 - Fully remove ENGINE usage, if it can be optional, just drop it.
---
 scripts/sign-file.c | 49 ++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 38 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index fbd34b8e8f57..2d633c5f57c3 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -52,6 +52,10 @@
 #include <openssl/pkcs7.h>
 #endif
 
+#if OPENSSL_VERSION_MAJOR >= 3
+#define ERR_get_error_line(f, l)	ERR_get_error_all(f, l, NULL, NULL, NULL)
+#endif
+
 struct module_signature {
 	uint8_t		algo;		/* Public-key crypto algorithm [0] */
 	uint8_t		hash;		/* Digest algorithm [0] */
@@ -92,16 +96,6 @@ static void display_openssl_errors(int l)
 	}
 }
 
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
 #define ERR(cond, fmt, ...)				\
 	do {						\
 		bool __cond = (cond);			\
@@ -135,35 +129,14 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
 static EVP_PKEY *read_private_key(const char *private_key_name)
 {
 	EVP_PKEY *private_key;
+	BIO *b;
 
-	if (!strncmp(private_key_name, "pkcs11:", 7)) {
-		ENGINE *e;
-
-		ENGINE_load_builtin_engines();
-		drain_openssl_errors();
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
-		if (ENGINE_init(e))
-			drain_openssl_errors();
-		else
-			ERR(1, "ENGINE_init");
-		if (key_pass)
-			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
-			    "Set PKCS#11 PIN");
-		private_key = ENGINE_load_private_key(e, private_key_name,
-						      NULL, NULL);
-		ERR(!private_key, "%s", private_key_name);
-	} else {
-		BIO *b;
-
-		b = BIO_new_file(private_key_name, "rb");
-		ERR(!b, "%s", private_key_name);
-		private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
-						      NULL);
-		ERR(!private_key, "%s", private_key_name);
-		BIO_free(b);
-	}
-
+	b = BIO_new_file(private_key_name, "rb");
+	ERR(!b, "%s", private_key_name);
+	private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
+					      NULL);
+	ERR(!private_key, "%s", private_key_name);
+	BIO_free(b);
 	return private_key;
 }
 
-- 
2.32.0

