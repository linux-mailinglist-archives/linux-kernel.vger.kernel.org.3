Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7DB4D5A02
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbiCKEtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346357AbiCKEtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:49:22 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC57B0EBF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:48:20 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id r2so296857ilh.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBRXqLWuyBojQser+FbveA33IOgP8H/VueHlz3pP7BU=;
        b=Dyxrf9L35Hr+o6Rm/FEKjC+JQ97HPxYkwKzea8dMbY2oborFn0jItr+z4C7tIGKC97
         8CTghaUFfyVolu/8SQcbgXHPRbOQmxXT2ukp7wit0PME42zZ0LDpu5Y6PvMe6BtiPWp2
         3cEDeZCu8FaaXKll6oe67z4fOGMc7dx1mDtWbpssZseAEqblBKdkJfMuaQ6AyVYbdjcL
         +ZVZHqKsDL4/ypd8F/RCAVTmLiZ8m493W9XdltdXs4JDb6MH+YOg5OjHhSaZK9kQahIm
         bIvpqdAjCHCEwQfHGz4fLPTwo0UfpgOUXu6y0+tbuz5pW4PXETXeTy7a/bk0DayQSzFo
         7Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBRXqLWuyBojQser+FbveA33IOgP8H/VueHlz3pP7BU=;
        b=fGR1Z7cEMtjkzeKk/uoPtRfDoTvq5KNyQGwbrQWG/yBHG/tfhqJOPdgWbfZaig82E6
         ZC3bUpl6WdD/Y9xk1ChV1w4+CAMwati/fwQOTj8jF8/DAynyqQjPN1MySDoUxasMuKAe
         ynFiN8y5NM8R1iaROyxwcCsSPg4TiMlChjxyo4gkyPBKLWNBElCYX69ZVx4a204j5gH6
         PPcImALWAdMcNazaLh67sUzPPY1Tf7ZovlExR3jFAfAesLJE0CEaAUKYF0t/m73pnXZW
         gag5Qx4Fn8BzfssU9zD5/diKvhRv+mInCrnvck86T/9ZnPlG7/GFbws7JtNAoWxrqFpS
         Fn5Q==
X-Gm-Message-State: AOAM5305mf4ED00CmbrI8rrP3/rQJj75bQNN3FZj0SfE6fS9aqcl3uV+
        CAehfN6O8+YR0uiXdHst1jI=
X-Google-Smtp-Source: ABdhPJwJ5EfN6gJUuWZfyYHiS3993axqKmOQimf6tP1CjpSIoyz16zSG/Fwey29yVYI3Ip9G+rcrEQ==
X-Received: by 2002:a05:6e02:11a4:b0:2c6:40dc:d30 with SMTP id 4-20020a056e0211a400b002c640dc0d30mr6420886ilj.283.1646974099505;
        Thu, 10 Mar 2022 20:48:19 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id q9-20020a5edb09000000b00645c7a00cbbsm3529834iop.20.2022.03.10.20.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 20:48:19 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 5/5] dyndbg: show both old and new in change-info
Date:   Thu, 10 Mar 2022 21:47:56 -0700
Message-Id: <20220311044756.425777-6-jim.cromie@gmail.com>
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

print old -> new flag values in the info("change") message.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b15a9c715e5b..cceac8ebbacd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -158,7 +158,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	struct flagsbuf fbuf;
+	struct flagsbuf fbuf, nbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -223,11 +223,12 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
+			v4pr_info("changed %s:%d [%s]%s %s -> %s\n",
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
2.35.1

