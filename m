Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471884702F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbhLJOlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbhLJOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:41:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402BC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:37:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i12so6976101wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iT+nRlkqP8ujdkhR1yHcmqTSB9Hb9nBGvw1m1PwYrU4=;
        b=LJW+Qg/MN2vlQ4hC5d84O4HWpmjzzbl+hwt4dYAELPT880hHpRFAZikcPqMVDWcaW5
         JtAe4D8wz5kZWyjyAB/+4xUZrgpNpozYFtRRLLKkMoU6/EmouGTvY6FPkA77kQoyvs/v
         aFr3sL11apWy0rCQjdfNzXf7eDGBYaG1f36x9tlciYdd8W99tguVUtOddHdFZoXklmgR
         9YEkIUxD3OWUv4I+T0ggbI7kTKXI2RtL7uOBPtbJhCb7AGimn/5ScmHknajg8CHl0fKD
         arVUYOpYX5UgcPQV8y9cCLcRZwdZQQrt5Sny0Bc2WwyHMnHoqBa3R++EnZ4LEG0SoY/p
         xrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iT+nRlkqP8ujdkhR1yHcmqTSB9Hb9nBGvw1m1PwYrU4=;
        b=c0lPH0vd5j738rI2Y3u0X7fbrKnLMAn2pIbfV60i+cc9bJcT9rI9KjcdmZXzIxremJ
         EW1vsIQ5SWVfl5dNdm0XWzVOai5YtjVdpSkD+VlBOhkIYvssqLdYAhStjY5EGA3cgycJ
         gMymheBPUwpkyBOpCdIo2zDuez3kg3gRil+JNHxtOJU42hXKNO/j5jYONEB7cb8ZKi9+
         KOfydVi6TdyGhFC/ojSULzE8lOsHU0TTahWhanyx960Cwwod3obT74Xx/F5o8OImw+e8
         a0wf13VFA/SlnCWYdJRuJ2AuDtaonv64PN5WlQYRH2Ri/qUD8dK0gYkgkK1EfsaWga2+
         qI+A==
X-Gm-Message-State: AOAM531CM/knrmiYbo5NHo2NRA3TNlh4znsCQPng2TPX6Fja97UNRgG6
        tG/avxDIh/ZHtfV0yZ6MBi/dog==
X-Google-Smtp-Source: ABdhPJzpmKQ+A4NRlPF6u1SVizDawCpgts4j/A6org/QHTlhW19yx/bTp0VUSDuxuLTJUFIurktC1A==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr17315115wmk.135.1639147044652;
        Fri, 10 Dec 2021 06:37:24 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:76c1:fb36:1e22:8677])
        by smtp.gmail.com with ESMTPSA id g5sm3758412wri.45.2021.12.10.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:37:24 -0800 (PST)
Date:   Fri, 10 Dec 2021 14:37:21 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 07/15] KVM: arm64: Introduce kvm_share_hyp()
Message-ID: <YbNmIfeRdgaQNf+l@google.com>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-8-qperret@google.com>
 <20211209111309.GB1912@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209111309.GB1912@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 Dec 2021 at 11:13:10 (+0000), Will Deacon wrote:
> On Wed, Dec 01, 2021 at 05:04:01PM +0000, Quentin Perret wrote:
> > The create_hyp_mappings() function can currently be called at any point
> > in time. However, its behaviour in protected mode changes widely
> > depending on when it is being called. Prior to KVM init, it is used to
> > create the temporary page-table used to bring-up the hypervisor, and
> > later on it is transparently turned into a 'share' hypercall when the
> > kernel has lost control over the hypervisor stage-1. In order to prepare
> > the ground for also unsharing pages with the hypervisor during guest
> > teardown, introduce a kvm_share_hyp() function to make it clear in which
> > places a share hypercall should be expected, as we will soon need a
> > matching unshare hypercall in all those places.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_mmu.h |  1 +
> >  arch/arm64/kvm/arm.c             |  4 ++--
> >  arch/arm64/kvm/fpsimd.c          |  2 +-
> >  arch/arm64/kvm/mmu.c             | 27 +++++++++++++++++++++------
> >  arch/arm64/kvm/reset.c           |  2 +-
> >  5 files changed, 26 insertions(+), 10 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index f8f1096a297f..fd868fb9d922 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -299,6 +299,25 @@ static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
> >  	return 0;
> >  }
> >  
> > +int kvm_share_hyp(void *from, void *to)
> > +{
> > +	if (is_kernel_in_hyp_mode())
> > +		return 0;
> > +
> > +	/*
> > +	 * The share hcall maps things in the 'fixed-offset' region of the hyp
> > +	 * VA space, so we can only share physically contiguous data-structures
> > +	 * for now.
> > +	 */
> > +	if (is_vmalloc_addr(from) || is_vmalloc_addr(to))
> > +		return -EINVAL;
> 
> If we're adding these sanity checks, perhaps is_vmalloc_or_module_addr()
> would be worth using instead?

Ack, I'll fix that up.
