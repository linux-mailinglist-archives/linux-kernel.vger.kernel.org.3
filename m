Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913BB48FD7F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 15:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiAPOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 09:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiAPOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 09:48:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77411C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 06:48:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n8so4483492plc.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 06:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hwm9EN1T261nv/f900i9G0f12xSK5YGW03Lcht+5kBU=;
        b=B+KoVkrayI0i+flhCN9bAMkmkkDeSVyVqUxivHEuJ9pj8fR2AOKxx61kTR+vAzsQeJ
         EK7HDUruP+MtsQmwPpJCCUjnFQ5LlIC0pSv7ETtDonxQBJRYMi5LUCMX/bh5oRMxhtPB
         bopVxKR9taNXeEjIkNV1RZb9GJ7bz2ZzWHRz2NPFzdpaCieZwmXK3pZOfNSXKy6Xb9gj
         wlC6CmpwSn2MR6RnRUfmrP7jjO0rHcKbVImNgANpDQzbqIrpMHZroFKJH/sQcR9c4tSO
         Xui217Ra0ltG4lOCzQpOsB7ZfhmR3o8BYSnFGc9CSAii7Lg8XL0pwZdVAtrgX2AjDT5z
         IX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hwm9EN1T261nv/f900i9G0f12xSK5YGW03Lcht+5kBU=;
        b=XBaNJ6wClr3D89OJDJfOmFkScP0U9Fiuu2SVxpibtntwbaHNVcQmGBwVW86QFdOsa3
         XWGuAAVJed24XUABuZk8lh6rGx7Os1z/oDyddTVnQKaovxlxPxWHmsqIjvm9gdCwJwmm
         Tnw8w19PlCM2pBaJh0/flAqQOxkQJl9g7xCtFNtM3RYgfIhzLb8npOb969SPYqmmkoxr
         KWrocZpNTEsHG+kaFe2fam+KSmoe87dhje2NmBIfBP/EBFjo37TC/kWBJvOa8cJTq2gr
         bnidCxpoRJe4wUwfhDhwKQe7wqTClzLyzxLPso6y4PLihnf5sUMjVeTtRTN7Cbt/lgeq
         AqGg==
X-Gm-Message-State: AOAM533p+qc1EHYV4+kMRT5OV5jSu4Plbar20D2yNGlpQ0seTpnSZeF4
        IaHl7hmsrcXkBeG8F21DC+ZJvymWIz5gRH+RyjQ=
X-Google-Smtp-Source: ABdhPJx9aLfppuD/fazepbHlmsjhnU+COlCpkHIDPFo5qlZGFIF1zV1miAIDPTQ9vmctcvNXfgxG6g==
X-Received: by 2002:a17:902:a509:b0:143:7eb6:c953 with SMTP id s9-20020a170902a50900b001437eb6c953mr18232733plq.4.1642344511064;
        Sun, 16 Jan 2022 06:48:31 -0800 (PST)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id z4sm11127095pfh.215.2022.01.16.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 06:48:30 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] tracing: Remove redundant assignment to variable ret
Date:   Sun, 16 Jan 2022 22:48:05 +0800
Message-Id: <20220116144805.102999-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value assigned to variable ret is never read, the assignment is
redundant and can be removed.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/trace/ftrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 403e485bf091..48499f58ce47 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7122,9 +7122,9 @@ void __init ftrace_init(void)
 
 	last_ftrace_enabled = ftrace_enabled = 1;
 
-	ret = ftrace_process_locs(NULL,
-				  __start_mcount_loc,
-				  __stop_mcount_loc);
+	ftrace_process_locs(NULL,
+			    __start_mcount_loc,
+			    __stop_mcount_loc);
 
 	pr_info("ftrace: allocated %ld pages with %ld groups\n",
 		ftrace_number_of_pages, ftrace_number_of_groups);
-- 
2.34.1

