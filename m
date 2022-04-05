Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC054F4B91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575070AbiDEXCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456966AbiDEQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C61AFDE02
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649172339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TksMvZLxU5D3wLYdweZNWRXI8BerHHYyfmDHfh4uH8=;
        b=LJDi9TzNFgedT6ApbPSnY7PYlk32uSzfYfe2NW9ZNs/flh0dzFpJ3YUln0lI1LG3Hhec8k
        f8/8J9QFD7VyIyg5nur5YjIp7PHuqjdkoPKkt/q2/h11m1syTdOSZ+G17ErqdsSq7WmwCV
        WUxyk6ZUeNXL8URaWUOncK5lmWu+kMI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-JGcf45s0O-qKYD98qyRAfw-1; Tue, 05 Apr 2022 11:25:38 -0400
X-MC-Unique: JGcf45s0O-qKYD98qyRAfw-1
Received: by mail-qv1-f72.google.com with SMTP id j15-20020a05621419cf00b00443ce184f48so7517892qvc.20
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8TksMvZLxU5D3wLYdweZNWRXI8BerHHYyfmDHfh4uH8=;
        b=y2RQwK5h5CC7bVWkTUkUWWJDRs2SoDNHyT1Dmrt7mzwFFt1ofr7hAHpxJ1rB+BUI2G
         wtwPbLOQA/bpD0zgpa3J2Dc8Fi+Y+4caqNLUEfduv2sy3jEJ4MHFP1rp85B6bz9DJNM6
         r4h+IJnYOmjjHkU7AX5yLYwyNAQXn1e608VmtK75hdrrUWZ3116NrqAXxh5a32XnPfom
         M7S0dMjetoly2c3GDhDT+d6VXRi+1JnoqNAM7iFawB0NgsT/624LN2dFTfvnDSdkz5KZ
         MlxaSQomk5lv8QDmGRgjOCs5aO34RGW1BfQgWKjlg7FooCwA1WV710djIiQ95b+yr6o2
         NnTw==
X-Gm-Message-State: AOAM533EdM6b7Wz6XuaFZOctJIfrg9VFRW/9VudoN0ThXVfWwQN0rplM
        aliwiTuUizHUhasF28oMsitGnuE5WE1dv4I+GCa/BfydXrV6tKt/6Hz/Zjw2RblaX3HzCHK+7V1
        sl/opS9u5LUmENpxw9vYLUXRZ
X-Received: by 2002:a05:620a:1a26:b0:680:ae30:4f3 with SMTP id bk38-20020a05620a1a2600b00680ae3004f3mr2659093qkb.372.1649172338118;
        Tue, 05 Apr 2022 08:25:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk1CXI1DZ2crMHFuoHw3aJEAaOcePFY/oBq7yxA8t3U2kwtMvwTZgOQ0iyPnS08ku/SZl0Dw==
X-Received: by 2002:a05:620a:1a26:b0:680:ae30:4f3 with SMTP id bk38-20020a05620a1a2600b00680ae3004f3mr2659069qkb.372.1649172337808;
        Tue, 05 Apr 2022 08:25:37 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id 188-20020a3709c5000000b0067b147584c2sm8150698qkj.102.2022.04.05.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 08:25:37 -0700 (PDT)
Message-ID: <84d56339-4a8a-6ddb-17cb-12074588ba9c@redhat.com>
Date:   Tue, 5 Apr 2022 17:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 042/104] KVM: x86/mmu: Track shadow MMIO value/mask
 on a per-VM basis
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <b494b94bf2d6a5d841cb76e63e255d4cff906d83.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <b494b94bf2d6a5d841cb76e63e255d4cff906d83.1646422845.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 20:48, isaku.yamahata@intel.com wrote:
> +	if (enable_ept) {
> +		const u64 init_value = enable_tdx ? VMX_EPT_SUPPRESS_VE_BIT : 0ull;
>   		kvm_mmu_set_ept_masks(enable_ept_ad_bits,
> -				      cpu_has_vmx_ept_execute_only());
> +				      cpu_has_vmx_ept_execute_only(), init_value);
> +		kvm_mmu_set_spte_init_value(init_value);
> +	}

I think kvm-intel.ko should use VMX_EPT_SUPPRESS_VE_BIT unconditionally 
as the init value.  The bit is ignored anyway if the "EPT-violation #VE" 
execution control is 0.  Otherwise looks good, but I have a couple more 
crazy ideas:

1) there could even be a test mode where KVM enables the execution 
control, traps #VE in the exception bitmap, and shouts loudly if it gets 
a #VE.  That might avoid hard-to-find bugs due to forgetting about 
VMX_EPT_SUPPRESS_VE_BIT.

2) or even, perhaps the init_value for the TDP MMU could set bit 63 
_unconditionally_, because KVM always sets the NX bit on AMD hardware. 
That would remove the whole infrastructure to keep shadow_init_value, 
because it would be constant 0 in mmu.c and constant BIT(63) in tdp_mmu.c.

Sean, what do you think?

Paolo

