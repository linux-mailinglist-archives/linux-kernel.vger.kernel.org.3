Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1E509BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387222AbiDUJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387211AbiDUJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:03:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9D9722506
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:00:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 256611477;
        Thu, 21 Apr 2022 02:00:46 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.76.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD1C03F766;
        Thu, 21 Apr 2022 02:00:42 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:00:36 +0100
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
Message-ID: <YmEdNME45PJr5w+Y@FVFF77S0Q05N>
References: <20220314200148.2695206-1-kaleshsingh@google.com>
 <20220314200148.2695206-8-kaleshsingh@google.com>
 <CA+EHjTwQRUCjvcMHNe1f0kPBdU=vS+f2+e_eefhnJDR4s73cQA@mail.gmail.com>
 <CAC_TJveNRaDFcQGo9-eqKa3=1DnuVDs4U+ye795VcJ1ozVkMyg@mail.gmail.com>
 <YlbXHg64HK2d3dgm@FVFF77S0Q05N>
 <CAC_TJveJYFkHPQLYdL8SCEAwMPgwpF_-ctMqKJ9w=eDa_M0u5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJveJYFkHPQLYdL8SCEAwMPgwpF_-ctMqKJ9w=eDa_M0u5w@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:37:56AM -0700, Kalesh Singh wrote:
> On Wed, Apr 13, 2022 at 6:59 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > I'm fine with the concept of splitting the unwind and logging steps; this is
> > akin to doing:
> >
> >         stack_trace_save_tsk(...);
> >         ...
> >         stack_trace_print(...);
> >
> > ... and I'm fine with having a stack_trace_save_hyp(...) variant.
> >
> > However, I would like to ensure that we're reusing logic rather than
> > duplicating it wholesale.
> 
> Agreed. Although some reimplementation may be unavoidable, as we can't
> safely link against kernel code from the protected KVM hypervisor.

Sure; I just mean that we have one implementation, even if that gets recompiled
in separate objects for different contexts.

> Perhaps we can move some of the common logic to a shared header that
> can be included in both places (host, hyp), WDYT?

My rough thinking was that we'd build the same stacktrace.c file (reworked from
the current one) as stracktrace.o and stacktrace.nvhe.o, but moving things
around into headers is also an option. Either way will need some
experimentation.

Thanks,
Mark.
