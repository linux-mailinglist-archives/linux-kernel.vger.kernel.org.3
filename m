Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E252C04A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbiERRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiERRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:01:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177DC56FA0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:01:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c205-20020a254ed6000000b0064d5bd93479so2211166ybb.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=21gji5A7fyf+LOH7W7vX2Ngr8AGXxxWBQWpGLTWRGhA=;
        b=GTzkF8O5vkR1Lt+Fnw7LR/ngt2HqSyPnypaoqbXSyP+l0zND+UX2I0KppXnl1YZi6I
         03baXp65KNEbOp+bqVWwVIBpZpkzPzYSrsYgzkjBGT3tSZ1qmttFgx3AwVGDCbEdJ8Nk
         TRVb/htkvdsqFa/k2tSEAefow55INRy1eJMxSjlVtQrpBLjC1y3k6B15D8J+y15khDS0
         3sZ/3NciSAL4YcN5zUE2nW3wbrdeS0l7Y3vSQwU/XD6RNkKP3vR2rqYFzdno8wUK2PBK
         9BCc2PRT+x06Z+qc/Tx+Db/tL9sxXLOz5VyT8X+kLlGTQ3l0efVDXJKBgpDhevgDT24b
         ocEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=21gji5A7fyf+LOH7W7vX2Ngr8AGXxxWBQWpGLTWRGhA=;
        b=pXuXUKwhuBAPTzjpe83s6h1ItLjPcyAm9fdiYyya0mVMuORzOhxiOl5RXFt4c7/J+r
         KfjwSTRvljpRZ1BY3vz92laS9F+9FGvJZI9D6gubrisdZ/GBPyr32L5t4P3APRcWy2JO
         WQMTZ5BcQdAprPU2Xxc5MOWyyhQ4iicJDpj67yPtBmBIOJ0iA5L75kMNQa1NAsTCBUMx
         wSyt/uDek1qVv+xjYqeef8CofX1cpkBZfD7y5wqWDPU93FWxF+S4gQgMiyIuM+31ZGmo
         j1nZuRB7mZu1kcyXFpJs0dsdXddtEsNmnozFW4NPtsN5cVh/iW7OBWL2kL3ldwlVqec9
         mEEQ==
X-Gm-Message-State: AOAM531A6ofEhmLHzDC1Iz4DwthdGW4QNbz6ZcHwR2kIYFHYBRG9CNEA
        ZO9Px/xqjYHKX3AIFWUF4X/GiWJadCSCrw==
X-Google-Smtp-Source: ABdhPJy5L9IdIUF+kc9lONmkwtmBOtrGteA3jV3FIp+O1wzAgxcgJV3U+0y/By+Qa0bPGIbZ2l3+jMPy66fGaw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a94f:2cb3:f298:ec1b])
 (user=dlatypov job=sendgmr) by 2002:a81:2f8c:0:b0:2fe:ed42:21ca with SMTP id
 v134-20020a812f8c000000b002feed4221camr399767ywv.120.1652893298194; Wed, 18
 May 2022 10:01:38 -0700 (PDT)
Date:   Wed, 18 May 2022 10:01:22 -0700
In-Reply-To: <20220518170124.2849497-1-dlatypov@google.com>
Message-Id: <20220518170124.2849497-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 1/3] Documentation: kunit: fix example run_kunit func to allow
 spaces in args
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

Without the quoting, the example will mess up invocations like
$ run_kunit "Something with spaces"

Note: this example isn't valid, but if ever a usecase arises where a
flag argument might have spaces in it, it'll break.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/running_tips.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index c36f6760087d..da8677c32aee 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -15,7 +15,7 @@ It can be handy to create a bash function like:
 .. code-block:: bash
 
 	function run_kunit() {
-	  ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run $@ )
+	  ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run "$@" )
 	}
 
 .. note::
-- 
2.36.1.124.g0e6072fb45-goog

