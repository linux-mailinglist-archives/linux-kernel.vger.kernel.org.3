Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5020E4ED70C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiCaJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiCaJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EEBAA94CB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648719281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4I67CcKiPUobplhi0H/iEbbjb5B4T/bEaOV1iH1XyI=;
        b=Q7ZGzN6YChX2745cuj2B2d7WMQZR4aeUOEUsZQ6CfUCjwF5BVbsd2VfXcBMT7PzGyDOXwN
        exDc5M+J0xV9Q1FAu/VkZC5pO9QuwtE7xjNQENGtDNQOkJUJRHCwgn7u+wKDjcgqzDk5f+
        UL0lj1RCowLFd8Z459VUCAMqB7AEsJE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-NvcI1196Nwqcw03NahSbCQ-1; Thu, 31 Mar 2022 05:34:39 -0400
X-MC-Unique: NvcI1196Nwqcw03NahSbCQ-1
Received: by mail-ed1-f72.google.com with SMTP id s9-20020a50d489000000b00418d556edbdso14600608edi.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4I67CcKiPUobplhi0H/iEbbjb5B4T/bEaOV1iH1XyI=;
        b=0Z31OYs9/xyYjCeYV6Ph2Ytq8GTTaS3ZLTxwnN4d/FJI7vg78WNMq/s9J5dd8iJuEt
         UCUXh7PdRbb1TfUCDlj7C1NEkJayslknFg9K+FKvkSnzlg+SYVRYMHbBSW+sy2Ftw/BT
         b06jWE9RUjnBPEiftS6IGguXNjvSCXRCDWW20WjQ1wY94vjEfUvCzPyIEYfvccZ6mVE6
         FscvrO35QEDd9aAj0RoQMzCKPOsZ46JIqtnm53TLoGTHZx/kzDBSR86olx1N0zGf6155
         o0GZa3ojqsJcN9D8umjb3FmIsgy6Nx2btB/YqSzXLp+I1STZcmgsRAmwTcRJdiaZbIpm
         6RCQ==
X-Gm-Message-State: AOAM5318qHPr0s9hEzhWzyI/UGcHMdnvuoKBOsblMhmDYEZ+rt0XuUGf
        bDAWhYl7n98uuz762+iAE3Au/yCxSlodHZkbi88NdPCjDeji4JzVUtd7gC8bVuVRuISFEgbs2O8
        dcfA3sVrgoVMOXX3fG+stdb+a
X-Received: by 2002:a17:907:8690:b0:6da:8436:2b94 with SMTP id qa16-20020a170907869000b006da84362b94mr4216995ejc.33.1648719278050;
        Thu, 31 Mar 2022 02:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmm5TucDYC0IjZ8wd1Hy41fioPOMEJ4xib5m76/cqdidZM+ZlL/DDuWUQ92fIGN689dzwERg==
X-Received: by 2002:a17:907:8690:b0:6da:8436:2b94 with SMTP id qa16-20020a170907869000b006da84362b94mr4216982ejc.33.1648719277816;
        Thu, 31 Mar 2022 02:34:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8ca6:a836:a237:fed1? ([2001:b07:6468:f312:8ca6:a836:a237:fed1])
        by smtp.googlemail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm11202939edt.80.2022.03.31.02.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 02:34:36 -0700 (PDT)
Message-ID: <0c830e36-fcf2-fab6-aed9-7b6a6736140f@redhat.com>
Date:   Thu, 31 Mar 2022 11:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] KVM: MMU: propagate alloc_workqueue failure
Content-Language: en-US
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220330165510.213111-1-pbonzini@redhat.com>
 <YkTs5BU24zrw30hK@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YkTs5BU24zrw30hK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 01:51, David Matlack wrote:
>> -void kvm_mmu_init_vm(struct kvm *kvm)
>> +int kvm_mmu_init_vm(struct kvm *kvm)
>>   {
>>   	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
>> +	int r;
>>   
>> +	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
>> +	INIT_LIST_HEAD(&kvm->arch.zapped_obsolete_pages);
>> +	INIT_LIST_HEAD(&kvm->arch.lpage_disallowed_mmu_pages);
> 
> I agree with moving these but that should probably be done in a separate
> commit.

Ok.

>> -	kvm->arch.tdp_mmu_zap_wq =
>> -		alloc_workqueue("kvm", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE, 0);
>> -
>> -	return true;
>> +	kvm->arch.tdp_mmu_zap_wq = wq;
> 
> Suggest moving this to just after checking the return value of
> alloc_workqueue().

This is intentional, in case we have other future allocations, to avoid 
having to NULL out the field in the unwind path.  It's a matter of taste 
I guess.

>> +	return 1;
> 
> Perhaps return 0 until we have a reason to differentiate the 2 cases.

Yeah, though I wanted to preserve the previous behavior.

>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index fe2171b11441..89b6efb7f504 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -11629,12 +11629,13 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>   
>>   	ret = kvm_page_track_init(kvm);
>>   	if (ret)
>> -		return ret;
>> +		goto out;
> 
> nit: This goto is unnecessary.

True, but I prefer to be consistent in using "goto" so that any future 
additions are careful about preserving the chain.

Paolo

