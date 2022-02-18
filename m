Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3D04BBE58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiBRR1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:27:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiBRR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:27:00 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B05064EF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:26:42 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e2so1912147ljq.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZYe2t/FMZ93x2Kic1ao1JKybApih1A56RL1y9i2FhLE=;
        b=gOzR/3gjf7/yY5lV5TZ57e/x1QHxbFE+SzLfqHEUg96Sgohxk75AEOBey92ZQc0yen
         4aThrlFgnRNf9Z68Q3QFatelLW9CVGwuBcW36NUiY4xO1gMmIPMkP+kho7g8aOG8ifL/
         yJkCIbLgpPXbQ3o35h4BggnBXVBhURaMExrK8uukcO82l+LdThbMAp/h+DKVZ+grqSh9
         s8l9HHb/JNFM5ttGIW9a1vz10ButIC84JkWcSsHyr2BEA40yNmf/Ig37ndCdp5XWrs2N
         JzB4n7vom3dKNRvlqiuYWluuxWMgOykrBmx9eq8BE49uM0RSwVgS8NQdOUpMzkpuCBi1
         PNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZYe2t/FMZ93x2Kic1ao1JKybApih1A56RL1y9i2FhLE=;
        b=tawyXn/LfhgtzS6HLTgyaZvE7yIQn9+fl98prhU3uf0rwyCwBIP06AR4XNpH9JJDPj
         xqk4B0l5s9weQ8/fOZ8S3fqPpv768yaHwiZ4tMGOMa69iQGl1fn3XnkbuVC4nWCs+uLh
         yRfH9275FLg8DMgtq3jNwKLtRhdjDFMZNX4s3bf7ZLNFVgw/HljDyGg5TKll/f0eub5Y
         8mvAMAjDWGmYf+mF7L7jZiA0Sc4yuzf0Ji50yoKQ+Lh/2k2ux7Vrsb6iU3PQK1xW9AbW
         vNJeGoG1LhnOhLPmrsrYzwHEUI6dm3wRfyzpWRIDEl5c9++sUZ2vFSuyTfFTpqC9vykA
         c6Qg==
X-Gm-Message-State: AOAM5329cschgsJKkY8iFy6VPhOVNFgBk8HwqETrORcfzSNhNajkv0rW
        b3VWoGZaT4UE0nGN6bVtgReFeA==
X-Google-Smtp-Source: ABdhPJzF6KsEJtgTA6aUDgNsa2gJAo/6KzTixWf4JHc5zKVLW0gmtaXhNhMuSUe6ZlrOXZsTogAVWQ==
X-Received: by 2002:a2e:99d1:0:b0:244:bad9:4ab7 with SMTP id l17-20020a2e99d1000000b00244bad94ab7mr6398922ljj.269.1645205200824;
        Fri, 18 Feb 2022 09:26:40 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r3sm272173lfi.260.2022.02.18.09.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 09:26:40 -0800 (PST)
Message-ID: <fab2ccb6-9c00-90cb-5986-8e1544c14596@linaro.org>
Date:   Fri, 18 Feb 2022 20:26:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/2] drm/msm/dpu: Fix timeout issues on command mode
 panels
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        abhinavk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20210911163919.47173-1-angelogioacchino.delregno@somainline.org>
 <20210911163919.47173-2-angelogioacchino.delregno@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20210911163919.47173-2-angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2021 19:39, AngeloGioacchino Del Regno wrote:
> In function dpu_encoder_phys_cmd_wait_for_commit_done we are always
> checking if the relative CTL is started by waiting for an interrupt
> to fire: it is fine to do that, but then sometimes we call this
> function while the CTL is up and has never been put down, but that
> interrupt gets raised only when the CTL gets a state change from
> 0 to 1 (disabled to enabled), so we're going to wait for something
> that will never happen on its own.
> 
> Solving this while avoiding to restart the CTL is actually possible
> and can be done by just checking if it is already up and running
> when the wait_for_commit_done function is called: in this case, so,
> if the CTL was already running, we can say that the commit is done
> if the command transmission is complete (in other terms, if the
> interface has been flushed).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index aa01698d6b25..aa5d3b3cef15 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -682,6 +682,9 @@ static int dpu_encoder_phys_cmd_wait_for_commit_done(
>   	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
>   		return 0;
>   
> +	if (phys_enc->hw_ctl->ops.is_started(phys_enc->hw_ctl))
> +		return dpu_encoder_phys_cmd_wait_for_tx_complete(phys_enc);
> +
>   	return _dpu_encoder_phys_cmd_wait_for_ctl_start(phys_enc);
>   }
>   


-- 
With best wishes
Dmitry
