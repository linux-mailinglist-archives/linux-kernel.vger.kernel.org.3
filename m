Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B05B57E0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGVLQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVLQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:16:39 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904049B5E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 04:16:37 -0700 (PDT)
Date:   Fri, 22 Jul 2022 12:16:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658488596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bWMt6DrO+QpBB8jeoqRLaRrtD7zLY5M5syjYMGmYEtY=;
        b=Lhtr/basSfJ7soT0J6Z9kSRdSByaPWd/Q/wvSTsFIqpuD2HM2bD7yOHAHq26QrBiiVP69r
        iXiApSpbGWW7FcvvN/pp5eKGKPxWRgh8WoSWcG0oS+vH7yzNvYkzLxzEsMHuxwj9Y7J7hg
        s15kMJaK4m3UqyuT0c4Phm9u+xPLcDY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com, will@kernel.org,
        qperret@google.com, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v5 16/17] KVM: arm64: Introduce pkvm_dump_backtrace()
Message-ID: <YtqHDTpnn376Qb7u@google.com>
References: <20220721055728.718573-1-kaleshsingh@google.com>
 <20220721055728.718573-17-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721055728.718573-17-kaleshsingh@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Wed, Jul 20, 2022 at 10:57:27PM -0700, Kalesh Singh wrote:

[...]

> +/*
> + * pkvm_dump_backtrace - Dump the protected nVHE HYP backtrace.
> + *
> + * @hyp_offset: hypervisor offset, used for address translation.
> + *
> + * Dumping of the pKVM HYP backtrace is done by reading the
> + * stack addresses from the shared stacktrace buffer, since the
> + * host cannot direclty access hyperviosr memory in protected
> + * mode.
> + */
> +static void pkvm_dump_backtrace(unsigned long hyp_offset)
> +{
> +	unsigned long *stacktrace_entry
> +		= (unsigned long *)this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
> +	unsigned long va_mask, pc;
> +
> +	va_mask = GENMASK_ULL(vabits_actual - 1, 0);
> +
> +	kvm_err("Protected nVHE HYP call trace:\n");

This and the footer printks should be put in respective helpers to share
between pKVM and non-pKVM backtrace implementations. I imagine users
will invariably bake some pattern matching to scrape traces, and it
should be consistent between both flavors.

> +	/* The stack trace is terminated by a null entry */
> +	for (; *stacktrace_entry; stacktrace_entry++) {

At the point we're dumping the backtrace we know that EL2 has already
soiled itself, so we shouldn't explicitly depend on it providing NULL
terminators. I believe this loop should have an explicit range && NULL
check.

--
Thanks,
Oliver
