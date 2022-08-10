Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B369058F00E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiHJQGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHJQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0CB6B665
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5AE361196
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2CAC4347C;
        Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oLoDF-000Uz2-1P;
        Wed, 10 Aug 2022 12:05:41 -0400
Message-ID: <20220810160541.268997705@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Aug 2022 12:04:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ben Hutchings <benh@debian.org>
Subject: [for-linus][PATCH 2/4] tools/rtla: Fix command symlinks
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

From: Ben Hutchings <benh@debian.org>

"ln -s" stores the next argument directly as the symlink target, so
it needs to be a relative path.  In this case, just "rtla".

Link: https://lore.kernel.org/linux-trace-devel/YtLBXMI6Ui4HLIF1@decadent.org.uk

Fixes: 0605bf009f18 ("rtla: Add osnoise tool")
Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Signed-off-by: Ben Hutchings <benh@debian.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 1bea2d16d4c1..b8fe10d941ce 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -108,9 +108,9 @@ install: doc_install
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
-- 
2.35.1
