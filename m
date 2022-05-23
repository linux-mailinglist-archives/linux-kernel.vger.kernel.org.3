Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05FE5314C6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiEWPx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbiEWPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:53:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6101060DBD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:53:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id E6C261F43999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653321209;
        bh=NzwdUWK14vQgJs3bT2nJXsIJw7vgrnGZ5jOEJKZH3V4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cSl8zy7n2eDm5whb81GyXjTw7qC/3a3Br6GIQSyiBLYqyJvRF7d9eOKpwJFYeviUw
         ADqBnvYJfBhejzlUu6LRy35efOpT6TOvV//6Kzju3OJ76GfFmya5ddyCUWO18LwbZE
         i26QQtWLmg5xFPnYdIE0o6WQegUvow1wpB/6cZo5Z06PRvC6StAfEycFD4EslPE2gF
         OU65WIwuNEzCmm6XtePpiKgTQMD2nbhj9956j/DwvREc69MSdNqmH7zf5l/XKYXlXM
         m3xvxnJ2wLtlnchWBF2OUHCpOTOeT+rpwbR29wp6BKOqnpOj/Ip2U9vU96iMBTT8of
         4ow03fBArPfKg==
Message-ID: <f42a3dc9-2a6f-2467-b2ff-b6487669ae48@collabora.com>
Date:   Mon, 23 May 2022 16:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/4] drm/i915: allow volatile buffers to use ttm pool
 allocator
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Matthew Auld <matthew.auld@intel.com>, linux-kernel@vger.kernel.org
References: <20220503191316.1145124-1-bob.beckett@collabora.com>
 <20220503191316.1145124-4-bob.beckett@collabora.com>
 <3ce81c514959e43f5afd7e74489dd5b89b1cd633.camel@linux.intel.com>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <3ce81c514959e43f5afd7e74489dd5b89b1cd633.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/05/2022 13:42, Thomas Hellström wrote:
> Hi, Bob,
> 
> On Tue, 2022-05-03 at 19:13 +0000, Robert Beckett wrote:
>> internal buffers should be shmem backed.
>> if a volatile buffer is requested, allow ttm to use the pool
>> allocator
>> to provide volatile pages as backing
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> index 4c25d9b2f138..fdb3a1c18cb6 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> @@ -309,7 +309,8 @@ static struct ttm_tt *i915_ttm_tt_create(struct
>> ttm_buffer_object *bo,
>>                  page_flags |= TTM_TT_FLAG_ZERO_ALLOC;
>>   
>>          caching = i915_ttm_select_tt_caching(obj);
>> -       if (i915_gem_object_is_shrinkable(obj) && caching ==
>> ttm_cached) {
>> +       if (i915_gem_object_is_shrinkable(obj) && caching ==
>> ttm_cached &&
>> +           !i915_gem_object_is_volatile(obj)) {
>>                  page_flags |= TTM_TT_FLAG_EXTERNAL |
>>                                TTM_TT_FLAG_EXTERNAL_MAPPABLE;
>>                  i915_tt->is_shmem = true;
> 
> While this is ok, I think it also needs adjustment in the i915_ttm
> shrink callback. If someone creates a volatile smem object which then
> hits the shrinker, I think we might hit asserts that it's a is_shem
> ttm?
> 
> In this case, the shrink callback should just i915_ttm_purge().

agreed. nice catch.
I'll fix for v2

looks like we could maybe do with some extra shrinker testing too? looks 
like nothing caught this during CI testing

> 
> /Thomas
> 
> 
