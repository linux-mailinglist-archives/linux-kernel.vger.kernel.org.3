Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739D258B181
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiHEVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiHEVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:29 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336ECF5A2;
        Fri,  5 Aug 2022 14:54:28 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h16so1968649ilc.10;
        Fri, 05 Aug 2022 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=J+XMFiNX/q3LQYLLDUo59QkX1sLIyVqPUPsR4ifBrfo=;
        b=a3pE4rSuZD6ro/cAPZ0Z73WjsYUoQsEAbwyUOAqkxPwqOML8IMtCRzyMMjE6ZCJJCH
         4scGqqJcV3JdotbBSmD47jk7lpKPscKlF7ejCkueKNDZc62M5x6RByzui6UXS/yrhEB/
         Ma9VANyVI7k0Kt+62fIgtMkwlry0TtsgYx+JzzmG7zLU3gOw8u6v8GVHIOxS78S6ySuJ
         yQedjpXdXviU2c0CtSvX8JSMMrEMC2fuCmCJ3zZs+/tekpoFMtppdOD1KBHt6WoE6wSl
         TqyEco90VmD806y4HavPugyYKbr4gmKWihAk17UiplBB9FsIctcOWsPeNGNljMqQiUYj
         Ds8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J+XMFiNX/q3LQYLLDUo59QkX1sLIyVqPUPsR4ifBrfo=;
        b=Fc0IFMLov8QIDw1xX5oomr5tmj7N+oeldsF0DiTgeJCUxbe7is+j2hL78nQgLzu2MT
         fxR7bLUVP6aFA6Itr+lQx8D0eQj9ahmwwfCI+/+RNEQ+B16+uHjd7Kl14jhpJRqDoMy8
         vLmJdSA1+p4zoAr/IYwga8hBPA/IIrBaebBdU+3KqkXjZ529axgIQYYeDfw2r+cB8AlE
         EkjWEf7MlAJ3wUfXY8T1UwIeQ5r9iIXgIaRwixI1GCIkvfSjVQQoFwjgZWCkEPUKhotZ
         Au/XoZZPi2mw0bMhscwF1lOvzG1X9uV6ooXj4ScXN5Zvb/N1wB4nCpjTjKCWHe881cTJ
         QhSg==
X-Gm-Message-State: ACgBeo05NS5b1bRMl4a0eB3UZSZKEBLl3bMIZheldWS+TzpVbBxrOk4S
        97cdM9XOa2zEXgGN4ypTQ0T6l0eu84kgjw==
X-Google-Smtp-Source: AA6agR61kurKmG2CZ4QJXTnktlt/717WlcXUXKttKGA+qVbP2Lsxbsku+CON2rmb9ab1kZ1VnYNO8w==
X-Received: by 2002:a05:6e02:180a:b0:2de:20c8:572 with SMTP id a10-20020a056e02180a00b002de20c80572mr3819308ilv.213.1659736467233;
        Fri, 05 Aug 2022 14:54:27 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.26
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
Subject: [PATCH v5 06/33] dyndbg: use ESCAPE_SPACE for cat control
Date:   Fri,  5 Aug 2022 15:53:28 -0600
Message-Id: <20220805215355.3509287-7-jim.cromie@gmail.com>
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

