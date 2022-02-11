Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C84B1AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346661AbiBKBH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:07:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiBKBH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:07:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E64F1DD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644541675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDVHHrY9xo1r6ZZ6WJj8B5leZYq7F6dN/3araFVGutk=;
        b=YWe8axRv2cqcslzhfhM8GtusKhJ9go+0ZcbovGnPzJXJiDK1N8+PzYtPgkvij/ImvFctPP
        xcqmO/4hB+Sh257oixx6/XCrXfBKKP8KA0VYPDlpbIY6wdxXv5Av9BzMstI0/qU07GTy5f
        gkdZkf27j0yZL+OKzHPBFdYIJ6TOoHk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-gAk2P9FcO8mX-ZKtfIT8xA-1; Thu, 10 Feb 2022 20:07:54 -0500
X-MC-Unique: gAk2P9FcO8mX-ZKtfIT8xA-1
Received: by mail-ej1-f70.google.com with SMTP id z26-20020a1709067e5a00b006cbe0628826so3471176ejr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZDVHHrY9xo1r6ZZ6WJj8B5leZYq7F6dN/3araFVGutk=;
        b=7AGRyvvL+UcBYXyCZ3uVxm9CwlCaFiO0uujZnaI81xEJNJdNLwypqJXs7Ek2GaGwJ2
         xNh5KgbpH8hrvF06LdUQIRuulcGQgDLGuUoyQZmiCo9wr6McC3DiO2EIQvnRZAnS54KM
         hqejEfaMym/SdvcpT1YqDG0xRS1Y3dT0msecUsz49EJ2Hc+uIOHlh4MUy9BdAAFtdY0W
         Xq25WjEilNTCSo7eVwe81XLno9UV5YFpfHcY4/xUaktiDUbCBxFVasRQawp7DcjwZiUu
         b/XrfzldnyW17OFucPJwq/xsYu1yNsSjBD39oEjDuyA571QP/2/lKV7eNOisbnSRgxU1
         8jcQ==
X-Gm-Message-State: AOAM532OftfKq2JolxEazq57W7poUYMdTMl9kHQRt9iDRWYIcDJK7Nw3
        oEUS5Ffcrs2VMttlpss5f7gJXBZv+52AsAuofKv53HUloCYlG6iI3zDB0Q8L4JimYWqBLvMYxPa
        pmpRP2hdef3Wsg8QoVf9z6ruG
X-Received: by 2002:a17:907:86a1:: with SMTP id qa33mr8488222ejc.516.1644541673401;
        Thu, 10 Feb 2022 17:07:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSlzz3TMDlNsCAaoChAOVRHHOe5lEaVtJsuAw4HbCPLbCmSAlvLKA86LekCaFE8Bvv8IjcAQ==
X-Received: by 2002:a17:907:86a1:: with SMTP id qa33mr8488209ejc.516.1644541673177;
        Thu, 10 Feb 2022 17:07:53 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id ed11sm5812649edb.81.2022.02.10.17.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 17:07:52 -0800 (PST)
Message-ID: <ba9e1a56-f769-01c1-607f-3630a62a1b5d@redhat.com>
Date:   Fri, 11 Feb 2022 02:07:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 08/12] KVM: MMU: do not consult levels when freeing roots
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-9-pbonzini@redhat.com> <YgWwrG+EQgTwyt8v@google.com>
 <YgWzyBbAZe89ljqO@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YgWzyBbAZe89ljqO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 01:54, Sean Christopherson wrote:
> On Fri, Feb 11, 2022, Sean Christopherson wrote:
>> On Wed, Feb 09, 2022, Paolo Bonzini wrote:
>>> Right now, PGD caching requires a complicated dance of first computing
>>> the MMU role and passing it to __kvm_mmu_new_pgd, and then separately calling
>>
>> Nit, adding () after function names helps readers easily recognize when you're
>> taking about a specific function, e.g. as opposed to a concept or whatever.
>>
>>> kvm_init_mmu.
>>>
>>> Part of this is due to kvm_mmu_free_roots using mmu->root_level and
>>> mmu->shadow_root_level to distinguish whether the page table uses a single
>>> root or 4 PAE roots.  Because kvm_init_mmu can overwrite mmu->root_level,
>>> kvm_mmu_free_roots must be called before kvm_init_mmu.
>>>
>>> However, even after kvm_init_mmu there is a way to detect whether the page table
>>> has a single root or four, because the pae_root does not have an associated
>>> struct kvm_mmu_page.
>>
>> Suggest a reword on the final paragraph, because there's a discrepancy with the
>> code (which handles 0, 1, or 4 "roots", versus just "single or four").
>>
>>    However, even after kvm_init_mmu() there is a way to detect whether the
>>    page table may hold PAE roots, as root.hpa isn't backed by a shadow when
>>    it points at PAE roots.
>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   arch/x86/kvm/mmu/mmu.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>>> index 3c3f597ea00d..95d0fa0bb876 100644
>>> --- a/arch/x86/kvm/mmu/mmu.c
>>> +++ b/arch/x86/kvm/mmu/mmu.c
>>> @@ -3219,12 +3219,15 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>>>   	struct kvm *kvm = vcpu->kvm;
>>>   	int i;
>>>   	LIST_HEAD(invalid_list);
>>> -	bool free_active_root = roots_to_free & KVM_MMU_ROOT_CURRENT;
>>> +	bool free_active_root;
>>>   
>>>   	BUILD_BUG_ON(KVM_MMU_NUM_PREV_ROOTS >= BITS_PER_LONG);
>>>   
>>>   	/* Before acquiring the MMU lock, see if we need to do any real work. */
>>> -	if (!(free_active_root && VALID_PAGE(mmu->root.hpa))) {
>>> +	free_active_root = (roots_to_free & KVM_MMU_ROOT_CURRENT)
>>> +		&& VALID_PAGE(mmu->root.hpa);
>>
>> 	free_active_root = (roots_to_free & KVM_MMU_ROOT_CURRENT) &&
>> 			   VALID_PAGE(mmu->root.hpa);
>>
>> Isn't this a separate bug fix?  E.g. call kvm_mmu_unload() without a valid current
>> root, but with valid previous roots?  In which case we'd try to free garbage, no?

mmu_free_root_page checks VALID_PAGE(*root_hpa).  If that's what you 
meant, then it wouldn't be a preexisting bug (and I think it'd be a 
fairly common case).

>>> +
>>> +	if (!free_active_root) {
>>>   		for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
>>>   			if ((roots_to_free & KVM_MMU_ROOT_PREVIOUS(i)) &&
>>>   			    VALID_PAGE(mmu->prev_roots[i].hpa))
>>> @@ -3242,8 +3245,7 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>>>   					   &invalid_list);
>>>   
>>>   	if (free_active_root) {
>>> -		if (mmu->shadow_root_level >= PT64_ROOT_4LEVEL &&
>>> -		    (mmu->root_level >= PT64_ROOT_4LEVEL || mmu->direct_map)) {
>>> +		if (to_shadow_page(mmu->root.hpa)) {
>>>   			mmu_free_root_page(kvm, &mmu->root.hpa, &invalid_list);
>>>   		} else if (mmu->pae_root) {
> 
> Gah, this is technically wrong.  It shouldn't truly matter, but it's wrong.  root.hpa
> will not be backed by shadow page if the root is pml4_root or pml5_root, in which
> case freeing the PAE root is wrong.  They should obviously be invalid already, but
> it's a little confusing because KVM wanders down a path that may not be relevant
> to the current mode.

pml4_root and pml5_root are dummy, and the first "real" level of page 
tables is stored in pae_root for that case too, so I think that should DTRT.

That's why I also disliked the shadow_root_level/root_level/direct 
check: even though there's half a dozen of cases involved, they all boil 
down to either 4 pae_roots or a single root with a backing kvm_mmu_page.

It's even more obscure to check shadow_root_level/root_level/direct in 
fast_pgd_switch, where it's pretty obvious that you cannot cache 4 
pae_roots in a single (hpa, pgd) pair...

Paolo

