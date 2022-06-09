Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871F54544A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbiFISlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344341AbiFISlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:41:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B3D5F58;
        Thu,  9 Jun 2022 11:41:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p69so4266120iod.0;
        Thu, 09 Jun 2022 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=J5cO+c3VWDWtDGQ/VZ7m7J37V3VxlHs2DiTN4lG9LWo=;
        b=BL9BMdvGJ9MxlWwy9ZVGtasBIFO0h7IoiZzbnaN2vl91+O3NJ+Iw0yLV6RVC99IvhD
         86JPGwmsqmoJaNJpCyQV6hwlIHncCPGhTW94fUvs/p2jV9IfEoxIHmktiA4Kz6IR0g6Q
         Q9UqPDRzPd0S22lwBvprUTmGXjGpraD0zVmHmdKPJE+6J7JUzO6Czd8j/vClwZ5svDDv
         Vrj3qQFXLAXx2EycIuZ5X0Sd+Q/faorzp+olmiaPko9DmT+DGHs8cxdL5ASo0Mg4KS1k
         CyPSgjmFDBLHA+5TDSyWSyDmVckZIy1Hjz+kIISayWuyhwmMrUFPLX0FuG2MM5hC/P16
         1zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=J5cO+c3VWDWtDGQ/VZ7m7J37V3VxlHs2DiTN4lG9LWo=;
        b=MzrySM0Tjp9TXjBPSByYNtczqWukYl49u9+mnwK1g0eeaH9NqUiwJjbja1YfyO4iRx
         mvtOkM/Oh4xs2gTYm5oUDDIDzN1KVRbjP3zFHtNiktbn+WXg6fZyFDc6IgGm85O7YkLY
         Co8KTWViqN4U6oDQ2l1QOKw5pPxDPx9k59J0Ar8eYH1O+Ao1orvaD/Et11uuycMxwXVy
         jTEvKXI0sBFM3IibPpGehSmP/lgYtgQcfZ11NDHMgdjc70rKSR7Viq5q3yBcC4MPZ6Qd
         4w694n1HLjhdo0BNXWhniFs/gintxiM2DJgRBeaRolu/n8PxP4QPWeghHE7l7jl9Fnol
         J2Yg==
X-Gm-Message-State: AOAM531Tc4Ivg8LTUeO27JjZ033N6vCwrBH/Kl+xiLajuoYHwIyY/4W7
        fnM15gsS7Lbvdnbr0OnKEhXC9QX6XE7dfrIDhKve1pgMk2Je6g==
X-Google-Smtp-Source: ABdhPJz6CY50dDCLdogImfvRqktbIKrlHvxFMUeZcm5RPkahHgtr3MX9G+0D0aoTmiuMF2gx29aDSVmBUVtQ/Xl8hhA=
X-Received: by 2002:a6b:3ec4:0:b0:669:b9e6:cd97 with SMTP id
 l187-20020a6b3ec4000000b00669b9e6cd97mr449781ioa.128.1654800065076; Thu, 09
 Jun 2022 11:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com> <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
In-Reply-To: <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 9 Jun 2022 20:40:29 +0200
Message-ID: <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 6:05 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, May 27, 2022 at 9:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Tue, May 24, 2022 at 9:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Thu, May 19, 2022 at 12:01 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > [ CC Kees and Salvatore ]
> > > >
> > > > The Debian kernel-team ships a fix (4 hours young):
> > > >
> > > > commit: 13e234d459c11946efba647c3daf15e03abb0d99
> > > > "sign-file: Convert API usage to support OpenSSL v3"
> > > >
> > > > *untested*
> > >
> > > @Kees:
> > >
> > > Any updates on the part of certs/extract-cert.c?
> > >
> >
> > [ CC Tasmiya Nalatwad ]
> >
> > There are several more reports on this issue (see [3]).
> >
> > I did a quick test with Kees' patch from [2] and my attached patch
> > "extract-cert: Suppress warnings with OpenSSL v3 API".
> >
> > Now, I see no more warnings due to OpenSSL v3 API:
> >
> > $ egrep 'sign-file|extract-cert'
> > ../build-log_5.18.0-2-amd64-clang14-lto.txt
> > 176:  clang -Wp,-MMD,scripts/.sign-file.d -Wall -Wmissing-prototypes
> > -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11
> > -Wdeclaration-after-statement         -o scripts/sign-file
> > scripts/sign-file.c   -lcrypto
> > 2053:  clang -Wp,-MMD,certs/.extract-cert.d -Wall -Wmissing-prototypes
> > -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11
> > -Wdeclaration-after-statement       -Wno-deprecated-declarations   -o
> > certs/extract-cert certs/extract-cert.c   -lcrypto
> > 2068:  certs/extract-cert "" certs/x509_certificate_list
> > 2069:  certs/extract-cert "" certs/signing_key.x509
> >
> > config-5.18-dileks: LLVM-14 + CONFIG_LTO_CLANG_THIN=y
> >
> > -Sedat-
> >
> > [1] https://marc.info/?l=linux-keyrings&m=165330697801670&w=2
> > [2] https://salsa.debian.org/kernel-team/linux/-/commit/13e234d459c11946efba647c3daf15e03abb0d99
> > [3] https://marc.info/?l=linux-keyrings&m=165330697801670&w=2
> >
>
> [ CC James Bottomley ]
>
> [PATCH] extract-cert: Force build against OpenSSL API Compat v1.1.x
>
> ...works as well.
>
> -Sedat-
>

Why go back and forth... do it like Alexander the Great and the Gordian knot.

Sword - Swash - Done.

commit 6bfb56e93bcef41859c2d5ab234ffd80b691be35
"cert host tools: Stop complaining about deprecated OpenSSL functions"

-Sedat-

[1] https://git.kernel.org/linus/6bfb56e93bcef41859c2d5ab234ffd80b691be35

P.S.: BTW, perf needs also a openssl-v3 fix as well.

$ git show -1 for-5.19/openssl3-perf-dileks-20220605
commit 3cd76edba5753061b88acb22e9adaece0b9cb2b4
(for-5.19/openssl3-perf-dileks-20220605)
Author: Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun Jun 5 14:23:06 2022 +0200

   perf: openssl-v3: Force build against OpenSSL API Compat v1.1.x

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 73e0762092fe..4da73213f89b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -140,6 +140,7 @@ FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind
-llzma -lunwind-x86
FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64

FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
+FEATURE_CHECK_LDFLAGS-libcrypto += -DOPENSSL_API_COMPAT=0x10100000L

ifdef CSINCLUDES
  LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
@@ -780,6 +781,7 @@ ifndef NO_LIBCRYPTO
  else
    CFLAGS += -DHAVE_LIBCRYPTO_SUPPORT
    EXTLIBS += -lcrypto
+    EXTLIBS += -DOPENSSL_API_COMPAT=0x10100000L
    $(call detected,CONFIG_CRYPTO)
  endif
endif


$ git show -1 for-5.19/openssl3-extract_cert-dileks-v3-20220605
commit 730a634c8ea1814c13abfff490c8a5fc48a4e25e
(for-5.19/openssl3-extract_cert-dileks-v3-20220605)
Author: Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon Jun 6 10:14:57 2022 +0200

   extract-cert: openssl-v3: Force build against OpenSSL API Compat v1.1.x

diff --git a/certs/Makefile b/certs/Makefile
index bb904f90f139..c24f31107c6a 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -87,4 +87,5 @@ targets += x509_revocation_list
hostprogs := extract-cert

HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags
libcrypto 2> /dev/null)
+HOSTCFLAGS_extract-cert.o += -DOPENSSL_API_COMPAT=0x10100000L
HOSTLDLIBS_extract-cert = $(shell $(HOSTPKG_CONFIG) --libs libcrypto
2> /dev/null || echo -lcrypto)


$ git show -1 for-5.19/openssl3-sign_file-kees-20220518
commit 711a9d3ddccb1303a0b3b85166b86159ba8dcfa5
(for-5.19/openssl3-sign_file-kees-20220518)
Author: Kees Cook <keescook@chromium.org>
Date:   Wed May 18 14:51:29 2022 -0700

   sign-file: Convert API usage to support OpenSSL v3

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
   Tested-by: Shuah Khan <skhan@linuxfoundation.org>

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index fbd34b8e8f57..2d633c5f57c3 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -52,6 +52,10 @@
#include <openssl/pkcs7.h>
#endif

+#if OPENSSL_VERSION_MAJOR >= 3
+#define ERR_get_error_line(f, l)       ERR_get_error_all(f, l, NULL,
NULL, NULL)
+#endif
+
struct module_signature {
       uint8_t         algo;           /* Public-key crypto algorithm [0] */
       uint8_t         hash;           /* Digest algorithm [0] */
@@ -92,16 +96,6 @@ static void display_openssl_errors(int l)
       }
}

-static void drain_openssl_errors(void)
-{
-       const char *file;
-       int line;
-
-       if (ERR_peek_error() == 0)
-               return;
-       while (ERR_get_error_line(&file, &line)) {}
-}
-
#define ERR(cond, fmt, ...)                            \
       do {                                            \
               bool __cond = (cond);                   \
@@ -135,35 +129,14 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
static EVP_PKEY *read_private_key(const char *private_key_name)
{
       EVP_PKEY *private_key;
+       BIO *b;

-       if (!strncmp(private_key_name, "pkcs11:", 7)) {
-               ENGINE *e;
-
-               ENGINE_load_builtin_engines();
-               drain_openssl_errors();
-               e = ENGINE_by_id("pkcs11");
-               ERR(!e, "Load PKCS#11 ENGINE");
-               if (ENGINE_init(e))
-                       drain_openssl_errors();
-               else
-                       ERR(1, "ENGINE_init");
-               if (key_pass)
-                       ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
-                           "Set PKCS#11 PIN");
-               private_key = ENGINE_load_private_key(e, private_key_name,
-                                                     NULL, NULL);
-               ERR(!private_key, "%s", private_key_name);
-       } else {
-               BIO *b;
-
-               b = BIO_new_file(private_key_name, "rb");
-               ERR(!b, "%s", private_key_name);
-               private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
-                                                     NULL);
-               ERR(!private_key, "%s", private_key_name);
-               BIO_free(b);
-       }
-
+       b = BIO_new_file(private_key_name, "rb");
+       ERR(!b, "%s", private_key_name);
+       private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
+                                             NULL);
+       ERR(!private_key, "%s", private_key_name);
+       BIO_free(b);
       return private_key;
}

-EOT-

> > > >
> > > > On Thu, May 19, 2022 at 11:55 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > here, I am on Debian/unstable AMD64.
> > > > >
> > > > > Recently (or still) there is/was a transition to OpenSSL see below link.
> > > > >
> > > > > The warnings look like:
> > > > >
> > > > > 189:scripts/sign-file.c:89:14: warning: 'ERR_get_error_line' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 201:scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 213:scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines'
> > > > > is deprecated [-Wdeprecated-declarations]
> > > > > 225:scripts/sign-file.c:144:7: warning: 'ENGINE_by_id' is deprecated
> > > > > [-Wdeprecated-declarations]
> > > > > 238:146:7: warning: 'ENGINE_init' is deprecated [-Wdeprecated-declarations]
> > > > > 250:scripts/sign-file.c:151:9: warning: 'ENGINE_ctrl_cmd_string' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 262:scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 395:certs/extract-cert.c:46:14: warning: 'ERR_get_error_line' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 407:certs/extract-cert.c:59:9: warning: 'ERR_get_error_line' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 420:certs/extract-cert.c:124:3: warning: 'ENGINE_load_builtin_engines'
> > > > > is deprecated [-Wdeprecated-declarations]
> > > > > 432:certs/extract-cert.c:126:7: warning: 'ENGINE_by_id' is deprecated
> > > > > [-Wdeprecated-declarations]
> > > > > 444:certs/extract-cert.c:128:7: warning: 'ENGINE_init' is deprecated
> > > > > [-Wdeprecated-declarations]
> > > > > 456:certs/extract-cert.c:133:9: warning: 'ENGINE_ctrl_cmd_string' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 468:certs/extract-cert.c:134:3: warning: 'ENGINE_ctrl_cmd' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > >
> > > > > More detailed output:
> > > > >
> > > > > 189:scripts/sign-file.c:89:14: warning: 'ERR_get_error_line' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 190-        while ((e = ERR_get_error_line(&file, &line))) {
> > > > > 191-                    ^
> > > > > 192-/usr/include/openssl/err.h:410:1: note: 'ERR_get_error_line' has
> > > > > been explicitly marked deprecated here
> > > > > 193-OSSL_DEPRECATEDIN_3_0
> > > > > 194-^
> > > > > 195-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > > 196-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > > 197-                                                ^
> > > > > 198-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > > 'OSSL_DEPRECATED'
> > > > > 199-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > > 200-                                                   ^
> > > > > 201:scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 202-        while (ERR_get_error_line(&file, &line)) {}
> > > > > 203-               ^
> > > > > 204-/usr/include/openssl/err.h:410:1: note: 'ERR_get_error_line' has
> > > > > been explicitly marked deprecated here
> > > > > 205-OSSL_DEPRECATEDIN_3_0
> > > > > 206-^
> > > > > 207-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > > 208-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > > 209-                                                ^
> > > > > 210-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > > 'OSSL_DEPRECATED'
> > > > > 211-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > > 212-                                                   ^
> > > > > 213:scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines'
> > > > > is deprecated [-Wdeprecated-declarations]
> > > > > 214-                ENGINE_load_builtin_engines();
> > > > > 215-                ^
> > > > > 216-/usr/include/openssl/engine.h:358:1: note:
> > > > > 'ENGINE_load_builtin_engines' has been explicitly marked deprecated
> > > > > here
> > > > > 217-OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
> > > > > 218-^
> > > > > 219-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > > 220-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > > 221-                                                ^
> > > > > 222-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > > 'OSSL_DEPRECATED'
> > > > > 223-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > > 224-                                                   ^
> > > > > 225:scripts/sign-file.c:144:7: warning: 'ENGINE_by_id' is deprecated
> > > > > [-Wdeprecated-declarations]
> > > > > 226-                e = ENGINE_by_id("pkcs11");
> > > > > 227-                    ^
> > > > > 228-/usr/include/openssl/engine.h:336:1: note: 'ENGINE_by_id' has been
> > > > > explicitly marked deprecated here
> > > > > 229-OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
> > > > > 230-^
> > > > > 231-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > > 232-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > > 233-                                                ^
> > > > > 234-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > > 'OSSL_DEPRECATED'
> > > > > 235-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > > 236-                                                   ^
> > > > > 237-scripts/sign-file.c:   ld.lld -r -o
> > > > > /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86/objtool-in.o
> > > > > /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86
> > > > > /special.o /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86/decode.o
> > > > > 238:146:7: warning: 'ENGINE_init' is deprecated [-Wdeprecated-declarations]
> > > > > 239-                if (ENGINE_init(e))
> > > > > 240-                    ^
> > > > > 241-/usr/include/openssl/engine.h:620:1: note: 'ENGINE_init' has been
> > > > > explicitly marked deprecated here
> > > > > 242-OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
> > > > > 243-^
> > > > > 244-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > > 245-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > > 246-                                                ^
> > > > > 247-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > > 'OSSL_DEPRECATED'
> > > > > 248-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > > 249-                                                   ^
> > > > > 250:scripts/sign-file.c:151:9: warning: 'ENGINE_ctrl_cmd_string' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 251-                        ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
> > > > > 252-                             ^
> > > > > 253-/usr/include/openssl/engine.h:478:1: note:
> > > > > 'ENGINE_ctrl_cmd_string' has been explicitly marked deprecated here
> > > > > 254-OSSL_DEPRECATEDIN_3_0
> > > > > 255-^
> > > > > 256-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > > 257-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > > 258-                                                ^
> > > > > 259-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > > 'OSSL_DEPRECATED'
> > > > > 260-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > > 261-                                                   ^
> > > > > 262:scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is
> > > > > deprecated [-Wdeprecated-declarations]
> > > > > 263-                private_key = ENGINE_load_private_key(e, private_key_name,
> > > > > 264-                              ^
> > > > > 265-/usr/include/openssl/engine.h:637:1: note:
> > > > > 'ENGINE_load_private_key' has been explicitly marked deprecated here
> > > > > 266-OSSL_DEPRECATEDIN_3_0
> > > > > 267-^
> > > > > 268-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > > 269-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > > 270-                                                ^
> > > > > 271-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > > 'OSSL_DEPRECATED'
> > > > > 272-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > > 273-
> > > > >
> > > > > Relevant OpenSSL v3.0.3 header files are attached.
> > > > > My kernel-config, too.
> > > > >
> > > > > If you need further information, please let me know.
> > > > >
> > > > > Regards,
> > > > > -Sedat-
> > > > >
> > > > > [1] https://release.debian.org/transitions/html/auto-openssl.html
