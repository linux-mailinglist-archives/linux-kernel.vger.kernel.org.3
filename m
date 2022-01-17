Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADAC490111
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiAQFQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAQFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:15:59 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE980C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:15:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s15so3428098pgs.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MQeBrGkGEPprlAGgzRHSnT1m1Ox7Vg6LsQGd/Iu7NGs=;
        b=zv1yBiIyK4mMISwhtI4Pbr+dw8RVonPbi+fUCF0Xpuvz6C5K5mWFWEFBGDxt0XxQ/W
         cJXmztz1z9qEGFd5duOYIkhhcKAwVgigWrJah0RZJTHFkgg2KXkAPb2nblOOySKzR6zo
         xF9yuG9KfYQfL0YSLww/NV3NB2EME+iINMugre+MRNmHKB/gT1cEGFDwRS+FC2z481qJ
         b0dEd5MkZkDLA887VF8x3QW7/w/+iJeVmnjSSOxk6zNyoUaH1arGie2EaDF32cE3koBT
         FATnZjisTmkrXzQF0HwxO3ga5/2uWvDKoBGXsBPb8FJfxxVcFgHd1EYoeDJqWFciEHCZ
         dsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MQeBrGkGEPprlAGgzRHSnT1m1Ox7Vg6LsQGd/Iu7NGs=;
        b=y/H/ZO+7rd5Oqu3F+8IZX9p/uQG2h2dkQt0uUvGnkcXQkX2/mQIqe9syX3QM8UMQ5s
         RTUtH/6uqm3LfkPBc46Tz2KAv3hwITBs2a8cWed9bfNN7hvu3OZm0UG6agX50ywruzfe
         32E6V6v0TWX+plZSMq/R+LBTfan7HgkQ1nrKikg2r2SfQv0BjdcXVDOCyM6w8Y78wTRx
         IsIa1spYlNOga/Lrw1bgespK2lafhu4xkbu50ussRhQS2VP+UNTO7mz7EKtUX2WsFwfr
         fRLtJJcMIxL9HhB+dhiBM1YjSee4AEDe3/5G5zSf8340ViGP23NkCwA/5g/13Ctr1g2q
         iXBQ==
X-Gm-Message-State: AOAM533AAHSD8TRUgitFE9cObDZ21/j51ZeUIWu/7Cz5XfkhBN3rQJaL
        /AjWZ6Jv9liz1bP5Cru+sgI8KQ==
X-Google-Smtp-Source: ABdhPJyd50JZ5TcZwpKKG06f3DkcKlsUMm/JuuJ/PhWjAmM8kxYt86DgraRr8zaKIruizzcn/MgB3g==
X-Received: by 2002:a05:6a00:2182:b0:4a7:ec46:29da with SMTP id h2-20020a056a00218200b004a7ec4629damr19626922pfi.68.1642396558414;
        Sun, 16 Jan 2022 21:15:58 -0800 (PST)
Received: from [10.16.129.73] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p18sm12346694pfq.174.2022.01.16.21.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 21:15:57 -0800 (PST)
Message-ID: <0cf405a1-0d2d-ed5e-abdf-be645e7a9209@igel.co.jp>
Date:   Mon, 17 Jan 2022 14:15:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
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
From:   Esaki Tomohito <etom@igel.co.jp>
In-Reply-To: <YeGFugZvwbF7l2I/@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reviews.

On 2022/01/14 23:16, Andy Shevchenko wrote:
> On Fri, Jan 14, 2022 at 07:17:52PM +0900, Tomohito Esaki wrote:
>> The LINEAR modifier is advertised as default if a driver doesn't specify
>> modifiers.
> 
> ...
> 
>> +	const uint64_t default_modifiers[] = {
>> +		DRM_FORMAT_MOD_LINEAR,
>> +		DRM_FORMAT_MOD_INVALID
> 
> + Comma?

There is no mention in the coding style about adding/removing a comma to 
the last element of an array. Is there a policy in drm driver?

I think the advantage of adding a comma to the last element of an array 
is that diff is only one line when an element is added to the end.
However since INVALID is always the last element in the modifiers array, 
I think it can be either in this case.
If there is a policy, I will match it.

Thanks,
Tomohito Esaki
