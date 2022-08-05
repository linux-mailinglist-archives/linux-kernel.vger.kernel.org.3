Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C558B17D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbiHEVyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbiHEVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:28 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F4E03;
        Fri,  5 Aug 2022 14:54:27 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s7so2899310ioa.0;
        Fri, 05 Aug 2022 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8oKEUq0EPzmllL1JKxsnzcEjeLeYCN2EOuzsBk4Lakg=;
        b=Z7Y4gNIuk1bd9NXInzS3xECyNbs5yvKfMdNd5uDzQIsLhCynYm5Ml3+Sjl1BQce/pZ
         whGmKTeAEsMdzkvbdlOjpR5DZryQKK4T8BqruPO+aM6DxWQmY9nH3xMnR5StQzeyTz/M
         PUKTD3o/51KTbaw1xEXio290b6Zi3mtfpvQtfvwPntT7s9hixz1XTbbvf1jkmjD2fSLS
         Na3MZDoiawvqnfr1m8sQVoTnzdn7abqs/LnQ1K5BVaF94OQgZi/IJcF6A/YJ6xp7oEVm
         qhfOV8ABrOupE32VP9UD0HuGKXuDbgOdmQIcA9ZBwORPZ6VQP3FbpDBGPUnYdXZHJFc7
         nMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8oKEUq0EPzmllL1JKxsnzcEjeLeYCN2EOuzsBk4Lakg=;
        b=gdfquemFJ5UGB4ItjN7Ny9aXiEPAdG5x7GoInGNk8QgQlzmpNkIxt7HK/1DccYm3Z+
         EbNJvOcxfhI2UKBjFPmNYKK27IRjoZopA6c6opuYrsRKUqzVNA3qZYTBLfo+oG6tESsK
         H5JVpkOOuZo6kR7WJf/+GhTHPyxLSP4K/1HBCEZYaqKhDd/+mPpWNhQRiAthSE93RuM6
         eqlx3fOsNVFTATavx7RgPI0G5WsOLIfvLBGz6Gc4Ei6yToPQngmydcCqdIhdTDOg3AYr
         Mbx6u0W2e8J65dKuai3rFvaSKPtSW19eMrtOy41dBPQ3cf6hfOw7ZsfiGS4qdd6Zm7ik
         DywQ==
X-Gm-Message-State: ACgBeo2hiGiIYjqHHXJ4yMyUvBHNSKmKWDM1TF+RMgC2qDx7UX/R0Lbx
        socV/PaV58OKlksMxPwPOj43nZ61QbZ+7A==
X-Google-Smtp-Source: AA6agR7UeYnK8xvl0wwhLHfYV68Yb0uAXZRnCcFJ+O9Xr14Frnao6jEA5Wnu7EbuD1TO+KC8WXNI1w==
X-Received: by 2002:a05:6638:22cd:b0:341:6180:c86f with SMTP id j13-20020a05663822cd00b003416180c86fmr3991488jat.57.1659736466315;
        Fri, 05 Aug 2022 14:54:26 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 05/33] dyndbg: reverse module.callsite walk in cat control
Date:   Fri,  5 Aug 2022 15:53:27 -0600
Message-Id: <20220805215355.3509287-6-jim.cromie@gmail.com>
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

Walk the module's vector of callsites backwards; ie N..0.  This
"corrects" the backwards appearance of a module's prdbg vector when
walked 0..N.  I think this is due to linker mechanics, which I'm
inclined to treat as immutable, and the order is fixable in display.

No functional changes.

Combined with previous commit, which reversed tables-list, we get:

  :#> head -n7 /proc/dynamic_debug/control
  # filename:lineno [module]function flags format
  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\012"
  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\012"
  init/main.c:1424 [main]run_init_process =_ "  with arguments:\012"
  init/main.c:1426 [main]run_init_process =_ "    %s\012"
  init/main.c:1427 [main]run_init_process =_ "  with environment:\012"
  init/main.c:1429 [main]run_init_process =_ "    %s\012"

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 lib/dynamic_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 7fb99492c16f..8ff11977b8bd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -59,7 +59,7 @@ struct ddebug_query {
 
 struct ddebug_iter {
 	struct ddebug_table *table;
-	unsigned int idx;
+	int idx;
 };
 
 struct flag_settings {
@@ -805,13 +805,12 @@ static struct _ddebug *ddebug_iter_first(struct ddebug_iter *iter)
 {
 	if (list_empty(&ddebug_tables)) {
 		iter->table = NULL;
-		iter->idx = 0;
 		return NULL;
 	}
 	iter->table = list_entry(ddebug_tables.next,
 				 struct ddebug_table, link);
-	iter->idx = 0;
-	return &iter->table->ddebugs[iter->idx];
+	iter->idx = iter->table->num_ddebugs;
+	return &iter->table->ddebugs[--iter->idx];
 }
 
 /*
@@ -824,15 +823,16 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
 {
 	if (iter->table == NULL)
 		return NULL;
-	if (++iter->idx == iter->table->num_ddebugs) {
+	if (--iter->idx < 0) {
 		/* iterate to next table */
-		iter->idx = 0;
 		if (list_is_last(&iter->table->link, &ddebug_tables)) {
 			iter->table = NULL;
 			return NULL;
 		}
 		iter->table = list_entry(iter->table->link.next,
 					 struct ddebug_table, link);
+		iter->idx = iter->table->num_ddebugs;
+		--iter->idx;
 	}
 	return &iter->table->ddebugs[iter->idx];
 }
-- 
2.37.1

