Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38854FC420
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349162AbiDKSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbiDKSff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:35:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0A92B0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:33:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso150316pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pKHcrKxjVBtrp4SSvxMbd0OqRyEIso/X6CPIJZBhm7w=;
        b=EDAt+PRYKtGeBsZg3ywwi7TgejNiKcOENX6u3+MIwXd5ZUGubKsYXy58cIQpHqT14V
         4PMudmo6PDjAyKKph0YkecIdZ3S6zzlXVQqa4xMrkjGFLkK/OiFdr9QbFH5RL3ddK0Hl
         xU9GQez2PJAX6nqmxdGXeBJ6gBlVeFWthqpwr+SmvP1bgTdDRn+U6/AXk64HyzayNcu4
         u+XT/Xk/lLOsMKU0q3Ag3LDptNijejcRcgEGS8aB6K+SozTIJ1BHqQ9rDzpu4co7wF1z
         1swdyzxLyIM2vabKDmAK4ti8fkTFl20fOP7HIDyMKaqNxruTtqoAPqpoO7SuZFJF39y8
         KFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pKHcrKxjVBtrp4SSvxMbd0OqRyEIso/X6CPIJZBhm7w=;
        b=nQsH3Kd6Jzi0MDXC897KE587SJJi6THYNhwt1vEGaOjK7KZ0NuwhSpn0u0J55NfBF7
         OdB+aoDDlJsAMW8jY+6e4eI2oq+Y1D/q6Y2F6ly5O+/nKu9fWnngtxgPYhOn+rIngapD
         hW2eHYTc6vcmhkA6jfLZAgkQktqzx8M1Tzo3bcVYG6dop0uSsgUzM/BscMlUBd4FK/dK
         QKa1Zg9vvfvF1jM0JKshA7kvKm7sMh/xRQZfgujI4FsEMqxYlIf1uS3Jq3UH8/g/XWwI
         r4JqKTiB+aiVsMz3YshraXanWGMX/AJVULyO6SXG3HCXjwifq9rbh0FnE02aJfbfOgfg
         /aCg==
X-Gm-Message-State: AOAM530Y7pDVWaWhZz45QjUyIFEvP2D8QYOF6OV6eyKrfbghVWPDKxGh
        oGO8YsnJa1zXUb4TzVu6oKFFyw==
X-Google-Smtp-Source: ABdhPJzI44uplT0Xftmm9vue7Q5rcTEg6DZVfpQdoP0/PHu496Ej9svyCCxQQK810UiZxX6zXoGtbQ==
X-Received: by 2002:a17:90b:314b:b0:1c7:4a4f:6740 with SMTP id ip11-20020a17090b314b00b001c74a4f6740mr534298pjb.145.1649702000010;
        Mon, 11 Apr 2022 11:33:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00170d00b004fb1450229bsm38219057pfc.16.2022.04.11.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 11:33:19 -0700 (PDT)
Date:   Mon, 11 Apr 2022 18:33:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] KVM: x86/mmu: Properly account NX huge page
 workaround for nonpaging MMUs
Message-ID: <YlR0a4PG5xzweeMZ@google.com>
References: <20220409003847.819686-1-seanjc@google.com>
 <20220409003847.819686-3-seanjc@google.com>
 <YlRn+8bYsHqNIbTU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlRn+8bYsHqNIbTU@google.com>
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

On Mon, Apr 11, 2022, Mingwei Zhang wrote:
> On Sat, Apr 09, 2022, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> > index 671cfeccf04e..89df062d5921 100644
> > --- a/arch/x86/kvm/mmu.h
> > +++ b/arch/x86/kvm/mmu.h
> > @@ -191,6 +191,15 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  		.user = err & PFERR_USER_MASK,
> >  		.prefetch = prefetch,
> >  		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
> > +
> > +		/*
> > +		 * Note, enforcing the NX huge page mitigation for nonpaging
> > +		 * MMUs (shadow paging, CR0.PG=0 in the guest) is completely
> > +		 * unnecessary.  The guest doesn't have any page tables to
> > +		 * abuse and is guaranteed to switch to a different MMU when
> > +		 * CR0.PG is toggled on (may not always be guaranteed when KVM
> > +		 * is using TDP).  See make_spte() for details.
> > +		 */
> >  		.nx_huge_page_workaround_enabled = is_nx_huge_page_enabled(),
> 
> hmm. I think there could be a minor issue here (even in original code).
> The nx_huge_page_workaround_enabled is attached here with page fault.
> However, at the time of make_spte(), we call is_nx_huge_page_enabled()
> again. Since this function will directly check the module parameter,
> there might be a race condition here. eg., at the time of page fault,
> the workround was 'true', while by the time we reach make_spte(), the
> parameter was set to 'false'.

Toggling the mitigation invalidates and zaps all roots.  Any page fault acquires
mmu_lock after the toggling is guaranteed to see the correct value, any page fault
that completed before kvm_mmu_zap_all_fast() is guaranteed to be zapped.

> I have not figured out what the side effect is. But I feel like the
> make_spte() should just follow the information in kvm_page_fault instead
> of directly querying the global config.

I started down this exact path :-)  The problem is that, even without Ben's series,
KVM uses make_spte() for things other than page faults.
