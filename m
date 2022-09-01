Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB75A9E64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiIARpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiIARoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:44:18 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6AD1EC5B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:43:19 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so33295920fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+hQWD3FFiCvjtBjWL5MEbFNgZqBTdR/iIIcXYH+DJ5U=;
        b=R7kqv1kzxzGMMrQ7ue3Hfy4EHITG2HXRXTNYAnw9dA2uDXa+BfwOU03rkMOS5rQjYM
         ahC+LAjqe22iF+ExhcYcKvePv59dzyV6wZlEVNpoWowkRIjpjjEeDeZZpLfqdyM98Zdu
         KtUZfZOz2teyBkHBvFOrHKvq2GLpuQ0L7Ev8fw5sRfP26FgYwlmiVK7TiSw2yasdKt4r
         Fd8gopCTKTeCWVt/t3oVcu9GJRePw+norCYr9+NYFcqrQbTTdIkJi4UuC72L2sVheYAt
         BldFaWjQZuw8ec6Lxl0dOoQU9cVaNLqTG4v7IwtS7qBOZVCqMzQpFiPGT4/JJy+KlYhv
         m4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+hQWD3FFiCvjtBjWL5MEbFNgZqBTdR/iIIcXYH+DJ5U=;
        b=E1yuStBPhb6k6MiHwVwPvawP+9gHKd7hwWIPO4rf5CLS/S05j+55zuEmOlGc/1WrLF
         bUDlSImA/NoW6ZDcc2AZeiahIdMnqqGOEC5qHRBI6NvlJ1+j6TdMzhQLeC1+Ns7oKXMN
         5pOTK7w0NlcrI4a+Z+2SweC11D02KjBDkEkraEO/Q8GsPh1HfpiiJAbq6wprvRd/NU2G
         MsMbwbiRjbHVB3Fv7cLM+VH7UWcsUHSu8BgEcT/mwF4PCI0QQm/QHsJ6YU//owpZooIG
         yzZlC9pvVQuxFQiQz4GWqssmzAGwOEfR5mpW5zs9QEi69QTRjavauq1QF2iip0/SPvo9
         USEw==
X-Gm-Message-State: ACgBeo3X12pWbYw4hUZnNWtVsrnE879p/mw+V6i4QaY4AGSiykzN6mst
        +NH7RxrE3/fKWHqhfcqI4U3ODHtMw/23VOcafgvP5g==
X-Google-Smtp-Source: AA6agR5GXD4P5DUY4rHzQY2C5yXB500D9X/y2vzf9C2+V0Ha1S+Z3BtW4/l6ETQYrSiEYGgwEfWjF8yPASB4mdbIwVo=
X-Received: by 2002:a05:6870:5a5:b0:122:5662:bee6 with SMTP id
 m37-20020a05687005a500b001225662bee6mr135980oap.181.1662054198367; Thu, 01
 Sep 2022 10:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220829100850.1474-1-santosh.shukla@amd.com> <20220829100850.1474-2-santosh.shukla@amd.com>
 <CALMp9eTrz2SkK=CjTSc9NdHvP4qsP+UWukFadbqv+BA+KdtMMg@mail.gmail.com> <a599f0da-3d9b-a37f-af7c-aa1310ed77e1@amd.com>
In-Reply-To: <a599f0da-3d9b-a37f-af7c-aa1310ed77e1@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 1 Sep 2022 10:43:07 -0700
Message-ID: <CALMp9eT3zHqZhDLKV=5UTnwLsvmbkpqibsh4tjqFnW4+MGR4aw@mail.gmail.com>
Subject: Re: [PATCHv4 1/8] x86/cpu: Add CPUID feature bit for VNMI
To:     "Shukla, Santosh" <santosh.shukla@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mlevitsk@redhat.com,
        mail@maciej.szmigiero.name
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

On Thu, Sep 1, 2022 at 5:45 AM Shukla, Santosh <santosh.shukla@amd.com> wrote:
>
> Hi Jim,
>
> On 9/1/2022 5:12 AM, Jim Mattson wrote:
> > On Mon, Aug 29, 2022 at 3:09 AM Santosh Shukla <santosh.shukla@amd.com> wrote:
> >>
> >> VNMI feature allows the hypervisor to inject NMI into the guest w/o
> >> using Event injection mechanism, The benefit of using VNMI over the
> >> event Injection that does not require tracking the Guest's NMI state and
> >> intercepting the IRET for the NMI completion. VNMI achieves that by
> >> exposing 3 capability bits in VMCB intr_cntrl which helps with
> >> virtualizing NMI injection and NMI_Masking.
> >>
> >> The presence of this feature is indicated via the CPUID function
> >> 0x8000000A_EDX[25].
> >>
> >> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> >> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> >> ---
> >>  arch/x86/include/asm/cpufeatures.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> >> index ef4775c6db01..33e3603be09e 100644
> >> --- a/arch/x86/include/asm/cpufeatures.h
> >> +++ b/arch/x86/include/asm/cpufeatures.h
> >> @@ -356,6 +356,7 @@
> >>  #define X86_FEATURE_VGIF               (15*32+16) /* Virtual GIF */
> >>  #define X86_FEATURE_X2AVIC             (15*32+18) /* Virtual x2apic */
> >>  #define X86_FEATURE_V_SPEC_CTRL                (15*32+20) /* Virtual SPEC_CTRL */
> >> +#define X86_FEATURE_V_NMI              (15*32+25) /* Virtual NMI */
> >>  #define X86_FEATURE_SVME_ADDR_CHK      (15*32+28) /* "" SVME addr check */
> >
> > Why is it "V_NMI," but "VGIF"?
> >
> I guess you are asking why I chose V_NMI and not VNMI, right?
> if so then there are two reasons for going with V_NMI - IP bits are named in order
> V_NMI, V_NMI_MASK, and V_NMI_ENABLE style and also Intel already using VNMI (X86_FEATURE_VNMI)

I would argue that inconsistency and arbitrary underscores
unnecessarily increase the cognitive load. It is not immediately
obvious to me that an extra underscore implies AMD. What's wrong with
X86_FEATURE_AMD_VNMI? We already have over half a dozen AMD feature
bits that are distinguished from the Intel version by an AMD prefix.
