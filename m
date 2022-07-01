Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4EB563387
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiGAMjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGAMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F5423B027
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656679168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8EPJUGLXSe6M8And1ttNiEeLb4XllnEQkbnHjdKlZY=;
        b=BCwqjHs3EfSjEd5vaVCbprwrET+RRuisS+QLd01U6fv/OpSRVPnPaGauCv1Az8MOYhKEw9
        k/rJyL0AmG/0J/f/dQh6WInb8nNhS9IZjKdgsmKIyB2GaRyiQUJLzFycbzuhVFN5XxMBYS
        1G17bSNwbvTW8rdx//MRXW8aOAeQUIg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-maRG3uRyOW29m5lbs1F_wg-1; Fri, 01 Jul 2022 08:39:27 -0400
X-MC-Unique: maRG3uRyOW29m5lbs1F_wg-1
Received: by mail-wm1-f72.google.com with SMTP id c185-20020a1c35c2000000b0039db3e56c39so2991866wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=s8EPJUGLXSe6M8And1ttNiEeLb4XllnEQkbnHjdKlZY=;
        b=1rJOht3TcQ8uysxB9nZeXlIWIWOzVphT30exM/51DMi78aoD2Qs2r0gXMd09ZIscaC
         5vqbTw+RaD7PQOKtxra5kDWX0awSWzqK2Hj8FoL+/mS8TZYNoEEVvmG/mAymbMwt3Lbz
         Xrhzv6RS8QdXQfLhZlPThBnPN85KloccoUGdJ9WXRYcHw7ymiAsqLiGfGoRVwzo99Umq
         6Mnqml8fHNIr3/cUirL74dph6xmVCdtto48t8HUUUu67aa5fQX0nr9uwzs9HYHJMAZlh
         lD464T4SVnMuUEsXqubRy2HT+NUjP82NSmsAoKyhsb33SIWiioRCMWnkSnrOFw8+yVQ+
         uhOw==
X-Gm-Message-State: AJIora9yM0Xpldlaazrk1zC7nqBKdwuEWFEzLA9K11CvBhf0Z0+BdIeV
        a8Jl8LNkK3Jv9X1nkcJfje/6p26Pzwm6q+PwQbAKg7wUnYM+6X7sP5EPe/AQL5v9eSd0Qco4oMO
        GGqiRiYfXBqwJ5NlOOr6FTXTO
X-Received: by 2002:a5d:47cd:0:b0:21d:30ea:a0d5 with SMTP id o13-20020a5d47cd000000b0021d30eaa0d5mr11146364wrc.74.1656679166170;
        Fri, 01 Jul 2022 05:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vuWsT0XC/Zky44X7gubBF+mJkHoq3T7uWaKyGNsztMBQSqQf5CWibCNdM8K8OMh+zSSDlbzg==
X-Received: by 2002:a5d:47cd:0:b0:21d:30ea:a0d5 with SMTP id o13-20020a5d47cd000000b0021d30eaa0d5mr11146345wrc.74.1656679165903;
        Fri, 01 Jul 2022 05:39:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:e300:d7a0:7fc3:8428:43e5? (p200300cbc709e300d7a07fc3842843e5.dip0.t-ipconnect.de. [2003:cb:c709:e300:d7a0:7fc3:8428:43e5])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b0021018642ff8sm23978560wrm.76.2022.07.01.05.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 05:39:25 -0700 (PDT)
Message-ID: <54b67d6b-f600-1b9b-3d3f-e91b13d04c91@redhat.com>
Date:   Fri, 1 Jul 2022 14:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yr7qQsWQGb0dhkxr@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not sure about exact details of the KSM implementation but if that
> is not a desirable behavior then it should be handled on the KSM level.
> The very sam thing can easily happen in a multithreaded (or in general
> multi-process with shared mm) environment as well.

I don't quite get what you mean.

>  
>>>> Further, if an app explicitly decides to disable KSM one some region, we
>>>> should not overwrite that.
>>>
>>> Well, the interface is rather spartan. You cannot really tell "disable
>>> KSM on some reqion". You can only tell "KSM can be applied to this
>>> region" and later change your mind. Maybe this is what you had in
>>> mind though.
>>
>> That's what I meant. The hugepage interface has different semantics and
>> you get three possible states:
>>
>> 1: yes please: MADV_HUGEPAGE
>> 2: don't care -- don't set anything
>> 3. please no: MADV_NOHUGEPAGE
>>
>> Currently for KSM we only have 1 and 2 internally I think (single
>> flag), because it didn't matter in the past ebcause there was no
>> force-enablement. One could convert it into all 3 states, changing the
>> semantics of MADV_UNMERGEABLE slightly from
>>
>>
>> 1: yes please: MADV_MERGEABLE
>> 2: don't care: MADV_UNMERGEABLE
>>
>> to
>>
>> 1: yes please: MADV_MERGEABLE
>> 2: don't care -- don't set anything
>> 3. please no: MADV_UNMERGEABLE
> 
> Are you saying that any remote handling of the KSM has to deal with a
> pre-existing semantic as well? Are we aware of any existing application
> that really uses MADV_UNMERGEABLE in a hope to disable KSM for any of
> its sensitive memory ranges? My understanding is that this is simply a
> on/off knob and a remote way to do the same is in line with the existing
> API.

"its sensitive memory ranges" that's exactly what I am concerned of.
There should be a toggle, and existing applciations will not be using it.

> 
> To be completely honest I do not really buy an argument that this might
> break something much more than the original application can do already.

How can you get a shared zeropage in a private mapping after a previous
write if not via KSM?

> Unless I am missing the ptrace check puts the bar rather high. Adversary
> with this level of access to the target application has already broken
> it. Or am I missing something?

I don't see what you mean.

-- 
Thanks,

David / dhildenb

