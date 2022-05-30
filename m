Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176D537514
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiE3HKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiE3HKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B640972203
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653894632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LKyr40u81d91YJ0bAYFifgBp0H7FfoDycnwKNeMS1M=;
        b=jS2oBjUkhpO+EGC9yES7pKiEjInnetkQYt/0moWkC6j3uAPe7KA1dZq14XtVfRBK3qq+z5
        vscrSKNP/EUIkRSCcR1T0dksEuSOO2yddOje3/Q/tBhva9nCIJ8K/zqW6lbNgXdCrGTq7N
        ZZ3MKUBdBtNNu9EFDb8q1uzDVllroXw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-gRDTuYXvMrO0UF7NloJpig-1; Mon, 30 May 2022 03:10:29 -0400
X-MC-Unique: gRDTuYXvMrO0UF7NloJpig-1
Received: by mail-wm1-f72.google.com with SMTP id l15-20020a05600c1d0f00b003973901d3b4so4170009wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5LKyr40u81d91YJ0bAYFifgBp0H7FfoDycnwKNeMS1M=;
        b=LiJGRjsM5rWMVaD05LUVNhfiRYGv9uxBGI7fngEj/Lp7ygUjY7cn1gzfM36Ha4eDru
         3l2aBl5My+hQWerc72uYX4UMWhWon2JH23YLo/aMvMMAOSWYmZlVghRHpLXg0TOH0OID
         8bKoSoXMN5WGn9QHhXWEM2ML/Y3YvCBxJzo9qyUY8+lnMKBwJCCsEmcPFGZJZvqKhcKb
         soYRuZn8Cfholf3ru4U+1RtXgp9XKbjz5s6A/5IWrCHkGgwbUHGdP+pZ+rhigUg+Y1PV
         Ug2onki5ruN4cG9M4U+ut7q2DoZeej94gtsBpPyd49ZOvU+Al6erAee48fJNV5+wi1tT
         nBJg==
X-Gm-Message-State: AOAM533A97rbYjBQ4hkyvjK4rNOZKItJhUf+t+KZfuvXWTLiBiBhFY5/
        dwfgiBv616ctkvvIvx1m1Z72ZV/GULbfaE3XcTRobx+gS35zqUgYxEfFAyGNdKQXvK5ic8QdzE+
        YKXYCs42eMDzUndi/nxI5CpDB
X-Received: by 2002:adf:f38f:0:b0:210:30cf:6e4a with SMTP id m15-20020adff38f000000b0021030cf6e4amr4326289wro.676.1653894628521;
        Mon, 30 May 2022 00:10:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8l4427ccpoPzji8Obbh/n34+WlPiwPLLWNjy0ZD6F0750Re1e3KdamTFPDt08c+BZiwY+Dg==
X-Received: by 2002:adf:f38f:0:b0:210:30cf:6e4a with SMTP id m15-20020adff38f000000b0021030cf6e4amr4326278wro.676.1653894628336;
        Mon, 30 May 2022 00:10:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000168400b0020fd392df33sm8055606wrd.29.2022.05.30.00.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:10:27 -0700 (PDT)
Message-ID: <1bbbe572-5aa3-18d1-35f0-3e089942b4cf@redhat.com>
Date:   Mon, 30 May 2022 09:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm: memory_hotplug: fix memory error handling
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        cheloha@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>
References: <20220530053326.41682-1-songmuchun@bytedance.com>
 <0563a019-09e3-a176-d4c1-c240f3cf62d0@redhat.com>
 <CAMZfGtUMfNjOGJ3j4tgha6SxFymNGDo3CW5NO73ZsMby42BPjg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMZfGtUMfNjOGJ3j4tgha6SxFymNGDo3CW5NO73ZsMby42BPjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.22 09:08, Muchun Song wrote:
> On Mon, May 30, 2022 at 2:56 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 30.05.22 07:33, Muchun Song wrote:
>>> The device_unregister() is supposed to be used to unregister devices if
>>> device_register() has succeed.  And device_unregister() will put device.
>>> The caller should not do it again, otherwise, the first call of
>>> put_device() will drop the last reference count, then the next call
>>> of device_unregister() will UAF on device.
>>>
>>> Fixes: 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in xarray to accelerate lookup")
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>  drivers/base/memory.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>> index 7222ff9b5e05..084d67fd55cc 100644
>>> --- a/drivers/base/memory.c
>>> +++ b/drivers/base/memory.c
>>> @@ -636,10 +636,9 @@ static int __add_memory_block(struct memory_block *memory)
>>>       }
>>>       ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
>>>                             GFP_KERNEL));
>>> -     if (ret) {
>>> -             put_device(&memory->dev);
>>> +     if (ret)
>>>               device_unregister(&memory->dev);
>>> -     }
>>> +
>>>       return ret;
>>>  }
>>>
>>
>> See
>>
>> https://lkml.kernel.org/r/d44c63d78affe844f020dc02ad6af29abc448fc4.1650611702.git.christophe.jaillet@wanadoo.fr
>>
> 
> I see. Good job by Christophe. Thanks David.
> 

I'm curious how both of you found that issue? Just by staring at that
code? :)

-- 
Thanks,

David / dhildenb

