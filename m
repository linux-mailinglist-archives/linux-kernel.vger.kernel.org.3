Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2994DE4F0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiCSBBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiCSBBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:01:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CAF9BBAA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:00:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d7so13759390wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCgXmCF718Hrjp6zjP2ObsCDhynsffIoLOmT0oY7piI=;
        b=WtFcWDQ9K/wlk1pJX5HrnJ+O9tANSJHZLPqNmqRSHsIAVj803Y5ZHrN/mP9vsOBBrq
         bE5dbOAxe6N9JrJ9Ni79S28Bkzm7ANWU3zoeKkC2RWH+e1V2N6GE3rBoW8GrSf6vYeI+
         T9f3++f3DY0WEu7MGnPuNJMswCVbah/kpBz6MnWA1O3OZDLaNYgMWRzr478WrMQfheFj
         drOaLp5ZpmcH823IdNCyPJQ0hqo7osBXdh5f0iwUilFpcIPuHflGhsCIsXCvmkLhNcfX
         QJ1vf1NvGFCXfQYydx3gt0HrPKIRLQENHEVAhEX2uG2K7O8jlBUmF8NIDs2zyeRIJH+9
         OY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCgXmCF718Hrjp6zjP2ObsCDhynsffIoLOmT0oY7piI=;
        b=lVJzhasHNforfu6LDLX1DNnz78W0l/DzeYpzd7OwWReJhbxDKhSsSlzOfz6FZKlXUd
         0E2MBtTBn1nHVX8iKoz4BkF7ASSPBOCkfZ9eh3fNA0egIbY90b0t71QriSyE6XDNNek1
         CABSrHtCqOm68dxdi0IRqiZE57sm5o9tycker1cZ9A53Lm1FpcB9rf5rF0n6NBjO6bun
         26ICdLZy0JdQd56SefEpzUR3p7sM7fGGuRGg0th33RNsaaotwunEWQbaYz7jV15+QYeE
         uqrs+j+Ikf9D+IzXJ+s6FzsrXF+6yWmbrlrCHhYfUqW6k5YiMpf7AuQ1PuK2uW/pWKPH
         yNAw==
X-Gm-Message-State: AOAM532syq0PxCZGKDW0HO55gqGx75Y2emIUbAsBQprcn6PeRRqlfqs1
        L+DctYh94vzwtCty0Rx6UlhDE7B646bmiw==
X-Google-Smtp-Source: ABdhPJzAfVwdsmMy2QNjKZpbWpTsi5200cUlkB1ixbXlTpV3AIZoaYYRRH+/jX/s+K0eAe5UTjJSUA==
X-Received: by 2002:adf:f881:0:b0:203:f9b1:a6ab with SMTP id u1-20020adff881000000b00203f9b1a6abmr3309208wrp.410.1647651617266;
        Fri, 18 Mar 2022 18:00:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:4d9a:ad76:b339:c04b])
        by smtp.gmail.com with ESMTPSA id 189-20020a1c02c6000000b0038c57df82aasm7979491wmc.20.2022.03.18.18.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 18:00:16 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: [PATCH] selftests/seccomp: Don't call read() on TTY from background pgrp
Date:   Sat, 19 Mar 2022 02:00:11 +0100
Message-Id: <20220319010011.1374622-1-jannh@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 92d25637a3a4 ("kselftest: signal all child processes"), tests
are executed in background process groups. This means that trying to read
from stdin now throws SIGTTIN when stdin is a TTY, which breaks some
seccomp selftests that try to use read(0, NULL, 0) as a dummy syscall.

The simplest way to fix that is probably to just use -1 instead of 0 as
the dummy read()'s FD.

Fixes: 92d25637a3a4 ("kselftest: signal all child processes")
Signed-off-by: Jann Horn <jannh@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/=
selftests/seccomp/seccomp_bpf.c
index 9d126d7fabdb..313bb0cbfb1e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -955,7 +955,7 @@ TEST(ERRNO_valid)
 	ASSERT_EQ(0, ret);
=20
 	EXPECT_EQ(parent, syscall(__NR_getppid));
-	EXPECT_EQ(-1, read(0, NULL, 0));
+	EXPECT_EQ(-1, read(-1, NULL, 0));
 	EXPECT_EQ(E2BIG, errno);
 }
=20
@@ -974,7 +974,7 @@ TEST(ERRNO_zero)
=20
 	EXPECT_EQ(parent, syscall(__NR_getppid));
 	/* "errno" of 0 is ok. */
-	EXPECT_EQ(0, read(0, NULL, 0));
+	EXPECT_EQ(0, read(-1, NULL, 0));
 }
=20
 /*
@@ -995,7 +995,7 @@ TEST(ERRNO_capped)
 	ASSERT_EQ(0, ret);
=20
 	EXPECT_EQ(parent, syscall(__NR_getppid));
-	EXPECT_EQ(-1, read(0, NULL, 0));
+	EXPECT_EQ(-1, read(-1, NULL, 0));
 	EXPECT_EQ(4095, errno);
 }
=20
@@ -1026,7 +1026,7 @@ TEST(ERRNO_order)
 	ASSERT_EQ(0, ret);
=20
 	EXPECT_EQ(parent, syscall(__NR_getppid));
-	EXPECT_EQ(-1, read(0, NULL, 0));
+	EXPECT_EQ(-1, read(-1, NULL, 0));
 	EXPECT_EQ(12, errno);
 }
=20
@@ -2623,7 +2623,7 @@ void *tsync_sibling(void *data)
 	ret =3D prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
 	if (!ret)
 		return (void *)SIBLING_EXIT_NEWPRIVS;
-	read(0, NULL, 0);
+	read(-1, NULL, 0);
 	return (void *)SIBLING_EXIT_UNKILLED;
 }
=20

base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
--=20
2.35.1.894.gb6a874cedc-goog

