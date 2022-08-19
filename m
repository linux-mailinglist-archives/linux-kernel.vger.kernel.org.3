Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C12599DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349594AbiHSOkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348130AbiHSOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:40:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630BD63F2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1I0ucBeVMEoFMs08MGdWuNXxLKgAd1wwapOXMbYJBGM=; b=Lp0Xe4G93z22RYX+k/BjoxutXK
        vNMCaJ8mn1KoMCRp/fu67KSKSEoKyGmNLryl7W3gjxoNfc98xGPzv3W3zEWgcFK2n1Ktpd0Wp/bSh
        zqBgTHfVLx60ViZKgCSWLBTmiLOQBfURHuC4NcTooIODNTWOgx+pwhb11GmfXHg3D1uQxKI+ho01X
        h9+LJC/STfZeoFYanwlSYfdDI6SB4rZf47keQuUv4kQFmbzrJMCGAh4wHmYqGFhfqJ3sz9lf2xq5I
        mYXON3kJaFjLtY/q7NrdBPnNnuOmQ3KHjVaRbuzmF7NYVOmb1cnkboZw5+0buSW8Zsjex7rEEpPlr
        uq/USRTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oP39H-00BEwT-Rp; Fri, 19 Aug 2022 14:39:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C40539801A1; Fri, 19 Aug 2022 16:38:57 +0200 (CEST)
Date:   Fri, 19 Aug 2022 16:38:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818181530.2355034-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> For some Alder Lake N machine, the below unchecked MSR access error may be
> triggered.
> 
> [ 0.088017] rcu: Hierarchical SRCU implementation.
> [ 0.088017] unchecked MSR access error: WRMSR to 0x38f (tried to write
> 0x0001000f0000003f) at rIP: 0xffffffffb5684de8 (native_write_msr+0x8/0x30)
> [ 0.088017] Call Trace:
> [ 0.088017] <TASK>
> [ 0.088017] __intel_pmu_enable_all.constprop.46+0x4a/0xa0

FWIW, I seem to get the same error when booting KVM on my ADL. I'm
fairly sure the whole CPUID vs vCPU thing is a trainwreck.
