Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5B4E6AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355450AbiCXWlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbiCXWlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:41:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F6BA32E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:39:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dc7bdd666fso47087707b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2UXOWK4H/ABoSS6KabIKT0cRAkKR0ZUPw5leAS4VA2Y=;
        b=mFrw/DyLpphzNFV0Nr7i6+kDrT0/C9GU5c4FP6bzXJk/QsrgjgdsN5pw+Twz+s6tGi
         qy25SacKdr9ipsWUo6trNsVmt+dTa/NxO3N5FT6aeXplL6+ZEw1LMGDWTo0PQCwb+Bvv
         4GDi1sgE7Jd6QRrZP/c4HReJ6wxGKYe3J8j58vlNKNI0HzHCFnfQgsW07wf12tX5ifUO
         PkWd0jUpPH/MCtF459clWjsDteS21Ykgbme/qNhmrt1Ttph7wf3EUSy9EX8Ao16PvJnO
         QLKcOxdXbMcH953M7Bj/sxYtgU4u2dWspJAXKFL7VZLBu7hfRoPYI0AbX+uq/222BMVD
         SSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2UXOWK4H/ABoSS6KabIKT0cRAkKR0ZUPw5leAS4VA2Y=;
        b=IYBYusjXhG7MlRPiDWUEq3FlaKgoFlrW9wIMt7lIhU+wPGRA3xRZ2uD6bLxOyhf0+s
         JyUtyKZjqAv4JCT8aSGOE9zKnT9sUzpwkEZ9PIT2n8KhV4QiT+POUJsSYpxQ964JTAbs
         R8s9cj1EL9JS+6cdynSuKR3Ap+5nF4B6wzfCnYO9QO3cz6VQ4LxCcK6tNCP2VTAaJ6GQ
         CVut12b1R4U6F01ZacfyhS9fgLukOpWKkgDq31F+GO96ajbpdsN/vvsp/jmaeHSWAI8C
         KHZErqTYjPoktnTqRpHtkHRBpZUzpOFlIkAAbb5XtD6GlEQp/NYzTAlQN0rWSai7g7Hv
         44lA==
X-Gm-Message-State: AOAM533I67Q+SabjvB2KLnHBXowGkzEB3ETJvlVx+ymoUnstYbMyB1nQ
        P2pxCK02DOtAHH8n0eeazgG6EduSIVMANdRxAQVE
X-Google-Smtp-Source: ABdhPJw4BH07SPiQZUc2OcEknGn2R1/wKMDadrW5rM6fMHjf1XTNKTbDi8N9qPU+6gv6J5NGI8IQbzzmpbGwWUQn91RR
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:9892:9f7f:2c27:2968])
 (user=axelrasmussen job=sendgmr) by 2002:a25:5f11:0:b0:633:ee0c:ab79 with
 SMTP id t17-20020a255f11000000b00633ee0cab79mr6599611ybb.491.1648161574585;
 Thu, 24 Mar 2022 15:39:34 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:39:28 -0700
Message-Id: <20220324223929.1893741-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 1/2] selftests: fix header dependency for pid_namespace selftests
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Axel Rasmussen <axelrasmussen@google.com>
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

The way the test target was defined before, when building with clang we
get a command line like this:

clang -Wall -Werror -g -I../../../../usr/include/ \
	regression_enomem.c ../pidfd/pidfd.h  -o regression_enomem

This yields an error, because clang thinks we want to produce both a *.o
file, as well as a precompiled header:

clang: error: cannot specify -o when generating multiple output files

gcc, for whatever reason, doesn't exhibit the same behavior which I
suspect is why the problem wasn't noticed before.

This can be fixed simply by using the LOCAL_HDRS infrastructure the
selftests lib.mk provides. It does the right think and marks the target
as depending on the header (so if the header changes, we rebuild), but
it filters the header out of the compiler command line, so we don't get
the error described above.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/pid_namespace/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/pid_namespace/Makefile b/tools/testing/selftests/pid_namespace/Makefile
index dcaefa224ca0..edafaca1aeb3 100644
--- a/tools/testing/selftests/pid_namespace/Makefile
+++ b/tools/testing/selftests/pid_namespace/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -g -I../../../../usr/include/
 
-TEST_GEN_PROGS := regression_enomem
+TEST_GEN_PROGS = regression_enomem
 
-include ../lib.mk
+LOCAL_HDRS += $(selfdir)/pidfd/pidfd.h
 
-$(OUTPUT)/regression_enomem: regression_enomem.c ../pidfd/pidfd.h
+include ../lib.mk
-- 
2.35.1.1021.g381101b075-goog

