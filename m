Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F475A6EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiH3Uxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiH3Ux3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:53:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A4D6FA33
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:53:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so618382ybs.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=XFDa6KTgHv01kWZj/Seua+4bvIrhtY4bUBF4MqV18nA=;
        b=H/B4/YP2EStOk1wApV/pkDl/3ocH+jW86m+kMjqfupJWEDtKmPbguzigbJi+iehwck
         u9h5UmeiZ/Y+6U08FR95+SJ7+0ggp3YI2ohxn+VjcC942GXqmQ9+b423Jryg/I9Bw8DH
         Nmy/gDoVn6i983bEcz+TiD844qnzMB73YjVfbRWjysYPxBrCGezlLiaMb168Glsm6M3b
         9PdqLGnY46ud8nEh+o9MNo2n0kVJdg2rnI4dBoZ75Z7ugj1cQCeQ6SyPegmpqMElKe1M
         +rMINy5wZ5pu9cglimln6dYGIAYENa0SCx9A2BZPqNWLYjctHkCijB6mTLtH5V3pVUsE
         2rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=XFDa6KTgHv01kWZj/Seua+4bvIrhtY4bUBF4MqV18nA=;
        b=nOtKe+V9o3mA7foQpsw5qQAEKyV17JUzXB4KtAHIs/W+uGJKhfFuJUjhKza/E4i+eX
         8ryPhFQ0r+5eBiByrKSmiQH6/GQYqSMZRmpS2EC4QUJVfMF02C79Y8bbm49fA7eH4z4O
         bzL2edEmomB7INqIrb7ctR6rMrcX7034FTqs14TZuoSy3xGvMlLbvTIGSXWbcjUHJvXq
         lNtWnM9bbSeWRW+DrH/yKd0gv3SRPr69CupcOKJXPivM4HHsfz7g12JYupXZy/r6/YY1
         tZeMnatBTQT8MvKO4q/GgW1/STH5tx5ZiywDvJR1AbJU6w2F1uLUnFbI+m/zVB3Ox6nr
         PV1Q==
X-Gm-Message-State: ACgBeo0P2EvSjMLJ1k3giiPxmrdfvMnO9OOIurxstld5XF/VhXn9o3q3
        xRw5Yc0Y1oQ/++NjcoAjdA7C3qf7GEaQ0rimdho=
X-Google-Smtp-Source: AA6agR5MMFcErFPh2qkaMkboWUbEABQ2QTTx3nnDWp3MZ+MbGpJqYtn/MroTOeI5lVbS/eEQRx5QJrTFkWBl2XP+U5s=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:422b:cadb:302a:7901])
 (user=ndesaulniers job=sendgmr) by 2002:a81:a0c1:0:b0:33d:c846:7ba3 with SMTP
 id x184-20020a81a0c1000000b0033dc8467ba3mr14975364ywg.204.1661892807644; Tue,
 30 Aug 2022 13:53:27 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:53:08 -0700
In-Reply-To: <20220830205309.312864-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220830205309.312864-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661892789; l=1585;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=IpcxEkpuMMXQt20IrbYrIKIderc1sjTmTpdDaYMsgqY=;
 b=5UP9/drrcNhfbuFf03VKoWmjREqkPFx9i+kfQjvqhjtKvuKmzjRZk/w2179sfrlEIphxWP9p6wch
 l2mCKGd7B1MgkjXr9TDikSaAARw/UmnmsNn9QyWCNAJ05V7TTxe4
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830205309.312864-3-ndesaulniers@google.com>
Subject: [PATCH 2/3] fortify: cosmetic cleanups to __compiletime_strlen
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

Two things I noticed in __compiletime_strlen:
1. A temporary, __p, is created+used to avoid repeated side effects from
   multiple evaluation of the macro parameter, but the macro parameter
   was being used accidentally in __builtin_object_size.
2. The temporary has a curious signedness and const-less qualification.
   Just use __auto_type.
3. (size_t)-1 is perhaps more readable as -1UL.
4. __p_size == -1UL when __builtin_object_size can't evaluate the
   object size at compile time. We could just reuse __ret and use one
   less variable here.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/fortify-string.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c5adad596a3f..aaf73575050f 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -22,11 +22,10 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
 
 #define __compiletime_strlen(p)					\
 ({								\
-	unsigned char *__p = (unsigned char *)(p);		\
-	size_t __ret = (size_t)-1;				\
-	size_t __p_size = __object_size(p, 1);			\
-	if (__p_size != (size_t)-1) {				\
-		size_t __p_len = __p_size - 1;			\
+	__auto_type __p = (p);					\
+	size_t __ret = __object_size(__p, 1);			\
+	if (__ret != -1UL) {					\
+		size_t __p_len = __ret - 1;			\
 		if (__builtin_constant_p(__p[__p_len]) &&	\
 		    __p[__p_len] == '\0')			\
 			__ret = __builtin_strlen(__p);		\
-- 
2.37.2.672.g94769d06f0-goog

