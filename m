Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC31A4F86C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346702AbiDGSBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346690AbiDGSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:01:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC7D45ADB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:59:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d2d45c0df7so55210767b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qW2G6QJQPB0zAi9jxpZzn0oRvztQZG9cLDkwD68iVl0=;
        b=oR4xdvGw3j0+k09kg7TSurTUKAgegEO6DhqberYZFqr9S5IhaQ8lB8xT7Vpmk2EZZ9
         2IizFWMW4QaQnv7jzov4pCAZVMwzutdJ0MeACwMajyrRJeevFyNqtLMMMix8Q8v/F+g+
         ax33VxknIU6WrU6+nSGQiv+1kiQNEPuOaT6S/R0xJEnzUmbbPHYRi4oZb3dPdQa51Yfw
         gMx04W5CPC1X2VzSFImUkLF3oyLpMyl5vy84AuTS4fBXefv1yRKnfFVFvyyqnjj5UMUp
         xuskqUkbHGFX+BCwYqNzRzQo5i96nXcT/C7eeDymFEgX14GsqxmLsYvWFtNUedTiDTGH
         16VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qW2G6QJQPB0zAi9jxpZzn0oRvztQZG9cLDkwD68iVl0=;
        b=sl+bnNnT/EcngUTBVu1Y+QXdvJMxstyc+BGnlyUSW1jK0IvFasgo4DLsZ1323fZ+j0
         YlnCi8QJYSRdBM0JE44Y9KRQ2w1obQ7kWpRjI0q0EYYvrGzov2mqQ4nq6zaBwUspqxnq
         GIlHPkH1u0JxZmURx2hNvLQL3a/8uZJ+qPGHzDeZwmWLIq21kEbkuIFcSDKde/hVqlJ3
         1bhrJ1EhmSpwZ1mbo/v8AOxu30Tx+FNCeTshy2rkt8khI+5rR6fBrrVUx8c0LAkDylbE
         PufMi3FmBclq2t4nVPHDOE1CbsTKQOMgCZyaPr62++Xys9dehjO7cKHXKICSplunepl1
         yWzQ==
X-Gm-Message-State: AOAM5316B6JIhvRItsZEV4lJTQqr563F2NBXcqLPzYO1Al+K4IBDMJXq
        a3veiQijuJhIpN9LU4vrpTHQ2Xwe
X-Google-Smtp-Source: ABdhPJxivmOowRh3AlaJxt1yAFWeG/V8zRjRa06koVEiM/woQviTIDs6OSB1GpPEauTwy35oABp/bAchig==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:9502:92c1:77f9:4633])
 (user=morbo job=sendgmr) by 2002:a81:52c4:0:b0:2eb:8d52:60d6 with SMTP id
 g187-20020a8152c4000000b002eb8d5260d6mr13102169ywb.394.1649354383373; Thu, 07
 Apr 2022 10:59:43 -0700 (PDT)
Date:   Thu,  7 Apr 2022 10:59:30 -0700
Message-Id: <20220407175930.471870-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] security: don't treat structure as an array of struct hlist_head
From:   Bill Wendling <morbo@google.com>
To:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization of "security_hook_heads" is done by casting it to
another structure pointer type, and treating it as an array of "struct
hlist_head" objects. This requires an exception be made in "randstruct",
because otherwise it will emit an error, reducing the effectiveness of
the hardening technique.

Instead of using a cast, initialize the individual struct hlist_head
elements in security_hook_heads explicitly. This removes the need for
the cast and randstruct exception.

Signed-off-by: Bill Wendling <morbo@google.com>
Cc: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 2 --
 security/security.c                           | 9 ++++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 334741a31d0a..c2ec81b68505 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -52,8 +52,6 @@ static const struct whitelist_entry whitelist[] = {
 	{ "net/unix/af_unix.c", "unix_skb_parms", "char" },
 	/* big_key payload.data struct splashing */
 	{ "security/keys/big_key.c", "path", "void *" },
-	/* walk struct security_hook_heads as an array of struct hlist_head */
-	{ "security/security.c", "hlist_head", "security_hook_heads" },
 	{ }
 };
 
diff --git a/security/security.c b/security/security.c
index b7cf5cbfdc67..37a9eeb901e0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -365,13 +365,12 @@ static void __init ordered_lsm_init(void)
 
 int __init early_security_init(void)
 {
-	int i;
-	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
 	struct lsm_info *lsm;
 
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
-	     i++)
-		INIT_HLIST_HEAD(&list[i]);
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	INIT_HLIST_HEAD(&security_hook_heads.NAME);
+#include "linux/lsm_hook_defs.h"
+#undef LSM_HOOK
 
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
-- 
2.35.1.1178.g4f1659d476-goog

