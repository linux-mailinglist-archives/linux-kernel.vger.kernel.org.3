Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF885599DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349620AbiHSPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349146AbiHSPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5711F5CC0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660921642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bCazOt/ABEyx6tcL3bVyPlDjCJvGwGf6FzkajqTSuZY=;
        b=A4PGvXYVzBCrqZxAl9U+Kk2ai8NJtbC4nwbuxvj4hHidf5iDL3EST9bzDnmIP+rZwoVhw4
        v0kEyPwyhnBVTybJWBzwMiIvAVZBwxNQ4Q8R+4GSwaUXqFXmConpMy3umQ/AFX24VA6dqU
        aGMlwzTJGumwIU2kelstltH39G5mRAo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-SHg1qevdOxmtR6Xg49cfvQ-1; Fri, 19 Aug 2022 11:07:20 -0400
X-MC-Unique: SHg1qevdOxmtR6Xg49cfvQ-1
Received: by mail-ed1-f69.google.com with SMTP id m18-20020a056402511200b0043d601a8035so3013367edd.20
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=bCazOt/ABEyx6tcL3bVyPlDjCJvGwGf6FzkajqTSuZY=;
        b=VTjWNFmr+qSoweIbjGJ3peIqTm7f2TvslIN3F6vfcinQgKM2wYX7OMqoUkhwcG+498
         JWnxw5+1wNVlj+GNv+vLd9WXiZoj9rKU/uKSACyUIX3aPwLRUrIt7QIN29JfY5ev+PLr
         OhJ2mUzS0f1HebWcvaJ0UaKEySOeAn5B6VK5fgTrvYr8G/NrvVV1L2/0YtRUp6aBAdo+
         +OpeC+mDVjmA5iRfb+D5Pns6j7zKtCP1zH8deyHawSGrgVODB3XdAL1WqYiyJalcgNC4
         2a2UUlbxkVpbnUWYHfDMvS3GI38wngIQ8q87edjRNPmi7MbZthLHinqJpmTK9Unz6VKY
         8eDA==
X-Gm-Message-State: ACgBeo14SSlMTpEEF9FLhJX7AGq6QSivr8b4pAyJN+ZwM5Mvb26LOa8K
        aaA0f51LgXbDNdnmlvbP0+yHKACL19Zz1L6r5YO1GRQCNJuFwiHm3PmZbjLH4d4xbUjPdbZGS3b
        AV6W506HoX1TUdcw2lyVkcvy7BJilFv5F6FiZVkx52s0bVoMzFmrgqPwX58nKiY30LEWbW/vPkb
        Mb
X-Received: by 2002:a05:6402:331a:b0:445:f60e:48cd with SMTP id e26-20020a056402331a00b00445f60e48cdmr6509959eda.201.1660921639550;
        Fri, 19 Aug 2022 08:07:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49vW3ArrSqHKuYMyNSKS4mQPJwS8C0/wsaM1PyYhEGcpfhFu8aYkDylokQz0Q4rE4QZyt3gw==
X-Received: by 2002:a05:6402:331a:b0:445:f60e:48cd with SMTP id e26-20020a056402331a00b00445f60e48cdmr6509928eda.201.1660921639286;
        Fri, 19 Aug 2022 08:07:19 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7dc02000000b0043a7c24a669sm3166096edu.91.2022.08.19.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:07:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/26] KVM: VMX: nVMX: Support TSC scaling and
 PERF_GLOBAL_CTRL with enlightened VMCS
In-Reply-To: <Yv+i/wuObvLf7QZE@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-10-vkuznets@redhat.com>
 <Yv50vWGoLQ9n+6MO@google.com> <87zgg0smqr.fsf@redhat.com>
 <Yv+i/wuObvLf7QZE@google.com>
Date:   Fri, 19 Aug 2022 17:07:17 +0200
Message-ID: <87lerks256.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 19, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
>> >> diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
>> >> index f886a8ff0342..4b809c79ae63 100644
>> >> --- a/arch/x86/kvm/vmx/evmcs.h
>> >> +++ b/arch/x86/kvm/vmx/evmcs.h
>> >> @@ -37,16 +37,9 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
>> >>   *	EPTP_LIST_ADDRESS               = 0x00002024,
>> >>   *	VMREAD_BITMAP                   = 0x00002026,
>> >>   *	VMWRITE_BITMAP                  = 0x00002028,
>> >> - *
>> >> - *	TSC_MULTIPLIER                  = 0x00002032,
>> >>   *	PLE_GAP                         = 0x00004020,
>> >>   *	PLE_WINDOW                      = 0x00004022,
>> >>   *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
>> >> - *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
>> >> - *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
>> >> - *
>> >> - * Currently unsupported in KVM:
>> >> - *	GUEST_IA32_RTIT_CTL		= 0x00002814,
>> >
>> > Almost forgot: is deleting this chunk of the comment intentional?
>> >
>> 
>> Intentional or not (I forgot :-), GUEST_IA32_RTIT_CTL is supported/used
>> by KVM since
>> 
>> commit f99e3daf94ff35dd4a878d32ff66e1fd35223ad6
>> Author: Chao Peng <chao.p.peng@linux.intel.com>
>> Date:   Wed Oct 24 16:05:10 2018 +0800
>> 
>>     KVM: x86: Add Intel PT virtualization work mode
>> 
>> ...
>>  
>> commit bf8c55d8dc094c85a3f98cd302a4dddb720dd63f
>> Author: Chao Peng <chao.p.peng@linux.intel.com>
>> Date:   Wed Oct 24 16:05:14 2018 +0800
>> 
>>     KVM: x86: Implement Intel PT MSRs read/write emulation
>> 
>> but there's no corresponding field in eVMCS. It would probably be better
>> to remove "Currently unsupported in KVM:" line leaving
>> 
>> "GUEST_IA32_RTIT_CTL             = 0x00002814" 
>> 
>> in place. 
>
> GUEST_IA32_RTIT_CTL isn't supported for nested VMX though, which is how I
> interpreted the "Currently unsupported in KVM:".  Would it be accurate to extend
> that part of the comment to "Currently unsupported in KVM for nested VMX:"?

Yea, sounds good to me. 

FWIW, there are other controls which are currently missing in KVM,
e.g. 'guest_ia32_lbr_ctl' (VMX field 0x2816) and we have no 'macro
shenanigans' to catch the moment when support for these gets introduced
in KVM. When this happens, we need to extend VMCS-to-eVMCS mapping
(vmcs_field_to_evmcs_1) to support KVM-on-Hyper-V case and, when the
corresponding field gets added to 'struct vmcs12',
copy_enlightened_to_vmcs12()/copy_vmcs12_to_enlightened(). The whole
process is manual and thus error prone...

-- 
Vitaly

