Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39D0517B0D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiEBXyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiEBXyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:54:14 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41CCA2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:50:44 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so2849837ooj.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7Cw+Kh2PwkVaz2CcLvmIqjqnZHIcRL3vzxNDm28vQI=;
        b=qUJMJzIghsthGyWraON5sQRLlRKSCoeCtBLqhKJxW+nZKX+BqUjkWgnilkYzSgnBqs
         ZgN1/gkwEi+9c2RnHpNtWioNpP/BXFLJBZdzymI1P+EuPoyeJWQL/nxy1AnvGQ159gqR
         zXwryGn81LW3dUC6mRtWsiyH4qnVUV+qCk+lcynIagdTX4YkYsJ3A6WfUAZnf2QV0BKv
         kWxI50BXL7mFaYi67tBF1BlWawAv+ZAAsnLzMI0Vdw3tg7DP8ChWMB7X3AnzKqttwNpo
         E7TF149IXP7bGqe9ftVMsqI8K5u+dBCsBKqJT/UeB3z3AIs17lfGrqtomLhC/oR0QrF5
         ZgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7Cw+Kh2PwkVaz2CcLvmIqjqnZHIcRL3vzxNDm28vQI=;
        b=n56nEyusNqRIy741Q5jKvky9P0aYsc5bfuCe50rbke6fs+j9MnvwvSpfdUcyXmw4Hd
         M5CwOqP5BDEf9x9pmzy+YnIYc0ryOnwlV7nKohmK7NojKD7orqghO4SjDaFp9onSb/E1
         DsQM3inmg76dByq20vRYYaC7Re9L6CN8nT7ekPpxsC1liLImqCfka/MW+lXAyCQKEfSg
         7Gn8T/gvf61CiB0cteMh4kR6NwuLtfNW2B5lx2/QYUTNQlhavepob+hbwQR6IBRAI/qK
         GlO5PjW2pwtoQRqUO/kj6Oe5k/y0LpqlA8vC3rsHb1oW4zJv3UdqXu4f3GrW6nImGFmd
         ZBJA==
X-Gm-Message-State: AOAM530rkHfPJelI209LdufxODsMEU/moHuE9xccbbOmWa9VqKD+7iSV
        1Fq7vHWKF4P0H+X04bPyKAqxRwwQ0ds+X41tDSD4aA==
X-Google-Smtp-Source: ABdhPJwXgvnATQa1rZ5EKOQDBk3E5T5DKJmlC3FwomnAmQjTyGDvBY73DuXdqDwMNiO01v0nBWKkIHXKLl9A2AM2Jpw=
X-Received: by 2002:a4a:bb10:0:b0:35e:d6a9:3208 with SMTP id
 f16-20020a4abb10000000b0035ed6a93208mr4306723oop.85.1651535443613; Mon, 02
 May 2022 16:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651058600.git.sandipan.das@amd.com> <3fef83d9c2b2f7516e8ff50d60851f29a4bcb716.1651058600.git.sandipan.das@amd.com>
In-Reply-To: <3fef83d9c2b2f7516e8ff50d60851f29a4bcb716.1651058600.git.sandipan.das@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 2 May 2022 16:50:32 -0700
Message-ID: <CALMp9eSdUW6et2Us1if-j2Do6cv9ssyT4C2KPiyomFd7i_Dc1Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, like.xu.linux@gmail.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 4:34 AM Sandipan Das <sandipan.das@amd.com> wrote:
>
> On some x86 processors, CPUID leaf 0xA provides information
> on Architectural Performance Monitoring features. It
> advertises a PMU version which Qemu uses to determine the
> availability of additional MSRs to manage the PMCs.
>
> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
> the same, the kernel constructs return values based on the
> x86_pmu_capability irrespective of the vendor.
>
> This leaf and the additional MSRs are not supported on AMD
> and Hygon processors. If AMD PerfMonV2 is detected, the PMU
> version is set to 2 and guest startup breaks because of an
> attempt to access a non-existent MSR. Return zeros to avoid
> this.
>
> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/kvm/cpuid.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 4b62d80bb22f..e66ebb747084 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -872,6 +872,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>                 union cpuid10_eax eax;
>                 union cpuid10_edx edx;
>
> +               if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {

Should this be checking kvm_cpu_cap_has(X86_FEATURE_ARCH_PERFMON) instead?

> +                       entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +                       break;
> +               }
> +
>                 perf_get_x86_pmu_capability(&cap);
>
>                 /*
> --
> 2.34.1
>
