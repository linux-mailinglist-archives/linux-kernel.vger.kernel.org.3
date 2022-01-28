Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9758149FDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350098AbiA1QXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:23:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59232 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350064AbiA1QXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D998761F0C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52843C340E6;
        Fri, 28 Jan 2022 16:23:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nDU2K-00AT1L-Gh;
        Fri, 28 Jan 2022 11:23:44 -0500
Message-ID: <20220128162344.355814811@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jan 2022 11:18:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [for-linus][PATCH 06/10] tools/tracing: Update Makefile to build rtla
References: <20220128161802.711119424@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>

Update tracing Makefile to build/install/clean rtla tragets.

Link: https://lkml.kernel.org/r/20220126002234.79337-1-skhan@linuxfoundation.org

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/Makefile | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/Makefile b/tools/tracing/Makefile
index 87e0ec48e2e7..95e485f12d97 100644
--- a/tools/tracing/Makefile
+++ b/tools/tracing/Makefile
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../scripts/Makefile.include
 
-all: latency
+all: latency rtla
 
-clean: latency_clean
+clean: latency_clean rtla_clean
 
-install: latency_install
+install: latency_install rtla_install
 
 latency:
 	$(call descend,latency)
@@ -16,4 +16,14 @@ latency_install:
 latency_clean:
 	$(call descend,latency,clean)
 
-.PHONY: all install clean latency latency_install latency_clean
+rtla:
+	$(call descend,rtla)
+
+rtla_install:
+	$(call descend,rtla,install)
+
+rtla_clean:
+	$(call descend,rtla,clean)
+
+.PHONY: all install clean latency latency_install latency_clean \
+	rtla rtla_install rtla_clean
-- 
2.33.0
