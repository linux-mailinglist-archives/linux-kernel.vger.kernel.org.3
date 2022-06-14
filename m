Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8FF54B3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbiFNOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353779AbiFNOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:49:10 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE622B16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:49:07 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id l2-20020a170906078200b006fed42bfeacso2969384ejc.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=f1NsV1WL/3Cu5HsrxjnodRBUD3ku1jNNTcExFOPtw8Q=;
        b=al9FrbtHB6hB3HQYB0ocqE+/toR3+Zyie77HTHacz6lBVeiSjBBpqTYTMHDrDg4YqU
         UlHQEBf9E9/D9nTkh9GUZhIldKcB7UOhIH90qqF6Nhfjn4Bq9Vj79utZbWD84hqcUECy
         3TVyyarRsH6Y/xaTYSx2hiaMeaQsnzy1oNgcqtnwCywR+hIBjNrD+46yDdUmYkyw+RBb
         RelxSqDfj/8CwgQZhoQsABEbZWwYfSxDPcgxYJNytaeWQqr1gJRPUwmUsP7UyeWeGiu2
         h69JLLvWiBQVbGLN4CHMeR+cVPgPIFnIeRhpCwQusREfkd7m7lhDPMZAe8y4VTJnUIiO
         90qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=f1NsV1WL/3Cu5HsrxjnodRBUD3ku1jNNTcExFOPtw8Q=;
        b=p2g+6Jq9Mo9tAbPf23DaiWx0ENUQWIyJ7b52jKOxD6C4ua0viu4XLHK4U9H1tYHFaN
         Nx2CKvDasKG3jiK4au3bzzGeVoCMx0D6zIz86Hzg6C9Xj3/pgC7De6pxJuKvVRez25I2
         Q++iT7JWKUflvZjZKERJ/bFemiM0g/Lshj5xuedypeDVXbyPfr4oeUlac2RMQWGWhaJQ
         aDZBCu3KlFc7GUnX6JGdZ3UqOCLPwLvovy1zeZ0kGRKrNEKopS6jkKD0wwZYazc9kf61
         lVkZQhABHsZdw2OPLLg4yPYA/oG96O+eEOx7rKKHJn1KtsoouHpS5K8zxN4cNK3mQwAJ
         koVg==
X-Gm-Message-State: AOAM532cdgyt2cX7oJUKXV7g5xndRcALgjmetP8TKGQaPk8fz0/xs/qv
        8OpX5bqWGnrpD6TGmFihUJhiZQblHec=
X-Google-Smtp-Source: ABdhPJwiyOTbJy7/Z19IQ0EL5TB6fB6fce6EnvsVdpqxlH/pXLatowNyuBMnTH7ww5XL7NmjFtiQoYXCqyo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3c7f:9830:1892:19a7])
 (user=glider job=sendgmr) by 2002:a05:6402:1f0e:b0:42d:e38a:51f7 with SMTP id
 b14-20020a0564021f0e00b0042de38a51f7mr6773121edb.68.1655218146192; Tue, 14
 Jun 2022 07:49:06 -0700 (PDT)
Date:   Tue, 14 Jun 2022 16:48:53 +0200
Message-Id: <20220614144853.3693273-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] [RFC] Initialization of unused function parameters
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
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

Consider the patch below, where under certain circumstances
initialization of `unsigned seq` and `struct inode *inode` passed into
step_into() may be skipped.  In particular, if the call to lookup_fast()
in walk_component() returns NULL, and lookup_slow() returns a valid
dentry, then the `seq` and `inode` will remain uninitialized until the
call to step_into() (see [1] for more info).

Right now step_into() correctly handles this and does not use the
uninitialized values, but explicitly initializing them will guarantee
their sanity in the case of future changes to step_into().

The bigger question I want to raise here is whether we want to
discourage passing uninitialized variables to functions in the kernel
altogether. While this is not required by the C standard (see the whole
discussion at [2]), KMSAN can help with detecting cases where uninits
are passed to functions (there is a more aggressive
-fsanitize-memory-param-retval compiler option for that). This is
somewhat similar to -Wmaybe-uninitialized, but works dynamically and has
no false positives.

Would initializing function parameters be a net benefit to the kernel?

[1] https://github.com/ClangBuiltLinux/linux/issues/1648#issuecomment-1146608063
[2] https://github.com/ClangBuiltLinux/linux/issues/1648

Cc: Evgenii Stepanov <eugenis@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Buka <vitalybuka@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-toolchains@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 509657fdf4f56..dde370338f5d6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2001,8 +2001,8 @@ static const char *handle_dots(struct nameidata *nd, int type)
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
-	struct inode *inode;
-	unsigned seq;
+	struct inode *inode = NULL;
+	unsigned seq = 0;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
@@ -3349,8 +3349,8 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
 	bool got_write = false;
-	unsigned seq;
-	struct inode *inode;
+	unsigned seq = 0;
+	struct inode *inode = NULL;
 	struct dentry *dentry;
 	const char *res;
 
-- 
2.36.1.476.g0c4daa206d-goog

