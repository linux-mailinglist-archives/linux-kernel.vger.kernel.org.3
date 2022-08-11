Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714BD5905EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiHKRgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiHKRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:36:00 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EAF6DF8D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:59 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e69so15195934iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8oKEUq0EPzmllL1JKxsnzcEjeLeYCN2EOuzsBk4Lakg=;
        b=QP2qAzAS7+Ydg+rd9bTIECTxRQts5ANDfs7JIVWR+befZECCVD3fgy+F4AiHyyCxTD
         6bgIb43ZS1HrCHRrwV+Xj9QmH/GPGX6zYsZVwk/KAeyywUwZOLK9DHxMZMSXG3/vHQ8X
         lWI7a+lVcEViQrO8CkxukR7bbWIMyFuKYKNfFcJCEwSRmKNNLSW1PvKPopU9olr2zOUh
         INYQGr+14DVws3nUswQnITOLkIklqjMqrLkHjOz1vtgKEFi7UzVG1tHq/EYsoZbA4dp7
         MH5f9iWH0o0eKA+Q5ezHYieBu1NGId/c31OaaBylfbe7kxqbn3D2DQCzIjEKyLl2zGM+
         25cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8oKEUq0EPzmllL1JKxsnzcEjeLeYCN2EOuzsBk4Lakg=;
        b=pJ/yQ4rtnshCanoXpG/WHLqVX3+3vK2Aj8qZGOcuhBpg1xwVoxWL5riDBI4aPvFs58
         tHtB10T/pe5MV5vUI+76FeqJsT52Lsj7wK6k0Y2UM4dIpEmCwkoLoSKIS9w3woPTbEEB
         31dTPj3gDD9bGbvx08/W4tBv+vMMqYnX/BxuePjec5KoUqRz8tYkuvBABzRBMkbilz0V
         vK1/PElqf42YNeh6EQHLxqVIQ0WpoTNmHmkdJGJvodXwfSY3tiplFyiiL1jFEmApAFxh
         zElNMrZIdWch8DAA23SH3n5zqUy4S32mn3uEBzz9B57R1gZeNGysg4MOXQisI7Q2L80I
         Z8Ng==
X-Gm-Message-State: ACgBeo3x5uc5j3FW1DN+hpEKViyVFwoZco882zraZZ5771lHF0HacL9Q
        QxnudiN+h4ZNkNurmGJ2TbxLTiu9JHs=
X-Google-Smtp-Source: AA6agR7P3OTO9QykDtdny6uNlBz4xfruevgARPLgoRXdcCi9y73Q1QuyfF9CxagkIcvws7doZ0a3CA==
X-Received: by 2002:a05:6638:1301:b0:342:c20d:3b15 with SMTP id r1-20020a056638130100b00342c20d3b15mr186682jad.59.1660239358576;
        Thu, 11 Aug 2022 10:35:58 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:35:58 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 05/11] dyndbg: reverse module.callsite walk in cat control
Date:   Thu, 11 Aug 2022 11:35:35 -0600
Message-Id: <20220811173541.2901122-6-jim.cromie@gmail.com>
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

