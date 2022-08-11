Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E452C5905F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiHKRgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiHKRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:36:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7006B156
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:00 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r5so15181294iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=J+XMFiNX/q3LQYLLDUo59QkX1sLIyVqPUPsR4ifBrfo=;
        b=k/uGzsEE9brEtITCglwRm8+ZCeF34mLrXNhdbENp6TWjeb2bbcXxRHndBbVlx5w2ZZ
         KVQ5fM/iUo/raYXrkPy8fuCzFDffKd5f74d8eekORzGrGsyxoUx1mDUrUWV7x2DkGXC1
         xcyPDTm9CBkgEqo757rRrNjMTmY9AkPbDaLXE0oC7UQcWFlFosTG1igL/RdPfck1/Vk0
         d7SIQI3XN0LhYLtzyXq/iM1zrnUXjInAUBnja6KezvBknVXHyij1hMvt4LXlmejq6fou
         6G90+xvg23/cYLbsQYaIHGiEeOL7tIEGphKMCqS9+FsVC2d/50p6q7n9CuBuSaUVBxwm
         Itdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J+XMFiNX/q3LQYLLDUo59QkX1sLIyVqPUPsR4ifBrfo=;
        b=agaJLwV8IGQ+/vDlCgX/t/9lMWjXBajxPVWuVsLHi/3N6jjPkadF3PUvVYzoPiR+kS
         y+OJuEWxdIrBHPEb2s86QuYHoo/KdaIRBB7Kryqsy/EqL4HEcdaLeM9MIrpOKrvLVI43
         kqFT9EySqc9vboc+osxj0L4fOmye1bBe3hQx5k7VEMJrIQnbuUWXPQXfEL52CSiscHl0
         YxVr6cFwt6GUIm3yOYGyHkOswS8u4mzNY/PLwcZKEeE5whrtimD4KJLTvQSu8yGjEKox
         4au8xXvMmohWGnGSoxpwD0aC3YZdHnm7sRAK/3Nzo7I+8BX2CHeB76zSkLMVldMTxd5d
         yikw==
X-Gm-Message-State: ACgBeo09oSyJlPVigdCbps05aXzOyi6d8M4eYK7oLyD7g6P+XpSW3iEV
        SmGyrYqMg806Z1n7dlv7AeU9qVwh8/4=
X-Google-Smtp-Source: AA6agR7UkkkeZPWzL08mYyDCs0ONvUCyyCq7oDwdgZnEay5MEM3TR2zGVmjCXrMkagXjcwy543GoFA==
X-Received: by 2002:a05:6638:2652:b0:343:d46:58e7 with SMTP id n18-20020a056638265200b003430d4658e7mr191389jat.134.1660239359447;
        Thu, 11 Aug 2022 10:35:59 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:35:59 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 06/11] dyndbg: use ESCAPE_SPACE for cat control
Date:   Thu, 11 Aug 2022 11:35:36 -0600
Message-Id: <20220811173541.2901122-7-jim.cromie@gmail.com>
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
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
2.37.1

