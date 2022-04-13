Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525B14FF843
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiDMOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiDMOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:01:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD534366AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:59:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797E31595;
        Wed, 13 Apr 2022 06:59:04 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.75.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 435003F5A1;
        Wed, 13 Apr 2022 06:59:01 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:58:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/8] KVM: arm64: Unwind and dump nVHE HYP stacktrace
Message-ID: <YlbXHg64HK2d3dgm@FVFF77S0Q05N>
References: <20220314200148.2695206-1-kaleshsingh@google.com>
 <20220314200148.2695206-8-kaleshsingh@google.com>
 <CA+EHjTwQRUCjvcMHNe1f0kPBdU=vS+f2+e_eefhnJDR4s73cQA@mail.gmail.com>
 <CAC_TJveNRaDFcQGo9-eqKa3=1DnuVDs4U+ye795VcJ1ozVkMyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJveNRaDFcQGo9-eqKa3=1DnuVDs4U+ye795VcJ1ozVkMyg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

Sorry for the radiosilence.

I see that in v7 you've dropped the stacktrace bits for now; I'm just
commenting here fot future reference.

On Thu, Mar 31, 2022 at 12:22:05PM -0700, Kalesh Singh wrote:
> Hi everyone,
> 
> There has been expressed interest in having hypervisor stack unwinding
> in production Android builds.
> 
> The current design targets NVHE_EL2_DEBUG enabled builds and is not
> suitable for production environments, since this config disables host
> stage-2 protection on hyp_panic() which breaks security guarantees.
> The benefit of this approach is that the stack unwinding can happen at
> EL1 and allows us to reuse most of the unwinding logic from the host
> kernel unwinder.
> 
> Proposal for how this can be done without disabling host stage-2 protection:
>   - The host allocates a "panic_info" page and shares it with the hypervisor.
>   - On hyp_panic(), the hypervisor can unwind and dump its stack
> addresses to the shared page.
>   - The host can read out this information and symbolize these addresses.
> 
> This would allow for getting hyp stack traces in production while
> preserving the security model. The downside being that the core
> unwinding logic would be duplicated at EL2.
> 
> Are there any objections to making this change?

I'm fine with the concept of splitting the unwind and logging steps; this is
akin to doing:

	stack_trace_save_tsk(...);
	...
	stack_trace_print(...);

... and I'm fine with having a stack_trace_save_hyp(...) variant.

However, I would like to ensure that we're reusing logic rather than
duplicating it wholesale. There are some changes I would like to make to the
stacktrace code in the near future that might make that a bit easier, e.g.
reworking the stack transition checks to be table-driven, and factoring out the
way we handle return trampolines.

I'll Cc you on changes to the stacktrace code. There are some preparatory
cleanups I'd like to get out of the way first which I'll send shortly.

Thanks,
Mark.
