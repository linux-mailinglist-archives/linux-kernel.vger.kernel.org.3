Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B907A5150E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiD2Qcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379206AbiD2Qbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E90EDAA05;
        Fri, 29 Apr 2022 09:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E0362338;
        Fri, 29 Apr 2022 16:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C48C385AF;
        Fri, 29 Apr 2022 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651249703;
        bh=i2s8MXletVaqxsQHutApX0kGzV6e20Tl+T1LrZsiZdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFJez6aLSagPmG2NVQ5jtfNBfUi4S0LFeqMFKDv31dtv+nkVDvCVCcGdgAiDf0WZk
         /B+k0/QsWPxQGcVyHXjYMuP1keP1r+z8gz7acwVc/vDGoBAzqI5AKdiXUmfjyFmgRg
         ffLaJylc1o83tF5p0Cx9cOmDONbI0bT6djg6/rI0uNIY0umJ0knA5fAnhLtfB0DQqX
         YeWf/WRBcGWSYoYHoGZGGV7oA+hqUmIMqWwrvKNL+9+CBs+XpaK5u43XSvVSKGmfRV
         TISokVBNQSXe0ozvzfPrUgMxLEJ2qFiYMycPkr2I4DQM2Wwy44tPANJt+mIi1/+1XS
         tyyXLqCjxXQGg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Bristot de Oliveria <bristot@redhat.com>
Subject: [PATCH 2/4] rtla: Don't overwrite existing directory mode
Date:   Fri, 29 Apr 2022 18:28:11 +0200
Message-Id: <8c294a6961080a1970fd8b73f7bcf1e3984579e2.1651247710.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651247710.git.bristot@kernel.org>
References: <cover.1651247710.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Kacur <jkacur@redhat.com>

The mode on /usr/bin is often 555 these days,
but make install on rtla overwrites this with 755

Fix this by preserving the current directory if it exists.

Link: https://lore.kernel.org/r/20220402043939.6962-1-jkacur@redhat.com

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveria <bristot@redhat.com>
Fixes: 79ce8f43ac5a ("rtla: Real-Time Linux Analysis tool")
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 11fb417abb42..5a3226e436ef 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -23,6 +23,7 @@ $(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
 $(call allow-override,LDCONFIG,ldconfig)
 
 INSTALL	=	install
+MKDIR	=	mkdir
 FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection
 WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
@@ -68,7 +69,7 @@ static: $(OBJ)
 
 .PHONY: install
 install: doc_install
-	$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
+	$(MKDIR) -p $(DESTDIR)$(BINDIR)
 	$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
 	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || rm $(DESTDIR)$(BINDIR)/osnoise
-- 
2.32.0

