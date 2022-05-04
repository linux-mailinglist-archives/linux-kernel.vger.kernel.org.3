Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0698D519CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348041AbiEDK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiEDK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:27:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D921DA60;
        Wed,  4 May 2022 03:23:32 -0700 (PDT)
Date:   Wed, 04 May 2022 10:23:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651659810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIuVsyo37CAL/ByVFpD4mcCmkEy7OLDSxrNoTrjcPak=;
        b=yceCzNANAIXAGy6VFg1F+FmDg1y5Vuq8J40CGcv3YoJmf6swrYQurxf5vTYqqqr6TRXUds
        AF3e64G1/uLWqHViTE2Bqjt8nXlvOvlEnZ9N0lPjLIZ5mwH+i4ZC53proGyrCaVwCdbDP/
        etCWlHDxtftNQn6bH0CCGW1VAgRfWxTkvdxweFSBJmaJ7P31u1mbiR1zJMtu0H5o82DL0t
        PmvwHPayUt6iUL0E4BDsmwjriYkSS7kip7DiJa/b8FzaYnci7OqJA/XwUOtqUMZ6OBpc+K
        Qvi8lhoB4nbeTXrQYfks9uI3UDAtUFEKZoCSARhcSbXORAY9PzewbeknL2VfiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651659810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIuVsyo37CAL/ByVFpD4mcCmkEy7OLDSxrNoTrjcPak=;
        b=1XCvQzShYJYXCl/Og3/XmtRYaHuioHAGKmyMVX0jm8PMQYKTJPVpqQeINfopRq/BOrrOSE
        JLsWyTUzIEy9lsAw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/split_lock: Enable the split lock feature on
 Raptor Lake
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220427231059.293086-1-tony.luck@intel.com>
References: <20220427231059.293086-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <165165980916.4207.15436369061550612493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     0180a1e823d7c41d9a1c19f38e6069b38fe60c87
Gitweb:        https://git.kernel.org/tip/0180a1e823d7c41d9a1c19f38e6069b38fe60c87
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 27 Apr 2022 16:10:59 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 04 May 2022 12:11:25 +02:00

x86/split_lock: Enable the split lock feature on Raptor Lake

Raptor Lake supports the split lock detection feature. Add it to
the split_lock_cpu_ids[] array.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220427231059.293086-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 672e253..e6c37f3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1257,6 +1257,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		1),
 	{}
 };
 
