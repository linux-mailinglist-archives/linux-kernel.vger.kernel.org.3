Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47865522820
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiEKAFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiEKAFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:05:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D1248E3A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:04:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q18so260107pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZchoqzQKbQQ0HkN8pkgXJH0p5sZcEYr4VEaC4c3fZv0=;
        b=Tm4Ct/yLf05DymgN6mV0U11Xeko5sOECiRgXCosO/olG5NK32Q/dzN+FXG3OMMYauZ
         7+Irsp9mnIlzsxodeL14fWjKfV8MdCVM++HPh+a9HMHBEAOAKBCe723qvaq8RN9ZLe66
         kX6gg57f7qsbux6WOtEvbFTvd9cwXIVQdYUfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZchoqzQKbQQ0HkN8pkgXJH0p5sZcEYr4VEaC4c3fZv0=;
        b=UA1B06At/GXRSIAHUOU6TennAV3ER9CG+R8JPBRvj4mYoAPXKFDPnqkmyVa3vGCjQk
         r6GB2rNL25C39vmYK6fZ5Ts11IzPI2/5TCjMh1pwDPLI2tnFj1rMa6MorSgOtLvPu4BB
         lh+KjjRVQFvYRnaiev1y+0DyI6L0YaPDDjKVCUw+Z9/20QM+SMCX01VS9/M7l2MGsXo5
         u5LceT5sACZFKstAfTa2yCgN5wE7lSYhLeHHEg9g3yOUtSkyDrpEFDu9KskBM6dXcjgk
         QuO3hxV71cPoqPlUo9gVByeHYshQZayYzSQDq8vCcAypg19XGmo5QlL/319Z4RBjKkjw
         dmCg==
X-Gm-Message-State: AOAM5319JwnSsL7TSz+L/VyW5sC2DHk/UP+5QjCRwNIQePmwcP4dYAXu
        z1sqU0Z9GX4N7FB356WoR2dTzQ==
X-Google-Smtp-Source: ABdhPJzYKPRjsS265QVn9SJMMbFfgmvXxQIW1Nk7jN2bzvqGgd+9VottH0k7ZuOcUwn0zEbmbuhd6Q==
X-Received: by 2002:a17:90b:1b0d:b0:1dc:672e:c8c2 with SMTP id nu13-20020a17090b1b0d00b001dc672ec8c2mr2413297pjb.96.1652227498758;
        Tue, 10 May 2022 17:04:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v1-20020aa78081000000b0050dc7628191sm130081pff.107.2022.05.10.17.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 17:04:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: randstruct: Remove cast exception handling
Date:   Tue, 10 May 2022 17:04:56 -0700
Message-Id: <20220511000456.3628751-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4672; h=from:subject; bh=sxL2eDYL0WKROpn9RSAKksfRkZnvvnEFvCZ/CKvb7mk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiev2oabvR4A3+JQQt/oBAOfuC7eY8RMBUyosqzaYa LPbHKf2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnr9qAAKCRCJcvTf3G3AJsxqD/ wNW8LHqJ04IT2OIsBy0JnUcUK59JPeTHe+dz+4Bep+SE4VzFi2arz0x1JRYdv3QZ4scpIyBAg2/of7 WoHnmJG+9DA4gyUz+RWk877MdDAbnpebI0qB/Q9Z7QkONT9FbGaFywqHSG4J2T1A3K+hmoOvSKWAGM cx6+Ka1UYjYlOjBUSj4MCqDW+t2Yz4iOY85nNTHXkbh8WCKgwK7rF02xlki87zH/23uyBeu6On6bQo BimMMSG3fnTy1BBmniUzrKzjA/QGve7buUVaAesDVY1cJRyCMJk7t9uAzsvJ/Izl+jEzFvmYtoarlp naydl6DkGBsgytwU+OlOFNPsqK6kRUWL0uoJfAQDWVu3Vzu82pkMQdc09UyWtiUFQiR/fbVGdTTbW/ p8qj0DnUhUZOoW77d58d90nhjL9UVzbjexj4os/2ifIrukOAV8HRBrbxUCspV6ePXkDZEYbM6E6f6w 9l8emKJHZ3rGA2X+XINHOHc3Dh8+5YS8ydLAPsvbhKicjUD/klxnzoUTA+FMYA6wGS1u+WLfKHrgb6 Tfj4TL92vXCJ4VS0LrYo9z+GN7BjAuCqYSrlZ9vJR+wFr36sOahRUeHK51C+mXeKDvapboK8GCdrkG rww0XJEswFgE7mVFi+fp3ZPkZ8lz9gynh8GH1FKwKwe1rMtstYH8SiUHOwmQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all randstruct exceptions removed, remove all the exception
handling code. Any future warnings are likely to be shared between
this plugin and Clang randstruct, and will need to be addressed in a
more wholistic fashion.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This depends on the other patches that remove the exception entries:
https://lore.kernel.org/linux-hardening/20220510235817.3627784-1-keescook@chromium.org/
https://lore.kernel.org/linux-hardening/20220510205729.3574400-1-keescook@chromium.org/
https://lore.kernel.org/linux-hardening/20220511000109.3628404-1-keescook@chromium.org/
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 79 +------------------
 1 file changed, 3 insertions(+), 76 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 2ca768d88a68..ea2aea570404 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -39,16 +39,6 @@ static struct plugin_info randomize_layout_plugin_info = {
 			  "performance-mode\tenable cacheline-aware layout randomization\n"
 };
 
-struct whitelist_entry {
-	const char *pathname;
-	const char *lhs;
-	const char *rhs;
-};
-
-static const struct whitelist_entry whitelist[] = {
-	{ }
-};
-
 /* from old Linux dcache.h */
 static inline unsigned long
 partial_name_hash(unsigned long c, unsigned long prevhash)
@@ -734,60 +724,6 @@ static void handle_local_var_initializers(void)
 	}
 }
 
-static bool type_name_eq(gimple stmt, const_tree type_tree, const char *wanted_name)
-{
-	const char *type_name;
-
-	if (type_tree == NULL_TREE)
-		return false;
-
-	switch (TREE_CODE(type_tree)) {
-	case RECORD_TYPE:
-		type_name = TYPE_NAME_POINTER(type_tree);
-		break;
-	case INTEGER_TYPE:
-		if (TYPE_PRECISION(type_tree) == CHAR_TYPE_SIZE)
-			type_name = "char";
-		else {
-			INFORM(gimple_location(stmt), "found non-char INTEGER_TYPE cast comparison: %qT\n", type_tree);
-			debug_tree(type_tree);
-			return false;
-		}
-		break;
-	case POINTER_TYPE:
-		if (TREE_CODE(TREE_TYPE(type_tree)) == VOID_TYPE) {
-			type_name = "void *";
-			break;
-		} else {
-			INFORM(gimple_location(stmt), "found non-void POINTER_TYPE cast comparison %qT\n", type_tree);
-			debug_tree(type_tree);
-			return false;
-		}
-	default:
-		INFORM(gimple_location(stmt), "unhandled cast comparison: %qT\n", type_tree);
-		debug_tree(type_tree);
-		return false;
-	}
-
-	return strcmp(type_name, wanted_name) == 0;
-}
-
-static bool whitelisted_cast(gimple stmt, const_tree lhs_tree, const_tree rhs_tree)
-{
-	const struct whitelist_entry *entry;
-	expanded_location xloc = expand_location(gimple_location(stmt));
-
-	for (entry = whitelist; entry->pathname; entry++) {
-		if (!strstr(xloc.file, entry->pathname))
-			continue;
-
-		if (type_name_eq(stmt, lhs_tree, entry->lhs) && type_name_eq(stmt, rhs_tree, entry->rhs))
-			return true;
-	}
-
-	return false;
-}
-
 /*
  * iterate over all statements to find "bad" casts:
  * those where the address of the start of a structure is cast
@@ -864,10 +800,7 @@ static unsigned int find_bad_casts_execute(void)
 #ifndef __DEBUG_PLUGIN
 				if (lookup_attribute("randomize_performed", TYPE_ATTRIBUTES(ptr_lhs_type)))
 #endif
-				{
-					if (!whitelisted_cast(stmt, ptr_lhs_type, ptr_rhs_type))
-						MISMATCH(gimple_location(stmt), "rhs", ptr_lhs_type, ptr_rhs_type);
-				}
+				MISMATCH(gimple_location(stmt), "rhs", ptr_lhs_type, ptr_rhs_type);
 				continue;
 			}
 
@@ -890,10 +823,7 @@ static unsigned int find_bad_casts_execute(void)
 #ifndef __DEBUG_PLUGIN
 				if (lookup_attribute("randomize_performed", TYPE_ATTRIBUTES(op0_type)))
 #endif
-				{
-					if (!whitelisted_cast(stmt, ptr_lhs_type, op0_type))
-						MISMATCH(gimple_location(stmt), "op0", ptr_lhs_type, op0_type);
-				}
+				MISMATCH(gimple_location(stmt), "op0", ptr_lhs_type, op0_type);
 			} else {
 				const_tree ssa_name_var = SSA_NAME_VAR(rhs1);
 				/* skip bogus type casts introduced by container_of */
@@ -903,10 +833,7 @@ static unsigned int find_bad_casts_execute(void)
 #ifndef __DEBUG_PLUGIN
 				if (lookup_attribute("randomize_performed", TYPE_ATTRIBUTES(ptr_rhs_type)))
 #endif
-				{
-					if (!whitelisted_cast(stmt, ptr_lhs_type, ptr_rhs_type))
-						MISMATCH(gimple_location(stmt), "ssa", ptr_lhs_type, ptr_rhs_type);
-				}
+				MISMATCH(gimple_location(stmt), "ssa", ptr_lhs_type, ptr_rhs_type);
 			}
 
 		}
-- 
2.32.0

