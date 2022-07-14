Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC6E5751FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiGNPi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbiGNPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CFA16069C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5Z13oVcpp8qclm0mCwL8Kzfkdtg4fQqLSWyr/f5fA0=;
        b=YMA54hyqurxvwlEq7MZBgN/kmr10EvpacYmCAG9uVF/S1tj4xknEPI9RF3zRaiUCuwAfx+
        v1kp4UpRQ+LWYF7xOw0R6vsa5avD3a0jiZboFArHV+31S8L7bpYrIT/Vp8perCllYqkGxn
        sISBAlUgo1NiFRzGaThiLDSA3fjQccQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-6DJB1ihNNSG6dnvSCDkShA-1; Thu, 14 Jul 2022 11:38:19 -0400
X-MC-Unique: 6DJB1ihNNSG6dnvSCDkShA-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020a056402278f00b0043acaf76f8dso1708729ede.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P5Z13oVcpp8qclm0mCwL8Kzfkdtg4fQqLSWyr/f5fA0=;
        b=K5EUiDw5wqLJtRSvgzmcygKgAYlqsnJuOIQDaMEYAPtFBilvYDblwVsfRH44ngSPZ0
         tsawpkBfZzXs3DhFaKv11/BWnSFfvLkAw+TC1yJqGTK2H9Hxx65xVY+joMCZOmDfnj6O
         u9uHGczSTDuHU2alAIM3J5tseG8/nRSRZUPBSTKm6IdQ5lu+Owksf85cl5UgtseVqAaX
         5zzIIJLpsrkU852kwTjazDeYlUKn4zh9G39Ow5jyqaCw221UOAwgjE3UPY2rvc+/WvvR
         LV2P6BzYXE4hZIIp0luIQb0e3Pf8zrSQHYXvLoF4Pu8mtscrE8UAoHRuY+wb2fdpithc
         wjlQ==
X-Gm-Message-State: AJIora9auOCDlGg9NPwLil1GOpWq/VGMqfIbY9a9Vtq29ZxhIWeVIZTT
        3hagDNmKlimN0camg2WIpIb+ZZhcIuKoOIHke5TREpRKZr/L7calMBiXFoC9HX307ocIDyUHyp6
        PxRHPRzypPTmKOWtYhYp+A5CJ
X-Received: by 2002:a05:6402:228f:b0:43a:896:e4f0 with SMTP id cw15-20020a056402228f00b0043a0896e4f0mr12803953edb.81.1657813098561;
        Thu, 14 Jul 2022 08:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1snZBx2XNszb4BuZBM78HEgBogAgCQ6gRW/x0MeMQhgt7EzwojStlVPIYxjVhTfL3dfr64PNg==
X-Received: by 2002:a05:6402:228f:b0:43a:896:e4f0 with SMTP id cw15-20020a056402228f00b0043a0896e4f0mr12803929edb.81.1657813098348;
        Thu, 14 Jul 2022 08:38:18 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id sa42-20020a1709076d2a00b007081282cbd8sm821831ejc.76.2022.07.14.08.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 08:38:17 -0700 (PDT)
Message-ID: <dbce7bba-12ac-1df5-c81b-32392830f77d@redhat.com>
Date:   Thu, 14 Jul 2022 17:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] KVM: x86: Add dedicated helper to get CPUID entry with
 significant index
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712000645.1144186-1-seanjc@google.com>
 <8a1ff7338f1252d75ff96c3518f16742919f92d7.camel@redhat.com>
 <Ys2i2B/jt5yDsAKj@google.com> <Ys2qwUmEJaJnsj6r@google.com>
 <087db845684c18af112e396172598172c7cc9980.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <087db845684c18af112e396172598172c7cc9980.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 12:58, Maxim Levitsky wrote:
> On Tue, 2022-07-12 at 17:09 +0000, Sean Christopherson wrote:
>> On Tue, Jul 12, 2022, Sean Christopherson wrote:
>>> On Tue, Jul 12, 2022, Maxim Levitsky wrote:
>>>> On Tue, 2022-07-12 at 00:06 +0000, Sean Christopherson wrote:
>>>>> +               /*
>>>>> +                * Function matches and index is significant; not specifying an
>>>>> +                * exact index in this case is a KVM bug.
>>>>> +                */
>>>> Nitpick: Why KVM bug? Bad userspace can also provide a index-significant entry for cpuid
>>>> leaf for which index is not significant in the x86 spec.
>>>
>>> Ugh, you're right.
>>>
>>>> We could arrange a table of all known leaves and for each leaf if it has an index
>>>> in the x86 spec, and warn/reject the userspace CPUID info if it doesn't match.
>>>
>>> We have such a table, cpuid_function_is_indexed().  The alternative would be to
>>> do:
>>>
>>>                  WARN_ON_ONCE(index == KVM_CPUID_INDEX_NOT_SIGNIFICANT &&
>>>                               cpuid_function_is_indexed(function));
>>>
>>> The problem with rejecting userspace CPUID on mismatch is that it could break
>>> userspace :-/  Of course, this entire patch would also break userspace to some
>>> extent, e.g. if userspace is relying on an exact match on index==0.  The only
>>> difference being the guest lookups with an exact index would still work.
>>>
>>> I think the restriction we could put in place would be that userspace can make
>>> a leaf more relaxed, e.g. to play nice if userspace forgets to set the SIGNFICANT
>>> flag, but rejects attempts to make guest CPUID more restrictive, i.e. disallow
>>> setting the SIGNFICANT flag on leafs that KVM doesn't enumerate as significant.
>>>
>>>>> +               WARN_ON_ONCE(index == KVM_CPUID_INDEX_NOT_SIGNIFICANT);
>>
>> Actually, better idea.  Let userspace do whatever, and have direct KVM lookups
>> for functions that architecturally don't have a significant index use the first
>> entry even if userspace set the SIGNIFICANT flag.  That will mostly maintain
>> backwards compatibility, the only thing that would break is if userspace set the
>> SIGNIFICANT flag _and_ provided a non-zero index _and_ relied on KVM to not match
>> the entry.
> 
> Makes sense as well.

Squashed and queued, thanks.

Regarding function and index, I never remember the "function" name, but 
it's pretty obvious that the index is ecx so there's no ambiguity.  And 
using different names for inputs and outputs makes it clear that there 
are no games with in/out parameters.

Paolo
Paolo

