Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB94C45CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiBYNRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbiBYNRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:17:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34A8A18E3E2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645795029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98ASH+Ojql5TMdnoXEkFgsLyBZPJgLPGXzcJbfRwQ+Q=;
        b=Ie9iKciUFJ9qr11GA+DFSx2chBkbiNYUIVMSmLs4uUgc2QdiUHwnjNra/SYoUz4ZFV5RSs
        3X3MAOeIV9xJKSBo8j4Av0CMSXGumkbexxV+kYmzD5u7IKJSM2E9b/OCULVStH/Q5Ylpv0
        cpSn57XZRCjAc3EnvxKf8dmVj5ryJFo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-5RKThJiYNbOfAmChgsZBvw-1; Fri, 25 Feb 2022 08:17:08 -0500
X-MC-Unique: 5RKThJiYNbOfAmChgsZBvw-1
Received: by mail-wr1-f70.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so874114wrg.20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=98ASH+Ojql5TMdnoXEkFgsLyBZPJgLPGXzcJbfRwQ+Q=;
        b=fX69PEJyVZc1qN91WIGcQJAVMf/mDnAe5vb6Yj+Eh1No6YCb7u5TrAfHkSAqr1fyBv
         NTlpl0SeHpiUaAC9YkGttS4ee8kz9pMujNlbs2cJ1Ur+3VIL+H+xNI1zjyxz8apk4sFp
         3F6izvnxXkiMuko1O8wttfj3WFTwB/ZRdUP38VkZ8WMGlQdxZ2lpDDsz/PSrmBTNMUyF
         ZZNrcEZY1H2wGCX4aDAwQf5pXfAXchXIDfAJuPPUa6l8xM3bAPYuoLGxYNRE9TQ2EaF6
         m0hYr9qVobefh8s/L/f5g4ByMdWzSFWMwdBFNN4c8U36kQR5y5NKvldnf2k4yZfi36F1
         6C2w==
X-Gm-Message-State: AOAM5306gANyHEeMhiz16wmctxvExinb7SgNvYv5ZDY4MQoZxnsWveVS
        ybfJT78WzI6R02ffdhMyLmftVa59mSQJNYn59V40IrQkispbbG5xNmekpEkb0bmDZFcV5GBxTXQ
        fy1aKh5R9XS/VKVf/ZnJ4JbvU
X-Received: by 2002:a1c:5459:0:b0:381:40b0:1ee8 with SMTP id p25-20020a1c5459000000b0038140b01ee8mr680657wmi.66.1645795026794;
        Fri, 25 Feb 2022 05:17:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxN7pVXxVV0JtwbnyQO2DO/9DYfN40PnDMUu6i7eqpKqOzRak+xNGQ/g128tClDoCJh23soQQ==
X-Received: by 2002:a1c:5459:0:b0:381:40b0:1ee8 with SMTP id p25-20020a1c5459000000b0038140b01ee8mr680642wmi.66.1645795026563;
        Fri, 25 Feb 2022 05:17:06 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm2214887wrm.82.2022.02.25.05.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:17:06 -0800 (PST)
Message-ID: <f398b5de-c867-98a4-a716-b18939cfd0ef@redhat.com>
Date:   Fri, 25 Feb 2022 14:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] KVM: x86: hyper-v: XMM fast hypercalls fixes
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
References: <20220222154642.684285-1-vkuznets@redhat.com>
 <b466b80c-21d1-f298-b4cd-a4b58988f767@redhat.com> <871qzrdr6x.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <871qzrdr6x.fsf@redhat.com>
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

On 2/25/22 14:13, Vitaly Kuznetsov wrote:
> Let's say we have 1 half of XMM0 consumed. Now:
> 
>   i = 0;
>   j = 1;
>   if (1)
>       sparse_banks[0] = sse128_lo(hc->xmm[0]);
> 
>   This doesn't look right as we need to get the upper half of XMM0.
> 
>   I guess it should be reversed,
> 
>       if (j % 2)
>           sparse_banks[i] = sse128_hi(hc->xmm[j / 2]);
>       else
>           sparse_banks[i] = sse128_lo(hc->xmm[j / 2]);

Yeah, of course.

Thanks!

Paolo

