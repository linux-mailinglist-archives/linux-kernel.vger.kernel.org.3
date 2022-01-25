Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9049BB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiAYScF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232377AbiAYSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643135504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiMvtf0ISdZjP/XjkwKlDCax9+P+Wq5+7WeQC/1x/e0=;
        b=HeP3RJUIuZ8gm/2Vqe4BPhH4wFgtOXef1/8l29Oh2Z/03KKzS56Kil20VopEFviebd2Sxh
        Prtqtp8N/qnIN7ehUQyKRgzfZ0+pbjv/+ETFgHjzG7LVj+IbyWPfYUKCGYyMkagxC+4iv3
        nFwQYBM0GUa+MZXpKZYv0NgNpxt8JKE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-Jnxv3xLLPm2901E-dlcFPQ-1; Tue, 25 Jan 2022 13:31:42 -0500
X-MC-Unique: Jnxv3xLLPm2901E-dlcFPQ-1
Received: by mail-wr1-f71.google.com with SMTP id k12-20020adfe3cc000000b001d6806dfde1so3441637wrm.16
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZiMvtf0ISdZjP/XjkwKlDCax9+P+Wq5+7WeQC/1x/e0=;
        b=fe1qjKV/sqcnXU1ikGcZmTyEU8yOj7Tno2KIwBj1tuFK8RJtC5+/oD17qKgr0FS6Ea
         e53x7SQA7vWMCCC87DhhmA+/gm4ETQLh2izXtHMfsy0PH0ScUfWu8ZijGvE0HlKQh5Qm
         CUihJygzYlOfAfCoE96HfApML6VJgoGT5gvQYVO7Z0ke17YtQiCzcL6A4qNq04XWLeFd
         cwwiUbo6BmdK4zpBU7ktHNQmkAfwVUj4SdBQemPs59C3qzXYDVSCY6Atj7YqD0zzy0q9
         gMNgQVPAJg9mKKwcuQ9ldVhtM+YGtKs/ohR1+hRNcA3h+/LE7Uz5aGohUPJYNXU3jtr8
         D1oQ==
X-Gm-Message-State: AOAM531saklfl8MFnyygqe3l+KfffunoGOYOoJvi3nsO/XbhtYG7Wv+e
        52Lbtj39Ooh9oFQQW4SL/7PjdPEO9TAp20XHJ9DDl9AgQu6oq+FseBm1OQuKBCPgKXVCQXtPyZb
        BSw1HV682Erl4MREDRx6my2Ba
X-Received: by 2002:a05:600c:3b9c:: with SMTP id n28mr4026525wms.128.1643135501327;
        Tue, 25 Jan 2022 10:31:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyN0IgX820Ekp2FGnNepZZuBtQxuN7cmwVJ8BQ4uskdVHzzxIheTLTx4aGzRFqWOkVsmlYLoA==
X-Received: by 2002:a05:600c:3b9c:: with SMTP id n28mr4026515wms.128.1643135501089;
        Tue, 25 Jan 2022 10:31:41 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d4sm1656669wri.39.2022.01.25.10.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 10:31:40 -0800 (PST)
Subject: Re: [PATCH v4 06/21] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
To:     Gavin Shan <gshan@redhat.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>,
        kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, pbonzini@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-7-gshan@redhat.com>
 <40d818a2-0c91-e06e-6ce8-ac8123b8d1d4@gmail.com>
 <798ecbb0-f369-f3e7-ad50-78acfd902d1d@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <3d791443-d3d3-29fb-98a4-bebadb84597e@redhat.com>
Date:   Tue, 25 Jan 2022 19:31:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <798ecbb0-f369-f3e7-ad50-78acfd902d1d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 1/13/22 8:02 AM, Gavin Shan wrote:
> Hi Shannon,
> 
> On 1/11/22 5:43 PM, Shannon Zhao wrote:
>> On 2021/8/15 8:13, Gavin Shan wrote:
>>> +static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>>> +{
>>> +    struct kvm *kvm = vcpu->kvm;
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>> +    struct kvm_sdei_vcpu_regs *regs;
>>> +    unsigned long index = smccc_get_arg1(vcpu);
>>> +    unsigned long ret = SDEI_SUCCESS;
>>> +
>>> +    /* Sanity check */
>>> +    if (!(ksdei && vsdei)) {
>>> +        ret = SDEI_NOT_SUPPORTED;
>>> +        goto out;
>>> +    }
>> Maybe we could move these common sanity check codes to
>> kvm_sdei_hypercall to save some lines.
>>
> 
> Not all hypercalls need this check. For example,
> COMPLETE/COMPLETE_RESUME/CONTEXT don't
> have SDEI event number as the argument. If we really want move this
> check into function
> kvm_sdei_hypercall(), we would have code like below. Too much duplicated
> snippets will
> be seen. I don't think it's better than what we have if I fully
> understand your comments.
> 
>       switch (...) {
>       case REGISTER:
>            if (!(ksdei && vsdei)) {
>                ret = SDEI_NOT_SUPPORTED;
>                break;
>            }
at least you can use an inline function taking the vcpu as param?

Thanks

Eric
> 
>            ret = kvm_sdei_hypercall_register(vcpu);
>            break;
>       case UNREGISTER:
>            if (!(ksdei && vsdei)) {
>                ret = SDEI_NOT_SUPPORTED;
>                break;
>            }
> 
>            ret = kvm_sdei_hypercall_unregister(vcpu);
>            break;
>      case CONTEXT:
>            ret = kvm_sdei_hypercall_context(vcpu);
>            break;
>        :
>     }
> 
> Thanks,
> Gavin
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

