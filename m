Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9292B5A1779
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiHYRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbiHYRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:01:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E18B81C9;
        Thu, 25 Aug 2022 10:01:11 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by6so20041215ljb.11;
        Thu, 25 Aug 2022 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=u+jxhx+TSXPwELwibZ9Ne8VEDzLYziqSPOhWXeVK9NQ=;
        b=g9icTPKZ50C2aRv1cQ/Eg4ys7nTZSRiFcJ2zCAb+gJrKiHTVoTmYR/NHsdjcORcX5A
         CMUMLyquYZLCz0a1nk6MvZkE+BgSPL0R2GQXFyluZxqpYdFowdG3e1wiKG1QbZo6i7i4
         un8avm4qBll+hR0duL6iuN8Yp/v3f4u7bfe/xZ0ZZXBhwqx8b25NruDqeUf5geiYy0Sq
         Uw0rZL2Y4WgivqDNhK95SR14yBf7eX3o8onD8VN/qus5WHihysKYD+L6QbTFZrGwI09v
         ZtrcS8HB4kUDEJQ+k2ospOievXGHuLA5IT5J1MQaEUBr0ICdQPcvokFxFiwWkLVhtkKt
         p+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=u+jxhx+TSXPwELwibZ9Ne8VEDzLYziqSPOhWXeVK9NQ=;
        b=u7I4IFsYgwgAFfzhF9aVLGHO55AfKbqV+JgQ79HDkQTlrDCJCLphtzwHsRuUldJwZ+
         nqD5TDj6Cxu9Xk0IT9ZYO5lA10Vciu/xxeOOvZHcjRnAX6bfgDe+jaKvaoWw9x378SW0
         JsCjEE+wHbZdN8NR1JfOLBe5Qa1Xw9wSZu9Moqpo5RSav0ly+B1NiAvY2e+ubR5E1erp
         8I6mYFyE7qooWZsPdOZv4kDUCPEViA+kLP5A+WXFW8APJMu8tLVnz28GJupYfWMn+rue
         Ps5upFKMOszyYhhHe9QOw6JcD3rYrVhobcAHoXr26oEouKMxdec9Y4YbXOCs619dgic7
         dx2A==
X-Gm-Message-State: ACgBeo3icBD78oJky10e08L4Ps6GVawSM9JpcXfBTZXDdapdROQC6LtJ
        SUWVPYJwwZ7jLVGQhBT1t/912bmeHIhq+aerzGE=
X-Google-Smtp-Source: AA6agR64ijqW88UieVoX/rrMRhMfRu/88/uDBRBGdOyjRgRF1a/EKjXyz8jeKBvTjdCRJYMbC6H3bPX8Coye3e6TQ0Q=
X-Received: by 2002:a05:651c:215:b0:261:d01e:2c1f with SMTP id
 y21-20020a05651c021500b00261d01e2c1fmr1280309ljn.345.1661446869891; Thu, 25
 Aug 2022 10:01:09 -0700 (PDT)
MIME-Version: 1.0
From:   Zixuan Tan <tanzixuan.me@gmail.com>
Date:   Fri, 26 Aug 2022 01:00:58 +0800
Message-ID: <CABwm_eTnARC1GwMD-JF176k8WXU1Z0+H190mvXn61yr369qt6g@mail.gmail.com>
Subject: [PATCH] perf/genelf: Switch deprecated openssl MD5_* functions to new
 EVP API
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zixuan Tan <tanzixuan.me@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the flavored EVP API like in test-libcrypto.c, and remove the
bad gcc #pragma.

Inspired-By: 5b245985a6de ("tools build: Switch to new openssl API for
test-libcrypto")
Signed-off-by: Zixuan Tan <tanzixuan.me@gmail.com>
---
 tools/perf/util/genelf.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 953338b9e887..ed28a0dbcb7f 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -30,10 +30,6 @@

 #define BUILD_ID_URANDOM /* different uuid for each run */

-// FIXME, remove this and fix the deprecation warnings before its removed and
-// We'll break for good here...
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 #ifdef HAVE_LIBCRYPTO_SUPPORT

 #define BUILD_ID_MD5
@@ -45,6 +41,7 @@
 #endif

 #ifdef BUILD_ID_MD5
+#include <openssl/evp.h>
 #include <openssl/md5.h>
 #endif
 #endif
@@ -142,15 +139,20 @@ gen_build_id(struct buildid_note *note,
 static void
 gen_build_id(struct buildid_note *note, unsigned long load_addr,
const void *code, size_t csize)
 {
-       MD5_CTX context;
+       EVP_MD_CTX *mdctx;

        if (sizeof(note->build_id) < 16)
                errx(1, "build_id too small for MD5");

-       MD5_Init(&context);
-       MD5_Update(&context, &load_addr, sizeof(load_addr));
-       MD5_Update(&context, code, csize);
-       MD5_Final((unsigned char *)note->build_id, &context);
+       mdctx = EVP_MD_CTX_new();
+       if (!mdctx)
+               errx(2, "failed to create EVP_MD_CTX");
+
+       EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
+       EVP_DigestUpdate(mdctx, &load_addr, sizeof(load_addr));
+       EVP_DigestUpdate(mdctx, code, csize);
+       EVP_DigestFinal_ex(mdctx, (unsigned char *)note->build_id, NULL);
+       EVP_MD_CTX_free(mdctx);
 }
 #endif

-- 
2.34.1
