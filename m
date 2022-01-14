Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45E48E242
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiANBql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiANBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:46:40 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E89C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:46:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z3so11983471plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bkqHKFcqNq4gb3jt/dwVidqQ5ehBpW6sVTKKduTND5U=;
        b=bw/xTIGkLnDSX9jnLJvwk5GLgnDjyrWwq8Y3tVvHRP6pWVepDvUpb24R90CZqhCC9L
         aPDuN+fjx5ZNM0lh6Ev1Rdp4FW9LQb33SYHXU/i36i7j63RSdUSEMkqSEA++xM1uPNqV
         StKVAv05ywvQcPh5touaCbEXJCmFgXsvK6N0KqdBzM1f06SgAVOAiKA6wnUrjGh+1pkZ
         II8T7YG2HfpxuY7x8xiehN6DY67dV2M4AyZiCLEvFd+uVW/sDwMW8qmu4OQr/Bm715bX
         85ItrhYElmFILfdvKOBwMu6otmSLygtM3c7AqcLmHK/BN7pWlStOp7FR0HmGMDn/1OFP
         2dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bkqHKFcqNq4gb3jt/dwVidqQ5ehBpW6sVTKKduTND5U=;
        b=r6HkcI4spaDj33AFN36JPiF86NYjgDM3bkCWr3sbT2RUYMWjgA9z5EWrd02Pk8UZzF
         3gMvqcHMv8CezyqjJQTYNxupn19EcqEtLCmL1vCke6LQdCqk3cpxpoHqx67EHFN/D+9j
         3UhfrpcdR6eFJkt6ngrDcmx2Gx8GEEBL0l+xM5+OivlaBhyw44/qgyhOIyO3jvh0NXpr
         GSOwWjZx1O/yy+e7W+9St+mOjjsP6172Ugy7+Ec+UXh3LuNks1jFoZgGGgaKHGkwHfMB
         5CLgufvWigTQP7C0n3YC6bKW2nlIOLUHh+zJGNJddyfyNXix8KfvnwYHp/qf9ZSHvlIk
         v8QA==
X-Gm-Message-State: AOAM532au/VOmtujSfsDmdu1F+CuT6SMXHVVYJNBvDW7DjBYJf+9MAgP
        R1aNp3YLPJEmJJF3+71wY34V9w==
X-Google-Smtp-Source: ABdhPJx1n2buo+IEu0BN44/SXSTvAhCpZgcA1x+30GjD3bQ1/gPeJucU2x/Go977cYZdYlI7KOzxEg==
X-Received: by 2002:a17:90b:3a87:: with SMTP id om7mr16573934pjb.16.1642124798972;
        Thu, 13 Jan 2022 17:46:38 -0800 (PST)
Received: from [10.16.129.73] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id a9sm3713554pfo.169.2022.01.13.17.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 17:46:38 -0800 (PST)
Message-ID: <4d77b583-ce3f-89e5-75e1-ccfd661c5198@igel.co.jp>
Date:   Fri, 14 Jan 2022 10:46:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v2 0/3] Add support modifiers for drivers whose planes
 only support linear layout
Content-Language: en-US
To:     Daniel Stone <daniel@fooishbar.org>
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
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
References: <20220113094419.12433-1-etom@igel.co.jp>
 <CAPj87rPk3_8LdnwWJ3BhtJnRuR+_WHg2hfdgK2R4SMacPGCrUQ@mail.gmail.com>
From:   Esaki Tomohito <etom@igel.co.jp>
In-Reply-To: <CAPj87rPk3_8LdnwWJ3BhtJnRuR+_WHg2hfdgK2R4SMacPGCrUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel-san,

Thank you for your comments.

On 2022/01/13 22:44, Daniel Stone wrote:
> Hi Esaki-san,
> 
> On Thu, 13 Jan 2022 at 09:44, Tomohito Esaki <etom@igel.co.jp> wrote:
>> Some drivers whose planes only support linear layout fb do not support format
>> modifiers.
>> These drivers should support modifiers, however the DRM core should handle this
>> rather than open-coding in every driver.
>>
>> In this patch series, these drivers expose format modifiers based on the
>> following suggestion[1].
> 
> Thanks for the series, it looks like the right thing to do.
> 
> Can you please change the patch ordering though? At the moment there
> will be a bisection break at patch #1, because the legacy drivers will
> suddenly start gaining modifier support, before it is removed in patch
> #2.
> 
> I think a better order would be:
>    1: add fb_modifiers_not_supported flag to core and drivers
>    2: add default modifiers (and set allow_fb_modifiers) if
> fb_modifiers_not_supported flag is not set
>    3: remove allow_fb_modifiers flag
> 
I agree to your proposal.
I will fix these patches.

-- 
--------------------------
株式会社イーゲル
江崎　朋人
etom@igel.co.jp
