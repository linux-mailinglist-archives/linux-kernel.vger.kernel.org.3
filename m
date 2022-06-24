Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DDA559B38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiFXOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiFXOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:14:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD9522F1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:14:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so4964411eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKXulITE9Q0m6cknypGbEmRTpbP1EjAz+x9d3E6n76w=;
        b=WM9CKv7gT7zU7vpTi0K3r/Fsy6hr4gErMi7Uhx5D8ZWXnpwp5nV2I0gK60bOy6ApgZ
         N+FYO0ZSwQlymxalgsy6Ly8Q1cs5EtqylTpQS1onazaNHh/QAdjOm3KjMf/62JIeutKb
         /jWPw7IEdDRFGplLRxf46VWEaEdZZWOh/4m33Se2FISi3Dl3NwV9wnuKTa24nsYmABJ+
         6otz6uRWjnEfm6bn3lLbrcClSs2+orNEyK/bGwTHYVu7ExjWONqFS8aiDdvhpg3REGlq
         G+gQnBLG1vcoYSdV29fPHmIqJ3cANv6ORw9MoocptJBf10RLiZW41aLsb9S46m86zMO7
         x1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKXulITE9Q0m6cknypGbEmRTpbP1EjAz+x9d3E6n76w=;
        b=fH/6TZOqYt2faDU9Iayhcg96weWcQz4lteBQ3rzDj4nKJbsqnTgK6CBv12OABwPuQM
         OQAsKz+18ce1ucMmxJdgT9x71VbQHVfRmBtnNdTqqPer0iWlfg8Ftj8SLSZ+lJR8Rh6y
         JttLuJQJJh73lRCYzc0CmpGOwo0GMRkiaSlCpGvR7hgUY8VfL3yiTeFCkrPcyX2HADvP
         cgTHbsdJmk6jmlWJcIC8IETPvHSaJeEysFc6G77PTgV3zB0SdPBAjiEh1hc/mOCv6m2j
         lnJQem7h7RQ5AbgXXagKz45V1mccAtmQ3R7SDpHcxFI9CozYgxt5nCZDTiTq+xNfOWkm
         HkuA==
X-Gm-Message-State: AJIora/jCYlTbKGXq8l2kl08c48bqkWmGskX4IDq12oKnNLFuxkWDaoS
        2B0XO7yugiYUgST2QBm+w2A=
X-Google-Smtp-Source: AGRyM1sE3SDEF4Pd9XY8EECtkkgUIIrqcrKa8ziYJNlqkepoOlzPnpihAXLlbRVuNdxcYbSlwgGvTg==
X-Received: by 2002:a17:907:97d4:b0:722:e550:7490 with SMTP id js20-20020a17090797d400b00722e5507490mr13935152ejc.625.1656080063750;
        Fri, 24 Jun 2022 07:14:23 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id j12-20020a1709064b4c00b00722e7e48dfdsm1162718ejv.218.2022.06.24.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 07:14:23 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] compiler-gcc.h: Remove ancient workaround for gcc PR 58670
Date:   Fri, 24 Jun 2022 16:14:12 +0200
Message-Id: <20220624141412.72274-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workaround for 'asm goto' miscompilation introduces a compiler
barrier quirk that inhibits many useful compiler optimizations. For
example, __try_cmpxchg_user compiles to:

   11375:	41 8b 4d 00          	mov    0x0(%r13),%ecx
   11379:	41 8b 02             	mov    (%r10),%eax
   1137c:	f0 0f b1 0a          	lock cmpxchg %ecx,(%rdx)
   11380:	0f 94 c2             	sete   %dl
   11383:	84 d2                	test   %dl,%dl
   11385:	75 c4                	jne    1134b <...>
   11387:	41 89 02             	mov    %eax,(%r10)

where the barrier inhibits flags propagation from asm when
compiled with gcc-12.

When the mentioned quirk is removed, the following code is generated:

   11553:	41 8b 4d 00          	mov    0x0(%r13),%ecx
   11557:	41 8b 02             	mov    (%r10),%eax
   1155a:	f0 0f b1 0a          	lock cmpxchg %ecx,(%rdx)
   1155e:	74 c9                	je     11529 <...>
   11560:	41 89 02             	mov    %eax,(%r10)

The refered compiler bug:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670

was fixed for gcc-4.8.2.

Current minimum required version of GCC is version 5.1 which has
the above 'asm goto' miscompilation fixed, so remove the workaround.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/compiler-gcc.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index a0c55eeaeaf1..9b157b71036f 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -66,17 +66,6 @@
 		__builtin_unreachable();	\
 	} while (0)
 
-/*
- * GCC 'asm goto' miscompiles certain code sequences:
- *
- *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
- *
- * Work it around via a compiler barrier quirk suggested by Jakub Jelinek.
- *
- * (asm goto is automatically volatile - the naming reflects this.)
- */
-#define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
-
 #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
-- 
2.35.3

