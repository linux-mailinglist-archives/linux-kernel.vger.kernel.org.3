Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140B48BCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345200AbiALCNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiALCNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:13:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:13:34 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e19so1804969plc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zRJAt/tHSPTVX2Oe9CjAVFlJyFBtZBGpgaIpMawcKN0=;
        b=4RxLy0zrQDn0+WSP0CFdZXXeX5oeHQpZpkg+SsPqAUnR3rzhuzAVfVk2cE2cSi3GM/
         12nqowe2KjGvcMz2u6Ytddyo5/bIFMA9I68Qaux3+s0A/LhJ38Vbt3sAlpfm3/NWlL+x
         89IxuL+4rsGLoO8XMquXbuBotOSQHO+V9V17CdMQmcBtoG1PMjME2cZNGNMsyJJr7oKb
         WXEtRhwnpjexfR2kB3Hvh0jhiJV2QW5B2p63jLNd+oEv1TZulc/y2IalsebnxkgfJOQn
         ztnqLJFizV+Oy1Y0D2ZelUhQz/PSN5MtJ0wGML3rwd4NsORAqmmcQn1VHf2++83eEewo
         42mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zRJAt/tHSPTVX2Oe9CjAVFlJyFBtZBGpgaIpMawcKN0=;
        b=XMoqswD+rnnAL5WeAEjOQQdn9M1woffr4arJ2Le4sZKpCeF2/a+bawwUdY4NpssoxX
         jkwv/DV1WCELWl/vOPtr6g4OoX3A73Jxz+1gebz/u0Mfp+2cohaNvnZ9+EaonQsl6wpI
         I0b0z0OW4RPPKVwHBquYWAEXAdkydlhd7r8d/n6Ud90BUP/N4t9JdqaK3g7cIwb3adC6
         lFinSuqvNTBXzwbX7eELIKQvMan2EbYFEa0udcVeK8UgNQUFYa4wRxbEObHWohxIm4+X
         zYbIVr1OvXqCq0aypQBIqFWmrc5OygQVPR6xuErDwfEsFEg28yabcSgqa3ZFpaleg6Uj
         s9JQ==
X-Gm-Message-State: AOAM531C1pPeNrYFqbVAfQpYvw1Eig/iGcp6u4gf7Pxr9Bb8O51FMfHF
        yEPbkAG+z4UILuaY2QyW/aRYKA==
X-Google-Smtp-Source: ABdhPJxT0QrQpLvM61rtdzCrVhjqlGt2/Jh6dcOGGMd3oLp7PfZbnPqkrZUsGV2wcWXHp7Nq/rNExg==
X-Received: by 2002:a63:7258:: with SMTP id c24mr6615835pgn.11.1641953613804;
        Tue, 11 Jan 2022 18:13:33 -0800 (PST)
Received: from [10.16.129.73] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id u20sm7947925pfi.220.2022.01.11.18.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 18:13:33 -0800 (PST)
Message-ID: <0cc8fd2b-b6c2-d2a8-7a4c-54214db3791d@igel.co.jp>
Date:   Wed, 12 Jan 2022 11:13:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 0/3] Add support modifiers for drivers whose planes
 only support linear layout
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>
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
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>, etom@igel.co.jp
References: <20211222052727.19725-1-etom@igel.co.jp>
 <OCRYf0WjHfvIDxKeXD9eR8KiweNqCTcuy5QUapIIYgtas4x2m_nNc6mDZGnhO-y1H_yYh0O8qzzgAWdExGyK-FjUExqXY1CDlCtSDevNmWg=@emersion.fr>
From:   Esaki Tomohito <etom@igel.co.jp>
In-Reply-To: <OCRYf0WjHfvIDxKeXD9eR8KiweNqCTcuy5QUapIIYgtas4x2m_nNc6mDZGnhO-y1H_yYh0O8qzzgAWdExGyK-FjUExqXY1CDlCtSDevNmWg=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Simon

On 2022/01/06 8:57, Simon Ser wrote:
> Thanks for working on this! I've pushed a patch [1] to drm-misc-next which
> touches the same function, can you rebase your patches on top of it?
> 
> [1]: https://patchwork.freedesktop.org/patch/467940/?series=98255&rev=3

I understand. I will rebase the patches and send.

Thanks
Tomohito Esaki
