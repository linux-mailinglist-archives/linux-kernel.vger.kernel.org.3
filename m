Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECA252F040
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351490AbiETQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351583AbiETQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:11:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8471FCD0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:11:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0EE581F8A3;
        Fri, 20 May 2022 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653063082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEq8jll1uVlKvKIVY/03w49mqN4gfPkZB6PAOSFOLso=;
        b=ndirlIC7tTrN0fg2qWW8hBXrCC7olF2A3LIKxv6frbORFi8C+K8CM2RFT2ql+CtgC0woHZ
        /BHC/zIPgazT5xlpKF6sUGxNnRikFB1DtAtHuSO/nDN7pk3TekBVhKFKYPHBZHdduOSvsI
        gRNu0bA0tNI6xuv8e4oA0ggtQhTpk4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653063082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEq8jll1uVlKvKIVY/03w49mqN4gfPkZB6PAOSFOLso=;
        b=vs1p2+tv18yui+vygQgkcB4quw34X8YNysCUr3KaumEkjK9PpGiSrSgItVSvjV4pv0KVu9
        3iIdxAHUOhfEl7Aw==
Received: from linux-ni6k.suse.de (unknown [10.163.44.102])
        by relay2.suse.de (Postfix) with ESMTP id C7EAA2C142;
        Fri, 20 May 2022 16:11:21 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 2/2] x86: fix platform info detection in frequency invariance
Date:   Fri, 20 May 2022 18:10:22 +0200
Message-Id: <20220520161022.5972-2-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220520161022.5972-1-ggherdovich@suse.cz>
References: <20220520161022.5972-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the microarchitecture is recognized (via x86_match_cpu()), a failure
in setting base_freq/turbo_freq should result in bailing out from frequency
invariance, not in trying the next microarchitecture. This is because the
call to core_set_max_freq_ratio() isn't guarded by x86_match_cpu(). The
call to core_set_max_freq_ratio() should happen if no more specific
microarch matched, but not in case of prior errors.

Initializing base_freq=0 and turbo_freq=0 gives a mean for later code to
check if setup failed.

Fixes: db441bd9f630 ("x86, sched: Move check for CPU type to caller function")
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 225a3c31297c..d0a692ea8294 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2044,23 +2044,26 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 
 static bool intel_set_max_freq_ratio(void)
 {
-	u64 base_freq, turbo_freq;
+	u64 base_freq = 0, turbo_freq = 0;
 	u64 turbo_ratio;
 
 	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
 		goto out;
 
-	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
-	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+	if (x86_match_cpu(has_glm_turbo_ratio_limits)) {
+		skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1);
 		goto out;
+	}
 
-	if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
-	    knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+	if (x86_match_cpu(has_knl_turbo_ratio_limits)) {
+		knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1);
 		goto out;
+	}
 
-	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
-	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
+	if (x86_match_cpu(has_skx_turbo_ratio_limits)) {
+		skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4);
 		goto out;
+	}
 
 	if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
 		goto out;
-- 
2.31.1

