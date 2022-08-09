Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B258DA84
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbiHIOsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiHIOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61B071B7B4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660056496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oU5hbTiZoyPEOUOTlvaBL3H9N6EhZuMpbA02nDl58AY=;
        b=bB04aJRq7dSZK49xiejbLEFBxbw4l3t79tGuXxDdzRptw3HuN1rlOZ10xtXj43VOhqPBlk
        cvQOs6Z0gmRiyygC7SXbsfDUiw9G9VjcGgFyWbfhzp5jUQux0d7DcdGNhFfFZZfTTWyFux
        bRAc/OAlHjd/WT47S4qcyJhDRqq2GaQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-NjGeBsX6PpWhXZvwa7uiXQ-1; Tue, 09 Aug 2022 10:48:15 -0400
X-MC-Unique: NjGeBsX6PpWhXZvwa7uiXQ-1
Received: by mail-ed1-f70.google.com with SMTP id s21-20020a056402521500b00440e91f30easo2216844edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 07:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oU5hbTiZoyPEOUOTlvaBL3H9N6EhZuMpbA02nDl58AY=;
        b=sOQ9pActqyuMSPjbyAO+LNASJLmtbc1nl6RR4Wp4agTI/xV36+a7o4b6gt6+ajCbpJ
         xP6fJVrmvPrkif5yX99Af4urmorM7hXktxyrsxYunmKwIfCc7JF8cr6hTrnz8ZZeduNh
         QqDRIRPFX8RVsukHQpEdBkwLzRFFPoNNv6rpZxsbbY4GSJmMXjUdKkBBe2OB1gLedhRK
         Ijp1uhihmRU98gk8r2MjVqsRiOVyZSCN5od8beHjIHWYYl4xojeNTAXzN4xFbZ8OELfp
         dIY5IId+fTqcagkx7iT6OmFzjDnOvlapGj7VFwfmDKgWzcwPIicMOxBCZHbkg4SnLtUw
         JvFA==
X-Gm-Message-State: ACgBeo0ly2jt4gUMtH3kGbFUZxHF1D9Rg2Y/glFz+IWbOeaLto7uQ2IX
        +g3qcF2EC2e+zF9y9Zi1LIWmCQv6QFgRtP7eIZaKOawO4SSI7SaUKsPd+LQR17Jnm8Arts+lhNg
        K1UVjvy9IRbPDaFmveEROhsyR
X-Received: by 2002:a05:6402:f22:b0:43e:8623:d32c with SMTP id i34-20020a0564020f2200b0043e8623d32cmr22714481eda.265.1660056493990;
        Tue, 09 Aug 2022 07:48:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xQ8Lh7X+ZFz0AifFd1gpD6L8dgNsLdDFMZwpfscudWV+4b7wKv+k9Mx6iQ4LmBiUHfNHFIQ==
X-Received: by 2002:a05:6402:f22:b0:43e:8623:d32c with SMTP id i34-20020a0564020f2200b0043e8623d32cmr22714469eda.265.1660056493743;
        Tue, 09 Aug 2022 07:48:13 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id n25-20020a17090695d900b007305c007e43sm1210713ejy.135.2022.08.09.07.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 07:48:13 -0700 (PDT)
Message-ID: <c976a6e6-963e-d076-053b-15e381c3800a@redhat.com>
Date:   Tue, 9 Aug 2022 16:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 5/8] KVM: x86/mmu: Set disallowed_nx_huge_page in TDP
 MMU before setting SPTE
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ben Gardon <bgardon@google.com>
References: <20220805230513.148869-1-seanjc@google.com>
 <20220805230513.148869-6-seanjc@google.com>
 <YvHT0dA0BGgCQ8L+@yzhao56-desk.sh.intel.com>
 <331dc774-c662-9475-1175-725cb2382bb2@redhat.com>
 <YvJyw96QZdf6YPAX@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YvJyw96QZdf6YPAX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 16:44, Sean Christopherson wrote:
> On Tue, Aug 09, 2022, Paolo Bonzini wrote:
>> On 8/9/22 05:26, Yan Zhao wrote:
>>> hi Sean,
>>>
>>> I understand this smp_rmb() is intended to prevent the reading of
>>> p->nx_huge_page_disallowed from happening before it's set to true in
>>> kvm_tdp_mmu_map(). Is this understanding right?
>>>
>>> If it's true, then do we also need the smp_rmb() for read of sp->gfn in
>>> handle_removed_pt()? (or maybe for other fields in sp in other places?)
>>
>> No, in that case the barrier is provided by rcu_dereference().  In fact, I
>> am not sure the barriers are needed in this patch either (but the comments
>> are :)):
> 
> Yeah, I'm 99% certain the barriers aren't strictly required, but I didn't love the
> idea of depending on other implementation details for the barriers.  Of course I
> completely overlooked the fact that all other sp fields would need the same
> barriers...
> 
>> - the write barrier is certainly not needed because it is implicit in
>> tdp_mmu_set_spte_atomic's cmpxchg64
>>
>> - the read barrier _should_ also be provided by rcu_dereference(pt), but I'm
>> not 100% sure about that. The reasoning is that you have
>>
>> (1)	iter->old spte = READ_ONCE(*rcu_dereference(iter->sptep));
>> 	...
>> (2)	tdp_ptep_t pt = spte_to_child_pt(old_spte, level);
>> (3)	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(pt));
>> 	...
>> (4)	if (sp->nx_huge_page_disallowed) {
>>
>> and (4) is definitely ordered after (1) thanks to the READ_ONCE hidden
>> within (3) and the data dependency from old_spte to sp.
> 
> Yes, I think that's correct.  Callers must verify the SPTE is present before getting
> the associated child shadow page.  KVM does have instances where a shadow page is
> retrieved from the SPTE _pointer_, but that's the parent shadow page, i.e. isn't
> guarded by the SPTE being present.
> 
> 	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
> 
> Something like this is as a separate patch?

Would you resubmit without the memory barriers then?

> diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
> index f0af385c56e0..9d982ccf4567 100644
> --- a/arch/x86/kvm/mmu/tdp_iter.h
> +++ b/arch/x86/kvm/mmu/tdp_iter.h
> @@ -13,6 +13,12 @@
>    * to be zapped while holding mmu_lock for read, and to allow TLB flushes to be
>    * batched without having to collect the list of zapped SPs.  Flows that can
>    * remove SPs must service pending TLB flushes prior to dropping RCU protection.
> + *
> + * The READ_ONCE() ensures that, if the SPTE points at a child shadow page, all
> + * fields in struct kvm_mmu_page will be read after the caller observes the
> + * present SPTE (KVM must check that the SPTE is present before following the
> + * SPTE's pfn to its associated shadow page).  Pairs with the implicit memory

I guess you mean both the shadow page table itself and the struct 
kvm_mmu_page?  Or do you think to_shadow_page() should have a smp_rmb()?

Paolo

