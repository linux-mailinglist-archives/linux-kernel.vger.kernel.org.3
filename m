Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD2C46E150
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhLIDiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhLIDiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:38:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA60C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 19:34:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p18so2889588plf.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IhIul+4nURod6NuSkYTrchSPnXVCxWUJGXACRxYc3MQ=;
        b=eXSVG+Ndarp4Nov0ojL5vYXJOqopOe8rmbtZMAES5EqdQfhuTJT9Uq3lALtJGa4LbO
         wWHdJFJ87qjeMcSOV3aq0PkzuieWlIvRP179Hr6+sgCEYfH7wf+V4jVqH10ELhTez0XB
         22huR9IEqlUxwdOVegX+j/rAjRjz7L8mt/AiBEGrV7CjsOrfNoQ1BJ9XPY8+vJZH31o7
         2P/ix6dz02VvGEjb+x0Ea1/8RXd4aZ7czYa7w2YNw1bcNUZxsKs/e400rD6pCJCOWN7L
         q5fhY1g9Ipg3RqbxuIOSnqylc7dCzgsNU5GquVam3pqRibhz+3qTwbdWItlmR7WucDdh
         VwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IhIul+4nURod6NuSkYTrchSPnXVCxWUJGXACRxYc3MQ=;
        b=N/fP0CCmd6XVV9WKLi+DnX8xW2p+xEtJNeXjdql2qpz+uDZGFPPssGbNKAvWTmTlQA
         wtBgzmu/Mu1bWJKjfgPUqwWQw/5odtylyGNH/UlYlPQMor9KmcXOYSLuT0ykpDn9gIRf
         2ZVdc4UAL++8hss2cvIfssIPunZtupqxWwIDaenYQye3+RFoXzqiEYh8yxP0rUUGbXuC
         DimvV7A48FBYS59sg9bbY1dUYXJWpm5pnshtW/yZzu2z5Nsl6SgEf+F3tSdCsbmkh18U
         hJEslD8naS9NlZA39LoxclPyiFSo5csCWAoj47NVQS5zEC0nrLGo66YCb5jNWRMm7IQM
         ITfg==
X-Gm-Message-State: AOAM532gROGBaT6Bw0Ny1dZxaiqlksJpu7guDaMeo8ygpk5Kx1teHoZg
        hYmciupd+47mwOZzrgAIIRovE4UT2KE=
X-Google-Smtp-Source: ABdhPJx7+EvOV3k5F+MwkvlqnlUuZKHGOaLEFVN8ri3k3vpvOVFTKnJpQnsX5z8mTpBCirtuipNWIg==
X-Received: by 2002:a17:90b:4b4c:: with SMTP id mi12mr12376886pjb.66.1639020881197;
        Wed, 08 Dec 2021 19:34:41 -0800 (PST)
Received: from [183.173.151.43] ([183.173.151.43])
        by smtp.gmail.com with ESMTPSA id y18sm4729594pfp.190.2021.12.08.19.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 19:34:40 -0800 (PST)
Subject: Re: [BUG] gpu: drm: amd: amdgpu: possible ABBA deadlock in
 amdgpu_set_power_dpm_force_performance_level() and
 amdgpu_debugfs_process_reg_op()
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, Felix.Kuehling@amd.com, ray.huang@amd.com,
        lee.jones@linaro.org
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <2dc31435-ba62-b6a4-76dc-cfe9747f4cfb@gmail.com>
Message-ID: <963eab5f-f333-456e-784c-0d2c81b849da@gmail.com>
Date:   Thu, 9 Dec 2021 11:34:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2dc31435-ba62-b6a4-76dc-cfe9747f4cfb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could you please provide the feedback to my previous report?
Thanks a lot :)


Best wishes,
Jia-Ju Bai

On 2021/9/15 17:39, Jia-Ju Bai wrote:
> Hello,
>
> My static analysis tool reports a possible ABBA deadlock in the amdgpu 
> driver in Linux 5.10:
>
> amdgpu_debugfs_process_reg_op()
>   mutex_lock(&adev->grbm_idx_mutex); --> Line 250 (Lock A)
>   mutex_lock(&adev->pm.mutex); --> Line 259 (Lock B)
>
> amdgpu_set_power_dpm_force_performance_level()
>   mutex_lock(&adev->pm.mutex); --> Line 381 (Lock B)
>     pp_dpm_force_performance_level() --> function pointer via 
> "amdgpu_dpm_force_performance_level()"
>       pp_dpm_en_umd_pstate()
>         amdgpu_device_ip_set_clockgating_state()
>           gfx_v7_0_set_clockgating_state() --> function pointer via 
> "funcs->set_clockgating_state()"
>             gfx_v7_0_enable_mgcg()
>               mutex_lock(&adev->grbm_idx_mutex); --> Line 3646 (Lock A)
>               mutex_lock(&adev->grbm_idx_mutex); --> Line 3697 (Lock A)
>
> When amdgpu_debugfs_process_reg_op() and 
> amdgpu_set_power_dpm_force_performance_level() are concurrently 
> executed, the deadlock can occur.
>
> I am not quite sure whether this possible deadlock is real and how to 
> fix it if it is real.
> Any feedback would be appreciated, thanks :)
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>
>
> Best wishes,
> Jia-Ju Bai

