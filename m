Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4723B476291
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhLOUCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhLOUCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:02:48 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1606FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:02:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d38so899941lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=om/HCVC0CxSoU09KzvT/xb3Xt+kGoC0IjivC7aVdsOU=;
        b=s8n8voY+G80iDGHzEN0iDm28Pjz+I27p2XDrzK3tqtodBaWLC4IKzkbZvcZIN4vqEK
         79k6DEND/LHkoSxewVx1C9wBFz+NXUFG3zUg7gMa+WfNCmJ9OzoXXAArgjpU3k/QucfX
         GCN2pifirNrUBtX1ncbrfFNnNPBk6l8ElsOOmmTEFZ9xvrVOJKTsMhtYO2wijsFmmzTe
         VpRgoH8WTi8ThTPNu/u5GsH/vYPOw8aRh03f2AvrAhnHo8tlKHFkQlyOB8F20pcJhype
         ozJ4WzWLNQFb9jNsnwU/A1PyAlhGnauorBFcJ1nFBQFyd5SQHpY7gYHVAUlGez5nRIwO
         OY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=om/HCVC0CxSoU09KzvT/xb3Xt+kGoC0IjivC7aVdsOU=;
        b=AvrS5sq/PMTrylfCcsPyBwQLXtvqQ7iPLFOd5pEAxdePUMNjgGO/oZwQqUryNOeXon
         gkjzFvF63zYsFDamP0cG9WrNMqpNZIkxQ5M8kMS3Oyji5zMp+ksX4UonoV7hCR72+nvP
         EPNVSfbt7NBYGjHZMAYrz137gk0islYpJT8C/P0huCGqYwzWYIE/tDIkaQkkeSVSxiiF
         TvNAC3Nej7jJJSWL9Pz7WA9hQVm2FdRTa3YP8YTURqxjkNW1VDToDP8pKVWN3+XFzgbX
         /vQ90iWjbpD2xGyDHb0MhzVXqe1TQGl+4ig5mLOJPCy05BY/WaObQEP6zaMlMClNn5Ao
         fpEA==
X-Gm-Message-State: AOAM533RH2Bnc1jq74Z0x5MX08QZApgJFOyWeZSZkKB0Qbcn8Pk1AN+U
        VZmGy26F/hgEzkRpPTBnkmas9g==
X-Google-Smtp-Source: ABdhPJxKvLhKMJ67E0hXe0d5fyzxvqCglgRRlF00/Qa9W98zBCmYEUfHy4a8/tNcYKNvPFcLR29PMw==
X-Received: by 2002:ac2:5f0e:: with SMTP id 14mr11833186lfq.625.1639598566321;
        Wed, 15 Dec 2021 12:02:46 -0800 (PST)
Received: from ?IPV6:2001:470:dd84:abc0::8a5? ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id e10sm472204lfr.213.2021.12.15.12.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 12:02:45 -0800 (PST)
Message-ID: <69e44191-201f-8714-8a83-1a65a7026b54@linaro.org>
Date:   Wed, 15 Dec 2021 23:02:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 0/2] Use "ref" clocks from firmware for DSI PLL VCO
 parent
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20210911131922.387964-1-marijn.suijten@somainline.org>
 <163165584152.763609.4056232270079096475@swboyd.mtv.corp.google.com>
 <20210918144038.6q352hzqopx7vvdu@SoMainline.org>
 <20211214194656.mayiy4xhcshjluwf@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211214194656.mayiy4xhcshjluwf@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 22:46, Marijn Suijten wrote:
> Hi all,
> 
> On 2021-09-18 16:40:38, Marijn Suijten wrote:
>> On 2021-09-14 14:44:01, Stephen Boyd wrote:
>>> Quoting Marijn Suijten (2021-09-11 06:19:19)
>>>> All DSI PHY/PLL drivers were referencing their VCO parent clock by a
>>>> global name, most of which don't exist or have been renamed.  These
>>>> clock drivers seem to function fine without that except the 14nm driver
>>>> for sdm6xx [1].
>>>>
>>>> At the same time all DTs provide a "ref" clock as per the requirements
>>>> of dsi-phy-common.yaml, but the clock is never used.  This patchset puts
>>>> that clock to use without relying on a global clock name, so that all
>>>> dependencies are explicitly defined in DT (the firmware) in the end.
>>>
>>> I can take this through clk tree if it helps avoid conflicts. There are
>>> some other patches to sdm660.c in the clk tree already.
>>
>> Might be useful to maintain proper ordering of these dependent patches
>> but it's up to Dmitry and Rob to decide, whom I'm sending this mail
>> directly to so that they can chime in.
> 
> Dependent patch [3] landed in 5.15 and [2] made it into 5.16 rc's - is
> it time to pick this series up and if so through what tree?

I'd also second the idea of merging these two patches into 5.17.
Most probably it'd be easier to merge both of them through the clk tree. 
Or we can take the first patch into drm-msm (but then we'd have a 
dependency between msm-next and clk-qcom-next).

Bjorn, Stephen?

> 
> Repeating the links from patch 1/2:
> [2]: https://lore.kernel.org/linux-arm-msm/20210830175739.143401-1-marijn.suijten@somainline.org/
> [3]: https://lore.kernel.org/linux-arm-msm/20210829203027.276143-2-marijn.suijten@somainline.org/
-- 
With best wishes
Dmitry
