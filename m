Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3165F5045AA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiDPW2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiDPW2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A3C51D33D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650147925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rAHldDuMtrwN53CF2WYzds8qp7tRtwJj5+xsN53tnj0=;
        b=UbeB9iQw6QiRiJRGjA3hjqFqYzcy/gTFTQ36mOjYfCguxI3QNpmtlzZWVSZgb2e49TWEn/
        BuewYIAXMRb/O0NapW73jYG1gUC9NH/Xaiy1ECbT4FTzuWaeBcApK6JDZD5eVX8NYKqv32
        41LzuEf8AWQUBD3kYAq0i2ChGG+EPvk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-WQoxoIBdO1WlkJWebzUwmA-1; Sat, 16 Apr 2022 18:25:24 -0400
X-MC-Unique: WQoxoIBdO1WlkJWebzUwmA-1
Received: by mail-qk1-f200.google.com with SMTP id de26-20020a05620a371a00b00699f7065b5cso7734833qkb.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 15:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rAHldDuMtrwN53CF2WYzds8qp7tRtwJj5+xsN53tnj0=;
        b=rPxrqp+8N6iBNJQvNmJVDXasPVfY5gDMHcHBILJbKmYC+gkHQqLvVEKDPmhqampNCG
         Tz4UCbDKGiR4guidqKOpvcan9nCoJKONqbH/KqAYDKYzN+MFnTn7Kcv+4hek4EsZEhxA
         +IFsmdy4eJkxEVmsdd6HDh2/syljebB43aUlsKfe6f/oAm6LL+aJadQLwAiyUSVQIrNF
         mxm0zAteHVqxay1GPYP0NaiT1xwl4j9jJibAHFohnbLRa1OKnbAbWz1JFyCNujVD2yUZ
         shmwOGuksS0+Q1lnPolVGjVPpwLD14h+6xc+uWZ6xagQgiszGo+BVO3MSDX1LG4rXOQc
         lvnA==
X-Gm-Message-State: AOAM532vc5V/7QMi21kY9Xl1OlogTfgoZHRrIuPzqR09FUs8AmMQHo6c
        JTm9Lkxv626w7Dw/AgFKxeNyQxCfj5E58HbJp0ZMGSdGSBcsphrryQa6ZgvgVGzKSbRI4U0mcs1
        PV/j1Apwc8l60bLN1bLxUFAYoQcg07WVOvstRyChu3mQq4Glb/5yNpOVmwd5Dz6CCbOwy0SA=
X-Received: by 2002:a05:620a:2585:b0:680:f1f5:23ac with SMTP id x5-20020a05620a258500b00680f1f523acmr2919890qko.656.1650147923914;
        Sat, 16 Apr 2022 15:25:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi81NuV1kGhitJKFFnawv59JqWzpTvRdIhVgpGW8vegAAaWegsx91tx2nF0D8cXb1IBOuR4Q==
X-Received: by 2002:a05:620a:2585:b0:680:f1f5:23ac with SMTP id x5-20020a05620a258500b00680f1f523acmr2919875qko.656.1650147923662;
        Sat, 16 Apr 2022 15:25:23 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w6-20020a05622a190600b002f1f91ad3e7sm842259qtc.22.2022.04.16.15.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 15:25:23 -0700 (PDT)
Subject: Re: [PATCH] drm/i915: change node clearing from memset to
 initialization
To:     Joe Perches <joe@perches.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220416172325.1039795-1-trix@redhat.com>
 <26839195c315eebcd1148d2a3de6a0df9e42dd1c.camel@perches.com>
 <7973fecf-4e51-3ec8-b626-2581e3ad2f26@redhat.com>
 <715d6dbd696a9dad2690772d175d2ab497e0c316.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d0f293a4-18fc-4c82-8dfc-286c4913948b@redhat.com>
Date:   Sat, 16 Apr 2022 15:25:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <715d6dbd696a9dad2690772d175d2ab497e0c316.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/22 2:04 PM, Joe Perches wrote:
> On Sat, 2022-04-16 at 13:48 -0700, Tom Rix wrote:
>> On 4/16/22 11:33 AM, Joe Perches wrote:
>>> On Sat, 2022-04-16 at 13:23 -0400, Tom Rix wrote:
>>>> In insert_mappable_node(), the parameter node is
>>>> cleared late in node's use with memset.
>>>> insert_mappable_node() is a singleton, called only
>>>> from i915_gem_gtt_prepare() which itself is only
>>>> called by i915_gem_gtt_pread() and
>>>> i915_gem_gtt_pwrite_fast() where the definition of
>>>> node originates.
>>>>
>>>> Instead of using memset, initialize node to 0 at it's
>>>> definitions.
>>> trivia: /it's/its/
>>>
>>> Only reason _not_ to do this is memset is guaranteed to
>>> zero any padding that might go to userspace.
>>>
>>> But it doesn't seem there is any padding anyway nor is
>>> the struct available to userspace.
>>>
>>> So this seems fine though it might increase overall code
>>> size a tiny bit.
>>>
>>> I do have a caveat: see below:
>>>
>>>> diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
>>> []
>>>> @@ -328,7 +327,6 @@ static struct i915_vma *i915_gem_gtt_prepare(struct drm_i915_gem_object *obj,
>>>>    		goto err_ww;
>>>>    	} else if (!IS_ERR(vma)) {
>>>>    		node->start = i915_ggtt_offset(vma);
>>>> -		node->flags = 0;
>>> Why is this unneeded?
>> node = {} initializes all of node's elements to 0, including this one.
> true, but could the call to insert_mappable_node combined with the
> retry goto in i915_gem_gtt_prepare set this to non-zero?

Yikes!

I'll add that back.

Thanks for pointing it out.

Tom

>
>

