Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD958B7C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiHFSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiHFSpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:45:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097972AFB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE52AB800C1
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F0FC433C1;
        Sat,  6 Aug 2022 18:45:18 +0000 (UTC)
Date:   Sat, 6 Aug 2022 14:45:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
Message-ID: <20220806144517.19140960@gandalf.local.home>
In-Reply-To: <20220806142203.3c133322@gandalf.local.home>
References: <20220803104936.7df810fd@gandalf.local.home>
        <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
        <20220805124701.4b44195d@gandalf.local.home>
        <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
        <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
        <20220806142203.3c133322@gandalf.local.home>
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

On Sat, 6 Aug 2022 14:22:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> With the below patch, it will show the warnings for both libtraceevent and
> libtracefs if they are not installed:
> 
>  $ make
> ********************************************
> ** NOTICE: libtraceevent version 1.5 or higher not found
> **
> ** Consider installing the latest libtraceevent from your
> ** distribution, e.g., 'dnf install libtraceevent-devel' on Fedora,
> ** or from source:
> **
> **  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
> **
> ********************************************
> ********************************************
> ** NOTICE: libtracefs version 1.3 or higher not found
> **
> ** Consider installing the latest libtracefs from your
> ** distribution, e.g., 'dnf install libtracefs-devel' on Fedora,
> ** or from source:
> **
> **  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
> **
> ********************************************
> Makefile:106: *** Please add the necessary dependencies.  Stop.


Or to even make it less noisy:

 $ make
********************************************
** NOTICE: Failed build dependencies
**
** Required Libraries:
**   libtraceevent version 1.5 or higher
**   libtracefs version 1.3 or higher
**
** Consider installing the latest libtracefs from your
** distribution, e.g., 'dnf install libtraceevent-devel libtracefs-devel' on Fedora,
** or from source:
**
**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/ 
**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ 
**
********************************************
Makefile:106: *** Please add the necessary dependencies.  Stop.

-- Steve


diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 1bea2d16d4c1..cc9478dabd8b 100644
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
