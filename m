Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D45C4903FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiAQIgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:36:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238251AbiAQIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642408598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uNhzno0wWEhzgVxHRwjARVs6TzvvxzJQTz1ejQZ7JqQ=;
        b=A8mRCfAK6l4N/G9AFMgckDSyDB+nL4pCMnR1hi7QwE1uIBue9wb2fBeANa6aexmoSBLeBL
        5gqcwUP5D49NgebqpJu/hDXw+rjPiKfzlFcMKHk7vcORNw9sBreuTsvE3cfg1jE076AG6S
        LHMRYMkAPNCoH7Ic2YPoHBew0tYJHdY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-KZfgY9rcP96CfMVddnsjug-1; Mon, 17 Jan 2022 03:36:33 -0500
X-MC-Unique: KZfgY9rcP96CfMVddnsjug-1
Received: by mail-wm1-f72.google.com with SMTP id p7-20020a05600c1d8700b0034a0c77dad6so10551268wms.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uNhzno0wWEhzgVxHRwjARVs6TzvvxzJQTz1ejQZ7JqQ=;
        b=OOPZtRKABMdbHD5zDmPzFGjBTEu6QCko0M/MlETTwZVg9BLtVJCd5shanrKbiXyHPx
         8OEBOYnB+kKtnBhXLQ5JR9I5e+HQy4F0mWTUFVASOyBc+XdbNOOtNsHiXVpSaQ7aSKna
         JZ+X8tnHD7QX2LrctrzQLE8Zn99CxItidE05bYn/3zE29ZaycHVDvxv2QNwwKf7VeB3k
         qU9m9jtaG2p/nnO2dMoBRmlCnzjiWGmMA5nalnXJPkaKr2iiN8Fckh9jJO/ezsfoOOeu
         6egjzSQpilK+WikSSq+YBicgudXeoxQJGW0hVARWXGfZtdAh9vodfmkfSZf2+Lq9JDYJ
         eHwQ==
X-Gm-Message-State: AOAM531lW6xPrcIEUpu3Q3CXyPeq3oYp8n3++UR5Y/yzgKvlGUuSudYm
        guc+xmUxDLqSJdBBFpCnejlvkxptJJ+A1smodaFAbxHD1h7D/0tdbBJQVyPCWa9iA8L9i+0mRt1
        ZQryIEBzJurYozxU7hAl7cDPz
X-Received: by 2002:adf:e84f:: with SMTP id d15mr18256188wrn.15.1642408592053;
        Mon, 17 Jan 2022 00:36:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxj2pp45Ih4MGk2jlOZCfHILaORsUuOFs80diJwXqRhG219ra8KDaGLXAInm8r0EuFBpb0QPA==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr18256174wrn.15.1642408591893;
        Mon, 17 Jan 2022 00:36:31 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id r19sm12674076wmh.42.2022.01.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:36:31 -0800 (PST)
Message-ID: <4ca0ec95-6552-ac86-64e4-4b50e65c776e@redhat.com>
Date:   Mon, 17 Jan 2022 09:36:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86/svm: Add module param to control PMU
 virtualization
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211117080304.38989-1-likexu@tencent.com>
 <c840f1fe-5000-fb45-b5f6-eac15e205995@redhat.com>
 <CALMp9eQCEFsQTbm7F9CqotirbP18OF_cQUySb7Q=dqiuiK1FMg@mail.gmail.com>
 <ad3cc4b9-11d4-861b-6e31-a75564539216@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ad3cc4b9-11d4-861b-6e31-a75564539216@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 03:33, Like Xu wrote:
>>>
>>
>> Whoops! The global 'pmu' is hidden by a local 'pmu' in get_gp_pmc_amd().
> 
> Indeed, I wonder if Poalo would like to take a look at this fix:
> https://lore.kernel.org/kvm/20220113035324.59572-1-likexu@tencent.com/

Yes, my mistake.

Paolo

