Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC246D058
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhLHJzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhLHJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:55:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6EDC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:51:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o13so2974670wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 01:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gldA+GhZIOtvn7+srlMnzCuMOvxYrv7KuJt8R9mUOr8=;
        b=I5USUv0adWNsdFOcjZGJioG32G+/SMDOX9D0A47diifl3032llJ03dZ67rehpoLcCo
         JjpPRT5bCYVQtH2wnYBwb221+dl1foyrCt+6Jp7wWFty3J06d2XkD5St37KRmlPjvn/s
         CqYzhyYp9D9nLG6dGbT8Nol8FixWbpt2QLUih88qo78XOqHxkHpPHLSHaGJITiNzabyx
         F0nmTWFLUYlFNarepQzJirszXMLPerNtjhhGrzZET76OPBMZHuFZb+23iGyq9HG7ZByR
         s5kL1etsmKS5plFGaEYrteLeuZEd1mr51zyRoE4O2aPaeoRR8l83W/96SxpJR4JrBExi
         u17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gldA+GhZIOtvn7+srlMnzCuMOvxYrv7KuJt8R9mUOr8=;
        b=pApxkfyKewq5nMIpAb2+FD70b63JCY3uP2/h6DpEUe43kqNK636dcetAC3j2qYBhBP
         jHZGdnjNebQJi8HDVtTAh/tqsvky37e+rl3xhMgu2QMAW19Ui9YY7+dhWGiEaFCbeZsz
         ZW85yoqrt8VkB3KQmgBIFV2pXs+uxJA7FjX0KP+FKiTdAHoUTovj9iH46FCBf4Uqd8q7
         1h+75SkWdPsbsN3BkJ2QX/P0h9P8VpGP93ms2i6nYt3YnhFQ798YlE+TUA+WQY8fS1+A
         Xm5+onl2nTUrm4j+cBop6FL1LMKtbXGwslrhjAlpvK2tyiI7oQ+N0QYQVSJtOXpF7qVC
         EkUA==
X-Gm-Message-State: AOAM532GFTJTqf7d44R0DX3XZDatlmpOhcGth8hp9EgeaWSFaU9SuLWF
        /OgylDb+dUMYvk/19i4MyqL9NA==
X-Google-Smtp-Source: ABdhPJxaWkQKHRy5eAGnuxAI4kVzboOgvmSfrlkZLSE9/5OHNPgsC5xZJ2qp6NyzrRB0QnSt+lERWg==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr58432938wrq.626.1638957095995;
        Wed, 08 Dec 2021 01:51:35 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:27b8:d9b2:cac1:a973])
        by smtp.gmail.com with ESMTPSA id d15sm2940100wri.50.2021.12.08.01.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 01:51:35 -0800 (PST)
Date:   Wed, 8 Dec 2021 09:51:33 +0000
From:   Quentin Perret <qperret@google.com>
To:     Andrew Walbran <qwandor@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 06/15] KVM: arm64: Implement kvm_pgtable_hyp_unmap()
 at EL2
Message-ID: <YbCAJZAqUXngvjZ2@google.com>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-7-qperret@google.com>
 <CA+_y_2EEP5tYbBTd17c1wuOeZ2jSfhgu0M2b=CpGKjKRgU-=gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_y_2EEP5tYbBTd17c1wuOeZ2jSfhgu0M2b=CpGKjKRgU-=gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tuesday 07 Dec 2021 at 14:47:14 (+0000), Andrew Walbran wrote:
> On Wed, 1 Dec 2021 at 17:04, 'Quentin Perret' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > From: Will Deacon <will@kernel.org>
> >
> > Implement kvm_pgtable_hyp_unmap() which can be used to remove hypervisor
> > stage-1 mappings at EL2.
> >
> > Signed-off-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h | 21 ++++++++++
> >  arch/arm64/kvm/hyp/pgtable.c         | 63 ++++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 027783829584..9d076f36401d 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -251,6 +251,27 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt);
> >  int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
> >                         enum kvm_pgtable_prot prot);
> >
> > +/**
> > + * kvm_pgtable_hyp_unmap() - Remove a mapping from a hypervisor stage-1 page-table.
> > + * @pgt:       Page-table structure initialised by kvm_pgtable_hyp_init().
> > + * @addr:      Virtual address from which to remove the mapping.
> > + * @size:      Size of the mapping.
> > + *
> > + * The offset of @addr within a page is ignored, @size is rounded-up to
> > + * the next page boundary and @phys is rounded-down to the previous page
> > + * boundary.
> > + *
> > + * TLB invalidation is performed for each page-table entry cleared during the
> > + * unmapping operation and the reference count for the page-table page
> > + * containing the cleared entry is decremented, with unreferenced pages being
> > + * freed. The unmapping operation will stop early if it encounters either an
> > + * invalid page-table entry or a valid block mapping which maps beyond the range
> > + * being unmapped.
> 
> How is the caller expected to break up the block mapping? Why not
> handle that within this function?

We don't really use block mappings for the hyp stage-1, since pretty
much forever (see the loop in pkvm_create_mappings_locked() for ex), so
handling it here would be somewhat unnecessary complexity. Handling this
in the pgtable code itself (which I assume would mean proactively
re-mapping the rest of the range with page-granularity mappings or
something along those lines) is tricky because of BBM and concurrency,
so I'd rather avoid handling same-level aborts at EL2 and all that mess
unless we have a good reason. Is there a use-case where you think that'd
be needed?

Cheers,
Quentin
