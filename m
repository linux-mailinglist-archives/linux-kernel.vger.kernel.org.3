Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC8751CF70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388576AbiEFDcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388559AbiEFDco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:32:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80EE644C9
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:29:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d22so6181063plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ObGYuo/jzq0kKJukFUQR7QwaI4Kz9Z4PyfnQhlw6wC8=;
        b=FH5bfMFwxWVOcCcK1H7vci7vjZllv7QZZuVaFyXVqPTdJUSlmaGKhReLpWEfoGgzqB
         yGhrAFmvtly4AH1gcK716aGkF4RRIr5ik6iHxB/yFq/FYoiY9rkDljXeZYkU8u57GLoK
         I/Axk1ELhvF8NVjmPopww1or1npjxaH2Tp3jQd/QsEOg05n40QAsyuF0nD+kN5B2aSUI
         ADURSrK5W+VgR4KTZ2AZAmONT3B0wZ33ZF1h1skwAEaECwJv9kUfrEK8nxQmeC0ey7z6
         RPnSkrzk4YuVb0P73S4Po3/IY3ftF8Ic6dOxuh4Ua8j7vaRGcI8rV+iKCh5bd+6f5L+L
         L/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ObGYuo/jzq0kKJukFUQR7QwaI4Kz9Z4PyfnQhlw6wC8=;
        b=NXnPzF1Z7VN0PImZyyK58abYGut50Et8+6epyjYwyVjJn4VBYT3J5rfsU1SOGX+UQ/
         YRkWW0R1YR9F0B3K/R0GDRzcHWW+/qG+O/BCubbDF0erdWfiEuxU6JeL6uBGlR06ElNW
         Q8GTjQLxX3wfM17+lyLWeNIwBqDb//FoqEGbhjZSrMKXF8+4pLKiX29lrrMUUtTIzfd7
         toR03cv0/PwzElcbkdjZ4PX3eTIZurWFTP63bniIbWX0LnIDACngyXPoi6hWUueFnwju
         izApg65ZMHgP/5N0h/K/pNwqX5CaK/7JoSSwahlDdQIwYAi+4P6KsdylXaU0ikmGjQwd
         8cFw==
X-Gm-Message-State: AOAM533dZ4hyu93mm+JQGjLe7dwJsORAtVjvaFZoeRRdpzQKBdDfQJDQ
        VPAtjtNgEzIF4mChvFQZWwzEEQ==
X-Google-Smtp-Source: ABdhPJwIr4coEHbie1ZiXIT/MWIZue8W7Smk/8+HtWenFSnceXzzUfrw05O7OwocPT4aA/z+T637AQ==
X-Received: by 2002:a17:90a:8d82:b0:1d8:a5a9:5489 with SMTP id d2-20020a17090a8d8200b001d8a5a95489mr1787634pjo.102.1651807742426;
        Thu, 05 May 2022 20:29:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id j19-20020a634a53000000b003c14af50610sm2233048pgl.40.2022.05.05.20.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:29:01 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mark.rutland@arm.com, catalin.marinas@arm.com
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        lkp@intel.com, zhouchengming@bytedance.com
Subject: [PATCH] ftrace/fgraph: fix increased missing-prototypes warnings
Date:   Fri,  6 May 2022 11:27:37 +0800
Message-Id: <20220506032737.23375-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit e999995c84c3 ("ftrace: cleanup ftrace_graph_caller enable
and disable") merged into the linux-next tree, the kernel test robot
(lkp@intel.com) has send out report that there are increased missing-prototypes
warnings caused by that commit.

COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 \
	O=build_dir ARCH=sh SHELL=/bin/bash kernel/trace/
warning: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Wmissing-prototypes]
warning: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Wmissing-prototypes]
warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]

BTW there are so many missing-prototypes warnings if build kernel with "W=1".

The increased warnings for 'ftrace_[enable,disable]_ftrace_graph_caller'
is caused by CONFIG_FUNCTION_GRAPH_TRACER && !CONFIG_DYNAMIC_FTRACE,
so the declarations in <linux/ftrace.h> can't be seen in fgraph.c.

And this warning can't reproduce on x86_64 since x86_64 select
HAVE_FUNCTION_GRAPH_TRACER only when DYNAMIC_FTRACE, so fgraph.c will
always see the declarations in <linux/ftrace.h>.

This patch fix the increased warnings by put the definitions in
CONFIG_DYNAMIC_FTRACE although there are no real problems exist.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/trace/fgraph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 289311680c29..2cd374294be7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -30,6 +30,7 @@ int ftrace_graph_active;
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 /*
  * archs can override this function if they must do something
  * to enable hook for graph tracer.
@@ -47,6 +48,7 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 {
 	return 0;
 }
+#endif
 
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
-- 
2.36.0

