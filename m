Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6644B02BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiBJB6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:58:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiBJB4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:13 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51637E7B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:49:55 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so4650700oos.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFbiXZ661Ew9fjYfgC6u/MqjxislkKWsUWOZlueLXog=;
        b=byGrfDBXU40CMAMH+QnRmZB2hgpnzd4NGTUutUKY82+AwMVd2EJaISHTE/1ECUa4pn
         MUX+upwrE8IMcQhdBgL9c9HMqEiPyB75Gbk2uvK+EAH5RDmJeWfvinBuuZDxPbUpxGSS
         lmdcQLNrhT7C7ORUJn3fReuqyYy4BRYSW1wZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFbiXZ661Ew9fjYfgC6u/MqjxislkKWsUWOZlueLXog=;
        b=16tVwiMsve2UOo+dg8WDYWid9NEb1sbdqd+GCebDuXL0uMPJT/xa8ZSKjeMkZPFd15
         TkYRRS2iuPcg0Tbm2GNpr5ET8bhF+N24EzFnriR/oFKRztq4f1D6XoZ9pIduE6eoHNPB
         t6GKJaYm7ROx3PwQe1y3Q0waRle4L7cD5NhckwJmvF4SQSk4knpOiSCv5sPnVNtr6n78
         BmTnvCTyT0dyabt7tEjuuLULY+p7gPiILLOkCRql4uf14KSIDA4SC2tb8JoDEEX3HqYe
         5jArH0GM4Na9CF4hZnYQ1PGTbFmxG3X1P49CvcSwxKhQlvErOjfcVhtMb+0jMQW5fapP
         MM/A==
X-Gm-Message-State: AOAM533oQeFRz3RPWj9qHQjH68h99pUcwXtD0nClZpJKXKxGDyzGxxC0
        1huRzidvDrYNie5FPH3D+VbCtrLZsq/3WQ==
X-Google-Smtp-Source: ABdhPJw+ZghIulP0lt/u5PYX2r5k/dJWK03itV6SCLMJRIfcICpmHfG8aQwsu7+Iq2Lfh3+XNlri9w==
X-Received: by 2002:a17:90b:314d:: with SMTP id ip13mr18418pjb.42.1644453808447;
        Wed, 09 Feb 2022 16:43:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r12sm15047114pgn.6.2022.02.09.16.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:43:28 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] overflow: Provide constant expression struct_size
Date:   Wed,  9 Feb 2022 16:43:26 -0800
Message-Id: <20220210004326.776574-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; h=from:subject; bh=14Ho7e3+FD8cqq+qkLYHbJIZoGsnOpApzExmvlYtrYc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiBF+tnHoL+rQk6Nngev4Kq+u30muSK0zNRaDjdCOE 1Oj38ieJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgRfrQAKCRCJcvTf3G3AJs6FD/ 9avPoQ7Z4IlMHbSykAxXrGFYSF+wvMgfe0LImCrE+GjGwL4rIgyN23by0prK/cgL3Y8vaggBM7gWub J532rvb1aGcwXl9AX6g4IT1r59xMvTB/+476o42yRpyBWHCkuZ2zdOTPWAmYb7oogKxfjH4pRlbGb0 54LugsOVNG9aiPEM8IvRmpuuNldJUUytI+7gDBxNnpkjBQnNXspdQoAqnu32RJhud1yrkDsi8++eQv afTWFDCZr1aQsThpcScXNOjBwvnVDnecEfuBzLKkLQ2GcETyd2J+qM6hlmHgofPhhof/jW8CE5QkiA VXhBfe6dd3JeSx/YN6Whg/stKHHJav9N/ye42U0uVV5UfjuzLxqLQPQ9OPjL5wu8X42x2tnKtJnRHu aGOtDi8V6JLqU3oDGtq8eVjgbhrjWKvgWOYxm0i7ZkE0qDThvkMKyNwtmv4AeyaAV+F9M3Dlh/s0Zq j60wyEwq82qbLk9v29YGRkbwrkqGmOPy5t1bznogdUjxg1lm3nX7E0SmO/jdkZXITYuRsPsXT5IDFu ZrTu8MlrtTor6sSB6MTu+J3YI+sq++lnl0fSNZ2986hrzFyqFeyCoju2Ckv5U6o2j/IMpeTAVG8fGs B1z8nyvOKcTrHfsPaMmWzWuTx9TQ/tZYcVaWLFI2UTgUeZZyXn9pApEK/Yjw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been cases where struct_size() (or flex_array_size()) needs
to be calculated for an initializer, which requires it be a constant
expression. This is possible when the "count" argument is a constant
expression, so provide this ability for the helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 10 +++++++---
 lib/test_overflow.c      |  7 +++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 59d7228104d0..f1221d11f8e5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/limits.h>
+#include <linux/const.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -221,8 +222,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define flex_array_size(p, member, count)				\
-	size_mul(count,							\
-		 sizeof(*(p)->member) + __must_be_array((p)->member))
+	__builtin_choose_expr(__is_constexpr(count),			\
+		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
+		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
 
 /**
  * struct_size() - Calculate size of structure with trailing flexible array.
@@ -237,6 +239,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define struct_size(p, member, count)					\
-	size_add(sizeof(*(p)), flex_array_size(p, member, count))
+	__builtin_choose_expr(__is_constexpr(count),			\
+		sizeof(*(p)) + flex_array_size(p, member, count),	\
+		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 712fb2351c27..d488ffaf56be 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -602,11 +602,18 @@ struct __test_flex_array {
 
 static int __init test_overflow_size_helpers(void)
 {
+	/* Make sure struct_size() can be used in a constant expression. */
+	u8 ce_array[struct_size((struct __test_flex_array *)0, data, 55)];
 	struct __test_flex_array *obj;
 	int count = 0;
 	int err = 0;
 	int var;
 
+	/* Verify constant expression against runtime version. */
+	var = 55;
+	OPTIMIZER_HIDE_VAR(var);
+	err |= sizeof(ce_array) != struct_size(obj, data, var);
+
 #define check_one_size_helper(expected, func, args...)	({	\
 	bool __failure = false;					\
 	size_t _r;						\
-- 
2.30.2

