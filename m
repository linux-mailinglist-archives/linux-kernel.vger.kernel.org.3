Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2004C911D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiCARJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiCARJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:09:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40CEC1B7BC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646154540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJDZOzPGUsKbLll7llFaQ4OK3orYVysgYCGoUQk0SGM=;
        b=c1iUK0ezcxC/wUM6QytAgC3gUT/TASo7/VPV5oJDyMZlmf6pqMRw0n1DgHm6FNVFQCr8hi
        DxDGcUakqFQCQbRDFRF674pQYerIkNNVCnObI06p8lGQTwmyGTjpNu+kt67TZ6rt4jn995
        b5lwzFz7/8AOigF5zsq3F0Jq+otOKwE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-UAKtXMddNJO_IP8ciOO88Q-1; Tue, 01 Mar 2022 12:08:58 -0500
X-MC-Unique: UAKtXMddNJO_IP8ciOO88Q-1
Received: by mail-wm1-f72.google.com with SMTP id r206-20020a1c44d7000000b00380e36c6d34so1082503wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZJDZOzPGUsKbLll7llFaQ4OK3orYVysgYCGoUQk0SGM=;
        b=Ft+7JsN541O81oCqCj3NRbnx4j4MtbjjcDWC9K9mPiKQMfc1KEtI/2yowRTXygw6kx
         1jFuAIGT+qIwbxdEGjrw74DghDqx+Av56a783Qa0txNqQvWfzL7VHEMn4FNmYTyFr51M
         KSjoPUr/yfNihJwCptA+A3HrvKGO6buYoc/mfLu4DK2atA7FsHkmzf2pOO63wzEPiJn7
         ZTg94FCYLJAEqO4abPqv0yKPxwKT9c626cIDKkAX5VYNM2Nz+m8TVjzxj81Cl6ggEESR
         IaGB/jNVfzqL90/ywUWLhOMzZTsQn0mdn49o2UHQobpwem4gv84VoXCf3UZGfCddYgIu
         aQ+A==
X-Gm-Message-State: AOAM530XcjapmE3mLEkJj5i9DNWPJ+QtsruTr+kkE4CvGbrRWr/RsAku
        cGJrCVcgRYC5ITOyIvFMhkbgrh+LtsofMS1UERDkBQSM7qXOHi2KATyPEw+0BA1Yq5cJJ7RZUpQ
        oV9exspD+71ugql9yWiwFuyiG
X-Received: by 2002:a05:600c:4ed0:b0:37b:e983:287b with SMTP id g16-20020a05600c4ed000b0037be983287bmr17602647wmq.156.1646154537126;
        Tue, 01 Mar 2022 09:08:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHmO6U3tzK2/0JyBPBzwhWBSC+mkBe9XsmYBaD+uYEmjw0r02fq3hD+PJO/RCam2xM91qwYg==
X-Received: by 2002:a05:600c:4ed0:b0:37b:e983:287b with SMTP id g16-20020a05600c4ed000b0037be983287bmr17602614wmq.156.1646154536842;
        Tue, 01 Mar 2022 09:08:56 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id m2-20020adff382000000b001f022ef0375sm1306419wro.102.2022.03.01.09.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 09:08:56 -0800 (PST)
Message-ID: <90363e5c-e21c-16cc-7ed1-59e3f73d9a87@redhat.com>
Date:   Tue, 1 Mar 2022 18:08:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/7] KVM: x86/mmu: Zap only obsolete roots on "reload"
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220225182248.3812651-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220225182248.3812651-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 19:22, Sean Christopherson wrote:
> For all intents and purposes, this is an x86/mmu series, but it touches
> s390 and common KVM code because KVM_REQ_MMU_RELOAD is currently a generic
> request despite its use being encapsulated entirely within arch code.
> 
> The meat of the series is to zap only obsolete (a.k.a. invalid) roots in
> response to KVM marking a root obsolete/invalid due to it being zapped.
> KVM currently drops/zaps all roots, which, aside from being a performance
> hit if the guest is using multiple roots, complicates x86 KVM paths that
> load a new root because it raises the question of what should be done if
> there's a pending KVM_REQ_MMU_RELOAD, i.e. if the path _knows_ that any
> root it loads will be obliterated.
> 
> Paolo, I'm hoping you can squash patch 01 with your patch it "fixes".
> 
> I'm also speculating that this will be applied after my patch to remove
> KVM_REQ_GPC_INVALIDATE, otherwise the changelog in patch 06 will be
> wrong.

Queued, thanks.

Paolo

> v2:
>   - Collect reviews. [Claudio, Janosch]
>   - Rebase to latest kvm/queue.
> 
> v1: https://lore.kernel.org/all/20211209060552.2956723-1-seanjc@google.com
> 
> Sean Christopherson (7):
>    KVM: x86: Remove spurious whitespaces from kvm_post_set_cr4()
>    KVM: x86: Invoke kvm_mmu_unload() directly on CR4.PCIDE change
>    KVM: Drop kvm_reload_remote_mmus(), open code request in x86 users
>    KVM: x86/mmu: Zap only obsolete roots if a root shadow page is zapped
>    KVM: s390: Replace KVM_REQ_MMU_RELOAD usage with arch specific request
>    KVM: Drop KVM_REQ_MMU_RELOAD and update vcpu-requests.rst
>      documentation
>    KVM: WARN if is_unsync_root() is called on a root without a shadow
>      page
> 
>   Documentation/virt/kvm/vcpu-requests.rst |  7 +-
>   arch/s390/include/asm/kvm_host.h         |  2 +
>   arch/s390/kvm/kvm-s390.c                 |  8 +--
>   arch/s390/kvm/kvm-s390.h                 |  2 +-
>   arch/x86/include/asm/kvm_host.h          |  2 +
>   arch/x86/kvm/mmu.h                       |  1 +
>   arch/x86/kvm/mmu/mmu.c                   | 83 ++++++++++++++++++++----
>   arch/x86/kvm/x86.c                       | 10 +--
>   include/linux/kvm_host.h                 |  4 +-
>   virt/kvm/kvm_main.c                      |  5 --
>   10 files changed, 90 insertions(+), 34 deletions(-)
> 
> 
> base-commit: f4bc051fc91ab9f1d5225d94e52d369ef58bec58

