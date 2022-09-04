Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0675AC6BA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiIDVmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiIDVmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:16 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33882F002
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:13 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q81so5653543iod.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PbqFdyxSi0Pp6DU3HKsSvwhQJYj8Q2VNhxZwCrpnF6M=;
        b=VsDvR0vs9q2FKCQfOJtjIj8FHz9/Z3bqLVP6coIdC18//1aR2LaIbaZwWf9Z6tEGfl
         5LATbVVqKiBlBcSVvzROupFX7UszhsGWDUy+bmPT1qGZcI1Zqa5qU39Qb2kqg4sRO0kw
         fgQxDQpiLWZ85LuT4smVr3O+O5zuSTuXZnwG3Rv/A16MfL6bVIcM4HNldOSP2KESU/gT
         V20+cxV8kGInvZOnWna6gEYV1K+GBUIItJpcmPhCpXQ4cyszHg26A0WRN3M3WtAN/wBm
         medsQTQakd/d2p87LqtCTlPg3npIOQkOQZQTqCeT1ibwK4SGN1YC/clvc4rCKuFX7YAD
         0pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PbqFdyxSi0Pp6DU3HKsSvwhQJYj8Q2VNhxZwCrpnF6M=;
        b=hGtoXlK7pMgn1l40fY8Yx5LCFrSwS16fCSY8hi2WvUPX6ZUNRpXwlxTnfAJiFMo+mH
         efGgEIc8wN5AJqTV0Xx4IWU97ogF/5t/EvGyVHXjhxMz5Yvw7NM5xqQb727K4n6IeMWJ
         /6NNLs8zV9YyAHQV3ona5NaI2VhYuekz1DpX00AQoriK8ZKkHMaRHw2ncRxbO1A7dKH5
         ag8GxNnwqgRpDhMxdHlXxZjeAENCLZP5DuxCTPR8tpGqu7u7QFOdjHU6czFpsQzQtdM9
         BinbVdWEWni26MNdsRqPkQRH8Td7jCVRMRH4V3qGdEseKvx2+BBt//IBUYPWeLYtwEeE
         5qUQ==
X-Gm-Message-State: ACgBeo1c8OZalrl0RuEoC+Q63vuIqKaNARZcToVrV9Lvhs2/6wTmdYgm
        jsud9GlDGeFopMDm5NJdISg=
X-Google-Smtp-Source: AA6agR7fSTOVCWKQ249DqThxtdMK6mWi8uoaxMmg3jSWwtFYYJA/nulJNENKG3FHhy/TNLExju0ubQ==
X-Received: by 2002:a05:6638:3385:b0:339:ea59:a31f with SMTP id h5-20020a056638338500b00339ea59a31fmr23089435jav.55.1662327732789;
        Sun, 04 Sep 2022 14:42:12 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 03/57] dyndbg: show both old and new in change-info
Date:   Sun,  4 Sep 2022 15:40:40 -0600
Message-Id: <20220904214134.408619-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

print "old => new" flag values to the info("change") message.

no functional change.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a56c1286ffa4..8faf584f2f4b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -156,7 +156,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	struct flagsbuf fbuf;
+	struct flagsbuf fbuf, nbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -217,11 +217,12 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
+			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
+				  trim_prefix(dp->filename), dp->lineno,
+				  dt->mod_name, dp->function,
+				  ddebug_describe_flags(dp->flags, &fbuf),
+				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
-			v4pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp->flags, &fbuf));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.37.2

