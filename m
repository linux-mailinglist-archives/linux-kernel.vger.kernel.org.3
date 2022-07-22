Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0584157E52C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiGVRPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiGVRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:15:49 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEED1C118
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:15:48 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e21-20020aa78c55000000b00528c6cca624so2110516pfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gq9vbxPAOwHYvlzwiSQtId4LrMlH0FUkyQCy4RHppRE=;
        b=iXVdLKcEomziIHggkUjy86YhATorBopk3UBt6C1zRmJk/B/4U8Ej81rCJWm8c1Y6Rd
         U1BarKkvjldx+jMx1H0vPiW/ppLkS7ufn2Kz1NmBStOqPhNKQUjqYDnANB4vyFSuT3tP
         YnUyp2txdO9gBkSh2FEQIm4jwFBO4giIpf3MAwBDL33PVgNPBg44T+m/kL1UkeIDsxeg
         2epZGY8sb0VeIKcoc9TuNdiGqHfp4jNw/M/TR3leqoqii6tgOsCKXZ089AQOfJFbzI7H
         qO+VABGC2e385h5KjwlhSWE2eeJcYqVm9jJx0gEfvW2zKn+ntkzAfsfyG8IeDJr0V+ml
         78RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gq9vbxPAOwHYvlzwiSQtId4LrMlH0FUkyQCy4RHppRE=;
        b=AKJeERfcSY3TlufBFczY9L/vR6xKukk7zK4TIpW34kNpcOJ4oD2TBnbveRQteYwNOE
         yFgwvoo2IAEYma0U78mojZ/6e9JcYdmnRaz0R16JwBBd8dGLNi8dkIOYv++wnKslSRfO
         4TN62Ajrh5gDuciQtc/GinOLxgVrnY7bwzWugDGl91fsvSSxReQDtmNrjtk5l+sJjc9i
         clR7r7ZkYK5HXGnHseWl0NY2/igVXn5AN/X9E0ZbtMrP60jSYDsO8pRjQxZmbYm3RtA+
         s0/qpBtIKKDvKu8AO3wNjB/+P+uGYXy+PqOisjIPxkJrgZ52hX3G2nPdzmC53uRw0nww
         xOhg==
X-Gm-Message-State: AJIora+ygW85s1wHjTujlVgrFObkNg6JPDJsv5QsTJvzyW0lkJzOXvDo
        mthMf709Dc0yzZBAFsHnSb2Zm2z9cs5ynw==
X-Google-Smtp-Source: AGRyM1uPxVd4kD3hkJLQPplHzxKJYD7ADNoMqovcPfELWI8lAoPtaW2gU3Zb+xUboC74fKpOTy4/k0WlYi+lTw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr1064402pje.0.1658510148119; Fri, 22 Jul
 2022 10:15:48 -0700 (PDT)
Date:   Fri, 22 Jul 2022 17:15:31 +0000
In-Reply-To: <20220722171534.3576419-1-dlatypov@google.com>
Message-Id: <20220722171534.3576419-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 2/5] kunit: drop test pointer in string_stream_fragment
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already store the `struct kunit *test` in the string_stream object
itself, so we need don't need to store a copy of this pointer in every
fragment in the stream.

Drop it, getting string_stream_fragment down the bare minimum: a
list_head and the `char *` with the actual fragment.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: no changes
---
 lib/kunit/string-stream.c | 10 +++++-----
 lib/kunit/string-stream.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index a2496abef152..f5ae79c37400 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -22,7 +22,6 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
 	if (!frag)
 		return ERR_PTR(-ENOMEM);
 
-	frag->test = test;
 	frag->fragment = kunit_kmalloc(test, len, gfp);
 	if (!frag->fragment)
 		return ERR_PTR(-ENOMEM);
@@ -30,11 +29,12 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
 	return frag;
 }
 
-static void string_stream_fragment_destroy(struct string_stream_fragment *frag)
+static void string_stream_fragment_destroy(struct kunit *test,
+					   struct string_stream_fragment *frag)
 {
 	list_del(&frag->node);
-	kunit_kfree(frag->test, frag->fragment);
-	kunit_kfree(frag->test, frag);
+	kunit_kfree(test, frag->fragment);
+	kunit_kfree(test, frag);
 }
 
 int string_stream_vadd(struct string_stream *stream,
@@ -89,7 +89,7 @@ static void string_stream_clear(struct string_stream *stream)
 				 frag_container_safe,
 				 &stream->fragments,
 				 node) {
-		string_stream_fragment_destroy(frag_container);
+		string_stream_fragment_destroy(stream->test, frag_container);
 	}
 	stream->length = 0;
 	spin_unlock(&stream->lock);
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index 494dee0f24bd..b669f9a75a94 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -14,7 +14,6 @@
 #include <linux/stdarg.h>
 
 struct string_stream_fragment {
-	struct kunit *test;
 	struct list_head node;
 	char *fragment;
 };
-- 
2.37.1.359.gd136c6c3e2-goog

