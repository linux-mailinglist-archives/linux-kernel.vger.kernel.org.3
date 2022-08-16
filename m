Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7C5959E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiHPLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiHPLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:22:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75779D133;
        Tue, 16 Aug 2022 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660643244; x=1692179244;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZB0wkmjlPdDSTA4EwQQs+F8Xlb10ueDxQGjHJOmfvkI=;
  b=W3J8XpGSJyBR66uMLKiswwoJLPKH+jmvDYbHtT4G6Z8DND7Ona+CT3VV
   6x7itKMAPuSvdxo0a4qS+M5CMDoEMTggEfgtMi1pz6e1DZquvANegYCtB
   WCz0gUvB+xPgDH60fOltWQzqMRTK0QZqRDWNJkdtv3KSkKu3fn74uYn1n
   WS74wFyeyZcc06lXucDiXQCth13I6yJTd9W97CjLP6ANgbuA4XM/RBPns
   spIz5nMH9aOJroStMwskW8Ul49uZ5nS7PAOUcq6av1R/g6kW7SAQoSePD
   JxrePsa5MXlZJBHP/0qVE3ejo1+TYyEu8PgOx8Agx5orI0pcFo4IPrtOr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="275229847"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="275229847"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:47:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934839368"
Received: from rvanorma-mobl.gar.corp.intel.com ([10.213.153.166])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:47:18 -0700
Message-ID: <8496afee057d63b83a7ff02ec7f1de8c2d0e97ae.camel@intel.com>
Subject: Re: [PATCH V2 1/8] perf/x86/intel/P4: Fix smp_num_siblings usage
From:   Zhang Rui <rui.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Date:   Tue, 16 Aug 2022 17:47:14 +0800
In-Reply-To: <YvtU2VKtpGCIOes4@worktop.programming.kicks-ass.net>
References: <20220816051633.17775-1-rui.zhang@intel.com>
         <20220816051633.17775-2-rui.zhang@intel.com>
         <YvtU2VKtpGCIOes4@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-16 at 10:27 +0200, Peter Zijlstra wrote:
> On Tue, Aug 16, 2022 at 01:16:26PM +0800, Zhang Rui wrote:
> > smp_num_siblings can be larger than 2.
> > 
> > Any value larger than 1 suggests HT is supported.
> 
> Subject and Changelog are still utterly insane.

what about this one, do I need to resend the full series?

thanks,
rui

From 2e368e6afa83cb73e44ac8c3cf8339207097d9e1 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 28 Jun 2022 11:02:12 +0800
Subject: [PATCH V3 1/8] perf/x86/intel/P4: unify logic for detecting HT

Any value larger than 1 suggests HT is supported.

Although smp_num_siblings cannot be larger than 2 on P4 platform, it is
better to keep this logic consistent across the kernel.

Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/include/asm/perf_event_p4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/perf_event_p4.h
b/arch/x86/include/asm/perf_event_p4.h
index 94de1a05aeba..b14e9a20a7c0 100644
--- a/arch/x86/include/asm/perf_event_p4.h
+++ b/arch/x86/include/asm/perf_event_p4.h
@@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
 static inline int p4_ht_thread(int cpu)
 {
 #ifdef CONFIG_SMP
-	if (smp_num_siblings == 2)
+	if (smp_num_siblings > 1)
 		return cpu !=
cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));
 #endif
 	return 0;
-- 
2.25.1


