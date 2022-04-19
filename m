Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3A506141
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbiDSAtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiDSApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA9201AD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A1B6143A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C23FC341CB;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=BqRhW0viiZISdTH+FzC+4ZTZeKsPZKQuH/G0o49gJ6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jR/E99R71vrHgMh40MXQrxYBHrCcvYTVNRtdLvAWl+4okpx3ZKM5TPx5YkVcH5BRl
         HKqoZy3WYAfQUB9uGO//GLyDcOZ8GWmowMmtKx5xLyJlFcV09TfWVGmR67B4WJm7+O
         W2S7i/LM4iNXS57L8ljo/e9qFJDVcREOe2cQBN/38sXDGAHk07BqTtTT2ktpXdN9iW
         +4QfSTMaBNtsLvXXmCKfv4kpEEVqOEvhES77MPbEjxHihUZLlgjuPqHU5iX8fU/X1J
         5autBqKAA3nikkd3dqsYlymtunbTcOFx95gvb2r68aD9RPNj+rsgdsQZGFGlyoDmLe
         rKDYEtv5SMlBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 628F75C323A; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 50/61] tools/nolibc: add the nolibc subdir to the common Makefile
Date:   Mon, 18 Apr 2022 17:42:14 -0700
Message-Id: <20220419004225.3952530-50-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
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

The Makefile in tools/ is used to forward options to the makefiles
in the various subdirs. Let's add nolibc there so that it becomes
possible to make tools/nolibc_headers_standalone from the main tree
to simply create a completely usable sysroot.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

