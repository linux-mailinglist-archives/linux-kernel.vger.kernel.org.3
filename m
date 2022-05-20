Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82452F03B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbiETQLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351581AbiETQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:11:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E61F63D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:11:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE47121A47;
        Fri, 20 May 2022 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653063081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7Fmj8JzLiden5OqfZWGpSyWFihaGS9xdX8GUKaCkaMI=;
        b=b922/Jvy3M50NHkdl+qrDCAH6lNwLFeTD2FQM5kMQ8zGe5Ur4NH2jCVgYv+w2iEW1Y0NoV
        hcBi5jGSq7I6KQyiBxn6UX8tpyn9WQQfkSMl0gJB87/ZLdJzM9henKxU2It14hDDXk30kD
        EBKlrq2ZKwajUGqDDJ/lHk3vlFlYLVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653063081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7Fmj8JzLiden5OqfZWGpSyWFihaGS9xdX8GUKaCkaMI=;
        b=jnXwwGVTn0rCuTKe0fajcPujDuk2cHebLOmfwf2Yp0zMtBWee74GixOlY8zkFYNz36g5rT
        oJZJscHl7P/jmcDw==
Received: from linux-ni6k.suse.de (unknown [10.163.44.102])
        by relay2.suse.de (Postfix) with ESMTP id 301342C141;
        Fri, 20 May 2022 16:11:20 +0000 (UTC)
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
Subject: [PATCH 1/2] x86: Fix return value in frequency invariance setup for XEON_PHI_KNL/KNM
Date:   Fri, 20 May 2022 18:10:21 +0200
Message-Id: <20220520161022.5972-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.31.1
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

knl_set_max_freq_ratio() should return true on success and false
otherwise. If the last line of the function body is reached, it means no
appropriate value for turbo_freq was found: the setup is unsuccessful and
it should return false.

Fixes: 8bea0dfb4a82 ("x86, sched: Add support for frequency invariance on XEON_PHI_KNL/KNM")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 2ef14772dc04..225a3c31297c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1985,7 +1985,7 @@ static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
 		i += 8;
 	} while (i < 64);
 
-	return true;
+	return false;
 }
 
 static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
-- 
2.31.1

