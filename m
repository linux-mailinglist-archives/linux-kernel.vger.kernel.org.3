Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7D5905F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiHKRgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiHKRgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:36:06 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE276DFA3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i84so15187628ioa.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5COrt8+UBE4dlO0UmlrrMAl6VEmhHXEe2GHU1HbZD24=;
        b=JaAuy9N5LSnFjIqLNRXXph+mheQVDE5xCZ87t3QrzwgreDl97oNVVaYGHwShJnYfSI
         BmP1dm0C+Db/uFvP3TDzPsP9LL8L3Kc+SZUqQWcsOIzB2TAu4RoZsLecNWIIDAXgxhXA
         0Rjxgvyx+FC1CEbyNoFr/MW6wb42nWgUu3mHbXIKH5p6I9e5FbfeQnoyDoVHu1ZE1TUw
         DL8b8B5XxK/nzK6ZKtkjR1cxop617jeZtj4BIHHVDjfE7ammSQJKMkJ5sOcrctVWDl9r
         +18abGYC8SCgv8wxLGvRxG6ap7F/WT/EMcLD4b/YjeyK37xOJRIoSGeUI7EHNM/Qyx6D
         vp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5COrt8+UBE4dlO0UmlrrMAl6VEmhHXEe2GHU1HbZD24=;
        b=JrtNYR2p2/AII/gLOji/DHuuc06HDHRXFmqowMDKvu4ao5DEe9tQ0U7zGOBi0Be/ch
         rpkbv67UjMhAisR/y2zgIzHOHQojHBNaqDexS+UWAvfPvWybpa3Q86BK4wus2ScNMv68
         59mUEYGVlHg4Q4/vmgQ5hgXRwUn6qwDpy+gfJ+jeNWXcUIWomGWAlk0pfhAQnKjUYZ9g
         JYr8vI52+aGed5bPhEjwaWKAuCLdGTBiMTOf2VG2iQqahbBLQ1w/b0hjoM7PayS3SVAL
         4ZoNjVUJ96QY6JwKgb5qg++B4QzGKKF2s/x4LgKEvpIvZmcuwLlyU5OcPX8ShKGeUfJI
         vipg==
X-Gm-Message-State: ACgBeo3jYLmKeTy9QiIaQsanLGk791JMramw3oLojV95ac8AcFnzOcSi
        bqhJeKPSu1I0VAYTZerinTp2WoSnxMs=
X-Google-Smtp-Source: AA6agR5LrGLtUpqabTS2wMV0IF1pey1TbmuUxEaqeLKA6ZR0SiP1sNIrIJb79bXIv/1R5XlbVvcvjQ==
X-Received: by 2002:a05:6602:2dd0:b0:684:8efd:6a26 with SMTP id l16-20020a0566022dd000b006848efd6a26mr169133iow.116.1660239362571;
        Thu, 11 Aug 2022 10:36:02 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:36:02 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 09/11] dyndbg: drop EXPORTed dynamic_debug_exec_queries
Date:   Thu, 11 Aug 2022 11:35:39 -0600
Message-Id: <20220811173541.2901122-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exported fn is unused, and will not be needed. Lets dump it.

The export was added to let drm control pr_debugs, as part of using
them to avoid drm_debug_enabled overheads.  But its better to just
implement the drm.debug bitmap interface, then its available for
everyone.

Fixes: a2d375eda771 ("dyndbg: refine export, rename to dynamic_debug_exec_queries()")
Fixes: 4c0d77828d4f ("dyndbg: export ddebug_exec_queries")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 include/linux/dynamic_debug.h |  9 ---------
 lib/dynamic_debug.c           | 29 -----------------------------
 2 files changed, 38 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index f30b01aa9fa4..8d9eec5f6d8b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -55,9 +55,6 @@ struct _ddebug {
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 
-/* exported for module authors to exercise >control */
-int dynamic_debug_exec_queries(const char *query, const char *modname);
-
 int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
@@ -221,12 +218,6 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 				rowsize, groupsize, buf, len, ascii);	\
 	} while (0)
 
-static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
-{
-	pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
-	return 0;
-}
-
 #endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a849716220a..e96dc216463b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -558,35 +558,6 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/**
- * dynamic_debug_exec_queries - select and change dynamic-debug prints
- * @query: query-string described in admin-guide/dynamic-debug-howto
- * @modname: string containing module name, usually &module.mod_name
- *
- * This uses the >/proc/dynamic_debug/control reader, allowing module
- * authors to modify their dynamic-debug callsites. The modname is
- * canonically struct module.mod_name, but can also be null or a
- * module-wildcard, for example: "drm*".
- */
-int dynamic_debug_exec_queries(const char *query, const char *modname)
-{
-	int rc;
-	char *qry; /* writable copy of query */
-
-	if (!query) {
-		pr_err("non-null query/command string expected\n");
-		return -EINVAL;
-	}
-	qry = kstrndup(query, PAGE_SIZE, GFP_KERNEL);
-	if (!qry)
-		return -ENOMEM;
-
-	rc = ddebug_exec_queries(qry, modname);
-	kfree(qry);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(dynamic_debug_exec_queries);
-
 #define PREFIX_SIZE 64
 
 static int remaining(int wrote)
-- 
2.37.1

