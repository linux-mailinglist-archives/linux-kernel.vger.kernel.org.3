Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA04BF3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiBVIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBVIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E64118615
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645518823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibCyDResb91RovUnBv8GIoexbZJ5js81Fq9QJozqMIw=;
        b=dsMN4o8Eh2bwFeDVuP7R3Sy/ELPVwXgoAbMrcRe3g3zzIbRKDxA0mNGmpvSZ6wMpW2vq0K
        w3VGy4Ft29YA3Rq4vn9uUWRwdQYZwwr27qVKb0DJl/oQ4+5ZYZX3CVQ6MpTtelusJqKxa2
        xFS9aqlHRmhYQoAjJ8RSjPd0N+ytgFg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-TN4fW3xkMFGoH4DHpuiqFQ-1; Tue, 22 Feb 2022 03:33:41 -0500
X-MC-Unique: TN4fW3xkMFGoH4DHpuiqFQ-1
Received: by mail-wm1-f70.google.com with SMTP id i20-20020a05600c051400b00380d5eb51a7so233453wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ibCyDResb91RovUnBv8GIoexbZJ5js81Fq9QJozqMIw=;
        b=eun3+VKLeapi2semajIcBcUh0+DyuaRjfTzClsaTwMaCYA0cQ9d02a8oqJDhcmLKWY
         uA/gKNQwOPPO6UOUyGylC7KUlgBux1k87Yi4raKyUeNiLgETUu0hhsrKNY6BOgMyjSuq
         9MlZNrp3lBMLq/5N7CarkTnrdGHIoTiNAuC5ZRN1knyvrY27bHMQ1XDs/l/g6/8848/2
         rf+TDLai5wYGCRmRnpPeKVVXBKk1McYFLTJUDJvoCu7ksJLTQZc0E2clVVyZxHyYxZ6n
         eV9dsTdFTa9IX63ZgUtwYlz96M+wiC4kFMQRYe5edJ52oV72y+QEutFpgy1fbQAmfFRl
         wA9A==
X-Gm-Message-State: AOAM533jxvfm0NPUcA6zUVK1B5MV00Ozyf6jTj7oFlosohYw4Xd1UeTz
        M2VGUFtpBEux8X6I8NYMW8y619nSwg6yg1RdJnbQR+rdNbR/zTzW2BFK9UbqNde1pMYRRjbMkDN
        4YaZ+gdZlLoFEamPdiAIcq/6O
X-Received: by 2002:a5d:55cd:0:b0:1e3:30ee:858 with SMTP id i13-20020a5d55cd000000b001e330ee0858mr18442267wrw.344.1645518820687;
        Tue, 22 Feb 2022 00:33:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKfMUzK5YMtBy1acQZBftJ5rLQYuElo69SnZRmXeESvFpU7FrUCI8tnaYVz4XVm3hyg+m0JA==
X-Received: by 2002:a5d:55cd:0:b0:1e3:30ee:858 with SMTP id i13-20020a5d55cd000000b001e330ee0858mr18442251wrw.344.1645518820486;
        Tue, 22 Feb 2022 00:33:40 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id p12sm1712785wmg.36.2022.02.22.00.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:33:39 -0800 (PST)
Message-ID: <01ba8559-b6f9-cc75-2080-7308a04ce262@redhat.com>
Date:   Tue, 22 Feb 2022 09:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] KVM: x86: Fix function address when kvm_x86_ops.func is
 NULL
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>
References: <20220222062510.48592-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220222062510.48592-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 07:25, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Fix the function address for __static_call_return0() which is used by
> static_call_update() when a func in struct kvm_x86_ops is NULL.
> 
> Fixes: 5be2226f417d ("KVM: x86: allow defining return-0 static calls")
> Signed-off-by: Like Xu <likexu@tencent.com>

Sorry for the stupid question, but what breaks?

Paolo

> ---
>   arch/x86/include/asm/kvm_host.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 713e08f62385..312f5ee19514 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1548,7 +1548,7 @@ static inline void kvm_ops_static_call_update(void)
>   #define KVM_X86_OP_OPTIONAL __KVM_X86_OP
>   #define KVM_X86_OP_OPTIONAL_RET0(func) \
>   	static_call_update(kvm_x86_##func, kvm_x86_ops.func ? : \
> -			   (void *) __static_call_return0);
> +			   (void *)&__static_call_return0);
>   #include <asm/kvm-x86-ops.h>
>   #undef __KVM_X86_OP
>   }

