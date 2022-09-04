Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56345AC6B8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiIDVme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiIDVmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:19 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07F2E69B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y187so5723630iof.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ysIiIQDuG3NPX9ftczW4ZGg58gUBI4jeSANScS140gM=;
        b=APgxhuRWpHrA5EiAcM6bPTAJX5sVjnKO8ZXN2+OQbTnNZthJ6+91rd6qMlpfQu96tK
         kU7buxw62MArc4SqmHlqi7ZnRepiJzi2ZjfY0l2reZS4c+bENNXL+q4MBcG6kmRIBJDg
         zjOTRGcunIJUea9k7GCkxnFakIoXTx5p4Q3YZsvD2JZKGgVLIqCxlvTVr6lLWopOQ5jg
         tM6aObbyHfQt4hKC15wVu4dtKTl7xSjSAHhGJrPEG7cERNokHi0L0ifYgGVAskmds7W2
         JuY57ATFtM+4aknCtkIxF/AXoHBg+QwEAv3LIU8kjqNqvJGhCXZbCxBDuxpyjqad4Plp
         4+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ysIiIQDuG3NPX9ftczW4ZGg58gUBI4jeSANScS140gM=;
        b=hesK1dUJzB5BEZDHhZG19+uKmpGEpdLG7h0Y0dE0a9am84X40l6rTgBjtduI6rLTfq
         3kXCVCxH+RYghbZA6Ynp+sifnpw4Z+Y5fc+tmYydz5/P/nJR+w93CMFPXLP6IMnygV/T
         /fhxBrFC/qfHfE14U3qjvyw46wB5ebACcxmG9djGbHPRih0FMko5X151lsv8YKWhNFZY
         j5R1yWzTz/YdcLVCbI4htG3Eq7SMk6yesfLBb0OWYhkuaO6Kvys+EkQCI8FD2AugmkUO
         LQi2cBd3udM9pl3EAQkmZJSb0x/57quel6+/BQ+KNZPVm0/QGxK10N7hkba19xUJ4OW6
         qe9Q==
X-Gm-Message-State: ACgBeo3q8rkucjymCRmB2q2+SteYPKFc/eGB3y6jFf8LerMANgHzIvfr
        zA0a6Bn/lrZpd/wVrcijbgY=
X-Google-Smtp-Source: AA6agR6afjzcErCVofVv8IgSNBB83b3vDq9Bdzagkl5cWOw7B+80htmvEYKRocJbPU12He1vQEZnCg==
X-Received: by 2002:a05:6602:2b81:b0:688:b897:13b8 with SMTP id r1-20020a0566022b8100b00688b89713b8mr21276933iov.43.1662327735766;
        Sun, 04 Sep 2022 14:42:15 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:15 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 06/57] dyndbg: use ESCAPE_SPACE for cat control
Date:   Sun,  4 Sep 2022 15:40:43 -0600
Message-Id: <20220904214134.408619-7-jim.cromie@gmail.com>
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

`cat control` currently does octal escape, so '\n' becomes "\012".
Change this to display as "\n" instead, which reads much cleaner.

   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
   init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
   init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
   init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
   init/main.c:1426 [main]run_init_process =_ "    %s\n"
   init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
   init/main.c:1429 [main]run_init_process =_ "    %s\n"

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8ff11977b8bd..e5cbe603000c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -900,7 +900,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
-	seq_escape(m, dp->format, "\t\r\n\"");
+	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
 	return 0;
-- 
2.37.2

