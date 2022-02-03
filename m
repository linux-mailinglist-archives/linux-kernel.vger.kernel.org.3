Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8C4A8F60
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiBCUvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBCUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:51:05 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFDC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:51:05 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id q14-20020a05683022ce00b005a6162a1620so3655484otc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 12:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZjT0AI8QaDMZi7gSSNnNcg9BqhdWxMUwV4p8xm0hR8=;
        b=Kz8+3jlUvBmSaJpMHCcA2q3moKa+5SMh4PI6lDjMnwXfYkHP0VRxwyrFw8xfddQkh9
         P32fHUmTYcCYzMCYgQUWzIp+6EQTME+zhyUOUfWtd6n2hiYGYmW0ywiYvdWBH+9FGbO+
         Al8e4kE8FjB59UoeQxgP6z95IA+9Wx5oqEid+jMX1GCMcKpM4KK3sx/JheZVUuDgD7QI
         vxdEkDG3alyhtZ7gmeYe8CV2gNfyZJSdjzLvK6Q0fAhCK2CN84Nis0S72wlq1oXXnsq0
         uYhmjLyrIv6UKClpw06Vt0GeuAfRRG0ObF6zH2N1CarhMciEvJRzO0oMNbBbqunmxsLu
         48Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZjT0AI8QaDMZi7gSSNnNcg9BqhdWxMUwV4p8xm0hR8=;
        b=WUgjufZ6p1krjHgAkqy0USrFc4J34tcsumGGMkJtvQ70OF4y/8tCbk4u7FQIqaAaqO
         TG/IZSA7hBXcgxvAFXGJDai4TvigNletXFR2Vn242yVvEUw+HrU9HQ5bKtqE8AoVq50g
         7CbBYrSIiP0oNlchYOP0eam+FOZ48TiHyoAkVWwmYSrxWh5F4jz2tRm5XAZRhPMZLc5I
         L7X1t+WDhuw83HCOEaIt49iqdCP30FlUC9JixjFFcFVcODye3u6ciuyIqczRcF8ums15
         eQKteeSPMiQmWnijv0MH12zWEsFhrOdlyUDnN+o4uRt1j+6d/J1Miaw0CY88R6aXUrd8
         LBIA==
X-Gm-Message-State: AOAM530r32/KfKPfOe1/HZA3XhFUk2mcsHqImPVbtTr32CbLYMm5dbky
        kwzzvsORKS3fEnwEBQEqCjd+ZnFvPtfoyAk6ND+vfg==
X-Google-Smtp-Source: ABdhPJw2iVj9BA487rbT1aNR7i4IP/OhCA2U8lcaqAzaVVQDRa3sVJM7rWWucUIzW4Z55E4ecDTq72JwdJeK/0gzc+Y=
X-Received: by 2002:a05:6830:22e3:: with SMTP id t3mr19898967otc.75.1643921464617;
 Thu, 03 Feb 2022 12:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20220203194308.2469117-1-jmattson@google.com> <20220203194308.2469117-2-jmattson@google.com>
 <e313b068-b5d6-dbc4-9894-02d759d2fe55@intel.com>
In-Reply-To: <e313b068-b5d6-dbc4-9894-02d759d2fe55@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Feb 2022 12:50:53 -0800
Message-ID: <CALMp9eQ+vRQhbmTh1j4YT7AhGcvRxnmzttTbjN3UKHaijwpqAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/cpufeatures: Add macros for Intel's new fast rep
 string features
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Jing Liu <jing2.liu@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 12:25 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/3/22 11:43, Jim Mattson wrote:
> > Even if no one else cares, these features should be exposed to kvm
> > guests, and the code for the KVM_GET_SUPPORTED_CPUID ioctl is more
> > readable if the bits have corresponding X86_FEATURE macros.
>
> I went digging around KVM_GET_SUPPORTED_CPUID and didn't see any obvious
> unreadable things resulting from not having these defines.  Maybe I'm
> looking in the wrong spot.  Do you have a slightly more specific pointer?

These features are not currently enumerated by
KVM_GET_SUPPORTED_CPUID. They would be added as follows [gmail mangles
diffs; sorry]:

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 28be02adc669..11e621b6faac 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -599,7 +599,7 @@ void kvm_set_cpu_caps(void)
                kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);

        kvm_cpu_cap_mask(CPUID_7_1_EAX,
-               F(AVX_VNNI) | F(AVX512_BF16)
+                F(AVX_VNNI) | F(AVX512_BF16) | F(FZRM) | F(FSRS) | F(FSRC)
        );

        kvm_cpu_cap_mask(CPUID_D_1_EAX,

(Of course, we can always define these macros in that file, if that's
preferable.)

> > +#define X86_FEATURE_FZRM             (12*32+10) /* Fast zero-length REP MOVSB */
> > +#define X86_FEATURE_FSRS             (12*32+11) /* Fast short REP STOSB */
> > +#define X86_FEATURE_FSRC             (12*32+12) /* Fast short REP {CMPSB,SCASB} */
>
> If the use really is for inside the kernel, maybe we should hide them
> from cpuinfo:
>
> #define X86_FEATURE_FSRC                (12*32+12) /* "" Fast short REP {CMPSB,SCASB} */

That sounds good to me.
