Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2E4932F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350771AbiASCfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiASCfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:35:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C19C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:35:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso1156041pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ghW/ul0d9NEyJ9r42fCrbuuKSEOCoJslPqejWSnYe4E=;
        b=uPqM8B/AGjP0zEx3Jb1zSG/XQs3hDbbgpen5gl3SMQdeuniUTowERurn5OXzTAdvtd
         fRR1eFmNfr/L328KILrOZGgiISXNDYf/CYtmObLx+YvxxNpnFvTtDTBtXm1zKxDTtTFn
         FmCtJUT5ufM73Pc8tn8pVy7/45/n6mPTHu06ivs5vZrR2Uan/i/bNM/XUw+UZymsYMi0
         kM+j5EyyQSO60NNsEg3qFLDqjZ4HHBYI7h07UqdQkJFoi/GsAK3ypsziUF4WOQY2b9t1
         dVl3eg/PpJwmFGNOSlQkbTd10Kq3T5nfbK7BqVAsWZRV2w8nva5jJysJuEabEcuXp5WG
         UPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ghW/ul0d9NEyJ9r42fCrbuuKSEOCoJslPqejWSnYe4E=;
        b=eM4xJK0rLZ0oigE+RuXTgNXk/I8unG4AiVTUJIhHTmoM/gWkfakbzH3A5nKB4hhfU/
         k/Cwy34QBA8jOutwevwi8al9jh6T9c2LjVIn6DlAIERaoHaiJtZcsBLzSELBnshYgjE/
         vUueQEtqd66HwUPgSm2NJNBXbSJOELR8wKdmg+KidAIwV53RtGtHPBuHi8Lbl2jxW69Z
         RGsXYYwwX3jjmFXI5flQ8Teff/P+ByT1W7NEMMsAeaRI0wf+ecX+dDGRvZ9zP26uheyF
         NI1R/vPQv/Tjuko6+LfstwFrnBr4zK2IlfkqbJmOc17ou/MfCVzLtt73/qdGYqOyIkFn
         IHmw==
X-Gm-Message-State: AOAM530Cpqja0FD6fo9fGhWur28/5gD3T8yOEPxAfkhBl1TNwKkPWaSQ
        GA24yTgAZAsvW2vXPL267AOWbw==
X-Google-Smtp-Source: ABdhPJxN1s1eA9Hs8mRFndnBGoYKps6ZgVn3wyGBiRkZe12FBr3GwhWrZf3/6Z6/SAg6dI6p5UlLsA==
X-Received: by 2002:a17:902:cece:b0:14a:73bb:e75 with SMTP id d14-20020a170902cece00b0014a73bb0e75mr30647215plg.115.1642559732396;
        Tue, 18 Jan 2022 18:35:32 -0800 (PST)
Received: from [10.16.129.73] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id d11sm18974996pfu.211.2022.01.18.18.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 18:35:31 -0800 (PST)
Message-ID: <94bddda6-9823-6479-bc1d-cbb8c1079877@igel.co.jp>
Date:   Wed, 19 Jan 2022 11:35:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v3 2/3] drm: add support modifiers for drivers whose
 planes only support linear layout
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>, Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-3-etom@igel.co.jp>
 <YeGFugZvwbF7l2I/@smile.fi.intel.com>
 <0cf405a1-0d2d-ed5e-abdf-be645e7a9209@igel.co.jp>
 <YeaOHqfTcf+evbVC@smile.fi.intel.com>
From:   Esaki Tomohito <etom@igel.co.jp>
In-Reply-To: <YeaOHqfTcf+evbVC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/18 18:53, Andy Shevchenko wrote:
> On Mon, Jan 17, 2022 at 02:15:48PM +0900, Esaki Tomohito wrote:
>> On 2022/01/14 23:16, Andy Shevchenko wrote:
>>> On Fri, Jan 14, 2022 at 07:17:52PM +0900, Tomohito Esaki wrote:
>>>> The LINEAR modifier is advertised as default if a driver doesn't specify
>>>> modifiers.
>>>
>>> ...
>>>
>>>> +	const uint64_t default_modifiers[] = {
>>>> +		DRM_FORMAT_MOD_LINEAR,
>>>> +		DRM_FORMAT_MOD_INVALID
>>>
>>> + Comma?
>>
>> There is no mention in the coding style about adding/removing a comma to the
>> last element of an array. Is there a policy in drm driver?
>>
>> I think the advantage of adding a comma to the last element of an array is
>> that diff is only one line when an element is added to the end.
>> However since INVALID is always the last element in the modifiers array, I
>> think it can be either in this case.
>> If there is a policy, I will match it.
> 
> Indeed, but there is a common sense. The idea behind (multi-line) definitions
> that when next time somebody will add an element in the array, there are will
> be:
> 
> a) no additional churn (like in case of this patch, if the item will be added
>     at the bottom;
> 
> b) an element that may not be added behind the terminator, which will look
>     weird.
> 
> That said, the question is if the element is terminator one or not, if not,
> comma is better than no comma and vise versa.
> 

Ah I see. In this case, DRM_FORMAT_MOD_INVALID is terminator, so it
should not have a comma.

Thanks
Tomohito Esaki
