Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73858F011
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiHJQGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiHJQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:05:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058578BF0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2B04B81D6A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0F9C43142;
        Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oLoDF-000V08-2c;
        Wed, 10 Aug 2022 12:05:41 -0400
Message-ID: <20220810160541.646408756@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Aug 2022 12:04:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 4/4] rtla: Consolidate and show all necessary libraries that failed for
 building
References: <20220810160455.872730397@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When building rtla tools, if the necessary libraries are not installed
(libtraceevent and libtracefs), show the ones that are missing in one
consolidated output, and also show how to install them (at least for
Fedora).

Link: https://lore.kernel.org/all/CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com/
Link: https://lkml.kernel.org/r/20220810113918.5d19ce59@gandalf.local.home

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile | 62 +++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index f392708c7a1e..22e28b76f800 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
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
-- 
2.35.1
