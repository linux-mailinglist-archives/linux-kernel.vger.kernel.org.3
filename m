Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC894A867F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351264AbiBCOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbiBCOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6282C061401;
        Thu,  3 Feb 2022 06:33:30 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyOBCS2qiX6Za/+koF37R2U6OX2eJf1Az1VzYnPrZcI=;
        b=SOsD3a8oGVMX53oWDtKu6tGExEvdYQzCCMZjw8ZQkku8wTH3B4FKPJpOGdjmMKVsF4oedH
        r6Kc9Jy5rd0aEUO13uoO3l9vj+o2BICDItY4YpmHwYW0Sx44Rf4N0oi1Y7/NZveM5g5+FH
        LeePeE02S1dwVyuyjQKQ4ZN8FCmJXS4Kev65KgFUrQBi/FPLEpV5tlJtC80md+ZrPI8pKo
        JNTmHEp7RiZqrLOXA5/5+1SQ24P9sqAL4vvMNgdPilmH2AbGjwM+RNJBap6Yik6t/AubVr
        nmof8CV9aQPJzm+Sneih51bnJ6HAbrnRKq6+ZA4jhibydQdPNytG1mllzYWKHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyOBCS2qiX6Za/+koF37R2U6OX2eJf1Az1VzYnPrZcI=;
        b=VrrCxAprKco7YLyFEZJKC5FninjuwippBWLZnV1lmmXXVVPHLR3clngnfU5vqPeKAZSx/f
        z2iahTODN2xa4jBQ==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Fix address filter config for
 32-bit kernel
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131072453.2839535-5-adrian.hunter@intel.com>
References: <20220131072453.2839535-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164389880841.16921.15408272988900880445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e5524bf1047eb3b3f3f33b5f59897ba67b3ade87
Gitweb:        https://git.kernel.org/tip/e5524bf1047eb3b3f3f33b5f59897ba67b3ade87
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 31 Jan 2022 09:24:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:43 +01:00

perf/x86/intel/pt: Fix address filter config for 32-bit kernel

Change from shifting 'unsigned long' to 'u64' to prevent the config bits
being lost on a 32-bit kernel.

Fixes: eadf48cab4b6b0 ("perf/x86/intel/pt: Add support for address range filtering in PT")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220131072453.2839535-5-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 93676a5..f061dc2 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -474,7 +474,7 @@ static u64 pt_config_filters(struct perf_event *event)
 			pt->filters.filter[range].msr_b = filter->msr_b;
 		}
 
-		rtit_ctl |= filter->config << pt_address_ranges[range].reg_off;
+		rtit_ctl |= (u64)filter->config << pt_address_ranges[range].reg_off;
 	}
 
 	return rtit_ctl;
