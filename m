Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964F84D7D93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiCNI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiCNI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:26:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7843611A06
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BDD6B80D31
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C36BC340E9;
        Mon, 14 Mar 2022 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246322;
        bh=tXtYxtXfnBNM1zCOA8IqcikrEBaViemXtjx+BivrHYI=;
        h=Date:From:To:cc:Subject:From;
        b=lvYtVHGbl9Z16cA4u57GAofUqHMt0AysFm9EEEEcFYWLvUIbhnJBsEBtV7gIRDai+
         pdoPA87NimrY+E4RA4mvpiiWRAMxZbAzuhfR412ZnH9OJ5/9hbR4W8btS/xZnxAs1k
         ZK5sS+tv8SA3eSdQ26OSEoTf8ddAfXskWno2CzczDSs6ITegF1CylP2cs5mxLuHJfV
         vrgl8ImGS1mdrQ+TiyXZNTS/lv2hhaDXxbIDQY97SmgPt+CbXfY893FU4jahZrJC6r
         dv0iaj0+318LCX/0pVCCganRtY0SkeO23VLiymvtfsZ8CrX9bR+9OVfJBZwpePE+na
         Pu8/bqH/o2GrA==
Date:   Mon, 14 Mar 2022 09:25:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/nmi: Remove the 'strange power saving mode' hint from
 unknown NMI handler
Message-ID: <nycvar.YFH.7.76.2203140924120.24795@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

The 'Do you have a strange power saving mode enabled?' hint when unknown 
NMI happens dates back to i386 stone age, and isn't currently really 
helpful.

Unknown NMIs are coming for many different reasons (broken firmware, 
faulty hardware, ...) and rarely have anything to do with 'strange power 
saving mode' (whatever that even is).

Just remove it as it's largerly misleading.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/kernel/nmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bce802d25fb..e73f7df362f5 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -292,7 +292,6 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 	pr_emerg("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
 		 reason, smp_processor_id());
 
-	pr_emerg("Do you have a strange power saving mode enabled?\n");
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
 		nmi_panic(regs, "NMI: Not continuing");
 
-- 
Jiri Kosina
SUSE Labs

