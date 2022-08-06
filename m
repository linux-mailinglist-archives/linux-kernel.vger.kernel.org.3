Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D2D58B7AB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiHFSWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiHFSWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:22:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0412FA
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0E9AB80835
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03DCC433D6;
        Sat,  6 Aug 2022 18:22:04 +0000 (UTC)
Date:   Sat, 6 Aug 2022 14:22:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
Message-ID: <20220806142203.3c133322@gandalf.local.home>
In-Reply-To: <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
References: <20220803104936.7df810fd@gandalf.local.home>
        <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
        <20220805124701.4b44195d@gandalf.local.home>
        <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
        <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
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

On Sat, 6 Aug 2022 08:52:29 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> For extra bonus points, if you can state all missing packages in one
> go (instead of "oops you don't have Xyz" followed by install of Xyz,
> followed by "Oops, now you don't have Abc") that would be nice too.
> 
> But at this point the fundamental problem with incomprehensible error
> messages is long gone, so it's not a big deal and not worth lots of
> effort. More of a "if it's easy enough.."

With the below patch, it will show the warnings for both libtraceevent and
libtracefs if they are not installed:

 $ make
********************************************
** NOTICE: libtraceevent version 1.5 or higher not found
**
** Consider installing the latest libtraceevent from your
** distribution, e.g., 'dnf install libtraceevent-devel' on Fedora,
** or from source:
**
**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
**
********************************************
********************************************
** NOTICE: libtracefs version 1.3 or higher not found
**
** Consider installing the latest libtracefs from your
** distribution, e.g., 'dnf install libtracefs-devel' on Fedora,
** or from source:
**
**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
**
********************************************
Makefile:106: *** Please add the necessary dependencies.  Stop.

-- Steve

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 1bea2d16d4c1..a8c89b5b8fa5 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -61,15 +61,19 @@ endif
 LIBTRACEEVENT_MIN_VERSION = 1.5
 LIBTRACEFS_MIN_VERSION = 1.3
 
+.PHONY:	all warnings
+all:	warnings rtla
+
 TEST_LIBTRACEEVENT = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEEVENT_MIN_VERSION) libtraceevent > /dev/null 2>&1 || echo n")
 ifeq ("$(TEST_LIBTRACEEVENT)", "n")
+WARNINGS += warning_traceevent
 .PHONY: warning_traceevent
 warning_traceevent:
 	@echo "********************************************"
 	@echo "** NOTICE: libtraceevent version $(LIBTRACEEVENT_MIN_VERSION) or higher not found"
 	@echo "**"
 	@echo "** Consider installing the latest libtraceevent from your"
-	@echo "** distribution, e.g., 'dnf install libtraceevent' on Fedora,"
+	@echo "** distribution, e.g., 'dnf install libtraceevent-devel' on Fedora,"
 	@echo "** or from source:"
 	@echo "**"
 	@echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/ "
@@ -80,12 +84,13 @@ endif
 TEST_LIBTRACEFS = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEFS_MIN_VERSION) libtracefs > /dev/null 2>&1 || echo n")
 ifeq ("$(TEST_LIBTRACEFS)", "n")
 .PHONY: warning_tracefs
+WARNINGS += warning_tracefs
 warning_tracefs:
 	@echo "********************************************"
 	@echo "** NOTICE: libtracefs version $(LIBTRACEFS_MIN_VERSION) or higher not found"
 	@echo "**"
 	@echo "** Consider installing the latest libtracefs from your"
-	@echo "** distribution, e.g., 'dnf install libtracefs' on Fedora,"
+	@echo "** distribution, e.g., 'dnf install libtracefs-devel' on Fedora,"
 	@echo "** or from source:"
 	@echo "**"
 	@echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ "
@@ -93,8 +98,12 @@ warning_tracefs:
 	@echo "********************************************"
 endif
 
-.PHONY:	all
-all:	rtla
+ifneq ("$(WARNINGS)", "")
+ERROR_OUT = $(error Please add the necessary dependencies)
+endif
+
+warnings: $(WARNINGS)
+	$(ERROR_OUT)
 
 rtla: $(OBJ)
 	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
