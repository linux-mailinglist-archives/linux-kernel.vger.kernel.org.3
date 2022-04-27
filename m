Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9EE511721
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiD0LlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiD0LlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:41:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759741635;
        Wed, 27 Apr 2022 04:37:50 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0F0A1EC04F9;
        Wed, 27 Apr 2022 13:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651059465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1fVJWQta5i4UbygG37TRGkW+2cfnzRwz9q+gHhnuUTY=;
        b=p+LNdQEMNifB7YsATeBFDQ+UR+1pEbHv/mPGJL/Jqc29oWfE0oJwMlcoBgQWwMtl7p13vE
        VSV9sLwNR+sMxejGKaXiJUir/uvE+23UHGyEQX1LWcEz109Pe29hGLEcNCei5kfTxOhxYC
        tJk7UBgAhOzVnNzXioI9wMoaxnrD4Hg=
Date:   Wed, 27 Apr 2022 13:37:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, puwen@hygon.cn, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH v4 0/7] perf/x86/amd/core: Add AMD PerfMonV2 support
Message-ID: <YmkrCYZxG6cbCPGq@zn.tnic>
References: <cover.1651058600.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1651058600.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 05:01:42PM +0530, Sandipan Das wrote:
> Sandipan Das (7):
>   x86/cpufeatures: Add PerfMonV2 feature bit
>   x86/msr: Add PerfCntrGlobal* registers
>   perf/x86/amd/core: Detect PerfMonV2 support
>   perf/x86/amd/core: Detect available counters
>   perf/x86/amd/core: Add PerfMonV2 counter control
>   perf/x86/amd/core: Add PerfMonV2 overflow handling
>   kvm: x86/cpuid: Fix CPUID leaf 0xA
> 
>  arch/x86/events/amd/core.c         | 227 +++++++++++++++++++++++++++--
>  arch/x86/include/asm/cpufeatures.h |   2 +-
>  arch/x86/include/asm/msr-index.h   |   5 +
>  arch/x86/include/asm/perf_event.h  |  17 +++
>  arch/x86/kernel/cpu/scattered.c    |   1 +
>  arch/x86/kvm/cpuid.c               |   5 +
>  6 files changed, 240 insertions(+), 17 deletions(-)

From: Documentation/process/submitting-patches.rst

Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
						     ^^^^^^^^^^^^^^^^^^^^^
one week before resubmitting or pinging reviewers - possibly longer during
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
busy times like merge windows.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
