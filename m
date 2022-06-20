Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91ED552812
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347448AbiFTXRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347125AbiFTXRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C13D222A4;
        Mon, 20 Jun 2022 16:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED6261507;
        Mon, 20 Jun 2022 23:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26660C3411B;
        Mon, 20 Jun 2022 23:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766810;
        bh=clhv5Qd1GDJBQPjEqFH6Zt5RkEPLR+JAFjAQe43nj0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXkYbmvt8BV/dBX0RLcs5/jqxU2xH28yQFp4GCasZZlkastzo/CWT0WR2NbN2/dBm
         ks+79uiRyuRxYxHr0we4+44o7gCCdieF5rZRNu74Gtg+IWWsDr5Wl9akerRDlthe9B
         M/AgpVUFeR3Fu+Vjv96ITH5foA/QDlGpqb+L4XKEvk2UOnFp7faCCmxYUZ8mnlaMHb
         3t9kuWMZFj78ofm4iY/Um81MUqGHz8+gc3+2o62xNpDmZ9Ewx8LfcNyl9dJRkFsSra
         SkSJZikPTaP1FloNHuBPMbXZlMl+kFyAMP9EfHvSy1MIHyOOwyXfh75aGF9MTwIexn
         p1XRoPGckIS3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF9975C0A15; Mon, 20 Jun 2022 16:13:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] tools/nolibc: fix the makefile to also work as "make -C tools ..."
Date:   Mon, 20 Jun 2022 16:13:26 -0700
Message-Id: <20220620231328.3845126-3-paulmck@kernel.org>
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

As reported by Linus, the nolibc's makefile is currently broken when
invoked as per the documented method (make -C tools nolibc_<target>),
because it now relies on the ARCH and OUTPUT variables that are not
set in this case.

This patch addresses this by sourcing subarch.include, and by
presetting OUTPUT to the current directory if not set. This is
sufficient to make the commands work both as a standalone target
and as a tools/ sub-target.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/Makefile | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 7a16d917c1859..e8bac6ef36538 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -7,6 +7,22 @@ ifeq ($(srctree),)
 srctree := $(patsubst %/tools/include/,%,$(dir $(CURDIR)))
 endif
 
+# when run as make -C tools/ nolibc_<foo> the arch is not set
+ifeq ($(ARCH),)
+include $(srctree)/scripts/subarch.include
+ARCH = $(SUBARCH)
+endif
+
+# OUTPUT is only set when run from the main makefile, otherwise
+# it defaults to this nolibc directory.
+OUTPUT ?= $(CURDIR)/
+
+ifeq ($(V),1)
+Q=
+else
+Q=@
+endif
+
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
 all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
@@ -36,7 +52,7 @@ headers:
 
 headers_standalone: headers
 	$(Q)$(MAKE) -C $(srctree) headers
-	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)/sysroot
+	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)sysroot
 
 clean:
 	$(call QUIET_CLEAN, nolibc) rm -rf "$(OUTPUT)sysroot"
-- 
2.31.1.189.g2e36527f23

