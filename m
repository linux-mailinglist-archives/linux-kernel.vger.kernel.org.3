Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBCA4BA3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiBQOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:52:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiBQOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:52:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FB20B7C7F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645109555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTh/c4sVBPa5BaOJUmYug7ljvVzxHETGf0CSaizO2uw=;
        b=WEeBCpP4Ul9FpsKLW0tXmQ8XGsFYO13WB8luUDB5OvkCXmrqIK8MjH5aYaofSz2CZPEw2f
        hDC18dCHDx2mfJjaOeIJr1daATLRzevbu/aU6VaF2gmukEGp0+tNIxUQXqGmNle6YvcG9D
        k56RZIJqUNa5NPGmN+IzxbfpukxvfjU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-awQMKBVVOXKwNFvqCuKY3g-1; Thu, 17 Feb 2022 09:52:32 -0500
X-MC-Unique: awQMKBVVOXKwNFvqCuKY3g-1
Received: by mail-ed1-f69.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso3623748edk.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KTh/c4sVBPa5BaOJUmYug7ljvVzxHETGf0CSaizO2uw=;
        b=ttqIsFs0O59peNKm7PfWFjwet44w0Su87NXTxsKRnZRuZrCBZqn3A26h7KF3epzIuy
         8uF7C+c4F4Ekcxcu7364t9Syvg3MZMV3Z8ReFELtSCxYTDV0Anuktw2CbMvik21LHGdo
         PL7vyDQ73GTrjLoEyMrNW5nm4EaR6mh3BeqQEd6TE2oCeRCHAokE+SnLs7fBDQJKKsth
         Hy4i+hJ1rIeUwhJsQ0bB0ztj5m3AYnKwGc1tayCZw9AxBR2N9EU4eXpT33rJvZP823mL
         V4px0mTaepSy0+2bhs1c8t6Wk1h1029zSPAIo5jYXeYHbktS6bDSD/t56Qw+uAQW1y3x
         c9Mg==
X-Gm-Message-State: AOAM530NsBkJR3A2bQeGVfwrG7cEIIGExYgZSFjRlSxl5LcT8toyD6Sn
        cYVHYHUqULDRxNOuZd0YgEhDaXrKO9soGSweEHQlJr0pQISofBmUmD9Xj+ycHhwApbO+y3lvy+b
        CDVLJjyT7267iCKU4/CqgwC/n
X-Received: by 2002:a05:6402:11cd:b0:410:d432:2e30 with SMTP id j13-20020a05640211cd00b00410d4322e30mr2942786edw.119.1645109551305;
        Thu, 17 Feb 2022 06:52:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxT+22vDZ223JM+/gj8psye67qvRqXh+Aeq8v3JNWIfCoWxFWIvQat6avYyHTOa7X8CRn25QA==
X-Received: by 2002:a05:6402:11cd:b0:410:d432:2e30 with SMTP id j13-20020a05640211cd00b00410d4322e30mr2942759edw.119.1645109551114;
        Thu, 17 Feb 2022 06:52:31 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id 5sm1242424ejl.211.2022.02.17.06.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 06:52:30 -0800 (PST)
Message-ID: <087309d0-f39c-d5d0-2b6a-2dd8595b06ea@redhat.com>
Date:   Thu, 17 Feb 2022 15:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/2] x86/kvm/fpu: Fix guest migration bugs that can
 crash guest
Content-Language: en-US
To:     Leonardo Bras <leobras@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Gilbert <dgilbert@redhat.com>,
        Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217053028.96432-1-leobras@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220217053028.96432-1-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 06:30, Leonardo Bras wrote:
> This patchset comes from a bug I found during qemu guest migration from a
> host with newer CPU to a host with an older version of this CPU, and thus
> having less FPU features.
> 
> When the guests were created, the one with less features is used as
> config, so migration is possible.
> 
> Patch 1 fix a bug that always happens during this migration, and is
> related to the fact that xsave saves all feature flags, but xrstor does
> not touch the PKRU flag. It also changes how fpstate->user_xfeatures
> is set, going from kvm_check_cpuid() to the later called
> kvm_vcpu_after_set_cpuid().
> 
> Patch 2 removes kvm_vcpu_arch.guest_supported_xcr0 since it now
> duplicates guest_fpu.fpstate->user_xfeatures. Some wrappers were
> introduced in order to make it easier to read the replaced version.
> 
> Patches were compile-tested, and could fix the bug found.

Queued, thanks (for 5.17 of course)!  For patch 2, I renamed the 
function to kvm_guest_supported_xcr0.

Paolo

> Please let me know of anything to improve!
> 
> Best regards,
> Leo
> 
> --
> Changes since v3:
> - Add new patch to remove the use of kvm_vcpu_arch.guest_supported_xcr0,
>    since it is now duplicating guest_fpu.fpstate->user_xfeatures.
> - On patch 1, also avoid setting user_xfeatures on kvm_check_cpuid(),
>    since it is already set in kvm_vcpu_after_set_cpuid() now.
> Changes since v2:
> - Fix building error because I forgot to EXPORT_SYMBOL(fpu_user_cfg)
> Changes since v1:
> - Instead of masking xfeatures, mask user_xfeatures instead. This will
>    only change the value sent to user, instead of the one saved in buf.
> - Above change removed the need of the patch 2/2
> - Instead of masking the current value of user_xfeatures, save on it
>    fpu_user_cfg.default_features & vcpu->arch.guest_supported_xcr0
> 
> Leonardo Bras (2):
>    x86/kvm/fpu: Mask guest fpstate->xfeatures with guest_supported_xcr0
>    x86/kvm/fpu: Remove kvm_vcpu_arch.guest_supported_xcr0
> 
>   arch/x86/include/asm/kvm_host.h |  1 -
>   arch/x86/kernel/fpu/xstate.c    |  5 ++++-
>   arch/x86/kvm/cpuid.c            |  5 ++++-
>   arch/x86/kvm/x86.c              | 20 +++++++++++++++-----
>   4 files changed, 23 insertions(+), 8 deletions(-)
> 

