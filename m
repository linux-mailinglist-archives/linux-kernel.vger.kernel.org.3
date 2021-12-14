Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17D47457F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhLNOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhLNOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:47:19 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A542C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:47:19 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q72so24437140iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFaTwQNiJAc7a2QN3hWW+V35/FnCiOZBYqAWjbKuIEY=;
        b=kRnF5ehDIA7oj8ynLN6/ltuRWtbP1Yd+CvSCVe4k9EkbJXvnlglG+1TDjcATPA25Bj
         Toe5TmW4Ih3plx0uXi1C+1Ey/n9J4MbMoNhiMLaU4INjM6u8fx9yqpd7//siCMT6Gjf3
         r7mcUYOMJDqa7InKOh1Z6F5/ZGChUydGGme2nU9whTylnLQaSXlkAYLgV34kuL9KwWDY
         46N2GfRQ25/g17+mJR2D5cuMR1UHt7jUDDX3m9ByOBl4/LUBJr5pYIPLmeIqjGLH9bFG
         0NKZWxrE0q4zHMjQQ9ueSaTozGAKng5dAfbKsRW5U8B1J+1nGB3tKlaADsvVu8Ao0W/3
         qYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFaTwQNiJAc7a2QN3hWW+V35/FnCiOZBYqAWjbKuIEY=;
        b=KAJTVIBuCGG9ALBamqZBnAu1gBZo0JA9AbEcA58NpQJ8BirTi/hSeYBYH2CD0bQT0y
         yeL9tOhaLPx0RP4MVPfWd0O/IoWGkqIOJxWnoToYXIWI5pcDqzosjusDsvVm+Z3o89tb
         ZSQKY4kuCbcDK30AJn2rKEQpeiHQUgsQxPw79RaRfReNOHsGldhTIDXRdn/5ANScSTXb
         jDbl9cAuD6JazoS27LJK24Ruer/rSp2GMw6wha4A1EGRTeoxiB/1G/OaB8wCtMGd2BsU
         PUvQatPRub9GxcFOyZs7H+2LaICe1w9lRfwXaeVWB7OYUgzt3n+cbNqIQlYPi9bYHor6
         4W7g==
X-Gm-Message-State: AOAM530KSXxd+ECCRTJRE2csjh3e3BsB8wxmUu2siNb2fW7GEHdU5ME7
        iJgXoHx69PWll3WAPIljqhBwYbFuxkM5pH4Lk99PTg==
X-Google-Smtp-Source: ABdhPJzTpfUg42dgB93Wl6laSIqoo4VQsY8HvOE1UvakA3FA6F/Os6E0TdbetECxIp+IWdNKdcuksIXKsEXFhJuTcWo=
X-Received: by 2002:a05:6602:2a44:: with SMTP id k4mr3890265iov.43.1639493238209;
 Tue, 14 Dec 2021 06:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com> <20211201170411.1561936-10-qperret@google.com>
In-Reply-To: <20211201170411.1561936-10-qperret@google.com>
From:   Andrew Walbran <qwandor@google.com>
Date:   Tue, 14 Dec 2021 14:47:06 +0000
Message-ID: <CA+_y_2FssSEiyBVU6D5MVrFw9nhBuoJp-qKWQePOMC6HV+NBCA@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] KVM: arm64: Extend pkvm_page_state enumeration
 to handle absent pages
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 at 17:04, 'Quentin Perret' via kernel-team
<kernel-team@android.com> wrote:
>
> From: Will Deacon <will@kernel.org>
>
> Explicitly name the combination of SW0 | SW1 as reserved in the pte and
> introduce a new PKVM_NOPAGE meta-state which, although not directly
> stored in the software bits of the pte, can be used to represent an
> entry for which there is no underlying page. This is distinct from an
> invalid pte, as stage-2 identity mappings for the host are created
> lazily and so an invalid pte there is the same as a valid mapping for
> the purposes of ownership information.
>
> This state will be used for permission checking during page transitions
> in later patches.
>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index b58c910babaf..56445586c755 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -24,6 +24,11 @@ enum pkvm_page_state {
>         PKVM_PAGE_OWNED                 = 0ULL,
>         PKVM_PAGE_SHARED_OWNED          = KVM_PGTABLE_PROT_SW0,
>         PKVM_PAGE_SHARED_BORROWED       = KVM_PGTABLE_PROT_SW1,
> +       __PKVM_PAGE_RESERVED            = KVM_PGTABLE_PROT_SW0 |
> +                                         KVM_PGTABLE_PROT_SW1,
> +
> +       /* Meta-states which aren't encoded directly in the PTE's SW bits */
> +       PKVM_NOPAGE,
>  };
>
>  #define PKVM_PAGE_STATE_PROT_MASK      (KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
> --
> 2.34.0.rc2.393.gf8c9666880-goog

Reviewed-by: Andrew Walbran <qwandor@google.com>
