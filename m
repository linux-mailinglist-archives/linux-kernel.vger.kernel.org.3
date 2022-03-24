Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C04E6AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355438AbiCXWlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiCXWlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:41:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E54ADD64
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:39:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j5-20020a056902020500b00628ab64be30so4625950ybs.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YffvJKmqGnNOFrJNUBozqcvaEBhfok9GG307YN+iOis=;
        b=rJBaV6pGwEOAZ5/DKw9WgYD8sOUIGzatpRwyLoMMfvhusF5BeyvsRwUwZWCNGuIDQ1
         nQB8oCdC9bv1EZ+2GtysbZIqyvqAenpHbQez/WxBwBE3CGVb3xXwPXtQKDi9eaWQ6y7j
         ZKrHVPDblW1plXoohNvFqYI+YSZ7lUzU+JDZLa+az53ILzpYvrYIYeB4+yyJZ67EEn+X
         fen1X83tGjPFdNkCIFZgPgVXkkcmBf7dBg8tE2ndTF7IzTTWpZI4Ahz8CtlYV5thWf5L
         xduypsO2tFYJpKt92zfyi3vjDV+lUkUnpditqzgfS6Zi5K3l63GEjp2/MNklpuAspxgA
         4uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YffvJKmqGnNOFrJNUBozqcvaEBhfok9GG307YN+iOis=;
        b=cOlZaxJNWwjXwl0EdodYkEIUbfq4YuDQAeRkDBEmsA8QXoZNb7NNlVScamlQ6INl4v
         Jl1n/AU3i/u3CUpONwgRl3UHAe6wPxkUbGuJH4laPsvTNi9SElQnZIGjO4xp3lUA/aHl
         Ag/ShjndzJ9xbtPQE1f+gauiX3zobLQEPmOEy1HlUHRnf47rlkXpIkkJyHifSUDLMLR5
         zXcD1urfhxWdt7Dm06r4rWvd3YnLVx9g6+pTHxrF5rophTRVbtlNz0F5Ns8Qn19nksU5
         JcTzhp8xy0oSycj735c97vblqUFc/8vWO8erlvi+uv9Zf0o7VOdWmK0AJzVfWmIRbaI7
         LVuA==
X-Gm-Message-State: AOAM532EyIP20VandXU8Gt4IUOByEoepi/aSB6NlZ68/tGTWCpt6UZFN
        5MoQ4XTlGLLrVb47vJXyy4DILgY/DIl6hRngOQpv
X-Google-Smtp-Source: ABdhPJzQniIe8bkEpjEUmGcF7TUYcFhdcZfxtrsrsS9hsTOunibTFJjXrnGim1HZIuwmtVj5ERBh+6ALOnRpNeXOLmhR
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:9892:9f7f:2c27:2968])
 (user=axelrasmussen job=sendgmr) by 2002:a25:3f87:0:b0:633:bbe5:c9d9 with
 SMTP id m129-20020a253f87000000b00633bbe5c9d9mr6992182yba.115.1648161576861;
 Thu, 24 Mar 2022 15:39:36 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:39:29 -0700
In-Reply-To: <20220324223929.1893741-1-axelrasmussen@google.com>
Message-Id: <20220324223929.1893741-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220324223929.1893741-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 2/2] selftests: fix an unused variable warning in pidfd selftest
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed a few warnings like this in commit e2aa5e650b07
("selftests: fixup build warnings in pidfd / clone3 tests"), but I
missed this one by mistake. Since this variable is unused, remove it.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/pidfd/pidfd_wait.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 17999e082aa7..070c1c876df1 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -95,7 +95,6 @@ TEST(wait_states)
 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
 		.exit_signal = SIGCHLD,
 	};
-	int ret;
 	pid_t pid;
 	siginfo_t info = {
 		.si_signo = 0,
-- 
2.35.1.1021.g381101b075-goog

