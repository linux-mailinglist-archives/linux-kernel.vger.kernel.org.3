Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A2467D16
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382500AbhLCSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbhLCSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:20:34 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF804C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:17:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k37so8517859lfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Pvwka+nQK0UfHFY3XxiSjtliqkg8sD5ZuyxOIxv5Cbs=;
        b=eIZxsWUwapXBrA560XcorJL8NqT1ntAWDUua+GJsnFNktaz/q6rhH2kj69fPiKJfme
         wdsA+qXnTzMm73W0MJytDuUILbe1cjL926x4EcZmvL7yWKyZYQq6X2XgBubpBwvmTmjq
         XNQ0A+Q+kK2S2rYPr91qC1zcozFLyrCVPLSWYZNotxJailRpu2aPFze12TNVTibkvJ2F
         6euQtrTzFj7X0k3n9vBCk9eH4vuWcdd/bhb0kUh6y0INWm/+A8HsB2wPi62MFi6kt7Pr
         j7gbIqKfj/j9qHACc9kMVWUpfReJcdcF8KuMZFF9dw+zyzoL4gPAjZQ+6avWwqM6O+tA
         xkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pvwka+nQK0UfHFY3XxiSjtliqkg8sD5ZuyxOIxv5Cbs=;
        b=gG82ZZb9OeAIX1aowF979gDcXiEBGLLybIOiXT6E4CKuBbZFlQt2x6HBh/P+9ebcTw
         rMkxMHI8+O+G2mNbRwhI1LhHBkaPPeFgw74F4N29XWY9JlfhbohOOLdbVfUqRjX4Mjb1
         8CADMQVjg4YPt9ob4d5GA8qQnA5CtIzFUNpnjTb//wK1ZF1UYOMF1DDyGahrdBk02Hvl
         mwWmJ7ZmDMmA+wNibdNzF/bDv3tl0qw6Ga+E0BOGsnglzihGBBJpYRQhQO3UDiZJx63b
         GTqG5Mq1yabnLsY7BQR+iksZjctL2kg33wJ0ncHQC4v7T3bRE+gRnR0+HN2LtIsGIxDi
         m/sw==
X-Gm-Message-State: AOAM533AQwGNPaULvz0uMmDoYqb3VtbFZhzDXGhW3a888MbZ72MpgOo1
        8PHTMkrsUXMl30KWOJi9iHCJbw==
X-Google-Smtp-Source: ABdhPJyKiAVCfe8d7jmNoqLFibh1Ce2dZGkb1WnECK82kC0o6EOkx6AYO0XZDzDfXVAgjTPEvo0Njg==
X-Received: by 2002:a19:7408:: with SMTP id v8mr18384090lfe.392.1638555428078;
        Fri, 03 Dec 2021 10:17:08 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id p3sm456437lfh.124.2021.12.03.10.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:17:07 -0800 (PST)
Message-ID: <93020f22-0048-e0e7-5df5-144c3e705b84@linaro.org>
Date:   Fri, 3 Dec 2021 21:17:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next] drm: remove node from list before freeing the node
Content-Language: en-GB
To:     Yang Li <yang.lee@linux.alibaba.com>, robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1638502612-113708-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1638502612-113708-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2021 06:36, Yang Li wrote:
> fix the following smatch warning:
> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1675 dpu_plane_init() warn:
> '&pdpu->mplane_list' not removed from list
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index ca190d9..aad238b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -1672,6 +1672,7 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
>   	if (pdpu && pdpu->pipe_hw)
>   		dpu_hw_sspp_destroy(pdpu->pipe_hw);
>   clean_plane:
> +	list_del(&pdpu->mplane_list);
>   	kfree(pdpu);
>   	return ERR_PTR(ret);
>   }
> 


-- 
With best wishes
Dmitry
