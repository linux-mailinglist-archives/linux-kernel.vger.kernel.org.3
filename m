Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91859C0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiHVNsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiHVNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:48:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7BBE1A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YF7MJpPCJtc8Urz7rYZCvMK8j3cGw0f0gRKAs00wVEk=; b=QHfWlkzVLdI+AGdCPDZQKGS/DU
        qV0mVroQeBjGW53Rpmo62vsSxsuhyEu9O4pnjkgNJQR7atycHNLELQh+er8s9KQB7mcBtJBm1mH7V
        HxVCgrQYpiOnecQwX+q5gW3aRf0+eN/B6OqYVsoWHSr81tK8i2IhpXTX3mL0NP38EoUAfqPM3FKqt
        ttoil8b4LrgLvyVx1u1q6aGgU8UpEjWYUDqeB1WVw66fQ8yvlsKiIxyxX8d1rHj62ZssNEr4N/nfp
        a8UZVGH3h2sgF/1ycqMudCam+NCYhhf9mgu4CG8SIFkooaNNEesrVyU746Vo+MidkZ/04saPEuWx1
        QcAegKMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ7mn-00565A-V9; Mon, 22 Aug 2022 13:48:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 817749804A3; Mon, 22 Aug 2022 15:48:12 +0200 (CEST)
Date:   Mon, 22 Aug 2022 15:48:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <YwOJHLuX57Q4e/wH@worktop.programming.kicks-ass.net>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:28:31AM -0400, Liang, Kan wrote:
> 
> 
> On 2022-08-19 10:38 a.m., Peter Zijlstra wrote:
> > On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> For some Alder Lake N machine, the below unchecked MSR access error may be
> >> triggered.
> >>
> >> [ 0.088017] rcu: Hierarchical SRCU implementation.
> >> [ 0.088017] unchecked MSR access error: WRMSR to 0x38f (tried to write
> >> 0x0001000f0000003f) at rIP: 0xffffffffb5684de8 (native_write_msr+0x8/0x30)
> >> [ 0.088017] Call Trace:
> >> [ 0.088017] <TASK>
> >> [ 0.088017] __intel_pmu_enable_all.constprop.46+0x4a/0xa0
> > 
> > FWIW, I seem to get the same error when booting KVM on my ADL. I'm
> > fairly sure the whole CPUID vs vCPU thing is a trainwreck.
> 
> We will enhance the CPUID to address the issues. Hopefully, we can have
> them supported in the next generation.

How!? A vCPU can readily migrate between a big and small CPU. There is
no way the guest can sanely program the (v)MSRs and expect it to work.
