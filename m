Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0D588E24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiHCOB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiHCOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:01:56 -0400
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA52B269
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1217; q=dns/txt; s=iport;
  t=1659535315; x=1660744915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8t9zvnYmA65JIhzd4OZ3iRWK42/wNYyO3z9pUde/lNI=;
  b=jUfLG+EBOMa4OvAZIvwlV0bn4aTThW5dKTE3QLa7gNKIy40SN5F7k5R4
   /TfIsdUEAxRq4AnnGiLmSAGAZJiRwQArKjz/OkjDue4EQo+YMAMYfDn/c
   mO/1d2Jl/RU9NfpkC2IkkJiTHmQocUgWmWNowGIoMXSVJrsp5ERUnnZWp
   8=;
X-IronPort-AV: E=Sophos;i="5.93,214,1654560000"; 
   d="scan'208";a="698913"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 03 Aug 2022 14:01:53 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 273E1qWF002584;
        Wed, 3 Aug 2022 14:01:53 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Subject: [v4.9 PATCH v3 6/6] random: only call boot_init_stack_canary() once
Date:   Wed,  3 Aug 2022 16:01:51 +0200
Message-Id: <20220803140151.687558-1-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Yupk5K1S7flR7yjD@kroah.com>
References: <Yupk5K1S7flR7yjD@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 166a592cad36 ("random: move rand_initialize() earlier") the
boot_init_stack_canary() call was added after the new random_init()
call.

However, the upstream commit d55535232c3d ("random: move
rand_initialize() earlier") also included removing the earlier call to
boot_init_stack_canary(), making sure this call is done after
random_init().

Hence fix what I assume is a wrong merge conflict resolution on the
linux-4.9.y stable branch.

Signed-off-by: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
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

