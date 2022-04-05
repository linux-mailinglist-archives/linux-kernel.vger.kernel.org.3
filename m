Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAAB4F508F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842259AbiDFBaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbiDEOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C26B01557F6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649163490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7YDzc0txooe4wDXjoZKV+HdiLgjGSAsT9wsXDKfsIc=;
        b=FKCw3Ti/+ORFFLtV7Tm8IUe5bp3acUYA1EXqpzxN3iRUr53lZTW/6WUTmkReqBvcof880l
        nYAr6po6kjbbJIFH3pac94g2YH0Q+dT9tK3B74QVliuIBALsLjKVdm3lDeGfC42FV4qV/Q
        zBfERp1jE8MyihcLzcpl4gote1tUzrU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-k7qXx2a9MtyUJ_rIkDzG8A-1; Tue, 05 Apr 2022 08:58:08 -0400
X-MC-Unique: k7qXx2a9MtyUJ_rIkDzG8A-1
Received: by mail-wm1-f69.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so1314277wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I7YDzc0txooe4wDXjoZKV+HdiLgjGSAsT9wsXDKfsIc=;
        b=318g+CFF7i7tEZz7irbT+DZNn5/+iizwTgX4341R9NtSmpeH/t+krxiQVbnnEuHaMe
         noKjObDx39YQz9p1u+2JBUAoOnu+wFvAl74g4PqnBScRQgaEz53tUh/E1fiqqurnuUvX
         ckblhylWH2yXpy/H0s5E1KLY55nMBMTV2mohNgb+Xn7Wxs6J0BBIEzD7+8ekuZ+FQ2iK
         WWAoY2H0GuzMHUOuEt1f6FJDUBsHEFOIGj5syMBMNsDu0MIDS+pGHOVvtE7a9EH81Bie
         fqDNkOT5IE2mCh62Xp+ZBeMQJGRthvdosWVle/wecjru/30SJ+deVWMsnjqPnynB+vEM
         a/mg==
X-Gm-Message-State: AOAM530ABlKDzgnDtApKar6tZUOxd63qQQ++rbXg/PG7rMX+jTEQLY21
        1QNj17Ijk/x2wGK2TfCw0QmY+CfwuejPPra9S+nklD9NuzWgghY86Cu4TBtnPVGjVOZomOAgruy
        AuczdcuQrOvwBKoIfEAgSX2Ws
X-Received: by 2002:a7b:c347:0:b0:37e:68e6:d85c with SMTP id l7-20020a7bc347000000b0037e68e6d85cmr3142058wmj.176.1649163487130;
        Tue, 05 Apr 2022 05:58:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOngzMtEU2KPnwylW2akB8kPVoiTa6yBmTv34dc8nvDFuKKvuEx56M9l/8R39QBk1A2dB1TQ==
X-Received: by 2002:a7b:c347:0:b0:37e:68e6:d85c with SMTP id l7-20020a7bc347000000b0037e68e6d85cmr3142030wmj.176.1649163486869;
        Tue, 05 Apr 2022 05:58:06 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b0038cbd8c41e9sm2096679wmq.12.2022.04.05.05.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 05:58:05 -0700 (PDT)
Message-ID: <e392b53a-fbaa-4724-07f4-171424144f70@redhat.com>
Date:   Tue, 5 Apr 2022 14:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 027/104] KVM: TDX: initialize VM with TDX specific
 parameters
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <c3b37cf5c83f92be0e153075d81a80729bf1031e.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <c3b37cf5c83f92be0e153075d81a80729bf1031e.1646422845.git.isaku.yamahata@intel.com>
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
> +	td_params->attributes = init_vm->attributes;
> +	if (td_params->attributes & TDX_TD_ATTRIBUTE_PERFMON) {
> +		pr_warn("TD doesn't support perfmon. KVM needs to save/restore "
> +			"host perf registers properly.\n");
> +		return -EOPNOTSUPP;
> +	}

Why does KVM have to hardcode this (and LBR/AMX below)?  Is the level of 
hardware support available from tdx_caps, for example through the CPUID 
configs (0xA for this one, 0xD for LBR and AMX)?

> +	/* PT can be exposed to TD guest regardless of KVM's XSS support */
> +	guest_supported_xss &= (supported_xss | XFEATURE_MASK_PT);
> +	td_params->xfam = guest_supported_xcr0 | guest_supported_xss;
> +	if (td_params->xfam & TDX_TD_XFAM_LBR) {
> +		pr_warn("TD doesn't support LBR. KVM needs to save/restore "
> +			"IA32_LBR_DEPTH properly.\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (td_params->xfam & TDX_TD_XFAM_AMX) {
> +		pr_warn("TD doesn't support AMX. KVM needs to save/restore "
> +			"IA32_XFD, IA32_XFD_ERR properly.\n");
> +		return -EOPNOTSUPP;
> +	}

> 
> +	if (init_vm->tsc_khz)
> +		guest_tsc_khz = init_vm->tsc_khz;
> +	else
> +		guest_tsc_khz = max_tsc_khz;

You can just use kvm->arch.default_tsc_khz in the latest kvm/queue.

> +#define BUILD_BUG_ON_MEMCPY(dst, src)				\
> +	do {							\
> +		BUILD_BUG_ON(sizeof(dst) != sizeof(src));	\
> +		memcpy((dst), (src), sizeof(dst));		\
> +	} while (0)
> +
> +	BUILD_BUG_ON_MEMCPY(td_params->mrconfigid, init_vm->mrconfigid);
> +	BUILD_BUG_ON_MEMCPY(td_params->mrowner, init_vm->mrowner);
> +	BUILD_BUG_ON_MEMCPY(td_params->mrownerconfig, init_vm->mrownerconfig);
> +


Please rename to MEMCPY_SAME_SIZE.

Thanks,

Paolo

