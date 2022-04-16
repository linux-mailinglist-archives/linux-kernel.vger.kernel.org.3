Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5C50383C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiDPUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiDPUu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 16:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 004992ED7D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650142101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWxIUT+rH8PESyeqg6StkvsoyVPPRKkMATCJ7S1FFtE=;
        b=flWmTfUfz467+IDARuKsFgUA8ZCBz7fvPXK7DnO7u4p85rY9MHGjxnb56TqQDIqCahoeip
        Z3jTS2j454uKmA4t6HdYFQWjcJK+ix0W2JHos65P5rseTZacCzFbaUHE/GXAG+sGCQ8a4D
        bSWmJXVavHW6i5nlEWzOiwuohGWQH14=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-J4PL_j8IMWqBBt7c_B-gDw-1; Sat, 16 Apr 2022 16:48:20 -0400
X-MC-Unique: J4PL_j8IMWqBBt7c_B-gDw-1
Received: by mail-qt1-f197.google.com with SMTP id s9-20020ac87589000000b002e1cfb25db9so192289qtq.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oWxIUT+rH8PESyeqg6StkvsoyVPPRKkMATCJ7S1FFtE=;
        b=dy9LKhzG6oobEqLmU4G3Oa6El5NzG38hu7rRFNZncog9X4XBpnN63pss61j2nuxnuK
         9tIwit44SQShoKXBN44DQuM/zc5VsrOF8vhGuIbdcW7iwcbBOS9FnmtqbZSikq0SH4kx
         4cbGdP3XyVGFK+sIAwhdUadzeE9eFC0Jfht7d2LzDgHI5i0+wOEeNO1MBuajLJm+ZyGq
         BpLNuzNJ2KpegAe+WKEJN6iTJgnB1Z4GZGHWSePvPKbgNCUH6osHk9F0mlEgQ0rPbu6y
         G4yzXxR3FFw4wpMeIqm8OAwrTCkRjCvkV4Ps1PHPYTh8x69QsLs2G0qkOP2md9PWENna
         RGaw==
X-Gm-Message-State: AOAM533xTchX7G5aldo4E8So0mCNlVY2+aYHeh/6IVXfTFfmLq9bGTnA
        zNga4mUPzPR3hWT70RbBJwPPEcouBtEI/BVOx1PZBrpTpZWSFl8iV72CwhQjXucc4dVWulOQ0SQ
        ktlllqbrMq8ZYmM7jDW0Q743x8N5o0TRAXyadr3Ci9w+qXJ1W2OBnwFAPaVeL00pRqXN1Bx4=
X-Received: by 2002:a05:622a:1e85:b0:2f1:129b:99aa with SMTP id bz5-20020a05622a1e8500b002f1129b99aamr2993995qtb.339.1650142099404;
        Sat, 16 Apr 2022 13:48:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt9KSKQzCO3SL1g6pRUSCiJkWiil0JhaE1lYAF2MNELSIbppyoFZIcehwE0xIBZs8EGr4V4Q==
X-Received: by 2002:a05:622a:1e85:b0:2f1:129b:99aa with SMTP id bz5-20020a05622a1e8500b002f1129b99aamr2993979qtb.339.1650142099159;
        Sat, 16 Apr 2022 13:48:19 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id y25-20020a05620a09d900b0069e82fb9310sm619703qky.15.2022.04.16.13.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 13:48:18 -0700 (PDT)
Subject: Re: [PATCH] drm/i915: change node clearing from memset to
 initialization
To:     Joe Perches <joe@perches.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220416172325.1039795-1-trix@redhat.com>
 <26839195c315eebcd1148d2a3de6a0df9e42dd1c.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7973fecf-4e51-3ec8-b626-2581e3ad2f26@redhat.com>
Date:   Sat, 16 Apr 2022 13:48:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <26839195c315eebcd1148d2a3de6a0df9e42dd1c.camel@perches.com>
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


On 4/16/22 11:33 AM, Joe Perches wrote:
> On Sat, 2022-04-16 at 13:23 -0400, Tom Rix wrote:
>> In insert_mappable_node(), the parameter node is
>> cleared late in node's use with memset.
>> insert_mappable_node() is a singleton, called only
>> from i915_gem_gtt_prepare() which itself is only
>> called by i915_gem_gtt_pread() and
>> i915_gem_gtt_pwrite_fast() where the definition of
>> node originates.
>>
>> Instead of using memset, initialize node to 0 at it's
>> definitions.
> trivia: /it's/its/
>
> Only reason _not_ to do this is memset is guaranteed to
> zero any padding that might go to userspace.
>
> But it doesn't seem there is any padding anyway nor is
> the struct available to userspace.
>
> So this seems fine though it might increase overall code
> size a tiny bit.
>
> I do have a caveat: see below:
>
>> diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
> []
>> @@ -328,7 +327,6 @@ static struct i915_vma *i915_gem_gtt_prepare(struct drm_i915_gem_object *obj,
>>   		goto err_ww;
>>   	} else if (!IS_ERR(vma)) {
>>   		node->start = i915_ggtt_offset(vma);
>> -		node->flags = 0;
> Why is this unneeded?

node = {} initializes all of node's elements to 0, including this one.

Tom

>
> from: drm_mm_insert_node_in_range which can set node->flags
>
> 		__set_bit(DRM_MM_NODE_ALLOCATED_BIT, &node->flags);
>
>

