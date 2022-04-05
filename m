Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC064F4B7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574692AbiDEXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384637AbiDEOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65ED111D7BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649163865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4H3o/lgu3i0pcf5MrN0knfGAGcFyCTknMXedxYHF10=;
        b=Qk+hScf7jQIir96nc0QLeymUfF5A8ekYuIzw7+0o8ZgdSMqu+rDUYZysdDWuHEZqepo/w8
        qoe9gpgfMOtJJ4jZL6Z+3lhilG+jx9R1QsBx1YZ7FJMc5K6GFj3j31mIujVRJXtFYm47Rr
        Eo5efe3LTxiodJGwLE4O04vGDVNoTIY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-xme13RalN2KDnHzHPjMkeQ-1; Tue, 05 Apr 2022 09:04:24 -0400
X-MC-Unique: xme13RalN2KDnHzHPjMkeQ-1
Received: by mail-wm1-f70.google.com with SMTP id i6-20020a05600c354600b0038be262d9d9so1311493wmq.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+4H3o/lgu3i0pcf5MrN0knfGAGcFyCTknMXedxYHF10=;
        b=RWBg110uq8D3UPMd+Tj9SAiAhjqoT9BnCviELZXm+sBNpRRzDRHzyBcsae77xKF2Ci
         risUR/aDIavRVkmAAQCXLw49iOOscXvoIyakRJsPYhFdXb4wB5pbSi132oIF1W5CY7JE
         XPh3uTiTw9HxzetybHw5szPdw3Djtsebcd934F87dy35IwOwClS/KxyHtvy7jbVo/Ths
         Nfcd72hH2DCdYr/oVdC+GVdkOnkScJBiA+CdmV+68QtvVb/6riWkODzzxHG0UhzZypS4
         n0BsznxZsqnuK4MkoLL1kJAd0mGrM7mBp8tlT1Vj9g2kgiz3EZXYXCakVZbkHga+AOsv
         Rz8g==
X-Gm-Message-State: AOAM533pC6mVkRpV0O+YTwbxchKtuhw3CjGSWtm4A+Dypytsx+83GDZZ
        /GNghjZ8MMy119SUj+ZpoxMPfCy76LFoyxAUcBlAjfRB+pFsAvqbIucQ5GLtBPEAAiZ+2Ss+I9b
        HjakONbCxZj+EBn5s+uMJEsU+
X-Received: by 2002:a05:600c:4fd4:b0:38c:cc3f:ac01 with SMTP id o20-20020a05600c4fd400b0038ccc3fac01mr3110637wmq.206.1649163863155;
        Tue, 05 Apr 2022 06:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTKXWIZeydbVrpApPxpI5TVS/gLhuIP6d8IrLPccqlzN5Ubrjxgzd+R1jeG967OIfKlV6SFg==
X-Received: by 2002:a1c:7519:0:b0:383:d29b:257 with SMTP id o25-20020a1c7519000000b00383d29b0257mr3095490wmc.172.1649163851954;
        Tue, 05 Apr 2022 06:04:11 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm2192280wms.15.2022.04.05.06.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:04:11 -0700 (PDT)
Message-ID: <a02a704a-e53d-6f1f-cd7f-a10b773475cc@redhat.com>
Date:   Tue, 5 Apr 2022 15:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 029/104] KVM: TDX: allocate/free TDX vcpu structure
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <e50caba2a40beaaee7fc1ade60d55d414d979d34.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <e50caba2a40beaaee7fc1ade60d55d414d979d34.1646422845.git.isaku.yamahata@intel.com>
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
> +	/*
> +	 * In TDX case, tsc frequency is per-VM and determined by the parameter
> +	 * tdh_mng_init().  Forcibly set it instead of max_tsc_khz set by
> +	 * kvm_arch_vcpu_create().
> +	 *
> +	 * This function is called after kvm_arch_vcpu_create() calling
> +	 * kvm_set_tsc_khz().
> +	 */
> +	kvm_set_tsc_khz(vcpu, kvm_tdx->tsc_khz);
> +

I think this is not needed anymore, now that there is 
kvm->arch.default_tsc_khz.  If so, exporting the function is not needed 
either.

Paolo

