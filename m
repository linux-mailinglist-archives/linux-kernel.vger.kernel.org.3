Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBB57E52E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiGVRQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiGVRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:15:52 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194791D0FF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:15:52 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id c9-20020a17090a674900b001f25399c053so587268pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RUauCLQfxebD9yFL6jKMCH6mXVYBNZNS09oviaAOZNY=;
        b=lyRj2rD2miVN/fQNO6oQK3dum8RZnMnojLOuGspbXBmNmkjX045GZuNv3i1Ni3uaN4
         MhJd8/XCX5JR0DAOaLFIE3hXI3qfqylhRUTteCMEKqewpBDHYI2b3xP+oCuZUWZIJC8s
         VunIE0zfDrEDMjIKUqxpxX5m35EBMNfYYa0lStcVKeeqlsVWcTB3OniwLX7Rb1j2KycT
         uTP6zwK38WEpr1ceTWcIXpAiQjn3LxJxA7D3QjTkjSRO9IgE6gVbuofc8wxABJ50KyDM
         Nc40qeWxTp0el63R/HFId2ONad3dUem4ufZZp+mux9H1+vxR1o6CSLOrH0dTeSPSLaXb
         4NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RUauCLQfxebD9yFL6jKMCH6mXVYBNZNS09oviaAOZNY=;
        b=O1t5vOlfAbmyGkZBpRHCj+2bVHZqN29j/rrmXuzCXytg9CQW4X5pVdt8vOs1+dV0c9
         /Hr2RSc/+PAo3SWZvZE9yJwBuxwkTwyHGmKz6EZ9tGR/wDkeD2s0OvNk+85Y1wwAVqvw
         /mg36iZmlXXXfE72/lQBhWuvcVBW0cXSVPeoZFXR27EtMfSu/hq0kEakZLVKQUchA6Rp
         3HQjHRfKIkzX6Nzp4fwiv8XCbQdgTnCDuqQXz/uXiNwFUP2nCBLwQMifLiTwkfytt0Jy
         kAWsnQBI5qtCLwDcdBKPaL9yhTUiqswqJHbtysiDP3WR3pzS7qSlZlEgf64tFGkdS4Lo
         XGug==
X-Gm-Message-State: AJIora8I6Vncp8jx6cXVQxm7trHdy7UMuYMoawVVhvX7ef8uQ1SWKR09
        n7Ho12jVdn+PrRP45b6WSspR748Vtv55qA==
X-Google-Smtp-Source: AGRyM1unJ/KGpdJLj10Pr2atWngJAHG5XIMztglIQ6IIW45XdLr1SMv/95HqFIYe4ZUgLsSDxzifVYnKKd0z/g==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP
 id h1-20020a056a00218100b0051b560bdd30mr788343pfi.44.1658510151585; Fri, 22
 Jul 2022 10:15:51 -0700 (PDT)
Date:   Fri, 22 Jul 2022 17:15:33 +0000
In-Reply-To: <20220722171534.3576419-1-dlatypov@google.com>
Message-Id: <20220722171534.3576419-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 4/5] kunit: make kunit_kfree() not segfault on invalid inputs
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

kunit_kfree() can only work on data ("resources") allocated by KUnit.

Currently for code like this,
> void *ptr = kmalloc(4, GFP_KERNEL);
> kunit_kfree(test, ptr);
kunit_kfree() will segfault.

It'll try and look up the kunit_resource associated with `ptr` and get a
NULL back, but it won't check for this. This means we also segfault if
you double-free.

Change kunit_kfree() so it'll notice these invalid pointers and respond
by failing the test.

Implementation: kunit_destroy_resource() does what kunit_kfree() does,
but is more generic and returns -ENOENT when it can't find the resource.
Sadly, unlike just letting it crash, this means we don't get a stack
trace. But kunit_kfree() is so infrequently used it shouldn't be hard to
track down the bad callsite anyways.

After this change, the above code gives:
> # example_simple_test: EXPECTATION FAILED at lib/kunit/test.c:702
> kunit_kfree: 00000000626ec200 already freed or not allocated by kunit

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: fix typo in commit desc.
---
 lib/kunit/test.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 82019a78462e..c7ca87484968 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -698,18 +698,8 @@ static inline bool kunit_kfree_match(struct kunit *test,
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
-	struct kunit_resource *res;
-
-	res = kunit_find_resource(test, kunit_kfree_match, (void *)ptr);
-
-	/*
-	 * Removing the resource from the list of resources drops the
-	 * reference count to 1; the final put will trigger the free.
-	 */
-	kunit_remove_resource(test, res);
-
-	kunit_put_resource(res);
-
+	if (kunit_destroy_resource(test, kunit_kfree_match, (void *)ptr))
+		KUNIT_FAIL(test, "kunit_kfree: %px already freed or not allocated by kunit", ptr);
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
-- 
2.37.1.359.gd136c6c3e2-goog

