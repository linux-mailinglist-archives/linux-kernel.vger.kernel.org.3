Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF45AFB88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiIGFGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIGFGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:06:32 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003307C514
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:06:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11eab59db71so33283716fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 22:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PuiKfvs0LWAFr8O4tXDEiRE5L2gc12ma++oYFMovvEU=;
        b=HiAdJ/axcwhcheeTKmxwxPlJ3kkpkpWVXXbMlfVAxshrVHB3RXTsEPc76wdtNg++Ul
         hs4GW0KDXPNwRfjyV1Vx9TSn/VpKF56LdGj0hygoXLfkabTG4kCC47aNL7OS+anUL8NU
         SHAGzhw4jhbjLjoGYRQVK8ly5/zLCX8nWH1MMTGJ2E9d93z2ozA455tVTjdP/fVASAG7
         Eml7f5DqE2LL6uCi7afSC2RvsH1Yo7W+fYTLrXxh386gXmQNCgX/nHjAZ0uje/zGU3tH
         3Hwh38WZoY+WSAuFEzxl0oOniXN6S1jtzddhoUCscPpQUsBy0JhbZJ/u9AnkRN/9XnLu
         Sjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PuiKfvs0LWAFr8O4tXDEiRE5L2gc12ma++oYFMovvEU=;
        b=I/dDYEXJyLOyPcWLyoupSi6I2VHSIejGO65ikvdyBMNzN8DdWSlYWQXCooroTwnl/L
         bL0CUtUkWYaPVsyfN3Mrco+4kawrjtliKf4fBfSAjTSbWDrmesEQxLEmZ0oZXyyeJFG8
         iw4SfYSh8M6P61Vx8Kvi113cp2exKjxI8jPtRc0qco7DAtOJjj0XuGBWfFTF5dq9yThI
         3sn8vjuQOXmNlIFhhl31ib9FmiO7jC9gnwnCheqnNK+Hc5shNVYYDS8ukO4r6X2G7rua
         jlNDLMu63J6uYdPUDSRbTN+Npe7kkAYYbpwygGtWwBYoAzhmct6tpkpfFYyCUwXiJvUD
         I5+Q==
X-Gm-Message-State: ACgBeo2wrtb5dDEEd9zh58XR2gW0dr2kemhLkj8iuR5/ctrQf/K2SVgq
        ngBjaShOFoXyoTQ5ZdDq8jRshr/lnK8U+xMpdFF69w==
X-Google-Smtp-Source: AA6agR68KEmYYa6UEG7EGujrK2R8QAdI92tuwkfI6jdcPL7421NRztQt6frx3ojGnuI2XSq/LIK2lBPgUVyLYIJYg9Y=
X-Received: by 2002:a05:6870:41d0:b0:126:5d06:28a5 with SMTP id
 z16-20020a05687041d000b001265d0628a5mr895080oac.181.1662527189600; Tue, 06
 Sep 2022 22:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220906081604.24035-1-likexu@tencent.com> <CALMp9eSQYp-BC_hERH0jzqY1gKU3HLV2YnJDjaAoR7DxRQu=fQ@mail.gmail.com>
 <2c9c1e8a-7ab5-8052-3e99-b4ebfd61edde@gmail.com>
In-Reply-To: <2c9c1e8a-7ab5-8052-3e99-b4ebfd61edde@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 6 Sep 2022 22:06:18 -0700
Message-ID: <CALMp9eRzmKAs5SvTjrG7+het7zfJqk2bFuU1fdqf8pFB2+0qvw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: omit "impossible" Intel counter MSRs from
 MSR list
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 8:25 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 7/9/2022 8:37 am, Jim Mattson wrote:
> > On Tue, Sep 6, 2022 at 1:16 AM Like Xu <like.xu.linux@gmail.com> wrote:
> >>
> >> From: Like Xu <likexu@tencent.com>
> >>
> >> According to Intel April 2022 SDM - Table 2-2. IA-32 Architectural MSRs,
> >> combined with the address reservation ranges of PERFCTRx, EVENTSELy, and
> >> MSR_IA32_PMCz, the theoretical effective maximum value of the Intel GP
> >> counters is 14, instead of 18:
> >>
> >>    14 = 0xE = min (
> >>      0xE = IA32_CORE_CAPABILITIES (0xCF) - IA32_PMC0 (0xC1),
> >>      0xF = IA32_OVERCLOCKING_STATUS (0x195) - IA32_PERFEVTSEL0 (0x186),
> >>      0xF = IA32_MCG_EXT_CTL (0x4D0) - IA32_A_PMC0 (0x4C1)
> >>    )
> >>
> >> the source of the incorrect number may be:
> >>    18 = 0x12 = IA32_PERF_STATUS (0x198) - IA32_PERFEVTSEL0 (0x186)
> >> but the range covers IA32_OVERCLOCKING_STATUS, which is also architectural.
> >> Cut the list to 14 entries to avoid false positives.
> >>
> >> Cc: Kan Liang <kan.liang@linux.intel.com>
> >> Cc: Jim Mattson <jamttson@google.com>
> >
> > That should be 'jmattson.'
>
> Oops, my fault.
>
> >
> >> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Fixes: cf05a67b68b8 ("KVM: x86: omit "impossible" pmu MSRs from MSR list")
> >
> > I'm not sure I completely agree with the "Fixes," since
> > IA32_OVERCLOCKING_STATUS didn't exist back then. However, Paolo did
> > make the incorrect assumption that Intel wouldn't cut the range even
> > further with the introduction of new MSRs.
>
> This new msr is added in April 2022.
>
> Driver-like software had to keep up with real hardware changes and
> speculatively with potential predictable hardware changes until failure.
>
> >
> > To that point, aren't you setting yourself up for a future "Fixes"
> > referencing this change?
>
> (1) We have precedents like be4f3b3f8227;
> (2) Fixes tags is introduced to help stable trees' maintainers (and their robot
> selectors)
> absorb suitable patches like this one. We can expect similar issues with stable
> trees running
> on new hardware without this fix.
> (3) Fixing the tags does not feather the developer's nest, on the contrary the
> upstream code
> itself as a vehicle for our group knowledge, is reinforced.
> >
> > We should probably stop at the maximum number of GP PMCs supported
> > today (8, I think).
>
> I actually thought that at first, until I saw the speculative offset +17 :D.

The root cause of all of this pain is commit a072738e04f0 ("perf, x86:
Implement initial P4 PMU driver"). It bumped X86_PMC_MAX_GENERIC from
8 to 32. That eventually mutated into INTEL_PMC_MAX_GENERIC, which is
what I consulted when I originally added the Intel PMU MSRs to
msrs_to_save[] in
commit e2ada66ec418 ("kvm: x86: Add Intel PMU MSRs to
msrs_to_save[]"). My bad for just assuming that I knew what
INTEL_PMC_MAX_GENERIC meant, based solely on its name!

Paolo fixed my commit by reducing the list to 18 PMCs, because of the
known conflict at the time. (Note that the SDM says that there are
actually only 18 PMCs on the P4, but I don't think Paolo factored this
into his change.)

This is all the more reason *not* to put a static list of PMU MSRs
into msrs_to_save[], but to dynamically add the PMU MSRs supported on
the host. If you're on a P4, there will be 18 of them, but they range
from 0x300 to 0x311.
