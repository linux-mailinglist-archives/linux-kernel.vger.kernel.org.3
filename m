Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE554D59FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346429AbiCKEti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346367AbiCKEtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:49:22 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407CF96828
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:48:19 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id x4so8906544iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/h9xFvawkOKYC2TFtGI3znCZsvzaWHfu4sF1ThE8sW8=;
        b=Zh/GmixJA2Bkf+z3osxm52SixJc6N5HkApUb2Sp4YGoESKhGGarMHbycUmY/c6Dz4J
         +xK6+F/W73MpUprLT70tAmHEUqNOYAibOBVn/qnSaB5/rEQVsqqczquFlpxgR1J6wk0M
         kbOZ/NOewpqCsHafnHbqm2A5Lf7hQfpJ43mC8fN2jZThxq+HG4T1ItPSF8mYPAY/XPGd
         qfrdVcgaU60hqfL84zXmEEPWBRZc0F5S63EKjTShBYTzQyn3feampBV7byM6fXOxZeo+
         dCdZKUt0qW4bASMO7CIYGnErd2OblUZJi3Z3Wk2Rp3k1mFnoHGT2abEHrvk7R3J0bqw9
         IKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/h9xFvawkOKYC2TFtGI3znCZsvzaWHfu4sF1ThE8sW8=;
        b=tXU+F3KCjIB+dzQrxE3osK/FYsLHRehCRt1KgE3LLYaOxlLmPmKVpCvwUWWWIdtbmf
         m9yobyCiKsUEL0LtCElKRCXcSEr+EGyG68ztf38W0C6wWQ3QwvoZRSstccmEyxK5msUP
         SJk7vlHKlLrHIZM6sNiTVtuuBsewtLAEc9mfYI9lPUBmYBFU31nx/ov1p8bjVupbbk9N
         Gy3KaB5fQhWYk3W3xzHTuABayCpg8Jv/a6qpFmmQuYqqnHpOpFvvnPYJJRfEbe0k2bRM
         b3Ryt207FgQ9bRXj2okMwlQnq895G7tSJ3vBiI4ihdvcR/Adtmwy8cc9F39nEBAydn+f
         sBfg==
X-Gm-Message-State: AOAM5329wz+LD2/45oaAzuV4Y3xjQ5kVNbhQObEEWygFXgbTdfBtgI6W
        K78OyXn0gG86qjwmqGWzwcA=
X-Google-Smtp-Source: ABdhPJx9nc37H2OIUHqJB2EjVVVmHJqmzNnu/dUpgVAbx3aqEwg8oB7jd+HVTBgzb+5P6OYmKvD6dg==
X-Received: by 2002:a05:6638:2586:b0:319:ac56:5f2f with SMTP id s6-20020a056638258600b00319ac565f2fmr6752417jat.146.1646974098620;
        Thu, 10 Mar 2022 20:48:18 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id q9-20020a5edb09000000b00645c7a00cbbsm3529834iop.20.2022.03.10.20.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 20:48:18 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 4/5] dyndbg: drop EXPORTed dynamic_debug_exec_queries
Date:   Thu, 10 Mar 2022 21:47:55 -0700
Message-Id: <20220311044756.425777-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311044756.425777-1-jim.cromie@gmail.com>
References: <20220311044756.425777-1-jim.cromie@gmail.com>
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

This exported fn is effectively obsoleted by Commit:HEAD~2, so remove it.

Its intent was to allow drm.debug to use the exported function to
implement its drm.debug bitmap api using dynamic_debug.  Instead,
HEAD~2 implements the bitmap inside dyndbg, using the internal fn that
the export wraps.

Since there are no other expected users, and any prospects would
likely reuse the bitmap or a straightforward extension of it, we can
drop the exported function until its really needed.

This also drops the CONFIG_DYNAMIC_DEBUG=N stub-func, and its
pr_warn(), which I avoided in 2012, then added in 2020 :-/

Fixes: a2d375eda771 ("dyndbg: refine export, rename to dynamic_debug_exec_queries()")
Fixes: 4c0d77828d4f ("dyndbg: export ddebug_exec_queries")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  9 ---------
 lib/dynamic_debug.c           | 29 -----------------------------
 2 files changed, 38 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e83c4e36ad29..664bb83778d2 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -60,9 +60,6 @@ struct _ddebug {
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 
-/* exported for module authors to exercise >control */
-int dynamic_debug_exec_queries(const char *query, const char *modname);
-
 int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
@@ -253,12 +250,6 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 				rowsize, groupsize, buf, len, ascii);	\
 	} while (0)
 
-static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
-{
-	pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
-	return 0;
-}
-
 struct kernel_param;
 static inline int param_set_dyndbg_classbits(const char *instr, const struct kernel_param *kp)
 { return 0; }
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 704361af5b23..b15a9c715e5b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -582,35 +582,6 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
 #ifdef CONFIG_MODULES
 #define KP_MOD_NAME kp->mod->name
 #else
-- 
2.35.1

