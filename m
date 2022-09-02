Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53B5AB991
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIBUoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiIBUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:43:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B2FC314
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:43:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso6618144pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nXV/kYcxRGP4+PC/wC/E1WmMIMB/DEMUyjUxzaTreGw=;
        b=cHlmGDucWugffybtU1NXRpK84RfhetNHSyxRNpz4OPVFMNCPebRN6HUazGQvm8DxjM
         Ca5mMNM8lTvPGRnENwR8gECD6NiKDnXKaP2gbjBA6Inj1r56/1vaqNqDUIMbaxigFFBO
         AqXXJDP7flKezJmMXtpBKDn54dIz26/0Tg1ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nXV/kYcxRGP4+PC/wC/E1WmMIMB/DEMUyjUxzaTreGw=;
        b=2JH/y6GHhea+hsGkt0SA8PbYp8qJPBnp/SZprfz0+N806a+k+pmnhodT0NnkpdLpun
         sZK+vzWnKSvIMD9q1LORU7pfIwSfT6+SMqKBsibCZPyXeUeLFh/c6BhxwjvNsKIVfF5L
         ZT/TeIt6wPwwOOACuhWdJA4gD0ATQGMMNC5IMO4PxYFEegz7IHgdbtplTjZUhf6EafjV
         jxhMsNU2v5NVPoAOR/L5lWbJWeihXXPef7pw7afjulHj87SLuaj+Fq5wXyElyF/C86g0
         iUm/Zo8G5IhQlnCCAgvZfBmlH6N2NZrLTP4j7ZSXKdJdssiZ8zMBmEIx1a6MdxaBPRVH
         QHgQ==
X-Gm-Message-State: ACgBeo3/eD4tp0/RvxxlW5V77mLw8phkVvP7DcVCbbIP00g69amCK9gF
        5iZQYLKrYzXvp0Agiq3b6UNiag==
X-Google-Smtp-Source: AA6agR4OTKbaTPmi+l9Osgr3f3/iWEvZcmM5T5mq8YCP3H+BKdqRtF3oXu9Ht4jAVa9+ZFw4qzTJiA==
X-Received: by 2002:a17:903:32cd:b0:16f:c31:7034 with SMTP id i13-20020a17090332cd00b0016f0c317034mr36867541plr.126.1662151436441;
        Fri, 02 Sep 2022 13:43:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p5-20020aa79e85000000b0053826eaa1c7sm2242366pfq.22.2022.09.02.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:43:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL
Date:   Fri,  2 Sep 2022 13:43:49 -0700
Message-Id: <20220902204351.2521805-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902204351.2521805-1-keescook@chromium.org>
References: <20220902204351.2521805-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; h=from:subject; bh=DcSHHHF6kn1GliVVBN0Pagg+IpCny/Ui+zrhTxFh/Ig=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEmsGk86XdtCYEmOQCgPx8egB0fdSS3e9m2VZTI23 uTv0O9uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxJrBgAKCRCJcvTf3G3AJuYcD/ 46zM6qv3smVwB5rZ2yT5KmQ/6rKo6NAA9bRqTf+cVhi63JuonH9xJUJIGZG+MoTCKjisfYwnMSQzxC JzaNXj7WkEtgdnD0FwG7abuEJKIfgtU0XaT1fFJE99rSCXoGFWzhdvyDwLnhbPqN5xM7bKjP6fs8/i HA4rfsFA2io/zAKOKbS0LcUohuLvzpmhh1FooGaDJNFpmkJEp5NIInreEiryFnGjvFV/9u8ICW8qX0 jQRNsTRh/oUF/wY0O25PWfyGOHq+pdb2z54/j+NOAWzjvSC09LbnOygH+6S692/psVAj5EggYDO/jF f8Lnz+jjlp/EVUqaYqsolrBOll6bfzSPd0c2Ot/oNu0XcyCyDA88YD64pWvgJCl/kXs3Vi05qm2hKW rfGR2CUtas8Cde1LUKAq9J7g4RNLjvGpZFXPMdB2K2uNw3BrNl0AmxaxJuT96wAAi2Ugv6MuSu8It7 Pbll63lCPLIlUSq9WOFBnKwgmbE0EqA3Z+f7s2i68q+8cLdESF7EDzMJYLkY+oKbrUin5IwJsrNMx5 aYmXCyvApdqpJQxT0ApO0GH7YxI0gTCLPb62iCjDvlsyb4ekhTCgPwxydRAx6fujxccIrOhnhVCAMV +WTnx3IlX62a2AP+WQ7hZQiKnc4G2GYlnWz1ydiMrJAX0gNyARjrGALryXSA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_FORTIFY=y and CONFIG_UBSAN_LOCAL_BOUNDS=y enabled, we observe
a runtime panic while running Android's Compatibility Test Suite's (CTS)
android.hardware.input.cts.tests. This is stemming from a strlen()
call in hidinput_allocate().

__compiletime_strlen() is implemented in terms of __builtin_object_size(),
then does an array access to check for NUL-termination. A quirk of
__builtin_object_size() is that for strings whose values are runtime
dependent, __builtin_object_size(str, 1 or 0) returns the maximum size
of possible values when those sizes are determinable at compile time.
Example:

  static const char *v = "FOO BAR";
  static const char *y = "FOO BA";
  unsigned long x (int z) {
      // Returns 8, which is:
      // max(__builtin_object_size(v, 1), __builtin_object_size(y, 1))
      return __builtin_object_size(z ? v : y, 1);
  }

So when FORTIFY_SOURCE is enabled, the current implementation of
__compiletime_strlen() will try to access beyond the end of y at runtime
using the size of v. Mixed with UBSAN_LOCAL_BOUNDS we get a fault.

hidinput_allocate() has a local C string whose value is control flow
dependent on a switch statement, so __builtin_object_size(str, 1)
evaluates to the maximum string length, making all other cases fault on
the last character check. hidinput_allocate() could be cleaned up to
avoid runtime calls to strlen() since the local variable can only have
literal values, so there's no benefit to trying to fortify the strlen
call site there.

Perform a __builtin_constant_p() check against index 0 earlier in the
macro to filter out the control-flow-dependant case. Add a KUnit test
for checking the expected behavioral characteristics of FORTIFY_SOURCE
internals.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: David Gow <davidgow@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Sander Vanheule <sander@svanheule.net>
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Co-developed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index eed2119b23c5..07d5d1921eff 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -19,7 +19,8 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
 	unsigned char *__p = (unsigned char *)(p);		\
 	size_t __ret = (size_t)-1;				\
 	size_t __p_size = __builtin_object_size(p, 1);		\
-	if (__p_size != (size_t)-1) {				\
+	if (__p_size != (size_t)-1 &&				\
+	    __builtin_constant_p(*__p)) {			\
 		size_t __p_len = __p_size - 1;			\
 		if (__builtin_constant_p(__p[__p_len]) &&	\
 		    __p[__p_len] == '\0')			\
-- 
2.34.1

