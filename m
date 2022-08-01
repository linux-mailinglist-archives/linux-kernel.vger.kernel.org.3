Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830EE586EED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiHAQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiHAQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:43:38 -0400
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F6BF40
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1963; q=dns/txt; s=iport;
  t=1659372217; x=1660581817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rbl5a3sCt+315DhFMGRBqCnTcR0L3yULt7Gy7tgeKUU=;
  b=CoKXYwcazdACEJQrs7X0MEg5sR6tFp3jlNjdzNnemFtt3m3gbhG8UsNf
   ImvBs5Q2CF5wXuAnxUjceVQI+HQa+I5dLS3kvXGJWpguoMTSxf9qsDGjD
   va6ju4tg4nMgaOxCMs1lUNys3t9fnsY+LYaLtG/DtwT04KPIZYn479/ze
   k=;
X-IronPort-AV: E=Sophos;i="5.93,208,1654560000"; 
   d="scan'208";a="3295291"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 01 Aug 2022 16:43:33 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 271GhT0T012552;
        Mon, 1 Aug 2022 16:43:32 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Laura Abbott <lauraa@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Kralevich <nnk@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Subject: [v4.9 PATCH v2 4/6] init: move stack canary initialization after setup_arch
Date:   Mon,  1 Aug 2022 18:43:26 +0200
Message-Id: <20220801164328.2205839-4-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220801164328.2205839-1-hegtvedt@cisco.com>
References: <20220801164328.2205839-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <lauraa@codeaurora.org>

Patch series "Command line randomness", v3.

A series to add the kernel command line as a source of randomness.

This patch (of 2):

Stack canary intialization involves getting a random number.  Getting this
random number may involve accessing caches or other architectural specific
features which are not available until after the architecture is setup.
Move the stack canary initialization later to accommodate this.

Link: http://lkml.kernel.org/r/20170816231458.2299-2-labbott@redhat.com
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Daniel Micay <danielmicay@gmail.com>
Cc: Nick Kralevich <nnk@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 121388a31362b0d3176dc1190ac8064b98a61b20)
Signed-off-by: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
---
 init/main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 8b803078d7b..67fa94c5967 100644
--- a/init/main.c
+++ b/init/main.c
@@ -487,12 +487,6 @@ asmlinkage __visible void __init start_kernel(void)
 	smp_setup_processor_id();
 	debug_objects_early_init();
 
-	/*
-	 * Set up the initial canary ASAP:
-	 */
-	add_latent_entropy();
-	boot_init_stack_canary();
-
 	cgroup_init_early();
 
 	local_irq_disable();
@@ -506,6 +500,11 @@ asmlinkage __visible void __init start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
+	/*
+	 * Set up the the initial canary and entropy after arch
+	 */
+	add_latent_entropy();
+	boot_init_stack_canary();
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
2.34.1

