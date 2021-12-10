Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256F047031E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbhLJOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbhLJOwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:52:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA24C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:48:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t18so15287634wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XSGjwIt9RpPIjkr6liBZIwGzdNBMMcqErsUs7NKqs3g=;
        b=eFa+/5A+zfMKqzOSVMBePCnsVCvDiruKqK0HXpczVW9xdUh2bI5XBpZykeV00eoyn0
         Ps0U7SIG3EJbM2kI0skWEcTnH6lkua7grTJTjDqX4T8jIuSkNqfqNddprnKjZOHHCBOr
         lAxx8avwGZkdKqJIhrNTAB+UHYQ2NTf1l05If80e5qPJhuhh8x/UU89YQ2EJiE8cor6K
         O1TOpAxYAh0Omdk6QzNXX51mJBiVH5OGAK5U+h85oIkduoyeNxLMk7CK7/LlxQAb6DOz
         9IZqTT8YSfKXYrk4aMHLmYOXa1wCvpRvUVnfICn8/QIi6iSE6JjmwvPvYentz7mJzyTz
         084g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSGjwIt9RpPIjkr6liBZIwGzdNBMMcqErsUs7NKqs3g=;
        b=NG37Bi404MJU1UW8Aex4fR3YFSCeRqkfbCb5n+mL0L6A3foqCFADQPW8f8OG9cdYRH
         vvYU6ZLttWQOqIEP6yV3Cv1I04LmzVgbfTLvTYySKklAGIND7F4rnuJuOgKIFTlhNvBj
         zrRm/1wufJHIDlzUcnmnoGgrsIWd/4ZehdmI8qCyUJaMk6WcH9wEWVVw0Spt59WEb09Z
         52m0woGAohGzcncZZ3q22IPchriwctKHYVLQ39lY+w9t+KaHnRMUc1zdP6/XzNsdh+qQ
         PIfjLPPdVbRTMvurylZhCzuMlpsS+xtZp+FLkfxK7yxUQHxS1utI8Y5xkrprF9oPHtcx
         t2vQ==
X-Gm-Message-State: AOAM530hynT5+Le1qxQS3MkScT3dtSwLtEJ8JPrdDBIlKV5Ak/pTDa83
        3NUappg9BQODXkKgP0feD0NjsA==
X-Google-Smtp-Source: ABdhPJwvEUvtytgXDIUTqN1i7hPX5BX/gnJ9OxL+n5KP+mAtXq7F0bdSrTa2ut2djOds2sajpum1GA==
X-Received: by 2002:adf:a412:: with SMTP id d18mr14714578wra.529.1639147736805;
        Fri, 10 Dec 2021 06:48:56 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:76c1:fb36:1e22:8677])
        by smtp.gmail.com with ESMTPSA id c4sm2669899wrr.37.2021.12.10.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:48:56 -0800 (PST)
Date:   Fri, 10 Dec 2021 14:48:53 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 15/15] KVM: arm64: pkvm: Unshare guest structs during
 teardown
Message-ID: <YbNo1SBn7ZNf89qL@google.com>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-16-qperret@google.com>
 <20211209112233.GD1912@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209112233.GD1912@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 Dec 2021 at 11:22:33 (+0000), Will Deacon wrote:
> On Wed, Dec 01, 2021 at 05:04:09PM +0000, Quentin Perret wrote:
> > Make use of the newly introduced unshare hypercall during guest teardown
> > to unmap guest-related data structures from the hyp stage-1.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  2 ++
> >  arch/arm64/include/asm/kvm_mmu.h  |  1 +
> >  arch/arm64/kvm/arm.c              |  2 ++
> >  arch/arm64/kvm/fpsimd.c           | 34 ++++++++++++++++++++++---
> >  arch/arm64/kvm/mmu.c              | 42 +++++++++++++++++++++++++++++++
> >  arch/arm64/kvm/reset.c            |  8 +++++-
> >  6 files changed, 85 insertions(+), 4 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index d72566896755..8e506ba8988e 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -344,6 +344,32 @@ static int share_pfn_hyp(u64 pfn)
> >  	return ret;
> >  }
> >  
> > +static int unshare_pfn_hyp(u64 pfn)
> > +{
> > +	struct rb_node **node, *parent;
> > +	struct hyp_shared_pfn *this;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&hyp_shared_pfns_lock);
> > +	this = find_shared_pfn(pfn, &node, &parent);
> > +	if (WARN_ON(!this)) {
> > +		ret = -EINVAL;
> 
> -ENOENT?

Sure.

> > +		goto unlock;
> > +	}
> > +
> > +	this->count--;
> > +	if (this->count)
> > +		goto unlock;
> 
> Again, if we did an RCU lookup then this could be converted to a refcount_t
> to take the mutex only when it hits zero. But for now I think it's fine.

No objection to do this in the future, but yeah I think we might as well
start simple :)

> > +
> > +	rb_erase(&this->node, &hyp_shared_pfns);
> > +	kfree(this);
> > +	ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp, pfn, 1);
> > +unlock:
> > +	mutex_unlock(&hyp_shared_pfns_lock);
> > +
> > +	return ret;
> > +}
> > +
> >  int kvm_share_hyp(void *from, void *to)
> >  {
> >  	phys_addr_t start, end, cur;
> > @@ -376,6 +402,22 @@ int kvm_share_hyp(void *from, void *to)
> >  	return 0;
> >  }
> >  
> > +void kvm_unshare_hyp(void *from, void *to)
> > +{
> > +	phys_addr_t start, end, cur;
> > +	u64 pfn;
> > +
> > +	if (is_kernel_in_hyp_mode() || kvm_host_owns_hyp_mappings() || !from)
> 
> I don't think you need the is_kernel_in_hyp_mode() check any more not that
> you've moved that into kvm_host_owns_hyp_mappings().

The logic is a little odd, but I think I still do as
kvm_host_owns_hyp_mappings() will return false if is_kernel_in_hyp_mode()
is true.
