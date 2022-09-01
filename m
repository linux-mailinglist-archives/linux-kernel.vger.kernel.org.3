Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972925A9E87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiIAR7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIAR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:59:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D383A78236
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:59:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i6-20020a259786000000b0069648392979so4954211ybo.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=Eznf++i6Hiz/WgIi82JzYKRSk0zp5tPqXtS/6z0a6sk=;
        b=h9YGObLHX574s+ltrn3qvuINtF7Mwp9izXYVcU/MiCMtbC+bh3egxPZtvsTwVTeAgG
         6b6GeDMbE4/+glo+q8cl6aUxaA+++6QSpSkAdZMgFF6EIZpx1z5hW02V/L8/QIz3FpLO
         oqexKNlYmrdBv5ZelOAxDTWCzejmPXDdexwdovsenVp34C20CiuugavdpmX7tvxTJ1Om
         9G0v9guIwUOxCTW2b+k3/6QZxkIy9lyrDQpyqXxFpLCup5veGSRnxx+oqVUk4S6to6SR
         0se0Vmp+9gjWe0RXXJSRyDvTMdL3SlJW071KmqmdpuMRVqg5s10e1OA7yogkADN2GxN9
         4Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Eznf++i6Hiz/WgIi82JzYKRSk0zp5tPqXtS/6z0a6sk=;
        b=g78qm9SUlJ2bDU4aPXfoPoStYjf2Je7RenyaYIpJiY5mOqHxemS0qFx1PK1gWnuzPy
         9imNTFyRsj7AFQIfHbf6pX+F4TaAwW0bdZnLkddjZxOzRfJJMDLVlLQtxQEep14cQi5s
         zpyt3sqiMYnqoFrbIKf07kpJMIFF1k76wIurzgNwigR2dvjuYbCQqtfXzxk8fcw1S/N4
         teoVYiYC3kXDvYMH1OZB0/wAPtkWiO15/M8YKULKlOdaaOdCVIbfZCH2peijBh9Axe3o
         f6w5BZ9RdH1PEMhCCCy1BRl+hps8j5tNIfO/m2/fDT4zyWvAa3OcMoUfDlS/Boduy29G
         OcOA==
X-Gm-Message-State: ACgBeo2BMTbq+8mZ0hYg8OH0xaC+Vm8SbogHH/9QiklkHi7n4XySZ9dk
        pnvF9lGVxuW6g/sSDm1CAiZhXib97FQQB19wPII=
X-Google-Smtp-Source: AA6agR6RJOq/gy/EH6yiM3DkBfPhDnWdLGHnc6wAPOgfY+13FEVuqxmoAP2HSwm1jTlTOzhNNaAj/fpOCZD6V1SfPis=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:99db:dcd4:6e34:2651])
 (user=ndesaulniers job=sendgmr) by 2002:a81:149:0:b0:33d:b55e:7e7a with SMTP
 id 70-20020a810149000000b0033db55e7e7amr24083872ywb.413.1662055165101; Thu,
 01 Sep 2022 10:59:25 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:59:13 -0700
In-Reply-To: <CAHk-=wiW_LjFRE9wFMj-j2gp9=u8jqrMVZtT3n4-oJWtQ6E0iQ@mail.gmail.com>
Mime-Version: 1.0
References: <CAHk-=wiW_LjFRE9wFMj-j2gp9=u8jqrMVZtT3n4-oJWtQ6E0iQ@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662055153; l=3012;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=9aydxQMib3Wu+j+JM/2pa56zYSBHnbBYkj5Ry7clV1E=;
 b=V5pYURGX/bQh0MwFkI4b7b7jGl3OPcO1iK4p/wUDPggm9TysXodSu4OtOQNYCGxI1z+nJKDhCRmX
 6yxh8RG3BC4kr39mCeEaGf9u65MRqo6o2+OYMNjIzi3V7kaX4jzw
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901175913.2183047-1-ndesaulniers@google.com>
Subject: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang; take 2
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Justin Stitt <jstitt007@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Wformat was recently re-enabled for builds with clang, then quickly
re-disabled, due to concerns stemming from the frequency of default
argument promotion related warning instances.

commit 258fafcd0683 ("Makefile.extrawarn: re-enable -Wformat for clang")
commit 21f9c8a13bb2 ("Revert "Makefile.extrawarn: re-enable -Wformat for clang"")

ISO WG14 has ratified N2562 to address default argument promotion
explicitly for printf, as part of the upcoming ISO C2X standard.

The behavior of clang was changed in clang-16 to not warn for the cited
cases in all language modes.

Add a version check, so that users of clang-16 now get the full effect
of -Wformat. For older clang versions, re-enable flags under the
-Wformat group that way users still get some useful checks related to
format strings, without noisy default argument promotion warnings. I
intentionally omitted -Wformat-y2k and -Wformat-security from being
re-enabled, which are also part of -Wformat in clang-16.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Link: https://github.com/llvm/llvm-project/issues/57102
Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2562.pdf
Suggested-by: Justin Stitt <jstitt007@gmail.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Linus, I figured I'd send this to you to see whether you'd prefer to
apply it, or let it "ride the trains" up through the kbuild tree? I do
have another series I'm working on to improve the compiler version
checks
<https://lore.kernel.org/llvm/20220831184408.2778264-4-ndesaulniers@google.com/>
where I can/will improve the checks used here, but I'm also interested in
having something that might backport cleanly to stable.

 scripts/Makefile.extrawarn | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 0621c39a3955..6ae482158bc4 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -47,7 +47,19 @@ else
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Wno-initializer-overrides
+# Clang before clang-16 would warn on default argument promotions.
+ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -lt 160000 ] && echo y),y)
+# Disable -Wformat
 KBUILD_CFLAGS += -Wno-format
+# Then re-enable flags that were part of the -Wformat group that aren't
+# problematic.
+KBUILD_CFLAGS += -Wformat-extra-args -Wformat-invalid-specifier
+KBUILD_CFLAGS += -Wformat-zero-length -Wnonnull
+# Requires clang-12+.
+ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -ge 120000 ] && echo y),y)
+KBUILD_CFLAGS += -Wformat-insufficient-args
+endif
+endif
 KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare

base-commit: 2880e1a175b9f31798f9d9482ee49187f61b5539
-- 
2.37.2.789.g6183377224-goog

