Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A84530760
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiEWB7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiEWB7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:59:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A33935877;
        Sun, 22 May 2022 18:59:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f21so46321pfa.3;
        Sun, 22 May 2022 18:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vD+DGie99zMkr0nJSBJghK7m9B4fcVep+NfF0Px5NeI=;
        b=UlU4j2O6HkuShPLRu/4u5GJiJ2CR1lrNCFQWQ3sarMDfjW3K35g5qugZRYr/bBsWMu
         sE5exKzQmF/F3MYbkC8G7PpD8LVneNqDvmVGPDRq8ZzwJ4s4FYk6ysLjd+0AKr89AI11
         WMX6f9PCKQ1MH9bSM+5o6Y8TImhjXLFM9jXTF2B7msyggWdCI4jEd9rR9whV5ZgcL5bm
         C3hu7HJCcQKC5SKKMU5vqy74ZftwJBS4P1Zwzx85K9+p0YF5ET0APiECuHeedzBqq1OH
         rgKZAhIqFADAwLBKp+duuuKcDz+a/q/vS/Z7YVtFI1kXc+pW/bGmZ64e/FaUUqB1yvak
         +yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vD+DGie99zMkr0nJSBJghK7m9B4fcVep+NfF0Px5NeI=;
        b=0wtTKV0iN0bxN4kAXnA8rZXXP6DPHO7Vo8WEPcaodO+JaO9H1qJRVH50axHaqdUmdZ
         RII8XDijkTj1RuiQPi5rVVU1dfT2mYkikoyBDVY4jH9JSCECy9c9zkCeCOm70YK+VAQ1
         BeA3ackl5Dkd2SUuqsxwf0LC/qn+rek1iTva8cdRY9PJj4EMDnGFd75x+W3uD3J/H6SR
         ps05ePpcDuCDUB+1+0bxw1JzR7esuac1kThU9BCXeKU+w0dcMPrIWRyuHtIhhdwd+pL4
         7C25aYlC0bpCj892KYMGZgWcjtNpfSlaJTvqjVUaBzwsYSYPYTCwqQhhFfeYm57bdnZY
         2r+w==
X-Gm-Message-State: AOAM531NrNUbWauccJjUbtEwmmh29uisMUdoPKE7IWKpfpOh01dJcvv7
        9hFYgyCrqzZhinF6Bo8Zhs0=
X-Google-Smtp-Source: ABdhPJy2p/jFV7g6ZgpcDogCvhXmrWLXQEZijPyaAoNQV+V83ON3F3qw4ZovWJ4SBd+qU6FmZPMsOw==
X-Received: by 2002:a63:8bc1:0:b0:3f9:f00b:f877 with SMTP id j184-20020a638bc1000000b003f9f00bf877mr7866091pge.378.1653271145241;
        Sun, 22 May 2022 18:59:05 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id l13-20020a6542cd000000b003c619f3d086sm3607429pgp.2.2022.05.22.18.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:59:04 -0700 (PDT)
Message-ID: <61149e02-ad4c-6e3d-e33b-b21025aa3b65@gmail.com>
Date:   Mon, 23 May 2022 09:58:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm: msm: fix possible memory leak in
 mdp5_crtc_cursor_set()
Content-Language: en-US
To:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
        gbeeresh@codeaurora.org, sviau@codeaurora.org,
        wentaox@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220509061125.18585-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220509061125.18585-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/9 14:11, Hangyu Hua wrote:
> drm_gem_object_lookup will call drm_gem_object_get inside. So cursor_bo
> needs to be put when msm_gem_get_and_pin_iova fails.
> 
> Fixes: e172d10a9c4a ("drm/msm/mdp5: Add hardware cursor support")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> index b966cd69f99d..6a5f73f6a23b 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> @@ -991,8 +991,10 @@ static int mdp5_crtc_cursor_set(struct drm_crtc *crtc,
>   
>   	ret = msm_gem_get_and_pin_iova(cursor_bo, kms->aspace,
>   			&mdp5_crtc->cursor.iova);
> -	if (ret)
> +	if (ret) {
> +		drm_gem_object_put(cursor_bo);
>   		return -EINVAL;
> +	}
>   
>   	pm_runtime_get_sync(&pdev->dev);
>   

Gentel ping.
