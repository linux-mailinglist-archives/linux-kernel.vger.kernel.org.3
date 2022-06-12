Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE95547B30
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiFLRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiFLR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 13:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 989285BE72
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655054976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSVELf33cGPsODeQrLYR4SnYy4MBpnDz+MPXMGIWt70=;
        b=Xz/O9rFIsstc7y9UrYkN+vnS8C0Iw+HJPGiU+CetM/8bW8IthB3tyA2cT02erkFqa/l/GM
        QahRvlK62aHtXQ12SstR8+/0An68/ydrdYEovx4sfqemIUQrAZ8UsRgJuowhCEdrQJaWrs
        AVLHL0aANKmkKHHcVP8l39yxyAnbctU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-MY6iialhNyKWzafUnolAMg-1; Sun, 12 Jun 2022 13:29:34 -0400
X-MC-Unique: MY6iialhNyKWzafUnolAMg-1
Received: by mail-ed1-f69.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso2689356eda.23
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 10:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=HSVELf33cGPsODeQrLYR4SnYy4MBpnDz+MPXMGIWt70=;
        b=EFdAnWQwOh5QNnfdiaFRQDqVmjdlGREiqbUD+m0xYAJnuLxKlOQrKsM7XPul0I8YZr
         3TC8amvWTPWP6p1DfyY6+5NXp1qDMoJa6LUcgrBS3d0bJou0DAMJKkwcVJSq+6klafLF
         dJdrs8kpYnzltnr6X5/LJzyDRZIO/KwBiDg33HSV0FiKe9SgoKQF5bsXZLcKnzOasODW
         88ClrF9SWfmVKRksA9xc2G4W8pt2XIV2WeyLPHNGvTQfZQZMO1/QLytz8JEsQlR/Ukyp
         pw1w71FsoKJhDvR/TNvjlYFe6sLjVvdN4ezop/xZ4C3XWhT4eFNIwvwNoijC1jNB66Ox
         7QUw==
X-Gm-Message-State: AOAM5311q2Yhbyx2KN2PQoaIr026tZy5Sou8GeNaXJZhiJaPjXMCuBqe
        6ISx9OzhsCrnPgg+tEMNY0JusXxCtWZgjcfuT/Vj+J3eYCLH1irxECJDAW3ZLzRCu/Sg5Bil7KY
        0Qshc13IjzcXE4ns3sGR/0/Dx
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id f11-20020a0564021e8b00b0041c59f62c26mr61549023edf.156.1655054973613;
        Sun, 12 Jun 2022 10:29:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya7ZRmmifJ8K2AxuWZhmPuC7IEuO1mcbLPJZtxqJfg5i707FaCm9lzgNPKLwvyBEBoozyzDA==
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id f11-20020a0564021e8b00b0041c59f62c26mr61549008edf.156.1655054973380;
        Sun, 12 Jun 2022 10:29:33 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id y18-20020aa7ce92000000b0042dc882c823sm3476955edv.70.2022.06.12.10.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 10:29:32 -0700 (PDT)
Message-ID: <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
Date:   Sun, 12 Jun 2022 19:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     paulmck@kernel.org,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, mtosatti@redhat.com,
        sheng.yang@intel.com
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
 <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
 <20220612133631.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
 <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
In-Reply-To: <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/22 18:40, Paul E. McKenney wrote:
>> Do these reserved memory regions really need to be allocated separately?
>> (For example, are they really all non-contiguous?  If not, that is, if
>> there are a lot of contiguous memory regions, could you sort the IORT
>> by address and do one ioctl() for each set of contiguous memory regions?)
>>
>> Are all of these reserved memory regions set up before init is spawned?
>>
>> Are all of these reserved memory regions set up while there is only a
>> single vCPU up and running?
>>
>> Is the SRCU grace period really needed in this case?  (I freely confess
>> to not being all that familiar with KVM.)
> 
> Oh, and there was a similar many-requests problem with networking many
> years ago.  This was solved by adding a new syscall/ioctl()/whatever
> that permitted many requests to be presented to the kernel with a single
> system call.
> 
> Could a new ioctl() be introduced that requested a large number
> of these memory regions in one go so as to make each call to
> synchronize_rcu_expedited() cover a useful fraction of your 9000+
> requests?  Adding a few of the KVM guys on CC for their thoughts.

Unfortunately not.  Apart from this specific case, in general the calls 
to KVM_SET_USER_MEMORY_REGION are triggered by writes to I/O registers 
in the guest, and those writes then map to a ioctl.  Typically the guest 
sets up a device at a time, and each setup step causes a 
synchronize_srcu()---and expedited at that.

KVM has two SRCUs:

1) kvm->irq_srcu is hardly relying on the "sleepable" part; it has 
readers that are very very small, but it needs extremely fast detection 
of grace periods; see commit 719d93cd5f5c ("kvm/irqchip: Speed up 
KVM_SET_GSI_ROUTING", 2014-05-05) which split it off kvm->srcu.  Readers 
are not so frequent.

2) kvm->srcu is nastier because there are readers all the time.  The 
read-side critical section are still short-ish, but they need the 
sleepable part because they access user memory.

Writers are not frequent per se; the problem is they come in very large 
bursts when a guest boots.  And while the whole boot path overall can be 
quadratic, O(n) expensive calls to synchronize_srcu() can have a larger 
impact on runtime than the O(n^2) parts, as demonstrated here.

Therefore, we operated on the assumption that the callers of 
synchronized_srcu_expedited were _anyway_ busy running CPU-bound guest 
code and the desire was to get past the booting phase as fast as 
possible.  If the guest wants to eat host CPU it can "for(;;)" as much 
as it wants; therefore, as long as expedited GPs didn't eat CPU 
*throughout the whole system*, a preemptable busy wait in 
synchronize_srcu_expedited() were not problematic.

This assumptions did match the SRCU code when kvm->srcu and 
kvm->irq_srcu were was introduced (respectively in 2009 and 2014).  But 
perhaps they do not hold anymore now that each SRCU is not as 
independent as it used to be in those years, and instead they use 
workqueues instead?

Thanks,

Paolo

