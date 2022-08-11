Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BD85905F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiHKRgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiHKRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:36:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194656FA0C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 68so8534938iou.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ip7G03GeGcrZkSaeVkjkXUMKYERuJTa3x3HVuceUBd4=;
        b=jkvp6ypAI7wmjuLyIm6zfQW7XgupXVr6/yxNKX+AiI/z6XQPh8raO880pk6CRYoNDT
         75YB+dVDMVqmv1Wnt1NEp1n9xwA/zA7qOvS2qWB/f3jazRfia8HuNCfiXy6SvxNzimmI
         XpLW05KgRbso2g07iJhXlDwvmSbHb+KykZqlOh6sb9F/RCQQK2PA6wl5pRDF6z7VFnSo
         QWFQW5uxSJcOHIWUFCVpw5UrpZH8BwmPBbDDpe8D/FRDhLgkSeIOklt0lq3HOtR4CtnZ
         mTTXYjBwfy/WRfzgfI0tAyXF5lWIyZzXOsFyhzBcC5T1+ny/iLF8VdmGI03kz9RoyOGT
         Nv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ip7G03GeGcrZkSaeVkjkXUMKYERuJTa3x3HVuceUBd4=;
        b=D4mceOQR8WAk0IGb+Mh1A/JuMiAw6jLm25A5dl65yGlbGGdIhmqgigvjzwVYVf0NcO
         S4vZdVMxQz00ziEbMWipBMburJQmcoyKCUEnwiDOoc1qIaRTrWchErd3sSP996GLgZ8R
         nH2ks4Rk4WUFbcV0n6a0UoYsQZm/eGgZvukPQX2T/s6KaS4QE3hDbcXBXBA46SCPxiYr
         tiJNCGuQz8fedKRmV9U3x566HgtcUJDTPJ2wq94AZzEwTo57JupdmmYGEe8r5Hm00rfQ
         jX+is/jheO8Ud3Q25aGqWZokGyrIcxLAmBOe+ccS8nkCa6M6JHuBCjenjg6bHa7vz4hX
         oVSw==
X-Gm-Message-State: ACgBeo2sa6Fkh8KtolP15zlVAMHTqHmQqjRLwQXtQ/zJ66vEAfn2FAuI
        VDXTRX3E6nL7WLYiyASxiaOa8FIwqVY=
X-Google-Smtp-Source: AA6agR5fDHZdIb6S54Ju2g6cePa4/XJS8UFUlqUYCk6NArZK5ieZdZTo4QpD2R+XyS1qaLf+kZREVQ==
X-Received: by 2002:a02:9f8a:0:b0:342:f254:6ede with SMTP id a10-20020a029f8a000000b00342f2546edemr189240jam.35.1660239360400;
        Thu, 11 Aug 2022 10:36:00 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:35:59 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/11] dyndbg: let query-modname override actual module name
Date:   Thu, 11 Aug 2022 11:35:37 -0600
Message-Id: <20220811173541.2901122-8-jim.cromie@gmail.com>
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

dyndbg's control-parser: ddebug_parse_query(), requires that search
terms: module, func, file, lineno, are used only once in a query; a
thing cannot be named both foo and bar.

The cited commit added an overriding module modname, taken from the
module loader, which is authoritative.  So it set query.module 1st,
which disallowed its use in the query-string.

But now, its useful to allow a module-load to enable classes across a
whole (or part of) a subsystem at once.

  # enable (dynamic-debug in) drm only
  modprobe drm dyndbg="class DRM_UT_CORE +p"

  # get drm_helper too
  modprobe drm dyndbg="class DRM_UT_CORE module drm* +p"

  # get everything that knows DRM_UT_CORE
  modprobe drm dyndbg="class DRM_UT_CORE module * +p"

  # also for boot-args:
  drm.dyndbg="class DRM_UT_CORE module * +p"

So convert the override into a default, by filling it only when/after
the query-string omitted the module.

NB: the query class FOO handling is forthcoming.

Fixes: 8e59b5cfb9a6 dynamic_debug: add modname arg to exec_query callchain
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 lib/dynamic_debug.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e5cbe603000c..5a849716220a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -385,10 +385,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		return -EINVAL;
 	}
 
-	if (modname)
-		/* support $modname.dyndbg=<multiple queries> */
-		query->module = modname;
-
 	for (i = 0; i < nwords; i += 2) {
 		char *keyword = words[i];
 		char *arg = words[i+1];
@@ -429,6 +425,13 @@ static int ddebug_parse_query(char *words[], int nwords,
 		if (rc)
 			return rc;
 	}
+	if (!query->module && modname)
+		/*
+		 * support $modname.dyndbg=<multiple queries>, when
+		 * not given in the query itself
+		 */
+		query->module = modname;
+
 	vpr_info_dq(query, "parsed");
 	return 0;
 }
-- 
2.37.1

