Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE55563998
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiGATNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGATNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 866B43CA4F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656702780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h152FewPrKnZVbE5g81JHsdbsg+iR3FNew4h05nwfCo=;
        b=BnP/WvBmqA82YXljhB2myERFQVO1lpXQ7xwGV0PI/5aQy03AvggkMiM1O0OdUv24JTDrPK
        ONlH8nNl/mnQsmrOxY/J7Ql9iIElcnPD4+9tSYnJQReK8Lk4tGmj/0iONrRIIui1QnfD6M
        PJG6PzPso74HQ37+VjTJsL71murcfQc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-_TkA17dGOxaCnUBJKkx2Kw-1; Fri, 01 Jul 2022 15:12:59 -0400
X-MC-Unique: _TkA17dGOxaCnUBJKkx2Kw-1
Received: by mail-wr1-f70.google.com with SMTP id w17-20020a5d6811000000b0021ba89c2e27so555219wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 12:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=h152FewPrKnZVbE5g81JHsdbsg+iR3FNew4h05nwfCo=;
        b=PqcQ8aociJcHGbPGrwUUthaJaeGhA8caUGBQKW/ZptwOOg7Q+vLDsBc0KUw9Zojk0X
         O8MTA6lb9ExCIMTSxE4PXs0DssI2Ya2IH3nrvgLd2K0NOIiry4e4igbEVARIHMsGW0+0
         eeiNKVW508pBzR9FJWJhCS6hmJdNQBtFtya0dgzhhe6dq8PepuJuuoS7v3Md6NYEDrk4
         W/s4Q/psoiN3tAsuwL+teBScC7PufvLrj2tpJfQKT1ojGArD77L74IP3Fh0ofF98lae2
         NrpdqRopDb1g5ufl5tlLlalT8zW3wH6NDsjFCF6sZ6Jvw6rctwDt8GgvxnylC5BIk5II
         /kXQ==
X-Gm-Message-State: AJIora9P62XWgVCdfhkXxdzrEW+seAlTljk1otn4TpXOUo9y8iWycgYO
        3/tDTgDE0JeoApVkIAIFKuE2Hy6HsvuDbC51NOD0VJMnoW8TK0GzKyG0+IZD4WvC6iIvhQjJwFk
        89aBS9vCvAbU+PBvnSX7juIfP
X-Received: by 2002:a05:600c:4f11:b0:3a1:8631:b6b4 with SMTP id l17-20020a05600c4f1100b003a18631b6b4mr9168385wmq.94.1656702778197;
        Fri, 01 Jul 2022 12:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sLzZyIb1fG4orx1PBfl+peet0Bt+n/odU70W6XVArPjhw07JD2zK/VbipQTMb95tN7YpKNoQ==
X-Received: by 2002:a05:600c:4f11:b0:3a1:8631:b6b4 with SMTP id l17-20020a05600c4f1100b003a18631b6b4mr9168376wmq.94.1656702777926;
        Fri, 01 Jul 2022 12:12:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:e300:d7a0:7fc3:8428:43e5? (p200300cbc709e300d7a07fc3842843e5.dip0.t-ipconnect.de. [2003:cb:c709:e300:d7a0:7fc3:8428:43e5])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003a0502c620dsm7331653wmq.44.2022.07.01.12.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 12:12:57 -0700 (PDT)
Message-ID: <11d28e6d-edb0-7d11-b476-c5808f3b7c5d@redhat.com>
Date:   Fri, 1 Jul 2022 21:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgel.zte@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
 <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
 <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
 <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
 <Yr7qQsWQGb0dhkxr@dhcp22.suse.cz>
 <54b67d6b-f600-1b9b-3d3f-e91b13d04c91@redhat.com>
 <Yr70ZwUAIHNz5VNy@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
In-Reply-To: <Yr70ZwUAIHNz5VNy@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.22 15:19, Michal Hocko wrote:
> On Fri 01-07-22 14:39:24, David Hildenbrand wrote:
>>> I am not sure about exact details of the KSM implementation but if that
>>> is not a desirable behavior then it should be handled on the KSM level.
>>> The very sam thing can easily happen in a multithreaded (or in general
>>> multi-process with shared mm) environment as well.
>>
>> I don't quite get what you mean.
> 
> I meant to say that if KSM needs to be aware of a special CoW semantic
> then it should be handled on the KSM layer regardless whether the KSM
> has been set by the process itself or any other process that has acccess
> to the MM. process_madvise is just another way to access a remote MM
> other than sharing the full MM.

Okay.

KSM has been a corner case feature that was restricted to well-defined
and well-tested environments. Until recently, R/O pins of any KSM pages
was essentially completely unreliably. And applications don't expect
such surprises. The shared zeropage is most probably the last
problematic piece.

Yes, we're getting there that it's a real feature that can see more
(forced) wide-spread use. However, until the known issues in KSM have
been fixed (e.g., below -- there is a whole list of papers regarding
attacks on memory deduplication), it should be limited to well defined
environments and applications only -- IMHO.

So what I want to express here is that if we're adding an interface that
can be used to just enable KSM on the whole system easily, it might be a
bit to soon for that. No matter what you document, people will ignore it.

OTOH, if this is a real debug feature that will only be available in
specific debug/test scenarios (kernel config? toggle? whatsoever?), then
it's "better". If that is already the case, good.

>  
> [...]
>>> Are you saying that any remote handling of the KSM has to deal with a
>>> pre-existing semantic as well? Are we aware of any existing application
>>> that really uses MADV_UNMERGEABLE in a hope to disable KSM for any of
>>> its sensitive memory ranges? My understanding is that this is simply a
>>> on/off knob and a remote way to do the same is in line with the existing
>>> API.
>>
>> "its sensitive memory ranges" that's exactly what I am concerned of.
>> There should be a toggle, and existing applciations will not be using it.
> 
> The thing is that most applications (are there any?) do not actively
> say that something is not KSM safe, right? They expect they opt in where

They can't. But knowing about stuff like
https://access.redhat.com/security/cve/cve-2021-3714 makes me be sure
that there are applications that don't want this force-enabled ever.

> it makes sense. So my question is, whether any remote way to opt in for
> KSM has to redefine the existing semantic or the same should be achieved
> by a sufficient privileges?
> 
> The former would have really hard times to be applicable to the very
> likely first hand usecase - unmodifiable binaries...

Yes, I know. I also don't have a good answer to all of that.

> 
>>> To be completely honest I do not really buy an argument that this might
>>> break something much more than the original application can do already.
>>
>> How can you get a shared zeropage in a private mapping after a previous
>> write if not via KSM?
> 
> I was not referring to KSM specifically here. My recollection is that
> PTRACE_MODE_READ_FSCREDS is quite powerful already.

Ah, you mean process_madvise() permissions.

-- 
Thanks,

David / dhildenb

