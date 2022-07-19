Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066B57956A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiGSImA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiGSIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:41:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D4626113;
        Tue, 19 Jul 2022 01:41:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2407034A08;
        Tue, 19 Jul 2022 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658220113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHhgnDp/HgaJaRlr8G3hSxYK+naf6eaZxyqXJNunF5E=;
        b=kC39Ol9R9JHw0JjgY+twMpxZCFtYfyaT7MQxbvmTh5/LM8cXPIB/UI1mq68PRHY9/sbqv3
        LHcElqhyOCFpc9iC9X8mdPJooQ+Gf29lTuXoRvd97u/OQHfiE4a961ZtOwhRRlzMWms1LU
        /aRTYL74mmLD60fLtwctIBvVxbToQ94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658220113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHhgnDp/HgaJaRlr8G3hSxYK+naf6eaZxyqXJNunF5E=;
        b=kbevgYW4DplY+FsNkY2xMbeXANmfqEhQ7AZk5+ujVXxCGhx2UUs3iLpogkwAwqGhPuaz5g
        qQPN6P3hR1zaf5DA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D5D432C142;
        Tue, 19 Jul 2022 08:41:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Liska <mliska@suse.cz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 2/2] kbuild: lto: preserve MAKEFLAGS for module linking
Date:   Tue, 19 Jul 2022 10:41:49 +0200
Message-Id: <20220719084149.29950-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719084149.29950-1-jslaby@suse.cz>
References: <20220719084149.29950-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Liska <mliska@suse.cz>

Prefix command in makefile run in order to preserve access to jobserver.
This is needed for gcc at least.

Fixes this warning:
lto-wrapper: warning: jobserver is not available: ‘--jobserver-auth=’ is not present in ‘MAKEFLAGS’

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v2] this is new in v2

 scripts/Makefile.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index bb63374fb055..493f3c4e8461 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -247,8 +247,8 @@ endef
 
 # Built-in and composite module parts
 $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
-	$(call if_changed_rule,cc_o_c)
-	$(call cmd,force_checksrc)
+	+$(call if_changed_rule,cc_o_c)
+	+$(call cmd,force_checksrc)
 
 # To make this rule robust against "Argument list too long" error,
 # ensure to add $(obj)/ prefix by a shell command.
@@ -457,7 +457,7 @@ endef
 $(multi-obj-m): objtool-enabled := $(delay-objtool)
 $(multi-obj-m): part-of-module := y
 $(multi-obj-m): %.o: %.mod FORCE
-	$(call if_changed_rule,ld_multi_m)
+	+$(call if_changed_rule,ld_multi_m)
 $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
 
 targets := $(filter-out $(PHONY), $(targets))
-- 
2.37.1

