Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456F94952F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377254AbiATRNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377214AbiATRNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642698823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fC9Rz1nl0EcRlodZgKlLvJmeGdyFjLwk5wksOksI7Rg=;
        b=RaE2ntu4s4XE8lZbBnkTKbCAibu3U22mUUm3AeYiw/dLmf+LmI8FVBGeakLV0lpRhKWnWo
        qkXUtotwJzK6jvDkTjJYwK1Jtu27OVXZBSjQ1bdK4ymEXOlw3kgKzE6o7EocXR8sibD1My
        82MRte8D5jo6MlVV0zwWoW+J1W0PJH4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-fdZYdMZhOFCmp-0cEGfCug-1; Thu, 20 Jan 2022 12:13:42 -0500
X-MC-Unique: fdZYdMZhOFCmp-0cEGfCug-1
Received: by mail-wm1-f70.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so7326478wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fC9Rz1nl0EcRlodZgKlLvJmeGdyFjLwk5wksOksI7Rg=;
        b=crW0j0FzN9jSc15l8N4Yu2004EZ1FCxSjYgCRB5qYbMjqsyrYIIyIzai0tqcB+wdT/
         KBLJi1jwTcBjJBBDkvGs5q/x1KFX75h8PqbZuOwICESj1c0mn13m4QLPEZ/tBn6ozRsM
         b8XWXERiUN0FaubD0nxxJmFCkRZrSOqvkOfB25/92rUqeAxXJeIw9yBaxbDRAcXB9Bhb
         iYmfBy06XuNvodBaV91d+vRKvpUyixOPNA7Vd/nUmIOmk9j6T7oQj1qqIwmPpI4VW1O4
         1Ta8Zp25+uBFRxsJ7PQyWI9UndmozMhbpqGiDlmF58xUkWVNcXsBu/BgwNnBGBU8pX2A
         KOxQ==
X-Gm-Message-State: AOAM533XG+DBMvSyKWL20fj+pOi87FhKw/Fze3jm8FsF8Hv6tGaaYn6U
        Cwt/6E5CGlOfQaC1N+3Ip9bZjvDPLdt/D6ltYJ2DA3hp07kOf+FwJXWRr99MyuFPYgSLXeSo73n
        ToTAWOZWBivIjoO89AiTXBkVN
X-Received: by 2002:a05:6000:1c1d:: with SMTP id ba29mr44919wrb.78.1642698820483;
        Thu, 20 Jan 2022 09:13:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSRCeywcM8eh72JNxUN49HsBHUyB5WOOk/6NBHCfm9T8/pz+/9qoxd3PuDX/ZTwiwJwLUUSw==
X-Received: by 2002:a05:6000:1c1d:: with SMTP id ba29mr44901wrb.78.1642698820240;
        Thu, 20 Jan 2022 09:13:40 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id a18sm3616586wrw.5.2022.01.20.09.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 09:13:39 -0800 (PST)
Message-ID: <39bb00be-e4e4-1eb5-de25-192d66aa2bc4@redhat.com>
Date:   Thu, 20 Jan 2022 18:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] docs: kvm: fix WARNINGs from api.rst
Content-Language: en-US
To:     Wei Wang <wei.w.wang@intel.com>, sfr@canb.auug.org.au
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220120045003.315177-1-wei.w.wang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220120045003.315177-1-wei.w.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 05:50, Wei Wang wrote:
> Use the api number 134 for KVM_GET_XSAVE2, instead of 42, which has been
> used by KVM_GET_XSAVE.
> Also, fix the WARNINGs of the underlines being too short.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   Documentation/virt/kvm/api.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index d3791a14eb9a..bb8cfddbb22d 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5545,8 +5545,8 @@ the trailing ``'\0'``, is indicated by ``name_size`` in the header.
>   The Stats Data block contains an array of 64-bit values in the same order
>   as the descriptors in Descriptors block.
>   
> -4.42 KVM_GET_XSAVE2
> -------------------
> +4.134 KVM_GET_XSAVE2
> +--------------------
>   
>   :Capability: KVM_CAP_XSAVE2
>   :Architectures: x86
> @@ -7363,7 +7363,7 @@ trap and emulate MSRs that are outside of the scope of KVM as well as
>   limit the attack surface on KVM's MSR emulation code.
>   
>   8.28 KVM_CAP_ENFORCE_PV_FEATURE_CPUID
> ------------------------------
> +-------------------------------------
>   
>   Architectures: x86
>   

Queued, thanks.

Paolo

