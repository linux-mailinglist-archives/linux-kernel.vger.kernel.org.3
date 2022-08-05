Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B771358B184
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbiHEVyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241605AbiHEVya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:30 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2129C43;
        Fri,  5 Aug 2022 14:54:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o2so2848610iof.8;
        Fri, 05 Aug 2022 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ip7G03GeGcrZkSaeVkjkXUMKYERuJTa3x3HVuceUBd4=;
        b=ewQ92O2vGpMAbSdWrB4+u6UhrXNZYJKTGukr+8UZtGaGb4+w6CiksOOQTQn87WyyNX
         wo5Df7zH9JxqD9apdFkTFusfidPasfZsOIm6pyx9X5xz5MkMkiQceQcD8+OrEsEe9RhS
         A/pMGk4fpmKBVUtxm/I+JRb9MVVLji8813bHcb+yg0LTm70CM2NjO4WqYWyNMS0o5FVo
         fB7O4+WYEYPDWxjM7LUXepooHEFyr8/yW8cCxEcb7t4T8DscS66q6XO7tWCER3eaMdwf
         DqJwCvy/6DcnFsXqXNmeL59eC/DLc4Qh/dr4dPn+9I8WggKs2QIEWX10y8x0RJXsd1Bm
         L2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ip7G03GeGcrZkSaeVkjkXUMKYERuJTa3x3HVuceUBd4=;
        b=DLeoDBoN232WmvVOFqXKfAhYOJv1oufeEK1g1hsvDEfoGagVSftqYCMZdep9ge0Dmq
         VpUG1wo7JdhZZKXD7gg++LycCeEqXmEXrVL6+QKlhuh4lZi/rbSOdHrRDDt7HNWR3VFz
         LAvhx6DP/Gy2A/6i/ShiG8cqwayYyksXFJskT+K1j3IsER+G5q1TR5nshWp1W46qIEjY
         14j0L821o7jo6EfY19Eud12JQbZWKjviiwAsp3KsHTIRYFlshejtabgoRfcgFjCbN3qX
         gJZu/suPOCUe6XCgeWZbolB7aH/l6IkBaoD+t5wGrimJTUYKLSLV/TMUy3k0kertd8oD
         QVmQ==
X-Gm-Message-State: ACgBeo3Q80Kd1xfpjhIZdWFZcUGqW+jJCMEA/+U7F42r7E5DYEdom710
        qVPrkNSJNz1t40RpGprVcEPHhyYZB2jh5w==
X-Google-Smtp-Source: AA6agR5F2b8YYYl6aGI+QseCk+8Ms4jeiO8wtWEfnF2wD77In7NaA/BOIIRV1TpkHi0h0b1ACEo2YQ==
X-Received: by 2002:a05:6638:4982:b0:342:39e0:1d44 with SMTP id cv2-20020a056638498200b0034239e01d44mr3814986jab.213.1659736468516;
        Fri, 05 Aug 2022 14:54:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 07/33] dyndbg: let query-modname override actual module name
Date:   Fri,  5 Aug 2022 15:53:29 -0600
Message-Id: <20220805215355.3509287-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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

