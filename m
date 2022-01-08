Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDEC488075
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiAHBXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiAHBXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:23:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840CC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 17:23:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e137-20020a25378f000000b0060c1f2f4939so15407379yba.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 17:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UxodAG8MISvgfTavxEJvx2vxa+QsUah/4xKUKf+ZKLE=;
        b=cXyd0tcGSWGi3eEvbdkhqYFC+pqvi9eGmVjmvAchBIkbSxdYDtOaT0XDzF1BufPKv7
         eMwDSBnKMPhZaXaBncMS1cy2yvxBNIDaeTqXpOkSZvuS1LfydrbShaAD/IBz1OFro0F6
         PR4P2kAWCZVOz77uZaO0WHg1XiMMdAqq03ElAvZYs/q8jgEWjmKRG1Mr3gnj/qUlFOeU
         imLmvR6lO+VXwyYKv5smiwbZANQcQyUPtjdSNmGo2AundnDijCnuTfP6j5fsKAHsqJsg
         xcHi/LKB4K9uTy8YNifsgBvJ5f/rxQKExp/+AT7VQaViI4cOoEFyAaFhXt+i/pusDzhn
         /81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UxodAG8MISvgfTavxEJvx2vxa+QsUah/4xKUKf+ZKLE=;
        b=FZjaPT5uzacLJ+83Ljgs2bH/0EQa1CqRFUNJaVqyL24bEM3h/ZfehK4hHCOm7VqRoR
         9C3arEP4FvP2ONrICQcQk0RYSUo4mmr2Crfte8gziu2nHUmg7ijH86BR3MuPykc4N5ur
         RF8sHKRbS4bHhVcqGRsGTl4iMooug7CXLIMecr0bj1Q/D0Br/lQsseu/30Vb9cwRErs/
         /aMrgG2lXBmwB6jE8M1+dC8leBuy6l46thyJ97maY512ldOz9pbH7Tg0DmdkAOSL5gd3
         Hw3MFUGqL8y4TlwwowlRnM50DLgpaXkVIkgZeeHhNV26cEdxskgdTzqV6b9rr0g20jS8
         TReg==
X-Gm-Message-State: AOAM530FfCqO4XBX559Jx7RidM6c8SuD7yasQAn5fNZooujER4DIJIp4
        6eJlw1FV/gmxNRtvphsMLb2OHDdZbBnZog==
X-Google-Smtp-Source: ABdhPJyGBj0i2YNBRxNrlnRCJuJAw7ad2nmp13PefOy5E6/jJafSsI8a5/HgOa5T5LfQrUs04k0oNSkNwBNl4Q==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bf8a:7e90:eb70:9b2b])
 (user=dlatypov job=sendgmr) by 2002:a25:740a:: with SMTP id
 p10mr76384062ybc.516.1641605013013; Fri, 07 Jan 2022 17:23:33 -0800 (PST)
Date:   Fri,  7 Jan 2022 17:23:02 -0800
In-Reply-To: <20220108012304.1049587-1-dlatypov@google.com>
Message-Id: <20220108012304.1049587-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 4/6] kunit: factor out kunit_base_assert_format() call into kunit_fail()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call this function first thing for all the assertion `format()`
functions.
This is the part that prints the file and line number and assertion type
(EXPECTATION, ASSERTION).

Having it as part of the format functions lets us have the flexibility
to not print that information (or print it differently) for new
assertion types, but I think this we don't need that.

And in the future, we'd like to consider factoring that data (file,
line#, type) out of the kunit_assert struct and into a `static`
variable, as Linus suggested [1], so we'd need to extract it anyways.

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/assert.c | 6 ------
 lib/kunit/test.c   | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index b972bda61c0c..4d9a1295efc7 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -40,7 +40,6 @@ EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
 {
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream, "%pV", &assert->message);
 }
 EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
@@ -52,7 +51,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 
 	unary_assert = container_of(assert, struct kunit_unary_assert, assert);
 
-	kunit_base_assert_format(assert, stream);
 	if (unary_assert->expected_true)
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
@@ -73,7 +71,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
 				  assert);
 
-	kunit_base_assert_format(assert, stream);
 	if (!ptr_assert->value) {
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
@@ -119,7 +116,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
@@ -147,7 +143,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
@@ -187,7 +182,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_str_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 5ad671745483..735c1b67d843 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -255,6 +255,7 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 		return;
 	}
 
+	kunit_base_assert_format(assert, stream);
 	assert->format(assert, stream);
 
 	kunit_print_string_stream(test, stream);
-- 
2.34.1.575.g55b058a8bb-goog

