Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9310C4E65C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351197AbiCXPDu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Mar 2022 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347598AbiCXPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:03:48 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3253A94EF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:02:15 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-oj5YYOTvPUORGiha6ai_Ug-1; Thu, 24 Mar 2022 11:02:11 -0400
X-MC-Unique: oj5YYOTvPUORGiha6ai_Ug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7516385A5BE;
        Thu, 24 Mar 2022 15:02:10 +0000 (UTC)
Received: from x1.com (unknown [10.22.34.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68C8A401476;
        Thu, 24 Mar 2022 15:02:09 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: rtla/Makefile: Properly handle dependencies
Date:   Thu, 24 Mar 2022 16:01:52 +0100
Message-Id: <48c7167c78a330d0b25dc631ee7d6f0f34c096e9.1648132686.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus had a problem compiling RTLA, saying:

"[...] I wish the tracing tools would do a bit more package
checking and helpful error messages too, rather than just
fail with:

    fatal error: tracefs.h: No such file or directory"

Which is indeed not a helpful message. Update the Makefile, adding
proper checks for the dependencies, with useful information about
how to resolve possible problems.

For example, the previous error is now reported as:

    $ make
    ********************************************
    ** NOTICE: libtracefs version 1.3 or higher not found
    **
    ** Consider installing the latest libtracefs from your
    ** distribution, e.g., 'dnf install libtracefs' on Fedora,
    ** or from source:
    **
    **  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ 
    **
    ********************************************

These messages are inspired by the ones used on trace-cmd, as suggested
by Stevel Rostedt.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/Makefile | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 5a1eda617992..448e9073736a 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -57,6 +57,78 @@ else
 DOCSRC	=	$(SRCTREE)/../../../Documentation/tools/rtla/
 endif
 
+LIBTRACEEVENT = libtraceevent
+LIBTRACEFS = libtracefs
+LIBPROCPS = libprocps
+
+LIBTRACEEVENT_MIN_VERSION = 1.5
+LIBTRACEFS_MIN_VERSION = 1.3
+LIBPROCPS_MIN_VERSION = 3.3
+
+TEST_LIBTRACEEVENT = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEEVENT_MIN_VERSION) $(LIBTRACEEVENT) > /dev/null 2>&1 || echo n")
+ifeq ("$(TEST_LIBTRACEEVENT)", "n")
+.PHONY: warning_traceevent
+warning_traceevent:
+	@echo "********************************************"
+	@echo "** NOTICE: $(LIBTRACEEVENT) version $(LIBTRACEEVENT_MIN_VERSION) or higher not found"
+	@echo "**"
+	@echo "** Consider installing the latest $(LIBTRACEEVENT) from your"
+	@echo "** distribution, e.g., 'dnf install $(LIBTRACEEVENT)' on Fedora,"
+	@echo "** or from source:"
+	@echo "**"
+	@echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/ "
+	@echo "**"
+	@echo "********************************************"
+endif
+
+TEST_LIBTRACEFS = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEFS_MIN_VERSION) $(LIBTRACEFS) > /dev/null 2>&1 || echo n")
+ifeq ("$(TEST_LIBTRACEFS)", "n")
+.PHONY: warning_tracefs
+warning_tracefs:
+	@echo "********************************************"
+	@echo "** NOTICE: $(LIBTRACEFS) version $(LIBTRACEFS_MIN_VERSION) or higher not found"
+	@echo "**"
+	@echo "** Consider installing the latest $(LIBTRACEFS) from your"
+	@echo "** distribution, e.g., 'dnf install $(LIBTRACEFS)' on Fedora,"
+	@echo "** or from source:"
+	@echo "**"
+	@echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ "
+	@echo "**"
+	@echo "********************************************"
+endif
+
+TEST_LIBPROCPS = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBPROCPS_MIN_VERSION) $(LIBPROCPS) > /dev/null 2>&1 || echo n")
+ifeq ("$(TEST_LIBPROCPS)", "n")
+.PHONY: warning_procps
+warning_procps:
+	@echo "********************************************"
+	@echo "** NOTICE: $(LIBPROCPS) version $(LIBPROCPS_MIN_VERSION) or higher not found"
+	@echo "**"
+	@echo "** Consider installing the latest procps-ng-devel from your"
+	@echo "** distribution, e.g., 'dnf install procps-ng-devel' on Fedora,"
+	@echo "** or from source:"
+	@echo "**"
+	@echo "**  https://gitlab.com/procps-ng/procps "
+	@echo "**"
+	@echo "********************************************"
+endif
+
+TEST_RST2MAN = $(shell sh -c "rst2man --version > /dev/null 2>&1 || echo n")
+ifeq ("$(TEST_RST2MAN)", "n")
+.PHONY: warning_rst2man
+warning_rst2man:
+	@echo "********************************************"
+	@echo "** NOTICE: rst2man not found"
+	@echo "**"
+	@echo "** Consider installing the latest rst2man from your"
+	@echo "** distribution, e.g., 'dnf install python3-docutils' on Fedora,"
+	@echo "** or from source:"
+	@echo "**"
+	@echo "**  https://docutils.sourceforge.io/docs/dev/repository.html "
+	@echo "**"
+	@echo "********************************************"
+endif
+
 .PHONY:	all
 all:	rtla
 
-- 
2.35.1

