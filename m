Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1224B29F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351091AbiBKQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:16:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbiBKQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:16:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE8B70
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:16:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y9so8531660pjf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKrit6f1ZhoCBVqw3r076zw40XfZbFZ96sRHFdOuik8=;
        b=FMITympTyB4cxAdAJLed/W53mGKN/3NHq1jFRdxfurhodPtGBFlft8BTrukwBpuCfu
         KMkxE+xw4PnMbSEBJFU4w1dW2pxj7l6TJr1XAyxYC+2IfZjA6r3/SSJpGXmINmPPpBsN
         LOT0ufqNBQgZuvDr4tp6QtaPiUCjPv//mv2zx3UFDXSv13C0WMlrqGbN5b1naRQlAPyS
         TE8nij9lYk92KfPQeFAnibxrihgIAWHfNWQY5Oi8Iy+YggCZokb8WdcaxHzZseiqo2zo
         md27CAHY1XV4WUGfesGoXAtwiB33MCylqYqZCuJsWoWz9nT+nP4H2gpy9I5TXpRFZcaY
         uOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKrit6f1ZhoCBVqw3r076zw40XfZbFZ96sRHFdOuik8=;
        b=d5MNaG5zf2XjYvgbxRcwJCn+VgEEGRvIld9+iWFrn/oC4KNt7cyjqonBiBZpK8wcw1
         cNTT8+wTqqRWS5SP2Zjr1kXoTLL6+6cxkbI78ezBk3clC6dFjd2ei98mUL/OMelDszoP
         cR30B3Zr2sgGxEIMUaOm3wcMdg2Am8KvPRGbG1DKnYdHV4CUoGURL5ieCOP4d98oGfxz
         E4eRwBqT/epluBXB6DvcGur8eEf3eao9rK/HNbFKzL3uv1PhFG7msPPXrn1gUABl6gLN
         RdimPJCm3mZZEOOemGY72V6zXYjFVFNY7RvtWIPu6LjkyrpNGdpXPZWIy70hX9XJLp+N
         pMiw==
X-Gm-Message-State: AOAM531mNYrt5F8qe7irF048v2zIGPsrAJ7VpsrtiHHR34UfjbFpcfaT
        ecrQtmXi/F++CUejdPHVlvKuIkWt5vQnkQ==
X-Google-Smtp-Source: ABdhPJyqGYLnBNu+H8/gpBo2EeOE7b86nFUYoNTSLZ+1Xo8/LqsVf93PHnoOnvHRWNRDEgg7nNvk5A==
X-Received: by 2002:a17:90b:38c9:: with SMTP id nn9mr1130824pjb.47.1644596166187;
        Fri, 11 Feb 2022 08:16:06 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d15sm27969915pfu.72.2022.02.11.08.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:16:05 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:16:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
Subject: Re: [PATCH 06/12] KVM: MMU: rename kvm_mmu_reload
Message-ID: <YgaLwvo2Gl565H3/@google.com>
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-7-pbonzini@redhat.com>
 <YgWtdUotsoBOOtXz@google.com>
 <4e05cfc5-55bb-1273-5309-46ed4fe52fed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e05cfc5-55bb-1273-5309-46ed4fe52fed@redhat.com>
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

On Fri, Feb 11, 2022, Paolo Bonzini wrote:
> On 2/11/22 01:27, Sean Christopherson wrote:
> > On Wed, Feb 09, 2022, Paolo Bonzini wrote:
> > > The name of kvm_mmu_reload is very confusing for two reasons:
> > > first, KVM_REQ_MMU_RELOAD actually does not call it; second,
> > > it only does anything if there is no valid root.
> > > 
> > > Rename it to kvm_mmu_ensure_valid_root, which matches the actual
> > > behavior better.
> > 
> > 100% agree that kvm_mmu_reload() is a terrible name, but kvm_mmu_ensure_valid_root()
> > isn't much better, e.g. it sounds like a sanity check and nothing more.
> 
> I would have thought that would be more of a check_valid_root().  There are
> other functions in the kernel following the idea that "ensure" means
> idempotency: skb_ensure_writable, perf_cgroup_ensure_storage,
> btf_ensure_modifiable and libbpf_ensure_mem in libbpf.  I'm not a native
> speaker but, at least in computing, "ensure" seems to mean not just "to make
> certain that (something) will be true", but also taking steps if that's not
> already the case.

There's no ambiguity on the "make certain that <x> will be true", it's the second
part about taking steps that's ambiguous.  Specifically, it doesn't convey any
information about _what_ steps will be taken, e.g. the below implementation is
also a possibility since it ensures the root is valid by preventing forward
progress if the root is invalid.

  static inline int kvm_mmu_ensure_valid_root(struct kvm_vcpu *vcpu)
  { 
	if (unlikely(vcpu->arch.mmu->root.hpa != INVALID_PAGE))
		return -EFAULT;
	return 0;
  }

Existing example of that interpretation are input_dev_ensure_poller() and
rtnl_ensure_unique_netns().

The other nuance that I want to avoid is the implication that KVM is checking for
a valid root because it doesn't trust what has happened before, i.e. that the call
is there as a safeguard.  That's misleading for the most common path, vcpu_enter_guest(),
because when the helper does do some work, it's usually because KVM deliberately
invalidated the root.


> I also thought of "establish_valid_root", but it has the opposite
> problem---it does not convey well, if at all, that the root could be valid
> already.

Heh, I agree that "establish" would imply the root is always invalid, but amusingly
"establish" is listed as a synonym for "ensure" on the few sites of checked. Yay English.  

I was going to suggest we just open code it in vcpu_enter_guest, but async #PF
uses it too :-/

Can we put this on the backburner for now?  IMO, KVM_REQ_MMU_RELOAD is far more
misleading than kvm_mmu_reload(), and I posted a series to remedy that (though I
need to check if it's still viable since you vetoed adding the check for a pending
request in the page fault handler).

https://lore.kernel.org/all/20211209060552.2956723-1-seanjc@google.com
