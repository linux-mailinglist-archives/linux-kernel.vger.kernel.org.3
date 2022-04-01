Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BFE4EFB6D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352104AbiDAUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352360AbiDAUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:23:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080028181A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:19:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e8216c4c46so35203057b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/q7CSXnA5KcPyL6yvbN6hU0mEK4VcrEfa9P7QXrPsno=;
        b=MiUIX6Azw4gtG61M0EgrFRKBvKyEQG/EVx3WfKgmJCOI1WbmZ3eVKWqXHsyJQizrwO
         USaqcbRG7X4MWf/4x5Ve8SrkgTr/4V2UhQq3N2IQIMVdXHwNBnNAm2md2xBbdiT2Or5i
         NArObT1io+WzbF1BzSRhOSHleYpxWaYGeh5J662TxIu/K7csviLub03/q2ALUH1dXwOD
         Jl2v0JTgK+Q1pKSweNXTYQNT267O7Y2usHG8mfxwatq/qiIYsfbMIxAPJJG/YmJwjp8/
         5mKaqSQNCOUhwgnL0G+iZqwgO/GywEELBAMnyqunFHlcgc1DJVMqgY1dilqcYoQtv5W+
         UQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/q7CSXnA5KcPyL6yvbN6hU0mEK4VcrEfa9P7QXrPsno=;
        b=O0WAg0+s3ia+i1DsDrFy/7p4n3fDriKKPkipxKGupGNAaq22p+xIXjP0riRXZA2NbM
         Mri3Gl5uSH7Z7Lfh8JTIdJmCBJ4F04mF1aL0zDKMOYttXVXBMtUxyT5PDAahBJfKrtf/
         TSE46p/aGgUdwRBfJkALLcAqM3ZiCc7Ap+sYvU5LiR5PpMoEuZT2Z0iGSco3H2C/8axJ
         +F1459UYY57ErjoEm2lnQ0PQ78HkzHtbQbA9oj/CwhE9+9aYlJ5oySZ5tc5HR0HTl3sy
         TdQ0zqGDrG7aqiAjOUFgccHvnSHxmQbhdBmOez1mU5SWt+cMaX4iJ32db1H7rw/zv9OI
         DtWA==
X-Gm-Message-State: AOAM5323KHiXeafWk+Ce5hRd8jBeaDDs0F7/venI6ufU/q305zngJqz/
        ZYElX9Pn964jc191mJCIkir2kvIIoe59KhFamSA=
X-Google-Smtp-Source: ABdhPJw1ufmCshm6xs5eFuvDkNHp0Doc5sHO9vZ7rTZ1C8L0VyRYzptcT0FB0O89vN84xvPmEeWDU2ZW5AP0eMggI8c=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ebe8:1acf:913c:f19e])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:150b:b0:639:f81:8179 with
 SMTP id q11-20020a056902150b00b006390f818179mr10164917ybu.31.1648844361283;
 Fri, 01 Apr 2022 13:19:21 -0700 (PDT)
Date:   Fri,  1 Apr 2022 13:19:14 -0700
In-Reply-To: <20220401201916.1487500-1-samitolvanen@google.com>
Message-Id: <20220401201916.1487500-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220401201916.1487500-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; h=from:subject;
 bh=7zO5jJOOB5O810+rUoHeiZO9VlITzF/f1cuVxYGtJV0=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBiR15CwOu77U++A+3akTihXXW47Ey1dwrsZdUhek8n
 HbC7HU+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYkdeQgAKCRBMtfaEi7xW7jNgC/
 9u4/tNF4JQ7D+noTqrl303CNHQm8GorY6FyAjWC07rJJryaMuFL93yb4bU75GxFtKpxj/fYIaSRV+X
 wS6AXBxfZQV6xonkBpPqmByjTDCB/eDPaoMPmqUkR6nmVE6lBybl2qQVu4UzjyV7SBwJI6CGxsM9cO
 K+CdjLl1ipQ+Xo+8OZ/t9jmcJsRCFRZxYv3oxFqZTVedEUxIMw01FsL0jQA/k1SYp9FCPwdMf5rDc/
 zCB8uqtggLCeBngSQ9wQlRpgnWxPt5lRvHO9UjTMUahmckUN+3F1FtKKVJYldjNtyAuXnpj21iZa9U
 ij3720OXjljPinXx1V7PMtX/wRkF8jvCX2jwyCLDKPpJQlGH+2yhDfSEoIcKlG9MWKB3m2k5hKh9pS
 wdaRKf5xbLUm3xS1j57Wlaeaei7EHSYPqj1WqVK0/svo+rz3g8XdXDfRHdhTbcqWvudqz1GYwMraNs
 klzsxlsrlC9LFSbv6jPvlcUA0QsjcyKwKpwZ3jgK1mn24=
X-Mailer: git-send-email 2.35.0
Subject: [PATCH 1/3] kbuild: Change CFI_CLANG to depend on __builtin_function_start
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang 14 added support for the __builtin_function_start()
built-in function, which allows us to implement function_nocfi()
without architecture-specific inline assembly. This patch changes
CONFIG_CFI_CLANG to depend on the built-in and effectively upgrades
the minimum supported compiler version for CFI to Clang 14.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/Kconfig | 5 +----
 init/Kconfig | 3 +++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 29b0167c088b..eecfc2809781 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -723,10 +723,7 @@ config ARCH_SUPPORTS_CFI_CLANG
 config CFI_CLANG
 	bool "Use Clang's Control Flow Integrity (CFI)"
 	depends on LTO_CLANG && ARCH_SUPPORTS_CFI_CLANG
-	# Clang >=3D 12:
-	# - https://bugs.llvm.org/show_bug.cgi?id=3D46258
-	# - https://bugs.llvm.org/show_bug.cgi?id=3D47479
-	depends on CLANG_VERSION >=3D 120000
+	depends on CC_HAS_BUILTIN_FUNCTION_START
 	select KALLSYMS
 	help
 	  This option enables Clang=E2=80=99s forward-edge Control Flow Integrity
diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..f024fd353373 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -86,6 +86,9 @@ config CC_HAS_ASM_INLINE
 config CC_HAS_NO_PROFILE_FN_ATTR
 	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) =
int x();' | $(CC) -x c - -c -o /dev/null -Werror)
=20
+config CC_HAS_BUILTIN_FUNCTION_START
+	def_bool $(success,echo 'void f(void) {}; void *p =3D __builtin_function_=
start(f);' | $(CC) -x c - -c -o /dev/null)
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
--=20
2.35.0

