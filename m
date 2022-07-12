Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000CC5719C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiGLMUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiGLMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94DA86D549
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657628419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/fC+rsuewsmYyokkHN4davc+n6pcIuIFkioCEI5EXs=;
        b=KWtiIi7iIdV/9yg2/AC6x/ClTJSLIxLzEPhg9WPI+s0KWpamj4r2i2HyKKesn0dHIExabS
        fq+1G9HBQo38wDrhXmW0u8srzuXCbsZnc9QEYCHi4PSm0rdd1WECGafJ3mq8QzqCi+1S0k
        s3LW4slFilsmcjRUl6x18tBwYmagl6s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-lazxwkXlOveUr_VqD-oelQ-1; Tue, 12 Jul 2022 08:19:09 -0400
X-MC-Unique: lazxwkXlOveUr_VqD-oelQ-1
Received: by mail-wm1-f71.google.com with SMTP id i5-20020a1c3b05000000b003a2e8a77dd1so637043wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=D/fC+rsuewsmYyokkHN4davc+n6pcIuIFkioCEI5EXs=;
        b=yU9hgBInS6jLRdoq73b4gSxNfCldb0IG2ruoTNSVAsShb8Ir7E/Dy6S8Do+cCjpLjm
         NbYmons3GYmp005LYWKMTWbpJhiW5o1jZd4nYh9GeRwxLE4GbCxzV4qKHYWUgruQm1dT
         +3PL/TDhAFBVDd/qAofINIt5dxCW4wy9pHkf8KlgUjzMQ1C5va0M/tXQPcTI3DZ+ETqe
         eBgIQM3ozkLkpksk7PKfQ8TAR69ardIkKKOU1D3sWsHGoLnnzNw1pzQb3EDX10stHr/r
         QRrAWWF2Oe0hn36KjdmOHGTvcfkZ+dK65hS45mz91UNjTUNCEtTIM+JqoIcZZyOS2HGh
         aMgw==
X-Gm-Message-State: AJIora8FLBj2nHr5poKk25sTfVvsgbrxIcBXcvkc+mvpqVwwUCYEkxxj
        tuyjEaWYoGZgwtIgtFhykm8u6Zlx+pRZQRm3fJkFYkFHKPneZREIUeiLTR7NFUupxEGgia2ApEQ
        /zACqYLod8YqQPle66Hy18uQt
X-Received: by 2002:a05:600c:3845:b0:3a2:c04d:5ff9 with SMTP id s5-20020a05600c384500b003a2c04d5ff9mr3619765wmr.74.1657628348621;
        Tue, 12 Jul 2022 05:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tSAiVrHcowqDbe7dPEm4sreDyxs47ZG63PfIWwugXmlHXOLYhohrraQDJqffTNnuGllHv/ag==
X-Received: by 2002:a05:600c:3845:b0:3a2:c04d:5ff9 with SMTP id s5-20020a05600c384500b003a2c04d5ff9mr3619748wmr.74.1657628348428;
        Tue, 12 Jul 2022 05:19:08 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j5-20020adff545000000b0021d864d4461sm8090767wrp.83.2022.07.12.05.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 05:19:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v3 03/25] x86/hyperv: Update 'struct
 hv_enlightened_vmcs' definition
In-Reply-To: <6cf5812083ebfa18ba52563527298cb8b91f7fab.camel@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
 <20220708144223.610080-4-vkuznets@redhat.com>
 <6cf5812083ebfa18ba52563527298cb8b91f7fab.camel@redhat.com>
Date:   Tue, 12 Jul 2022 14:19:06 +0200
Message-ID: <874jzmplqd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
>> Updated Hyper-V Enlightened VMCS specification lists several new
>> fields for the following features:
>>=20
>> - PerfGlobalCtrl
>> - EnclsExitingBitmap
>> - Tsc Scaling
>> - GuestLbrCtl
>> - CET
>> - SSP
>>=20
>> Update the definition. The updated definition is available only when
>> CPUID.0x4000000A.EBX BIT(0) is '1'. Add a define for it as well.
>>=20
>> Note: The latest TLFS is available at
>> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/=
tlfs
>>=20
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/hyperv-tlfs.h | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/h=
yperv-tlfs.h
>> index 6f0acc45e67a..6f2c3cdacdf4 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -138,6 +138,9 @@
>>  #define HV_X64_NESTED_GUEST_MAPPING_FLUSH		BIT(18)
>>  #define HV_X64_NESTED_MSR_BITMAP			BIT(19)
>>=20=20
>
> Maybe add a comment that this is undocumented + what that cpuid bit does?
>
>> +/* Nested quirks. These are HYPERV_CPUID_NESTED_FEATURES.EBX bits. */
>> +#define HV_X64_NESTED_EVMCS1_2022_UPDATE		BIT(0)
>> +
>>  /*
>>   * This is specific to AMD and specifies that enlightened TLB flush is
>>   * supported. If guest opts in to this feature, ASID invalidations only
>> @@ -559,9 +562,20 @@ struct hv_enlightened_vmcs {
>>  	u64 partition_assist_page;
>>  	u64 padding64_4[4];
>>  	u64 guest_bndcfgs;
>> -	u64 padding64_5[7];
>> +	u64 guest_ia32_perf_global_ctrl;
>> +	u64 guest_ia32_s_cet;
>> +	u64 guest_ssp;
>> +	u64 guest_ia32_int_ssp_table_addr;
>> +	u64 guest_ia32_lbr_ctl;
>> +	u64 padding64_5[2];
>
> This change looks OK
>
>>  	u64 xss_exit_bitmap;
>> -	u64 padding64_6[7];
>> +	u64 host_ia32_perf_global_ctrl;
>> +	u64 encls_exiting_bitmap;
>> +	u64 tsc_multiplier;
>> +	u64 host_ia32_s_cet;
>> +	u64 host_ssp;
>> +	u64 host_ia32_int_ssp_table_addr;
>> +	u64 padding64_6;
>
> I think we have a mistake here:
>
> UINT64 XssExitingBitmap;
> UINT64 EnclsExitingBitmap;
> UINT64 HostPerfGlobalCtrl;
> UINT64 TscMultiplier;
> UINT64 HostSCet;
> UINT64 HostSsp;
> UINT64 HostInterruptSspTableAddr;
> UINT64 Rsvd8;
>
>
> I think you need to swap encls_exiting_bitmap and host_ia32_perf_global_c=
trl
>
> I used=C2=A0https://docs.microsoft.com/en-us/virtualization/hyper-v-on-wi=
ndows/tlfs/datatypes/hv_vmx_enlightened_vmcs
> as the reference.=C2=A0

Oh, nice catch, thanks! I have no idea how this mistake crept in. A
conspiracy theory: maybe the online version of TLFS was updated
under our feet? :-)

v4 is coming to rescue.

>
>
> Best regards,
> 	Maxim Levitsky
>
>
>>  } __packed;
>>=20=20
>>  #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE			0
>
>

--=20
Vitaly

