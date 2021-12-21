Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04ED47BCE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhLUJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:30:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232603AbhLUJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640079054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDP731re5DMtQOApW41TGX/daqIlWGEhnQrLBNbi7cU=;
        b=UJ1G9+aC/wLQj6TtCQu/frP4WdqRKcc9qbxvhTdn1RDqW3N86TQro2KmbfLRqvAhcGTAt6
        JRnlbQeRBcuCRWadJwTJsZUr4PCEh7r0/7x25YjXzzk9RJ+yej/SSLt52T3OUsAibrNkv/
        Ac4CzuHCiXhE+FQBl/Qx9VKKvE65FAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-VWnp8ExyPGWVsOcK2XHS_w-1; Tue, 21 Dec 2021 04:30:52 -0500
X-MC-Unique: VWnp8ExyPGWVsOcK2XHS_w-1
Received: by mail-wr1-f69.google.com with SMTP id v6-20020adfa1c6000000b001a26d0c3e32so3081733wrv.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MDP731re5DMtQOApW41TGX/daqIlWGEhnQrLBNbi7cU=;
        b=UAlaMWwVz5u/WiVJGu7+j+RtQPLBCRCH17FK242NhHfCshqubot312uQ5nLlOdo2f7
         NJGE5+2lyBcFSAnhBAxUmoP4ygj9+J/auvi2mpr60IbWZ1H/lrd0D93IDcH3g6Jm/dZt
         1IBLd+MsXw8cmnVoYavz5BJOIfAGdtnk906IyWQFACtsIgeDAFxl4eyW2/WyM/iGEoP2
         XGLsGDjFLQkiaN2oZTC9wpFBXeY8pcm4g1mT3xT2cUvJynvjxo/EZpn1Arqiepx3fbpg
         kL40uo5dQ4JPEhxDWGPUMARJkN0O9sHaFQ2QTEIWXzHu4pKeTVJzDar62D3YeWGFnHLN
         vftQ==
X-Gm-Message-State: AOAM531QP3Bpe1ynMMwrOzx9FcaLYv6WsWMONVldELFyiBEYJlRyZ0OE
        ebqF3AafT77VhiIxocCk618arT1G6LT4q73z1f7Gb6A+rVDP5n5oFzbe7V8WZKngRNph5D/4ZJx
        zXmAZRzGag7aZhxTIJ13EiqyV
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr1820860wri.704.1640079051269;
        Tue, 21 Dec 2021 01:30:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4OPUY2kgWsIwpXa/+dQUUQY5BJbjatdV1r5w+V9wm4oetQS+1VJTpTYIkBdnpO2hY/PhkRg==
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr1820839wri.704.1640079051075;
        Tue, 21 Dec 2021 01:30:51 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id j17sm10390448wrp.68.2021.12.21.01.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 01:30:50 -0800 (PST)
Message-ID: <34ad15d6-d525-1fe0-8aa7-92a52a19861c@redhat.com>
Date:   Tue, 21 Dec 2021 10:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 18/23] kvm: x86: Get/set expanded xstate buffer
Content-Language: en-US
To:     "Wang, Wei W" <wei.w.wang@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "seanjc@google.com" <seanjc@google.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
References: <20211217153003.1719189-1-jing2.liu@intel.com>
 <20211217153003.1719189-19-jing2.liu@intel.com>
 <3ffa47eb-3555-5925-1c55-f89a07ceb4bc@redhat.com>
 <e0fd378de64f44fd8becfe67b02cb635@intel.com>
 <219a751e-ac2d-9ce1-9db7-7d5b1edd6bdd@redhat.com>
 <c06fdc4f3b4d4346ae80801a6c3a6ff2@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <c06fdc4f3b4d4346ae80801a6c3a6ff2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 10:06, Wang, Wei W wrote:
>> (I'm not sure if the first sentence is true in the code, but if not it is a bug that
>> has to be fixed :)).
> For the implementation, KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2) always return kvm->vcpus[0]->arch.guest_fpu.uabi_size.
> Do you want to change it to below?
> 
> If (kvm->vcpus[0]->arch.guest_fpu.uabi_size < 4096)
> 	return 0;

return 4096;

since the minimum size of struct kvm_xsave2 (with no extra) is 4096.

Paolo

> else
> 	return kvm->vcpus[0]->arch.guest_fpu.uabi_size;
> 
> If the size is less than 4096 (e.g. no dynamic xfeatures enabled),
> userspace should use the old KVM_GET_XSAVE (instead of KVM_GET_XSAVE2)?
> (KVM_GET_XSAVE2 supports to work with size less than 4096, so I think this isn't necessary)

