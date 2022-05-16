Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4C52941C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350011AbiEPW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349885AbiEPW5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:07 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC6C42EC3;
        Mon, 16 May 2022 15:57:05 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s14so11544342ild.6;
        Mon, 16 May 2022 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnVwspe5uVckeO1htOV0stxvFuwasrGdrVlM7tfSrfg=;
        b=OuCUf4sb69edJrEZ0gKdZzUlEGkHa8dxOXluIHFfd6mv5ISx7ldIjhYAFFNn02Uw07
         MObKaGN8fpxZnvPpJGBIwCuIiuR9IyeS7iH1uxXj/jhLQGhcfat661+qgzEFktP5seY8
         GiaibvoJ532MURzfeqBgThog2fe9DLO4A2hVL/DOhn/6IFDp+oBelBemRUpy55N0zLqI
         zER5IPos8OFUfpDFENsaqh+ouoKsLIvtcyA+eImWseUCcwepToR1grw0WW/uysyVvaIv
         1eJO5nP+NFljczTz12OqQvUpG1AJSUX1UZQUh7+ic0iZgws4hnpW+TgwNJvS24y6rqno
         m2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnVwspe5uVckeO1htOV0stxvFuwasrGdrVlM7tfSrfg=;
        b=C7G89M51XVPMh3bNlt69t7W8XdJlRZinQw0jFNIkDtgdZhDsbbtRW/brRimfWeYlp2
         CuEzZDamaCEoblxGVzX3bdYzOR+Poc0rZr7Kvh2TZTZeLycYn/6VCedzCkoAPYxJqhzk
         yEEkSLCWx3n2L7fX9Uk/sHdXuv/k+cQXN9A6sB6Hd6TYkUcDcA4CIwP5pcWc7yhR5jh4
         psjpEUphPo+66FmzSXatl8wtCbhD8gG+9AU8P5fxVjtPST44u94BoJPk6Qlr43uCstPJ
         ItMDiq+b/7oNkU6L2Vgsr0nsAvEOk0w+F1IiEuVagNuo4aZV2b81MsY/QId5xyiHOWQO
         IovQ==
X-Gm-Message-State: AOAM531MTBj5e1Q0I/RSXFpzHzMTjPypIUl1veFRdxwt5qsrvG2Fm7W9
        Sa80AYt0oa3JNtMl+8LxA44=
X-Google-Smtp-Source: ABdhPJxwTzocvNIWCrH3mXf/01/smRYYOyx0fBIce2z2QYjkxLZMX7EQwEEWdjIctASlFEwNKAFkXw==
X-Received: by 2002:a05:6e02:16cf:b0:2cf:8ecb:c8d4 with SMTP id 15-20020a056e0216cf00b002cf8ecbc8d4mr10064349ilx.174.1652741825259;
        Mon, 16 May 2022 15:57:05 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v2 04/27] dyndbg: drop EXPORTed dynamic_debug_exec_queries
Date:   Mon, 16 May 2022 16:56:17 -0600
Message-Id: <20220516225640.3102269-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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

This exported fn is unused, and is effectively obsoleted by a
forthcoming commit, so remove it.

The export was added to let drm control pr_debugs, as part of using
them to avoid drm_debug_enabled overheads.  But following patches
implement the drm.debug interface, and adapt drm to just use it, so
nobody will never need the export.

This also drops the CONFIG_DYNAMIC_DEBUG=N stub-func, and its
pr_warn(), which I avoided in 2012, then added in 2020 :-/

Fixes: a2d375eda771 ("dyndbg: refine export, rename to dynamic_debug_exec_queries()")
Fixes: 4c0d77828d4f ("dyndbg: export ddebug_exec_queries")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  8 --------
 lib/dynamic_debug.c           | 29 -----------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index f30b01aa9fa4..dd20e825c36f 100644
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
@@ -221,11 +218,6 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 				rowsize, groupsize, buf, len, ascii);	\
 	} while (0)
 
-static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
-{
-	pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
-	return 0;
-}
 
 #endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ca2a28f1d51c..cdc0b03b1148 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -555,35 +555,6 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
2.35.3

