Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369AA586EEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiHAQoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiHAQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:43:39 -0400
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF21CB2D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1812; q=dns/txt; s=iport;
  t=1659372218; x=1660581818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/YFYhKFlG4eL8qi07k8+Dxmz4ofUBREJaJtFpI9ocRY=;
  b=D/hoVa4FoxbrPFRLxodW9SPsEe3yDJ2gRi08LT6QjO9rIn6a86rBiU4l
   boVU6uUN+bu+pJwmlDxisFpCQIg/SQ+THajt13ThiLbYOBRjNZEezF6ib
   NNmUZpotOOhJBu+5oUwNfIevA2zZ0T6AFJvC1yllL606wPQH78cz1IEBh
   w=;
X-IronPort-AV: E=Sophos;i="5.93,208,1654560000"; 
   d="scan'208";a="3296646"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 01 Aug 2022 16:43:34 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 271GhT0V012552;
        Mon, 1 Aug 2022 16:43:34 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Kees Cook <keescook@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Subject: [v4.9 PATCH v2 6/6] random: move rand_initialize() earlier
Date:   Mon,  1 Aug 2022 18:43:28 +0200
Message-Id: <20220801164328.2205839-6-hegtvedt@cisco.com>
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

From: Kees Cook <keescook@chromium.org>

Right now rand_initialize() is run as an early_initcall(), but it only
depends on timekeeping_init() (for mixing ktime_get_real() into the
pools). However, the call to boot_init_stack_canary() for stack canary
initialization runs earlier, which triggers a warning at boot:

random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0

Instead, this moves rand_initialize() to after timekeeping_init(), and moves
canary initialization here as well.

Note that this warning may still remain for machines that do not have
UEFI RNG support (which initializes the RNG pools during setup_arch()),
or for x86 machines without RDRAND (or booting without "random.trust=on"
or CONFIG_RANDOM_TRUST_CPU=y).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
(cherry picked from commit d55535232c3dbde9a523a9d10d68670f5fe5dec3)
Signed-off-by: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>

Adjusted to fit on top of linux-4.9.y branch, suspecting a wrongly
solved conflict when cherry picked earlier.
---
 init/main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/init/main.c b/init/main.c
index 6bc1a3fa152..6537f51a0ba 100644
--- a/init/main.c
+++ b/init/main.c
@@ -500,13 +500,6 @@ asmlinkage __visible void __init start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
-	/*
-	 * Set up the the initial canary and entropy after arch
-	 * and after adding latent and command line entropy.
-	 */
-	add_latent_entropy();
-	add_device_randomness(command_line, strlen(command_line));
-	boot_init_stack_canary();
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
2.34.1

