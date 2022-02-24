Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DB24C2E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiBXOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiBXOpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62D5323A1AF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645713893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbEproH24Nb7tYPTH/K4BdGwkHbYgaoV/yDje8U1XwI=;
        b=YjYwxO/Rm6Xbt9/Cv0o/DsekK4nB+5mqzjvqdj5oSL4DbVnedx11FlZR6HpLCNjTmDDRjO
        YAjg0W8H+C10PiVx7kXF+//xASgSA/rwzi7OOKorkA9FSo3w4+fJUZJrt1ZWS4yN4zt4wl
        ppFYhgQIBwNVX6HdizTIIwdLzWDmkVs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-0Af_Ra22OiyPFTs-UiPAdQ-1; Thu, 24 Feb 2022 09:44:52 -0500
X-MC-Unique: 0Af_Ra22OiyPFTs-UiPAdQ-1
Received: by mail-ej1-f71.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso1294066ejc.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GbEproH24Nb7tYPTH/K4BdGwkHbYgaoV/yDje8U1XwI=;
        b=ku6lVFRO00TOuOlhuAvvHiGuvMFsUUWg9psD9PvsQnts7APhyuPwqGJh36YoNjq4qr
         cC+eiKx7UOMxnjTVUyR01DV+EDUJ82w141xS9eBH+42qTd4WX50ziIRnZBZKceb1BQNr
         Zkwf/StCO1NVEVo5B+2QX11A4t8ihziWuSxB4ziAQp1RZhNoXwpxKXCch3RHB1Tpooar
         7qYdEiDOLkPI5hZiSerYByEVfuoWChv7p31AlXLoj/SZcuLCW6/51/K81SesU6MPkum7
         f1p15NC1nBI2TBoPtqRBCjrHkadD2R2DRSzpRusxkCWcvabHqc/lzg/m0qR52sQNMdA5
         ox1Q==
X-Gm-Message-State: AOAM531jkGTn1fxNXS0R7Brd9wWyj/IlGVgWL/sfmq24JnqSi0pBMKSM
        9PtIAhKyMX9YgoFxcOMLqmlfiaEUyogU4rWCjJeDESEhS3YEV3731SQ3RquavEOzk1yiuK+WAb4
        /s3XnLohe0M9hlzCXX67KV3eJ
X-Received: by 2002:a17:906:4987:b0:6ce:88fc:3c88 with SMTP id p7-20020a170906498700b006ce88fc3c88mr2401991eju.608.1645713890864;
        Thu, 24 Feb 2022 06:44:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZcvLntGLEMOZeQNDz06+3JrdpH/4f+5BClXZE9MIlKqar04vYm+Igr+9loVgByBMTOi4ljA==
X-Received: by 2002:a17:906:4987:b0:6ce:88fc:3c88 with SMTP id p7-20020a170906498700b006ce88fc3c88mr2401973eju.608.1645713890585;
        Thu, 24 Feb 2022 06:44:50 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id z12sm1635541edc.80.2022.02.24.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:44:49 -0800 (PST)
Message-ID: <beb1878e-7708-9dd1-0282-7fb5f0d23df4@redhat.com>
Date:   Thu, 24 Feb 2022 15:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] KVM: x86: Fix emulation in writing cr8
Content-Language: en-US
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com
References: <20220210094506.20181-1-zhenzhong.duan@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220210094506.20181-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 10:45, Zhenzhong Duan wrote:
> In emulation of writing to cr8, one of the lowest four bits in TPR[3:0]
> is kept.
> 
> According to Intel SDM 10.8.6.1(baremetal scenario):
> "APIC.TPR[bits 7:4] = CR8[bits 3:0], APIC.TPR[bits 3:0] = 0";
> 
> and SDM 28.3(use TPR shadow):
> "MOV to CR8. The instruction stores bits 3:0 of its source operand into
> bits 7:4 of VTPR; the remainder of VTPR (bits 3:0 and bits 31:8) are
> cleared.";
> 
> and AMD's APM 16.6.4:
> "Task Priority Sub-class (TPS)-Bits 3 : 0. The TPS field indicates the
> current sub-priority to be used when arbitrating lowest-priority messages.
> This field is written with zero when TPR is written using the architectural
> CR8 register.";
> 
> so in KVM emulated scenario, clear TPR[3:0] to make a consistent behavior
> as in other scenarios.
> 
> This doesn't impact evaluation and delivery of pending virtual interrupts
> because processor does not use the processor-priority sub-class to
> determine which interrupts to delivery and which to inhibit.
> 
> Sub-class is used by hardware to arbitrate lowest priority interrupts,
> but KVM just does a round-robin style delivery.
> 
> Fixes: b93463aa59d6 ("KVM: Accelerated apic support")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> ---
> v2: Add Sean's comments and "Fixes:" to patch description
> 
>   arch/x86/kvm/lapic.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index d7e6fde82d25..306025db9959 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2242,10 +2242,7 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
>   
>   void kvm_lapic_set_tpr(struct kvm_vcpu *vcpu, unsigned long cr8)
>   {
> -	struct kvm_lapic *apic = vcpu->arch.apic;
> -
> -	apic_set_tpr(apic, ((cr8 & 0x0f) << 4)
> -		     | (kvm_lapic_get_reg(apic, APIC_TASKPRI) & 4));
> +	apic_set_tpr(vcpu->arch.apic, (cr8 & 0x0f) << 4);
>   }
>   
>   u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu)

Queued, thanks.

Paolo

