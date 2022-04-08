Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2514F92A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiDHKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiDHKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA7339F3A1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649412637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDv/rk0p/ym3Otaap0CgRvB/aOstceiT80X2oN268IM=;
        b=IAoQCqkIzlu+4Hk7fyAfvYV5vd07ulJ6K3CdCRJllErxiRIKYejYIKptisVgshDP9ih2Rd
        NzGeYq+1PBlNzHphpti8OXkJ0M0iXKLzDoZg2PgZiwTVHqskJVRz+XIEsjQLpfh2Ii6vYK
        jbmsbdpM8fl3/ndnDq+5Ves0/4lH0w0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-EyQbJNhMMbCV_gLwVWvWUg-1; Fri, 08 Apr 2022 06:10:36 -0400
X-MC-Unique: EyQbJNhMMbCV_gLwVWvWUg-1
Received: by mail-wm1-f71.google.com with SMTP id i6-20020a05600c354600b0038be262d9d9so5747589wmq.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dDv/rk0p/ym3Otaap0CgRvB/aOstceiT80X2oN268IM=;
        b=CPNVYDN2tUbgcqjm0rfNg3AoSbTNnwm/qm7Lmq1d3tG9vWjP54xFiHAVos9onnZt2O
         yRhN+DwDFs6D9+sOOtCqQnUeBgILyipWotKvb8ZRYkQ98gCUX+zxXWfihrVOLgoGGPSK
         f+1473Xr2lmrQoLHOG1hVw3A+vGsz15FI58fdyALZD76IQZVBKNtC4ksS/v3d2KSOyQI
         tUcYnWS87q/SdEm+IpM/yPJOsFurE5pVhiu3nONDQFmtbS3Oi9fGn4jMKeWcgQ+CaRu5
         YrzO/QIpG1S9lyVBUwk70wLkYGJD85nQx9RUGkIyo/BQSXbyGVmWHn3mg6eabNvcQDYE
         xYtw==
X-Gm-Message-State: AOAM533kYkJ4XYd7b1XBF2uqQr3sNV4+muhOFf6wrG/vgIEXPiPdOEJY
        xUdGyr/ebeT4P27ugqbMbrqgB68qRc3Cxj4N/chTAzxXKkpymUEcCuTbEMTBM85/JAaF+i5FDbp
        w9stVwfRmVe6qyiXM3Q4ZhvrG
X-Received: by 2002:a5d:4712:0:b0:206:120d:b038 with SMTP id y18-20020a5d4712000000b00206120db038mr14696767wrq.542.1649412635424;
        Fri, 08 Apr 2022 03:10:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1beWVQuoGGl5w6Zz3Zazu8hP0ijuNjw/pQk7dZcuH0wdWMvMcyHhbw6FqT4wuqPomqK5XFw==
X-Received: by 2002:a5d:4712:0:b0:206:120d:b038 with SMTP id y18-20020a5d4712000000b00206120db038mr14696747wrq.542.1649412635207;
        Fri, 08 Apr 2022 03:10:35 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm9776282wmn.46.2022.04.08.03.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 03:10:34 -0700 (PDT)
Message-ID: <c31a5f84-6da2-c6a0-c0cd-9f6802c39fc3@redhat.com>
Date:   Fri, 8 Apr 2022 12:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] KVM: x86/mmu: remove unnecessary
 kvm_shadow_root_allocated() check
Content-Language: en-US
To:     luofei <luofei@unicloud.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407014016.1266469-1-luofei@unicloud.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220407014016.1266469-1-luofei@unicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 03:40, luofei wrote:
> When we reach here, the return value of kvm_shadow_root_allocated()
> has already been checked to false under kvm->slots_arch_lock.
> So remove the unnecessary recheck.

It's a little less clear t check !is_tdp_mmu_enabled().

That said, this is only done once, so perhaps it's better/easier to just 
remove the if completely.

Paolo


> Signed-off-by: luofei <luofei@unicloud.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 8f19ea752704..1978ee527298 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3394,7 +3394,7 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
>   	 * Check if anything actually needs to be allocated, e.g. all metadata
>   	 * will be allocated upfront if TDP is disabled.
>   	 */
> -	if (kvm_memslots_have_rmaps(kvm) &&
> +	if (!is_tdp_mmu_enabled(kvm) &&
>   	    kvm_page_track_write_tracking_enabled(kvm))
>   		goto out_success;
>   

