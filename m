Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF85757E036
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiGVKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiGVKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:48:41 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A962A6F8F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:48:36 -0700 (PDT)
Date:   Fri, 22 Jul 2022 11:48:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658486914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0AyQqMWkq3QK3cl0AVPhmS1VRFhKVJORRDR1qEdQa2E=;
        b=xicOKB6Owxf662WLaEHk73CJEtDiVVJlzZYlCwcm2/Diwz0HTpzvGaebKIShQmRpj0iZR1
        G0JoITMh43Aju/9To6bjbUkmSVnwtTN0+CxPKbszZa19YuGHmQBj+QkAqOzApPVL6H6VZH
        n38wfKDStIPrL8+wxF39Kgji85DhFrU=
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
Subject: Re: [PATCH v5 00/17] KVM nVHE Hypervisor stack unwinder
Message-ID: <YtqAf0e7Tc7qu5/c@google.com>
References: <20220721055728.718573-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Wed, Jul 20, 2022 at 10:57:11PM -0700, Kalesh Singh wrote:

[...]

> Kalesh Singh (17):
>   arm64: stacktrace: Add shared header for common stack unwinding code
>   arm64: stacktrace: Factor out on_accessible_stack_common()
>   arm64: stacktrace: Factor out unwind_next_common()
>   arm64: stacktrace: Handle frame pointer from different address spaces
>   arm64: stacktrace: Factor out common unwind()
>   arm64: stacktrace: Add description of stacktrace/common.h
>   KVM: arm64: On stack overflow switch to hyp overflow_stack
>   KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
>   KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
>   KVM: arm64: Stub implementation of pKVM HYP stack unwinder
>   KVM: arm64: Stub implementation of non-protected nVHE HYP stack
>     unwinder
>   KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
>   KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
>   KVM: arm64: Implement protected nVHE hyp stack unwinder
>   KVM: arm64: Implement non-protected nVHE hyp stack unwinder
>   KVM: arm64: Introduce pkvm_dump_backtrace()
>   KVM: arm64: Introduce hyp_dump_backtrace()

Adding a general comment on the organization of the series. I think for
the next spin it'd be good to organize the entire non-pKVM
implementation first, followed by the pKVM implementation. Otherwise,
reviewers need to jump around the series a lot in order to page in the
appropriate context.

I had mentioned this about the last two patches earlier, but after
grokking the stack I see the comment applies to the entire KVM portion
of the series.

--
Thanks,
Oliver
