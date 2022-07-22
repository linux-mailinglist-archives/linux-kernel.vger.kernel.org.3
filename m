Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700AD57E57B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiGVRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:25:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DD9D56
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:25:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bv24so7404920wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qo8WtVG4n0zTyMgzLgHF96/1qxYxV8ri3HK7ykqwnO8=;
        b=IK7V1IOiUtkzMNlZe+LF+whif65Ho4BnHQgQT5ZqfEnJBdOdhx+lcnsEqWnONdEIj5
         37zG5sDarPhLTl8WkWOedv9TArm8RDXVASNCbomlxOJZVtSYWcSdjX/2pK+YEaabocSO
         vHG5ODih6QIppMO3JhyTpBsN+rCbddhFRKimz/zgyqwR1EnLH1QxtEIvX5/kYonlKosk
         2BxCBvjDosLoJIIRjCMzRvruT384mua/wXVI+I2tkETcS4K8ZUtaZ57+L+go0dpvv1Pp
         L0WZjgtsSjEI/qBKh8D7LLxMRKJLuLObV4Ml3SUEGNA59aYtWV92hmkMEOFDlWPgM0w5
         34Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qo8WtVG4n0zTyMgzLgHF96/1qxYxV8ri3HK7ykqwnO8=;
        b=t1KwXGhIq5IULvOAEKwQDYc7RW/+QSt6Iy7Y7jKVwW1LlmJhB4zlPpIqeS2BPSIUy+
         JDPqwyNwMKFiwq0ifSp7BX/sZRnm/ZDuqwAo6bp1Ib+z4RDN6OFX3Gu7QKHDoeWt2qkI
         GPQqoUbPi7DhNxwThdww2x2b0OKQzNfxNAmXqJo/k8CCNaZdOBwgOpeqDRs4AWVO+dgp
         NgutJmPpvn1p0eYe3ynYtBrAGzS8ts3sdPeyEi9lf6x7zx9V+QGWI6XsS91ExGP9wXnn
         dcUWobh5P1W/TKQ+T7RZkjJS8e1n8MhXpXUF1MjiflwHXqW2biqT71j/dEDbcSPiH8W+
         fAMw==
X-Gm-Message-State: AJIora+5PWbrXUNgwnZ/JirYRRnZhrFpSthO1dNG3exFYv9r5pxf1EyS
        DIvb0Vi+YeueovdUWY65A4mWgTKmUJA/ZrEOZDxnFQ==
X-Google-Smtp-Source: AGRyM1tMBRELkdIUB+WahUZ3HbBB7VpSn07XisByEgMH3WLYDxJwtXXySPT1I4TW5C1OKkrxltUynrrqfqmbgcKRLcA=
X-Received: by 2002:a5d:6c65:0:b0:21d:b7c0:9930 with SMTP id
 r5-20020a5d6c65000000b0021db7c09930mr626692wrz.500.1658510724540; Fri, 22 Jul
 2022 10:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
 <20220721055728.718573-17-kaleshsingh@google.com> <YtqHDTpnn376Qb7u@google.com>
In-Reply-To: <YtqHDTpnn376Qb7u@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 22 Jul 2022 10:25:13 -0700
Message-ID: <CAC_TJvdAa0PnTSiNa4W0QusQYJ7bEGeWD2+i4EsuZL94LjB15Q@mail.gmail.com>
Subject: Re: [PATCH v5 16/17] KVM: arm64: Introduce pkvm_dump_backtrace()
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 4:16 AM Oliver Upton <oliver.upton@linux.dev> wrote:
>
> Hi Kalesh,
>
> On Wed, Jul 20, 2022 at 10:57:27PM -0700, Kalesh Singh wrote:
>
> [...]
>
> > +/*
> > + * pkvm_dump_backtrace - Dump the protected nVHE HYP backtrace.
> > + *
> > + * @hyp_offset: hypervisor offset, used for address translation.
> > + *
> > + * Dumping of the pKVM HYP backtrace is done by reading the
> > + * stack addresses from the shared stacktrace buffer, since the
> > + * host cannot direclty access hyperviosr memory in protected
> > + * mode.
> > + */
> > +static void pkvm_dump_backtrace(unsigned long hyp_offset)
> > +{
> > +     unsigned long *stacktrace_entry
> > +             = (unsigned long *)this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
> > +     unsigned long va_mask, pc;
> > +
> > +     va_mask = GENMASK_ULL(vabits_actual - 1, 0);
> > +
> > +     kvm_err("Protected nVHE HYP call trace:\n");
>
> This and the footer printks should be put in respective helpers to share
> between pKVM and non-pKVM backtrace implementations. I imagine users
> will invariably bake some pattern matching to scrape traces, and it
> should be consistent between both flavors.

Hi Oliver,

Ok will split these out into helpers.

>
> > +     /* The stack trace is terminated by a null entry */
> > +     for (; *stacktrace_entry; stacktrace_entry++) {
>
> At the point we're dumping the backtrace we know that EL2 has already
> soiled itself, so we shouldn't explicitly depend on it providing NULL
> terminators. I believe this loop should have an explicit range && NULL
> check.

Good point, I'll add the additional checks in the next version,

Thanks,
Kalesh
>
> --
> Thanks,
> Oliver
