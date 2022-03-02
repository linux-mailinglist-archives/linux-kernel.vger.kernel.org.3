Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F59D4CAC89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbiCBRxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbiCBRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:53:43 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C454BB80
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:52:59 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 12so2400438oix.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlEoIVc7+NdNNNlbbRMkxDAku4T4vggQ1rCrcIbBpUo=;
        b=ZpLYgEffyee+yG5VtiHuJn6Ea5HHN+Ow6ERaKYwN+xGjUVS9SK8tfQAYiNlMXuGJdO
         tjLhNwCDfWWIxp9PMkwznQg2jT0X6qYvbZNTM+BuyeNOopntLHPjfmGxIokC9KdW52N9
         sS8e/ooUreQj4Ng+b5urR40o5fTUbuT5TTCGQVn96+CVAgNx7mQLLuoVvqJdsJePAEYF
         H/IAkPNSop/oyUtWvk6oy7AttWSHWiatbEBbRXE7wC+d1ZqVzhFYoICOczFWiJIm2Bdt
         oqxlgseBqohrkuGuXvaKNLwEuesgmxpKXI1b1IKdk6CoRVJoOSCxrlCICy5XYnFytENS
         rdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlEoIVc7+NdNNNlbbRMkxDAku4T4vggQ1rCrcIbBpUo=;
        b=0ZHGBHT6VlKZ2kRk8nqXVuXYErrig+QouM3P5/X0HwHCi0Pe398tBEfsZReTfUFh4s
         cqMeYoMiZri6wkKtKGhkH9B7wXbALDhh6gk1x6bUwteqndxvV1yxB7JWenl2OypxKUKU
         pNIlNkA/Z0Z1RaGjE5cfckcdNkCMP75jYJFS6+gbiw/q0sJybCE6GCil/sEMR3uo5vy+
         RVGOpuRikz0426/AOePSzweZ7pWu2wQk/ITiErQou1P6kGTmNgnhwEa1ns5bPyigr45r
         gJruMComFvYlypbTol1OtwT82hxQwojREu04qBwkLOcAcIcxC/cQLgo0KbeuBMHiSBVn
         LFtA==
X-Gm-Message-State: AOAM533ApUP728Ku4QTmWsobbj9/hHZeROj4k4NiSq+r2ArC2x3CfBOX
        Vlq47XoxujWrQVr6hLhnNFUKq3LTnaeXp2rQjjpt2jIjzKk=
X-Google-Smtp-Source: ABdhPJzq3p5uu9sVlEsb/MIquJMJtnsmWeB8BSeuGIc4dqYqNDjXA/hAoGgDUvk8Wtsxo9gRXHKHVfayfofUwkasTDk=
X-Received: by 2002:a05:6808:1443:b0:2d7:306b:2943 with SMTP id
 x3-20020a056808144300b002d7306b2943mr933327oiv.66.1646243578556; Wed, 02 Mar
 2022 09:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20220302111334.12689-1-likexu@tencent.com> <20220302111334.12689-13-likexu@tencent.com>
In-Reply-To: <20220302111334.12689-13-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Mar 2022 09:52:47 -0800
Message-ID: <CALMp9eT1N_HeipXjpyqrXs_WmBEip2vchy4d1GffpwrEd+444w@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] KVM: x86/pmu: Clear reserved bit PERF_CTL2[43]
 for AMD erratum 1292
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 3:14 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> The AMD Family 19h Models 00h-0Fh Processors may experience sampling
> inaccuracies that cause the following performance counters to overcount
> retire-based events. To count the non-FP affected PMC events correctly,
> a patched guest with a target vCPU model would:
>
>     - Use Core::X86::Msr::PERF_CTL2 to count the events, and
>     - Program Core::X86::Msr::PERF_CTL2[43] to 1b, and
>     - Program Core::X86::Msr::PERF_CTL2[20] to 0b.
>
> To support this use of AMD guests, KVM should not reserve bit 43
> only for counter #2. Treatment of other cases remains unchanged.
>
> AMD hardware team clarified that the conditions under which the
> overcounting can happen, is quite rare. This change may make those
> PMU driver developers who have read errata #1292 less disappointed.
>
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Like Xu <likexu@tencent.com>

This seems unnecessarily convoluted. As I've said previously, KVM
should not ever synthesize a #GP for any value written to a
PerfEvtSeln MSR when emulating an AMD CPU.
