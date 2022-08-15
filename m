Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1315859442A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349227AbiHOWZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350834AbiHOWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:18:40 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE341D32
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:42:38 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id s194so4181614vka.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RGBjkPaE8J9hO2HXiD58roaLLtlMCd9GApWRbn/4InE=;
        b=FPnuTloO45sF2T+4wEAf823pe7ogF3QnjRaKt7CEVoHfJADFo52qIDJ1ZW2Z4LsAcu
         H1W2iVmPI4c522AHFCUyx7ONp/gv20XWuh3LLqi1W1gNTA7Go2R4zwn18WsNaore+syl
         0eYy6eJq/oyYLaYS+z59QmSMvokUC+mywr5AIISm+KTlLsOJU4LPOKV0XxpFu3UwdcS0
         dYc0WrRklRJfH4uzQCrjttrHj/om6vTyzT/5gmlSslEJoj/j2XoWwJu62hNTThOfBCfK
         uwOFZ9py99FCDB/TEkuZ2PIS8vruJ36GwJ47bJEEbddUQ86rJ18LozZWAOKcFsQXzuXX
         elKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RGBjkPaE8J9hO2HXiD58roaLLtlMCd9GApWRbn/4InE=;
        b=iV1FoVuCAapvgYQQWnwndDAUu9j8pHU1tqNTPYfKPL6SjCYaNOE9ILs4IYqOK6f+NT
         1aNAdMPfR5Ru2Eg3qSn5q6aZfnxmbsZiuHwUw35gelUiLpRHruumUk8YPoqX3n4kk8bh
         WQblVUdXcZfh4+pFA5HkUEZ/HDj9xjN/wKrDVbbELosbnnHB3anLXr6jLL2fPL7umoZR
         hQXCGrJ+mqufLwfm77qda2Jw1L49V0JCW0iRkuCwQThC+/cZ5OIDfNGG3LP88CDdKvqZ
         k9H1N2tmIfwSmRt8Wr9sFuKGSES3JHt+AtzSphLV906kOXLOsoGhKdjL0CLfjsMXLblA
         XrFQ==
X-Gm-Message-State: ACgBeo38fAdRGQqlnLeKxIxqkWWyV22TGOt3xEW3aOa1FNs1+C8ZXX7d
        gmetPyX4HVhNA5TdK8kZY9F8ck2U6tZeoQM9Vf6q3KtkDXK/+g==
X-Google-Smtp-Source: AA6agR7pGITv9xB++a81UrxiizddUCff4tMML/JKgOT3cUKsfaaQ9Khq0zhzod+3R31qgsSrSVaAxFx5/6Bs+6Zfd0E=
X-Received: by 2002:a1f:2b47:0:b0:380:59c5:8b8f with SMTP id
 r68-20020a1f2b47000000b0038059c58b8fmr1092986vkr.20.1660592557245; Mon, 15
 Aug 2022 12:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660211399.git.sandipan.das@amd.com> <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
 <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
In-Reply-To: <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 15 Aug 2022 12:42:23 -0700
Message-ID: <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
Subject: Re: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        like.xu.linux@gmail.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
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

Hi,

On Mon, Aug 15, 2022 at 4:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Aug 11, 2022 at 05:59:52PM +0530, Sandipan Das wrote:
> > CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some new performance
> > monitoring features for AMD processors.
> >
> > Bit 1 of EAX indicates support for Last Branch Record Extension Version 2
> > (LbrExtV2) features. If found to be set during PMU initialization, the EBX
> > bits of the same leaf can be used to determine the number of available LBR
> > entries.
> >
> > For better utilization of feature words, LbrExtV2 is added as a scattered
> > feature bit.
> >
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 2 +-
> >  arch/x86/kernel/cpu/scattered.c    | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index 393f2bbb5e3a..e3fa476a24b0 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -96,7 +96,7 @@
> >  #define X86_FEATURE_SYSCALL32                ( 3*32+14) /* "" syscall in IA32 userspace */
> >  #define X86_FEATURE_SYSENTER32               ( 3*32+15) /* "" sysenter in IA32 userspace */
> >  #define X86_FEATURE_REP_GOOD         ( 3*32+16) /* REP microcode works well */
> > -/* FREE!                                ( 3*32+17) */
> > +#define X86_FEATURE_LBREXT_V2                ( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
> >  #define X86_FEATURE_LFENCE_RDTSC     ( 3*32+18) /* "" LFENCE synchronizes RDTSC */
> >  #define X86_FEATURE_ACC_POWER                ( 3*32+19) /* AMD Accumulated Power Mechanism */
> >  #define X86_FEATURE_NOPL             ( 3*32+20) /* The NOPL (0F 1F) instructions */
> > diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> > index dbaa8326d6f2..6be46dffddbf 100644
> > --- a/arch/x86/kernel/cpu/scattered.c
> > +++ b/arch/x86/kernel/cpu/scattered.c
> > @@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] = {
> >       { X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> >       { X86_FEATURE_MBA,              CPUID_EBX,  6, 0x80000008, 0 },
> >       { X86_FEATURE_PERFMON_V2,       CPUID_EAX,  0, 0x80000022, 0 },
> > +     { X86_FEATURE_LBREXT_V2,        CPUID_EAX,  1, 0x80000022, 0 },
> >       { 0, 0, 0, 0, 0 }
> >  };
>
> Would LBR_V2 work at all? It being a new version already seems to imply
> extention, no? Then again, I suppose there's an argument to be had for
> avoiding confusion vs the Intel LBR thing.. Couldn't you have called
> this BRS_V2 :-)
>
I believe it is called v2 because there was already a LBR in previous
generations, however it
was 1-deep and it was not connected to the PMU like this one. The
public PPR mentions it
(MSR 0x1DB/0x1DC, Last Branch From IP, Last Branch To IP). See for
instance the PPR
for Fam17h model 71h:
https://www.amd.com/system/files/TechDocs/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06.zip

BRS is a model specific feature for Zen3.

LBRv2 is a great improvement including over Zen3 BRS.
