Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF21552826
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347540AbiFTXSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347158AbiFTXRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:17:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E8B20F69;
        Mon, 20 Jun 2022 16:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84BFEB8125A;
        Mon, 20 Jun 2022 23:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E875C341C8;
        Mon, 20 Jun 2022 23:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766810;
        bh=hQDDfCX6FrCbbHOOBzzqdZX9si4toBVrX232zBu3hPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKbFH2f6v1EhhycIA1bhHU6Mr6VnY3KlF2ITwaZml3znskuB5lk/aHqTev5gUFcRL
         5veMbV4mBKK2WpFjWmLHyLCQ+EjFKGq75NegtlJNOVz6KJTaG/WbSaADNndRK+w3hr
         g02s4enD3GZmugFmiVwG7jxDab1hRF8U2En+3HyU2zgzJGMpHdudZcmrNumHFE61Fs
         GIGQ8L/5m8+0ajcBvjICcadLc1JPciMt/qLkLaSIDFYibHwifQlefrHdo86h963kGu
         SkzdY6TJp89D8e9vYPbErYueu8Ms/0jZ/gtjnTUL3j4TtMYHJhhuvKFUW6do9OjMR2
         v2L8NAHXGsbdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E37125C0ADC; Mon, 20 Jun 2022 16:13:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/5] tools/nolibc: add a help target to list supported targets
Date:   Mon, 20 Jun 2022 16:13:28 -0700
Message-Id: <20220620231328.3845126-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

The "help" target simply presents the list of supported targets
and the current set of variables being used to build the sysroot.

Since the help in tools/ suggests to use "install", which is
supported by most tools while such a target is not really relevant
here, an "install" target was also added, redirecting to "help".

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/Makefile | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 9768819abd55d..cfd06764b5aee 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -31,6 +31,23 @@ all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
 # install all headers needed to support a bare-metal compiler
 all: headers
 
+install: help
+
+help:
+	@echo "Supported targets under nolibc:"
+	@echo "  all                 call \"headers\""
+	@echo "  clean               clean the sysroot"
+	@echo "  headers             prepare a sysroot in tools/include/nolibc/sysroot"
+	@echo "  headers_standalone  like \"headers\", and also install kernel headers"
+	@echo "  help                this help"
+	@echo ""
+	@echo "These targets may also be called from tools as \"make nolibc_<target>\"."
+	@echo ""
+	@echo "Currently using the following variables:"
+	@echo "  ARCH    = $(ARCH)"
+	@echo "  OUTPUT  = $(OUTPUT)"
+	@echo ""
+
 # Note: when ARCH is "x86" we concatenate both x86_64 and i386
 headers:
 	$(Q)mkdir -p $(OUTPUT)sysroot
-- 
2.31.1.189.g2e36527f23

