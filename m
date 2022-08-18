Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99C59862E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbiHROl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343609AbiHROlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:41:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19ABB6A4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3349FB821C7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08482C433D6;
        Thu, 18 Aug 2022 14:41:40 +0000 (UTC)
Date:   Thu, 18 Aug 2022 10:41:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Alexandre Vicenzi <alexandre.vicenzi@suse.com>,
        Ben Hutchings <benh@debian.org>
Subject: [GIT PULL] rtla: Fixes for 6.0
Message-ID: <20220818104151.524f3df2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Fixes for the RTLA tooling:

- Fix tracer name in comments and prints

- Fix setting up symlinks

- Allow extra flags to be set in build

- Consolidate and show all necessary libraries not found in build error


Please pull the latest trace-rtla-v6.0 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-rtla-v6.0

Tag SHA1: a54079a2b9a25f6cf1229b053ef2f4fa71d6cee5
Head SHA1: 20aec89aac7761e3c096004f5c819aacc86fc542


Alexandre Vicenzi (1):
      rtla: Fix tracer name

Ben Hutchings (2):
      tools/rtla: Fix command symlinks
      tools/rtla: Build with EXTRA_{C,LD}FLAGS

Steven Rostedt (Google) (1):
      rtla: Consolidate and show all necessary libraries that failed for building

----
 Documentation/tools/rtla/rtla-timerlat-hist.rst |  2 +-
 tools/tracing/rtla/Makefile                     | 70 ++++++++++++++-----------
 tools/tracing/rtla/src/timerlat_hist.c          |  2 +-
 tools/tracing/rtla/src/timerlat_top.c           |  2 +-
 4 files changed, 43 insertions(+), 33 deletions(-)
---------------------------
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index e12eae1f3301..6bf7f0ca4556 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -33,7 +33,7 @@ EXAMPLE
 =======
 In the example below, **rtla timerlat hist** is set to run for *10* minutes,
 in the cpus *0-4*, *skipping zero* only lines. Moreover, **rtla timerlat
-hist** will change the priority of the *timelat* threads to run under
+hist** will change the priority of the *timerlat* threads to run under
 *SCHED_DEADLINE* priority, with a *10us* runtime every *1ms* period. The
 *1ms* period is also passed to the *timerlat* tracer::
 
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 1bea2d16d4c1..22e28b76f800 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -30,8 +30,8 @@ WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_A
 
 TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
 
-CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS)
-LDFLAGS	:=	-ggdb
+CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS)
+LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
 LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
 
 SRC	:=	$(wildcard src/*.c)
@@ -61,40 +61,50 @@ endif
 LIBTRACEEVENT_MIN_VERSION = 1.5
 LIBTRACEFS_MIN_VERSION = 1.3
 
+.PHONY:	all warnings show_warnings
+all:	warnings rtla
+
 TEST_LIBTRACEEVENT = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEEVENT_MIN_VERSION) libtraceevent > /dev/null 2>&1 || echo n")
 ifeq ("$(TEST_LIBTRACEEVENT)", "n")
-.PHONY: warning_traceevent
-warning_traceevent:
-	@echo "********************************************"
-	@echo "** NOTICE: libtraceevent version $(LIBTRACEEVENT_MIN_VERSION) or higher not found"
-	@echo "**"
-	@echo "** Consider installing the latest libtraceevent from your"
-	@echo "** distribution, e.g., 'dnf install libtraceevent' on Fedora,"
-	@echo "** or from source:"
-	@echo "**"
-	@echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/ "
-	@echo "**"
-	@echo "********************************************"
+WARNINGS = show_warnings
+MISSING_LIBS += echo "**   libtraceevent version $(LIBTRACEEVENT_MIN_VERSION) or higher";
+MISSING_PACKAGES += "libtraceevent-devel"
+MISSING_SOURCE += echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/ ";
 endif
 
 TEST_LIBTRACEFS = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEFS_MIN_VERSION) libtracefs > /dev/null 2>&1 || echo n")
 ifeq ("$(TEST_LIBTRACEFS)", "n")
-.PHONY: warning_tracefs
-warning_tracefs:
-	@echo "********************************************"
-	@echo "** NOTICE: libtracefs version $(LIBTRACEFS_MIN_VERSION) or higher not found"
-	@echo "**"
-	@echo "** Consider installing the latest libtracefs from your"
-	@echo "** distribution, e.g., 'dnf install libtracefs' on Fedora,"
-	@echo "** or from source:"
-	@echo "**"
-	@echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ "
-	@echo "**"
-	@echo "********************************************"
+WARNINGS = show_warnings
+MISSING_LIBS += echo "**   libtracefs version $(LIBTRACEFS_MIN_VERSION) or higher";
+MISSING_PACKAGES += "libtracefs-devel"
+MISSING_SOURCE += echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ ";
 endif
 
-.PHONY:	all
-all:	rtla
+define show_dependencies
+	@echo "********************************************";				\
+	echo "** NOTICE: Failed build dependencies";					\
+	echo "**";									\
+	echo "** Required Libraries:";							\
+	$(MISSING_LIBS)									\
+	echo "**";									\
+	echo "** Consider installing the latest libtracefs from your";			\
+	echo "** distribution, e.g., 'dnf install $(MISSING_PACKAGES)' on Fedora,";	\
+	echo "** or from source:";							\
+	echo "**";									\
+	$(MISSING_SOURCE)								\
+	echo "**";									\
+	echo "********************************************"
+endef
+
+show_warnings:
+	$(call show_dependencies);
+
+ifneq ("$(WARNINGS)", "")
+ERROR_OUT = $(error Please add the necessary dependencies)
+
+warnings: $(WARNINGS)
+	$(ERROR_OUT)
+endif
 
 rtla: $(OBJ)
 	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
@@ -108,9 +118,9 @@ install: doc_install
 	$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
 	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || rm $(DESTDIR)$(BINDIR)/osnoise
-	ln -s $(DESTDIR)$(BINDIR)/rtla $(DESTDIR)$(BINDIR)/osnoise
+	ln -s rtla $(DESTDIR)$(BINDIR)/osnoise
 	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || rm $(DESTDIR)$(BINDIR)/timerlat
-	ln -s $(DESTDIR)$(BINDIR)/rtla $(DESTDIR)$(BINDIR)/timerlat
+	ln -s rtla $(DESTDIR)$(BINDIR)/timerlat
 
 .PHONY: clean tarball
 clean: doc_clean
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index f3ec628f5e51..4b48af8a8309 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -892,7 +892,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	return_value = 0;
 
 	if (trace_is_off(&tool->trace, &record->trace)) {
-		printf("rtla timelat hit stop tracing\n");
+		printf("rtla timerlat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
 			save_trace_to_file(record->trace.inst, params->trace_output);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 35452a1d45e9..334271935222 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -687,7 +687,7 @@ int timerlat_top_main(int argc, char *argv[])
 	return_value = 0;
 
 	if (trace_is_off(&top->trace, &record->trace)) {
-		printf("rtla timelat hit stop tracing\n");
+		printf("rtla timerlat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
 			save_trace_to_file(record->trace.inst, params->trace_output);
