Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2294BB45A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiBRIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:36:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiBRIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFDA74969C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645173372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKiicN0GGFcwBtp1TH+GXwl5J82xlM6HV1RS1efNVOk=;
        b=SkPshWTSKvoTC2H3WJ3yb4KJgYqq9lB48kMk8JIRw2Afm+gcwQDdztERhGzXqLS822g/QF
        AThhJydLIEKl1OPZH0kqNkadSzFDdDZd4ZCTO3C/p4HmZSg3DYdeFAaMh8YtxT32r50a/v
        rWUVPKZY0nCuvtfRo1ssQZOLJqf1L60=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-wSrCBTT2MCShq2cbkHmgGg-1; Fri, 18 Feb 2022 03:36:11 -0500
X-MC-Unique: wSrCBTT2MCShq2cbkHmgGg-1
Received: by mail-ed1-f70.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so5130435edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LKiicN0GGFcwBtp1TH+GXwl5J82xlM6HV1RS1efNVOk=;
        b=2iZOh+HeswLKFcw0z2ceqH94PlwMrWnnB5kU/nUApMA3/ab2B7bfVUtQHwL52vT98i
         NFD5id4X3yZxlIgkS+cp/MhGOZ+GWME4dvU2CLIE2wOsm8AniTmFKtl1m/nT0f11zZ7u
         BWhAt8PfaBqJEHQ8mbwnj1ntGcgVLw6lV7HskXu8sZv0UaoE+3d2F5riyxAaxaUNQH3F
         Rdg914MWBtgI32hqkJ7a9GQIho3xywepH+EClDuzEe04WtJ+WM9wc+8iAXl1lHyhxPi7
         Hoo31fg23cllC7LynP3c910V3Y7IaVjopSlkldjFpnoasgM4v09MiZ1N8cXEd11ns5Qs
         uWUw==
X-Gm-Message-State: AOAM533J/RIXUuVl1afgWPlJmyoV5oQoRsquyQWp+d4z2rfQsNBNS/Wb
        2pwLcHYDJ1FaWF47oBPz8/Kcc1c/12ESX02iK6jMaT1ekDGvK8KLBF0BGEJn3aSKEy1yCXJiv4J
        IWoWuPIrDeBrCD+hrLycfyB6K
X-Received: by 2002:a17:907:1256:b0:6b0:5b4c:d855 with SMTP id wc22-20020a170907125600b006b05b4cd855mr5988104ejb.458.1645173369980;
        Fri, 18 Feb 2022 00:36:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBuN9YuzXKoJrN8NlGU74iYYJVw0tiqOTNuGILWFHqBgv2L9fUzDnXZnQte/0xIx4qtNqD9Q==
X-Received: by 2002:a17:907:1256:b0:6b0:5b4c:d855 with SMTP id wc22-20020a170907125600b006b05b4cd855mr5988089ejb.458.1645173369774;
        Fri, 18 Feb 2022 00:36:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id 5sm4494082edx.32.2022.02.18.00.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 00:36:09 -0800 (PST)
Message-ID: <49dcda6e-adf8-4e56-3525-ad5fbf371880@redhat.com>
Date:   Fri, 18 Feb 2022 09:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] x86/kvm: Fix compilation warning in non-x86_64
 builds
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
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220218034100.115702-1-leobras@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220218034100.115702-1-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 04:41, Leonardo Bras wrote:
> On non-x86_64 builds, the helper gtod_is_based_on_tsc() is defined but
> never used, which results in an warning with -Wunused-function, and
> becomes an error if -Werror is present.
> 
> Add #ifdef so gtod_is_based_on_tsc() is only defined in x86_64 builds.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>   arch/x86/kvm/x86.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ca0fae020961..b389517aa6ed 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2363,10 +2363,12 @@ static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
>   	return tsc;
>   }
>   
> +#ifdef CONFIG_X86_64
>   static inline int gtod_is_based_on_tsc(int mode)
>   {
>   	return mode == VDSO_CLOCKMODE_TSC || mode == VDSO_CLOCKMODE_HVCLOCK;
>   }
> +#endif
>   
>   static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
>   {

More precisely, this is an "inline" in a .c (main compilation unit) 
file.  clang warns on them even though it doesn't do that on a .h 
(included) file.

I tend not to rewind kvm/master and kvm/next unless absolutely 
necessary, so I pushed an incremental fix for kvm_guest_supported_xfd() 
as well.

Paolo

