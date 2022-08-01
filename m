Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6114558661F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiHAIRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiHAIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B33583A489
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659341816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmzNZho9jHBcgTfBsUmmqn9Qv9k7TLN2eQSID+/Hv5I=;
        b=CaARCQ0jkkwXn63YGOJRCa/U3SIssXAY7iJvr5cSLGrt5ZWDTgL4NurJ00UA9dODhT5blW
        VGE7QSatldf76pgkVMkLlO6kmdx2jXwJ+3eOqSaSsS0LxF8SNgg/NoqXSp+Nk9MOxk2sGZ
        C5ZNYM5cCCKNVG0X/GYKNaZyvI6tvBc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-ga8mTe0GMHm3II1j38F1cA-1; Mon, 01 Aug 2022 04:16:55 -0400
X-MC-Unique: ga8mTe0GMHm3II1j38F1cA-1
Received: by mail-wr1-f71.google.com with SMTP id o8-20020adfa108000000b0021e903fb612so2311106wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MmzNZho9jHBcgTfBsUmmqn9Qv9k7TLN2eQSID+/Hv5I=;
        b=inMECA1T8NzoSVE2/zwG3UBg638QiyAN5QlkG/7Q73hZVnQ4VEApijxElP+Z/oZ1Ff
         12UzKX21f0ARTHSoKZXaqwUUccmy66BpkNiXUVP+fhij9tq9SmJYWSYC6F1nIWnqtF2b
         ndt5LIvWZcliVI0nlbYRH0hv+E5vmQ4Eu/H/NmsV80ZHjoPvwhpTn+sGCkRUNVn+TFBL
         g20NEgVqKPmruOh2D28XBoBJ3yipBTJUsCUcGE93HylEwss0pN+Se7Cka2wftegzRPWf
         +LAkNliZrd/bo7iceq0akVtuznA9sDRfTzch3O4v4On/jCX+7YZeVkFUymXn6DYkgq2y
         d92g==
X-Gm-Message-State: AJIora+xN8mruCW4CS8LL13vwIYjZ7GTK7F31dWAtJ5FpyRIS9i3h8Cp
        WQeyFgyOzU03R7xnfP6EFEHZf+gslBR0Fk8Uw8Sn/F8Vm5WMYs9VXCXmpKkpkDTDNcel13GklRb
        xNP7jV2+MRBe3t4x3ENd8bdWNPid3r4MA4n+YUTaC4I46aB6xXqzwPJyxNM3C6UDKKkX4O9jdv9
        bV
X-Received: by 2002:a05:600c:ad2:b0:3a3:181e:e228 with SMTP id c18-20020a05600c0ad200b003a3181ee228mr10761585wmr.139.1659341814351;
        Mon, 01 Aug 2022 01:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v1Hhb0GUxYAsdQ0Nri0ye05EzX/FYjnD0pCuZVbbLU3CZWG1D3bT3/XrF/BvevGIspEmp2kQ==
X-Received: by 2002:a05:600c:ad2:b0:3a3:181e:e228 with SMTP id c18-20020a05600c0ad200b003a3181ee228mr10761562wmr.139.1659341814024;
        Mon, 01 Aug 2022 01:16:54 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b003a31df6af2esm19012657wmq.1.2022.08.01.01.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 01:16:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/25] KVM: x86: hyper-v: Expose access to debug MSRs
 in the partition privilege flags
In-Reply-To: <0741719d-17b4-96fe-1ee8-5f22cf3e255b@redhat.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-2-vkuznets@redhat.com>
 <YtnIgQOPbcZOQK2D@google.com>
 <0741719d-17b4-96fe-1ee8-5f22cf3e255b@redhat.com>
Date:   Mon, 01 Aug 2022 10:16:52 +0200
Message-ID: <87a68o2xaj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 7/21/22 23:43, Sean Christopherson wrote:
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index c284a605e453..ca91547034e4 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1282,7 +1282,7 @@ static bool hv_check_msr_access(struct kvm_vcpu_hv *hv_vcpu, u32 msr)
>>          case HV_X64_MSR_SYNDBG_OPTIONS:
>>          case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
>>                  return hv_vcpu->cpuid_cache.features_edx &
>> -                       HV_FEATURE_DEBUG_MSRS_AVAILABLE;
>> +                       HV_ACCESS_DEBUG_MSRS;
>>          default:
>>                  break;
>>          }
>> 
>
> Yes, and this will need some kind of hack in QEMU to expose both CPUID 
> bits.  Fortunately hv-syndbg shouldn't be in much use in the wild, so I 
> think we can avoid quirks etc.

Properly behaving VMM should always expose both bits. I'm not sure what
would it mean if only 'access' bit is present: you can try accessing the
missing feature but you get #GP anyway most likely. When the feature is
available but 'access' bit is not set -- the result is also #GP. In case
we really want to support this behavior in KVM we should probably check
*both* bits in hv_check_msr_access() but I don't really see a
use-case. I've lazily kept HV_FEATURE_DEBUG_MSRS_AVAILABLE here just to
be QEMU compatible.

-- 
Vitaly

