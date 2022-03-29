Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6914EB4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiC2UdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiC2UdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DF4433A0B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648585897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ep24nhUy1NfqZYcqo2uvggmox6RnZ/7P2SEhxMzfOyM=;
        b=O1hblq2eBc0glFG6lH4v1TzDmvIKB3R+/JpF29SbwUC5a+Q56/jpdGiPC0+X+O0xEcVvej
        kkuq/FLnXH0qCAu7seKIZllLlvi7ph0VzjwerRPId/cKSU011kQ/JxOkdPJBcBw+txbOH0
        KgVr5MCnINTf6OFH7LHl/y4TsnPbaAo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-3WkAAZOcOq-CkFeJDiqBDg-1; Tue, 29 Mar 2022 16:31:33 -0400
X-MC-Unique: 3WkAAZOcOq-CkFeJDiqBDg-1
Received: by mail-wm1-f72.google.com with SMTP id 2-20020a1c0202000000b0038c71e8c49cso4318wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ep24nhUy1NfqZYcqo2uvggmox6RnZ/7P2SEhxMzfOyM=;
        b=Dm6Z/wMNiw+XiZOzOMXrFeaSguXy0oreTGWKlW6Vo4nHDZjIKnIDXWNoQJydYiP0cy
         TerZTR+Q1epsNYUQPex6gL1gJe4JHd/IBu28FNMOZaLrcHZVYV2VteSGmAg87VvTPa37
         e3zNWO8Cp7NIsdj8LfaqnULwsSmyETafc64Itd8OQOR88K4JXZVFS8TbC4fnjQR7kjsA
         5H1zs+4bz86XlEsHuRZ0BMdPwiZ9/EwXeKVZhhIdLSl0Z/psaf/n+UwuAZj2/lWxp1Mj
         OGgZj7gDsGCrJ3k7Nj8m7WHe1bSvvEhG/ugpAAPqOwGq4O96O0D+vkF7MJyF5Jsk+PY7
         ZMuw==
X-Gm-Message-State: AOAM531a0l9Li6wNeXkgE2p1SvvM8qfu+oIw6O1jh7vOKWjMUpa2PQWn
        jv5Yt9t6POIEFYX1j3YmyggNfYaJJX5X+XjG9+UctVUPmhl+AhHAbf/xB4nShqlFU76Uv7DKQTL
        Ho+ZVQxs20LF3HL9pKH+37q0Q
X-Received: by 2002:adf:e2cc:0:b0:203:e8ba:c709 with SMTP id d12-20020adfe2cc000000b00203e8bac709mr33615675wrj.713.1648585892559;
        Tue, 29 Mar 2022 13:31:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBmMNc4KsEsOZNqGNoV8S7Z3pC1zatXcvDbPiEslZ3NI4NbZQOv6xaXesMrj4EBZ0rxoQ3jQ==
X-Received: by 2002:adf:e2cc:0:b0:203:e8ba:c709 with SMTP id d12-20020adfe2cc000000b00203e8bac709mr33615658wrj.713.1648585892284;
        Tue, 29 Mar 2022 13:31:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8ca6:a836:a237:fed1? ([2001:b07:6468:f312:8ca6:a836:a237:fed1])
        by smtp.googlemail.com with ESMTPSA id r12-20020a5d6c6c000000b00203ec2b1255sm20257578wrz.60.2022.03.29.13.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 13:31:31 -0700 (PDT)
Message-ID: <d8f5f25d-e544-dea7-2474-6d98fea39cbc@redhat.com>
Date:   Tue, 29 Mar 2022 22:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH V2 0/4] KVM: X86: Add and use shadow page with level
 expanded or acting as pae_root
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>
References: <20220329153604.507475-1-jiangshanlai@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220329153604.507475-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 17:36, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> (Request For Help for testing on AMD machine with 32 bit L1 hypervisor,
> see information below)
> 
> KVM handles root pages specially for these cases:
> 
> direct mmu (nonpaping for 32 bit guest):
> 	gCR0_PG=0
> shadow mmu (shadow paping for 32 bit guest):
> 	gCR0_PG=1,gEFER_LMA=0,gCR4_PSE=0
> 	gCR0_PG=1,gEFER_LMA=0,gCR4_PSE=1
> direct mmu (NPT for 32bit host):
> 	hEFER_LMA=0
> shadow nested NPT (for 32bit L1 hypervisor):
> 	gCR0_PG=1,gEFER_LMA=0,gCR4_PSE=0,hEFER_LMA=0
> 	gCR0_PG=1,gEFER_LMA=0,gCR4_PSE=1,hEFER_LMA=0
> 	gCR0_PG=1,gEFER_LMA=0,gCR4_PSE={0|1},hEFER_LMA=1,hCR4_LA57={0|1}
> Shadow nested NPT for 64bit L1 hypervisor:
> 	gEFER_LMA=1,gCR4_LA57=0,hEFER_LMA=1,hCR4_LA57=1
> 
> They are either using special roots or matched the condition
> ((mmu->shadow_root_level > mmu->root_level) && !mm->direct_map)
> (refered as level expansion) or both.
> 
> All the cases are using special roots except the last one.
> Many cases are doing level expansion including the last one.

Hi Jiangshan,

so the main difference between direct and passthrough shadow pages is 
that passthrough pages can have indirect children.  A direct page maps 
the page at sp->gfn, while a passthrough page maps the page _table_ at 
sp->gfn.  Is this correct?

If so, I think there is a difference between a passthrough page that
maps a level-2 page from level-4, and a passthrough page that maps a
level-3 page from level-4.  If that is true, a single bit in the role
is not enough.

One way to handle this could be to have a single field "mapping_level"
that subsumes both "direct" and "passthrough".  direct==1
would correspond to "mapping_level == 0"; direct==0 && passthrough==0 
would be "mapping_level == level"; anything in the middle would be a 
passthrough page in your series.

What do you think?

Thanks,

Paolo

