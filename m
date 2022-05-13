Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AFC525D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378324AbiEMIcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378277AbiEMIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:32:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB606352A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:32:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so66739147b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hUQluwx+IeHDQbtP0fjL9XDhdITsEoJIWpp8L9h5giw=;
        b=F/cDv7XyzfAhrhFHas6iEitptBabeLxs7JYySMnnIYCMoVWQlm1aMRtE+/SqhaEDNm
         CUtVY8Whw9qTUb+f6i/9SrNwUqK//hLviYObbOgELsaAp+e5PQTys3VZGSOL11haUR2h
         JXi3PzXSBFhTXTg6T1Af2lQ5jg98qlb1DqYvd/5im6SSwHSqg3+18b/zRgwbpeniHh5w
         dFaHx//RRMeVVvYwkpThQ2ynlPG4D3Z6TPN9+uRk3fk2kHCiIjA3uT5TTFvKie7Uwrfj
         xvGnEU8+v1psGFcZQC5sVKJwY5jyAB/aWooaKwolISkK6dLklWtYlS3y29i6SEb8U5+M
         i2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hUQluwx+IeHDQbtP0fjL9XDhdITsEoJIWpp8L9h5giw=;
        b=GuO8SK3D/KkVHsDh9kGEBLF0wX0fomowdt0OQrWtvJXlOOz+8Q32VV0fzjR0Jb6FOj
         sjAcSt6TaUguretk3YSSuk0q0p9cEB+jr7YLEtT4lRPbwxsGUyedgmvSTxFxokHT78PE
         Lm6w5ONNHbzzmJxGvvKVic8suazPZYWlshv3vQHvNzFItjw5HW8nR/QLP1CamhCVvQFk
         LyFFt+WORTq4YNC29jTFFaKAVdlOR03BHWKBJvClhEC75UIi3wifvkQIZHt+yR7YgCxE
         74uMGf14XPHjMhnnY6FdpN+z1q6i08lxWgHQFk3UkeJla4I1ecIfBe6+Gl57lM7c/fRy
         rTGw==
X-Gm-Message-State: AOAM5318z6Psw2ZoTiOVQBxnSF7mnzmv7sTGSOJJKmsMy1rkWO4vKr0I
        6fSaYsYkyommLwA8BTmY3GNmrpYtl88fpg==
X-Google-Smtp-Source: ABdhPJz63iUUnCr3zTam4iVPENkFDo9Hk9l7LA5hxnjO3aj6X2c1blool5DQ+WglykBzpsoKBGog87zoHV/MCQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:d689:0:b0:2fb:9a57:8517 with SMTP id
 y131-20020a0dd689000000b002fb9a578517mr4235720ywd.502.1652430747159; Fri, 13
 May 2022 01:32:27 -0700 (PDT)
Date:   Fri, 13 May 2022 16:32:11 +0800
In-Reply-To: <20220429043913.626647-1-davidgow@google.com>
Message-Id: <20220513083212.3537869-1-davidgow@google.com>
Mime-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 1/3] panic: Taint kernel if tests are run
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most in-kernel tests (such as KUnit tests) are not supposed to run on
production systems: they may do deliberately illegal things to trigger
errors, and have security implications (for example, KUnit assertions
will often deliberately leak kernel addresses).

Add a new taint type, TAINT_TEST to signal that a test has been run.
This will be printed as 'N' (originally for kuNit, as every other
sensible letter was taken.)

This should discourage people from running these tests on production
systems, and to make it easier to tell if tests have been run
accidentally (by loading the wrong configuration, etc.)

Signed-off-by: David Gow <davidgow@google.com>
---

Updated this to handle the most common case of selftest modules, in
addition to KUnit tests. There's room for other tests or test frameworks
to use this as well, either with a call to add_taint() from within the
kernel, or by writing to /proc/sys/kernel/tainted.

The 'N' character for the taint is even less useful now that it's no
longer short for kuNit, but all the letters in TEST are taken. :-(

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220430030019.803481-1-davidgow@google.com/
- Rename TAINT_KUNIT -> TAINT_TEST.
- Split into separate patches for adding the taint, and triggering it.
- Taint on a kselftest_module being loaded (patch 3/3)

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220429043913.626647-1-davidgow@google.com/
- Make the taint per-module, to handle the case when tests are in
  (longer lasting) modules. (Thanks Greg KH).

Note that this still has checkpatch.pl warnings around bracket
placement, which are intentional as part of matching the surrounding
code.

---
 Documentation/admin-guide/tainted-kernels.rst | 1 +
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index ceeed7b0798d..546f3071940d 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
+ 18  _/N  262144  an in-kernel test (such as a KUnit test) has been run
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
diff --git a/include/linux/panic.h b/include/linux/panic.h
index f5844908a089..2f5f2a9ecaf7 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -74,7 +74,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_TEST			18
+#define TAINT_FLAGS_COUNT		19
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index eb4dfb932c85..1cf707e3bacd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -404,6 +404,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_TEST ]			= { 'N', ' ', true },
 };
 
 /**
-- 
2.36.0.550.gb090851708-goog

