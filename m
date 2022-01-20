Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF64947A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiATHAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiATHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:00:47 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:00:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h12so4869689pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhyhwE3CHJG0B5F6U7HDGNGF80WPUFSFTmXHqgzZiOw=;
        b=OgobDuIgA9duQXU2Cd3SfEWbNR+WG/wX/ddOj10SQAFnxJZLt00GzM8JV2pQfeWpZ/
         xoyotaVVO9dKM6kF/AR+xDQBrHStlCkYBAEQMSWYJaBn7gFqbL5XMeaqp823Paq4qwhP
         Otc0vVJT9sAymFfAGRGL2BfMnQnkovW+CHgznwNe8yrDews4RnMxgw8s3imrRqE+3CYv
         3++FeH//mLKa1PfnStqph4emVMj81upshs3VJKUCa3Qvr1BYNRuLSWnTc42AKIyPslEX
         7JNqAE4L0DImJZitAEHbF9p3VStnd19TJ/y45LGDoDnykM7EI59/G/9gXB8GCBDwLT3d
         1JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhyhwE3CHJG0B5F6U7HDGNGF80WPUFSFTmXHqgzZiOw=;
        b=ckj+DdBh18MUO7YGoQKQGRC5H3fY4C7tHiR7TinOoMKmKg6+rjnhHGYh1XArmxccjW
         Qit/Q52Vf5uUOp3CIKp5PAaFdVVyeDxmDXLuGGLiaoDZyX2KzeVBdtI1JFihzcA50mRw
         aIKDMTheJHQr+gtp6ib34GTshyAycqDX+kaA7UnOabp3VgXI9lMzKSPMgAK/i7xPjZBb
         Z8TiqnbEMkBs7oEnb1xh7sCRLHiWa8R5TBJ/oqstAdoOpgM3do5m8cT2KBbSdqdWUO7R
         8z3vvGnfp8d3u/xf2khe17Ea8oyB5eIpG3tjO1rsJC+z7QlrZj3G1Z2Gwz7m0uMQxIYL
         MMYw==
X-Gm-Message-State: AOAM531vzzP3s5dLZpGFAgBPimd/dsYdh3aum0BZJS/2YX5IrKpYigOw
        E44DNN9VtJ4OO4Duy6t/1co=
X-Google-Smtp-Source: ABdhPJxJDJaiKIzTZnHaDKX4aWRu4D2NRow+pPmQRA9lsrKtVrlkI/aOcnNwwFPDW3laUdIp3VX+GA==
X-Received: by 2002:a17:902:b414:b0:149:61c7:d550 with SMTP id x20-20020a170902b41400b0014961c7d550mr36717502plr.129.1642662046662;
        Wed, 19 Jan 2022 23:00:46 -0800 (PST)
Received: from vultr.guest ([141.164.42.249])
        by smtp.gmail.com with ESMTPSA id y6sm1954296pfa.66.2022.01.19.23.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 23:00:46 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2] tracing: Deal with error return code of the ftrace_process_locs() function
Date:   Thu, 20 Jan 2022 06:59:49 +0000
Message-Id: <20220120065949.1813231-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119095741.1fff2305@gandalf.local.home>
References: <20220119095741.1fff2305@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace_process_locs() function may return -ENOMEM error code, which
should be handled by the callers.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
Changes since v1:
- Deal with error return code instead of just removing it

 kernel/trace/ftrace.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6163b6f762f7..eb98797b399b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6791,11 +6791,16 @@ void ftrace_module_enable(struct module *mod)
 
 void ftrace_module_init(struct module *mod)
 {
+	int ret;
+
 	if (ftrace_disabled || !mod->num_ftrace_callsites)
 		return;
 
-	ftrace_process_locs(mod, mod->ftrace_callsites,
-			    mod->ftrace_callsites + mod->num_ftrace_callsites);
+	ret = ftrace_process_locs(mod, mod->ftrace_callsites,
+				  mod->ftrace_callsites + mod->num_ftrace_callsites);
+	if (ret)
+		pr_warn("ftrace: failed to allocate entries for module '%s' functions\n",
+			mod->name);
 }
 
 static void save_ftrace_mod_rec(struct ftrace_mod_map *mod_map,
@@ -7126,15 +7131,19 @@ void __init ftrace_init(void)
 	pr_info("ftrace: allocating %ld entries in %ld pages\n",
 		count, count / ENTRIES_PER_PAGE + 1);
 
-	last_ftrace_enabled = ftrace_enabled = 1;
-
 	ret = ftrace_process_locs(NULL,
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
+	if (ret) {
+		pr_warn("ftrace: failed to allocate entries for functions\n");
+		goto failed;
+	}
 
 	pr_info("ftrace: allocated %ld pages with %ld groups\n",
 		ftrace_number_of_pages, ftrace_number_of_groups);
 
+	last_ftrace_enabled = ftrace_enabled = 1;
+
 	set_ftrace_early_filters();
 
 	return;
-- 
2.34.1.75.gabe6bb3905

