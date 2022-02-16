Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A094B8487
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiBPJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:36:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiBPJgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:36:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B391D2A82EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645004157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wuRCqHtrGnCNe4lFzhUlKSmhRtzzz/eDauDhTkRgdqU=;
        b=MZqSIL9hQyB0BKX+W/24iR2QV9G/5YCiuEtwcbFzYJfGkQpI/j0dICJvyFKMpukPz0FuSR
        I8/1aX3e1VndM0Ua8Ta1WphW4XdJObroYUB1e//2PyJ4RmsexkqUoBw/gkoKa9ESadkdtX
        gxeKi5g46OYNqCOr9gOj6lJeG1BhyDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-HRokvN2kNGa5tuBEWjT44Q-1; Wed, 16 Feb 2022 04:35:56 -0500
X-MC-Unique: HRokvN2kNGa5tuBEWjT44Q-1
Received: by mail-wm1-f70.google.com with SMTP id b17-20020a05600c4e1100b0037cc0d56524so2692996wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wuRCqHtrGnCNe4lFzhUlKSmhRtzzz/eDauDhTkRgdqU=;
        b=euqVWqGJ78UDQq7sBd9JcRx3NC3jzeD54yDzx2eqLazWG19w7w/lbf4m0e7/te8emk
         pPhMOIIp5876wXh4xuydLuYtNmijxPKfB7NWkYL/WflLlWnJkZOiGYtMpbbutbiETaMK
         wfD9ZNlLJNzKHI2Ob1ZSRdGgtzEETiEXcZ3xchix8A7TnQj5JQeZHq/TN06PPaqvI4mg
         NC3Nnp4RhgCEQU6ktN3A0YX6v969NVa89/uqoT2bkk1I3WVNnhnJ5HUG0yoyPLZZGB6i
         EAiOpKWYbpmlMUhRKbZekYLoSfcn6PtSoHLF+P4tfXNzJIz6/WG6IK5heEfqOUXBJz1h
         4Dng==
X-Gm-Message-State: AOAM532S+IQ4cpU7BBwcGNVDnMVhTQ8Awkv1RJh74UemrlCO4MzToTnn
        KrvR5fkc5T75DhGGeoKxnoJ+P1MNfKTBm67/phTtSG+QY90xIMqDGjECp69afoAlOww8T+pzqqI
        TlAsLHVM4XnFLIMofmjYNLm2a
X-Received: by 2002:a7b:c4d5:0:b0:37b:ffb9:bb6a with SMTP id g21-20020a7bc4d5000000b0037bffb9bb6amr727583wmk.89.1645004155041;
        Wed, 16 Feb 2022 01:35:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqfTxyIwHKGURmvfa8yIzjAYthlgNAnwVa9jRIycXk3slfzdebWzRK+l4sr6w0evO2C94Sgg==
X-Received: by 2002:a7b:c4d5:0:b0:37b:ffb9:bb6a with SMTP id g21-20020a7bc4d5000000b0037bffb9bb6amr727553wmk.89.1645004154754;
        Wed, 16 Feb 2022 01:35:54 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b16sm26397520wrj.26.2022.02.16.01.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 01:35:54 -0800 (PST)
Message-ID: <ce339fc7-b6bf-b19a-be10-54ee86487b96@redhat.com>
Date:   Wed, 16 Feb 2022 10:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] drm: Plumb debugfs_init through to panels
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Doug Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, lschyi@chromium.org,
        Sam Ravnborg <sam@ravnborg.org>, jjsu@chromium.org
References: <20220205001342.3155839-1-dianders@chromium.org>
 <20220204161245.v2.2.Ib0bd5346135cbb0b63006b69b61d4c8af6484740@changeid>
 <5d60473d-be8f-e2dc-2ce9-bc0b9056e4b4@redhat.com>
 <e6670fd7-1f75-56f7-b668-20db9902cac6@intel.com>
 <CAD=FV=Ut3N9syXbN7i939mNsx3h7-u9cU9j6=XFkz9vrh0Vseg@mail.gmail.com>
 <87ee435fjs.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87ee435fjs.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 10:25, Jani Nikula wrote:

[snip]

>>
>> I actually wrote said follow-up patches and they were ready to go, but
>> when I was trying to come up with the right "Fixes" tag I found commit
>> b792e64021ec ("drm: no need to check return value of debugfs_create
>> functions"). So what's being requested is nearly the opposite of what
>> Greg did there.
>>
>> I thought about perhaps only checking for directories but even that
>> type of check was removed by Greg's patch. Further checking shows that
>> start_creating() actually has:
>>
>> if (IS_ERR(parent))
>>   return parent;
>>
>> ...so I guess that explains why it's fine to skip the check even for parents?
>>
>> Sure enough I confirmed that if I pass `ERR_PTR(-EINVAL)` as the root
>> for `panel->funcs->debugfs_init()` that nothing bad seems to happen...
> 
> Yeah, the idea is that you don't need to check for debugfs function
> return values and you can safely pass error pointers to debugfs
> functions. The worst that can happen is you don't get the debugfs, but
> hey, it's debugfs so you shouldn't fail anything else because of that
> anyway.
> 

Thanks a lot Doug and Jani for the explanations. That makes sense and it
explains why most code I looked was not checking for the return value.

I guess we should write something about this in the debugfs functions
kernel doc so it's mentioned explicitly and people don't have to guess. 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

