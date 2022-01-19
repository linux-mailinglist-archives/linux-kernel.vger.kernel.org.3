Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACE4943B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiASXM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiASXMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:12:55 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA44C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:12:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m1so14486907lfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U2dwbqcasQ5jAt+dZT0r0geSiO9Og0zFjtJjCnr7lCs=;
        b=nwoSlp64QlHMhIXPAbqSlvtxn3YRmwGuo7gO9z+aJyjKE7+vGUsNePrlnd9gihi5Cv
         +2/QZYmgoEypLlDZcKxH1xBn7ERBNTyQcDLz9/0Mr+kdiO6ZDMdAmAfB/OYxvdzGEUvQ
         3OV5kWf4Op6Su8FEfxrPBhTn+HHIa5UT0ry6dssyU+V7b+IQJWFdqbZpKDMYqYOV70do
         9ZK52EFTCsRvagLpb7P+t59v138vDT01JUF5KA8DeNO+yIe9OX3Z1Iknx2Vf+n4wZ4QT
         EMXsApYX9RQleRf2uYL/GQv99KdQWAqiv4A6D5XTZMJrDRUc4RI2XNFqRQCant61Tqhw
         TSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U2dwbqcasQ5jAt+dZT0r0geSiO9Og0zFjtJjCnr7lCs=;
        b=yIwLrF+OIDphxeeQhyvf2MKjd8JPMPTaTW03N5LlKG+4Hbc/k0inyzgtSXpg7vnaJE
         i1LVoXwHXInavWeFMxaK6VCe/AKPBikypfoa2KrTpBd3kvwORkRG8X4Vnj/2hUWZOSPK
         OSCCRXtouT15T5j0WE2oLgSAHPRDytCJElPJv+MNHWjf75fnBYHXrL77lb151+HpUnri
         jXOc1/7tsrFbsgO1KO44ziCQzaL+nIy9nKNmF4VtWNGYWHhJjqSmgyoM8kUooBSt+lcB
         gR95kwFNQZ+3BAbfJA4/y6ys+dKVWQILESKdMVvOJPGqZJPBHA+4UgMnDF/vt4A31066
         i6VA==
X-Gm-Message-State: AOAM533qJNOFUXkoNp3ZBJlnpCjmoT/IZuS28sJXhI8pUNPPZ1NvuyHr
        LYz+iNZHJ21nEzGSR1cgQUeQkw==
X-Google-Smtp-Source: ABdhPJzS0S2j0mE2ciBclrlhqyzVclucItRkmT/yH3LWXkOsMSX6ENnBKT8aGA/LNELrdDToVn+shw==
X-Received: by 2002:a05:6512:3da1:: with SMTP id k33mr27853059lfv.212.1642633973353;
        Wed, 19 Jan 2022 15:12:53 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q27sm103546lfd.271.2022.01.19.15.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 15:12:52 -0800 (PST)
Message-ID: <84bd598c-b1b7-984e-9fa1-94ad28087ef0@linaro.org>
Date:   Thu, 20 Jan 2022 02:12:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/msm/dpu: Bind pingpong block to intf on active ctls
 in cmd encoder
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Bernard <bernard@vivo.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20211222105513.44860-1-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211222105513.44860-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2021 13:55, Marijn Suijten wrote:
> As per the specification of DPU_CTL_ACTIVE_CFG the configuration of
> active blocks should be proactively specified, and the pingpong block is
> no different.
> 
> The downstream display driver [1] confirms this by also calling
> bind_pingpong_blk on CTL_ACTIVE_CFG.  Note that this else-if is always
> entered, as setup_intf_cfg - unlike this mainline dpu driver that
> combines both behind the same function pointer - is left NULL in favour
> of using setup_intf_cfg_v1 when CTL_ACTIVE_CFG is set.
> 
> This solves continuous timeouts on at least the Qualcomm sm6125 SoC:
> 
>      [drm:dpu_encoder_frame_done_timeout:2091] [dpu error]enc31 frame done timeout
>      [drm:_dpu_encoder_phys_cmd_handle_ppdone_timeout.isra.0] *ERROR* id:31 pp:0 kickoff timeout 0 cnt 1 koff_cnt 1
>      [drm:dpu_encoder_phys_cmd_prepare_for_kickoff] *ERROR* failed wait_for_idle: id:31 ret:-110 pp:0
> 
> In the same way this pingpong block should also be unbound followed by
> an interface flush when the encoder is disabled, according to the
> downstream display driver [2].
> 
> [1]: https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers/tree/msm/sde/sde_encoder_phys_cmd.c?h=LA.UM.9.16.r1-08500-MANNAR.0#n167
> [2]: https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers/tree/msm/sde/sde_encoder.c?h=LA.UM.9.16.r1-08500-MANNAR.0#n2986
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index 8e433af7aea4..e0e08a874f07 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -71,6 +71,13 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>   	intf_cfg.stream_sel = cmd_enc->stream_sel;
>   	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
>   	ctl->ops.setup_intf_cfg(ctl, &intf_cfg);
> +
> +	/* setup which pp blk will connect to this intf */
> +	if (test_bit(DPU_CTL_ACTIVE_CFG, &ctl->caps->features) && phys_enc->hw_intf->ops.bind_pingpong_blk)

Nit: here we bind all interfaces, but later we unbind only master. Is 
this correct?

> +		phys_enc->hw_intf->ops.bind_pingpong_blk(
> +				phys_enc->hw_intf,
> +				true,
> +				phys_enc->hw_pp->idx);
>   }
>   
>   static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
> @@ -507,6 +514,7 @@ static void dpu_encoder_phys_cmd_disable(struct dpu_encoder_phys *phys_enc)
>   {
>   	struct dpu_encoder_phys_cmd *cmd_enc =
>   		to_dpu_encoder_phys_cmd(phys_enc);
> +	struct dpu_hw_ctl *ctl;
>   
>   	if (!phys_enc->hw_pp) {
>   		DPU_ERROR("invalid encoder\n");
> @@ -523,6 +531,19 @@ static void dpu_encoder_phys_cmd_disable(struct dpu_encoder_phys *phys_enc)
>   
>   	if (phys_enc->hw_pp->ops.enable_tearcheck)
>   		phys_enc->hw_pp->ops.enable_tearcheck(phys_enc->hw_pp, false);
> +
> +	if (dpu_encoder_phys_cmd_is_master(phys_enc)) {
> +		if (phys_enc->hw_intf->ops.bind_pingpong_blk) {
> +			phys_enc->hw_intf->ops.bind_pingpong_blk(
> +					phys_enc->hw_intf,
> +					false,
> +					phys_enc->hw_pp->idx);
> +
> +			ctl = phys_enc->hw_ctl;
> +			ctl->ops.update_pending_flush_intf(ctl, phys_enc->intf_idx);
> +		}
> +	}
> +
>   	phys_enc->enable_state = DPU_ENC_DISABLED;
>   }
>   


-- 
With best wishes
Dmitry
