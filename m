Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8E4B5B70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiBNUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:49:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiBNUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:49:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AC15F601
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:49:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5942610A1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CF1C340EB;
        Mon, 14 Feb 2022 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644866937;
        bh=zRzXMCM9AhF3WBIJ4GuTK+ukLtut1AMLJ1G7ORC9iMo=;
        h=From:To:Cc:Subject:Date:From;
        b=b+KNMhMmSRyY30RB495UofKiq8RCAoxZ29bKm99qeU5cyjakjYbzzcr74HtjwzIwr
         cOurBuPKU/EahWT87CKDYhUaP0vAThxFcXXQN0i1qoFSAS+kofwPd2BIMA61cNJ9s5
         aTTuDcblueQaenPKeRXnNbduZxc8vDKFXMtn2jBHsd0e90iktNhU0o+NblIF+KWrGo
         PKL3ZV3PpwTq9euozbw7iLvsG/c0uxGER+GXMeGqOwh9LFUdOCPJ/ds1lwHHLJ9H0b
         6FHu4YkEKEiBEgUy+gGS7/gxb8o68h17PuQVsqbZwjMZ2XiI8J7yK93/CXvIz5jiZV
         B6c/tEaw3NlvQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ftrace: Remove unused ftrace_startup_enable() stub
Date:   Mon, 14 Feb 2022 12:28:47 -0700
Message-Id: <20220214192847.488166-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang + CONFIG_DYNAMIC_FTRACE=n + W=1, there is a
warning:

  kernel/trace/ftrace.c:7194:20: error: unused function 'ftrace_startup_enable' [-Werror,-Wunused-function]
  static inline void ftrace_startup_enable(int command) { }
                     ^
  1 error generated.

Clang warns on instances of static inline functions in .c files with W=1
after commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

The ftrace_startup_enable() stub has been unused since
commit e1effa0144a1 ("ftrace: Annotate the ops operation on update"),
where its use outside of the CONFIG_DYNAMIC_TRACE section was replaced
by ftrace_startup_all().  Remove it to resolve the warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/trace/ftrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9feb197b2da..a4b462b6f944 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7191,7 +7191,6 @@ static int __init ftrace_nodyn_init(void)
 core_initcall(ftrace_nodyn_init);
 
 static inline int ftrace_init_dyn_tracefs(struct dentry *d_tracer) { return 0; }
-static inline void ftrace_startup_enable(int command) { }
 static inline void ftrace_startup_all(int command) { }
 
 # define ftrace_startup_sysctl()	do { } while (0)

base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07
-- 
2.35.1

