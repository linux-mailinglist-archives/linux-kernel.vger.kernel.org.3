Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF71F49EDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiA0Vwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiA0Vw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:52:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56476C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:52:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a88-20020a25a1e1000000b00615c588ab22so8559697ybi.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JPoXnQxk1ka8IPJ0XT1Jbys/cgKi0K3dUrFoxr2hH90=;
        b=AREOSaMxAUumJURgukoWmMtb4bSG3MUzjwZxH13PkmDxsGa4jqih87mtx1VOca+FO+
         uYfHoElnx0xbW8dtx76lzBMyitQ0SijCqOknlvCAYkHaMqlRry/XHIoVCp3rwviHZSgZ
         5bveJRUoYiigwe3v4MKWOwS9NCpzHJJjxEGjdTYRWDJl5jmezh5cQiG+2mffhKOSMUqF
         rtAjR5XdiS4w+O+XH6sUTpQKhZdlVKpUhzwT3iKLMIn95BmULQpHT24yxyrbe8UemQ3u
         /tq+IrAs3bU4yw3U9ZmFGuvxd1BtW3icneIalGq5YrU884YGNAhO4EP48UUd30aYuBd6
         69og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JPoXnQxk1ka8IPJ0XT1Jbys/cgKi0K3dUrFoxr2hH90=;
        b=tTGHgSN3ybYYATqzFXp6zMwecAPHvbfHb/WoXXC+pxQzQAITULXsY8lCxunrMV82t3
         6iNo78cjaSv43Om/AZnOXQ/Dr+ZCXGM0IVYrGKtkCtExPl3FTE6hKpPCx2A2dA/oHCTh
         ERD52VVYdKQ6n/tdEXVQuWd85z4m3Kd48mYCuyF97UN5eHL6tNOUj1+mDDyxlJwcfCLP
         1w+YwXQ+HQZ6DilF7NFHl1YHdUE9A8AilurMfiovREf4eJJaY/GH5KaoFeq/hp6IUZxX
         CrxmEiK2RXmrBazeDupK/E79cCczu1nQ24LGQ8x9yVnTY5mJKkpC69VBUSxM+4zMKhdt
         eLEg==
X-Gm-Message-State: AOAM530a/bzXFIsAuCcsjIHmOQk3rC+QR5q7qYNrYwRTKqnzuLqluPc/
        cL5iwbsRUr65a85MEueNwO3wfwUSN0IYvw==
X-Google-Smtp-Source: ABdhPJzBGtnLv/y52L2vEZJ97rm4iMHe/jYh76HL0wmgaI1BonlqwJGG8ueykRayA1mNwbDWnLuCJ5DjNAhFWQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5484:2aa:f5f4:a1e0])
 (user=dlatypov job=sendgmr) by 2002:a81:23d1:: with SMTP id
 j200mr0ywj.471.1643320347735; Thu, 27 Jan 2022 13:52:27 -0800 (PST)
Date:   Thu, 27 Jan 2022 13:52:22 -0800
Message-Id: <20220127215222.159049-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] kunit: cleanup assertion macro internal variables
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the operands should be tagged `const`.
We're only assigning them to variables so that we can compare them (e.g.
check if left == right, etc.) and avoid evaluating expressions multiple
times.

There's no need for them to be mutable.

Also rename the helper variable `loc` to `__loc` like we do with
`__assertion` and `__strs` to avoid potential name collisions with user
code.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
Note: this patch is based on top of
https://lore.kernel.org/all/20220125210011.3817742-4-dlatypov@google.com/
There is no semantic dependency between the patches, but they touch
adjacent lines.
---
 include/kunit/test.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 088ff394ae94..00b9ff7783ab 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -779,10 +779,10 @@ void kunit_do_failed_assertion(struct kunit *test,
 
 #define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
 	if (unlikely(!(pass))) {					       \
-		static const struct kunit_loc loc = KUNIT_CURRENT_LOC;	       \
+		static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;       \
 		struct assert_class __assertion = INITIALIZER;		       \
 		kunit_do_failed_assertion(test,				       \
-					  &loc,				       \
+					  &__loc,			       \
 					  assert_type,			       \
 					  &__assertion.assert,		       \
 					  fmt,				       \
@@ -872,8 +872,8 @@ void kunit_do_failed_assertion(struct kunit *test,
 				    fmt,				       \
 				    ...)				       \
 do {									       \
-	typeof(left) __left = (left);					       \
-	typeof(right) __right = (right);				       \
+	const typeof(left) __left = (left);				       \
+	const typeof(right) __right = (right);				       \
 	static const struct kunit_binary_assert_text __text = {		       \
 		.operation = #op,					       \
 		.left_text = #left,					       \
@@ -956,7 +956,7 @@ do {									       \
 						fmt,			       \
 						...)			       \
 do {									       \
-	typeof(ptr) __ptr = (ptr);					       \
+	const typeof(ptr) __ptr = (ptr);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			assert_type,					       \
-- 
2.35.0.rc2.247.g8bbb082509-goog

