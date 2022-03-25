Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0054E7223
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355760AbiCYL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiCYL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C94A70CF0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648207627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxKFEDtkVHDp152TUqHwV7Qynzuw7D2VF2jr802SS7Q=;
        b=eGwnJZJl3nDl/l+GagqjGfqgyCW1sGnoKry9Et9lwfsDqH2ZwRMjKXnkgbSfoAfrNjI0T3
        r5zMZLOksjeZAStC6w4DIFllkGYSCrxIpFL2UsE7IY+QmTEm81GqJWvkJlWVt8X2Ux9el9
        YFp2ha8wJhc/dQ6cOvPt7bjxwdceWUw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-2xk_WrfuMyyccUwkDZI8ZQ-1; Fri, 25 Mar 2022 07:27:05 -0400
X-MC-Unique: 2xk_WrfuMyyccUwkDZI8ZQ-1
Received: by mail-ej1-f72.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso3925627eje.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sxKFEDtkVHDp152TUqHwV7Qynzuw7D2VF2jr802SS7Q=;
        b=GnxCtp5Ga0KevnQAcrxEDpjx2UeSS2zp3qJJX7W8604AEsdbaM6kQDzF8GqbJGcWbp
         ZQcqI7afQnhrH+1CVYiW2cH+bLO43CEmuux4Ti7AGybRks0hf+EaZ8C1iQnhVXsFzE8g
         63+670iboitqaf6uzA8vn2675jt7vR+t6L0wyO3kzFfAGGT/dXRK47r4v03FgleBI3oy
         IpY7vLxk6IQm6ONOm+8chQ6Wp/9UXUHq6QaBk3wSHi13yHcQ1kCSdo9RwcO+8OvgfJnZ
         4ySN+5lYZ9PDWxtYfOLhSeWvrPlYFAEG2SnW/NMjjoBaQYm+WwzlW3HZj9OPubPabXIM
         v00A==
X-Gm-Message-State: AOAM530dZMka8XOBwtiu1a4CCEkIqsa0D/Estgm2Y0p8PRP4GDF0VdAx
        rV8wpkPf+IjlqaNzGApzM/wxnlzLMz4FKxOY8CPMX4sa+m+iumAb6sCi9iFeBUTsB6Bqq3Tgeul
        R0au4xrX+6O6oWGxDKi5Jekd/
X-Received: by 2002:a17:906:4ad0:b0:6e0:12aa:a911 with SMTP id u16-20020a1709064ad000b006e012aaa911mr11177145ejt.455.1648207624526;
        Fri, 25 Mar 2022 04:27:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdxZ6Dd1obUVVjmdWCRsGy/xGG5OGJ84RjwzSYKCiseyMLFhRU7VOvhU2RHoakRMd321PrXw==
X-Received: by 2002:a17:906:4ad0:b0:6e0:12aa:a911 with SMTP id u16-20020a1709064ad000b006e012aaa911mr11177120ejt.455.1648207624243;
        Fri, 25 Mar 2022 04:27:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id bm23-20020a170906c05700b006d597fd51c6sm2254888ejb.145.2022.03.25.04.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 04:27:03 -0700 (PDT)
Message-ID: <c7309380-c7d5-419d-6ba5-25d3243c469b@redhat.com>
Date:   Fri, 25 Mar 2022 12:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86/mmu: Don't rebuild page when the page is synced
 and no tlb flushing is required
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
References: <0dabeeb789f57b0d793f85d073893063e692032d.1647336064.git.houwenlong.hwl@antgroup.com>
 <YjzRwDSPQNbpTrZ9@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YjzRwDSPQNbpTrZ9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 21:17, Sean Christopherson wrote:
>> +static int kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>>   			 struct list_head *invalid_list)
>>   {
>>   	int ret = vcpu->arch.mmu->sync_page(vcpu, sp);
>>   
>> -	if (ret < 0) {
>> +	if (ret < 0)
>>   		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
>> -		return false;
>> -	}
>> -
>> -	return !!ret;
>> +	return ret;
> Hrm, this creates an oddity in mmu_sync_children(), which does a logical-OR of
> the result into a boolean.  It doesn't actually change the functionality since
> kvm_mmu_remote_flush_or_zap() will prioritize invalid_list, but it's weird.
> 
> What about checking invalid_list directly and keeping the boolean return?  Compile
> tested only.

It's even better to check

         flush |= kvm_sync_page(vcpu, sp, &invalid_list) > 0;

in mmu_sync_children.  If the returned value is <0, then the page is 
added to invalid_list and there is no need to set flush = true, just 
like there is no need to call kvm_flush_remote_tlbs() in kvm_mmu_get_page().

Paolo

