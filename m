Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B884E2F19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349314AbiCURfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346206AbiCURe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1C6766610
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXOmQ007577;
        Mon, 21 Mar 2022 18:33:24 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 8/8] tools/nolibc: add the nolibc subdir to the common Makefile
Date:   Mon, 21 Mar 2022 18:33:14 +0100
Message-Id: <20220321173314.7519-9-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile in tools/ is used to forward options to the makefiles
in the various subdirs. Let's add nolibc there so that it becomes
possible to make tools/nolibc_headers_standalone from the main tree
to simply create a completely usable sysroot.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index db2f7b8ebed5..724134f0e56c 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -24,6 +24,7 @@ help:
 	@echo '  intel-speed-select     - Intel Speed Select tool'
 	@echo '  kvm_stat               - top-like utility for displaying kvm statistics'
 	@echo '  leds                   - LEDs  tools'
+	@echo '  nolibc                 - nolibc headers testing and installation'
 	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
@@ -74,6 +75,9 @@ bpf/%: FORCE
 libapi: FORCE
 	$(call descend,lib/api)
 
+nolibc_%: FORCE
+	$(call descend,include/nolibc,$(patsubst nolibc_%,%,$@))
+
 # The perf build does not follow the descend function setup,
 # invoking it via it's own make rule.
 PERF_O   = $(if $(O),$(O)/tools/perf,)
-- 
2.35.1

