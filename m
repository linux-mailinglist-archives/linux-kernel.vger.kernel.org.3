Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB4543CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiFHT3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiFHT3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:29:07 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8751B1E716B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:29:05 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2cd424b9cso28468491fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=5vvwrgdknn1K9gJFkCVHoS1UOMpaiXh3dfNKyE3vHCA=;
        b=Hd5jcwosS+DHrHrSRvsp1DiAbCxUrFWV4Ys2JHKBdh4xlpDyW7BhzoIfKfDx5gjQXM
         1mW+SikjxugwKvDlj4Tgp4hFCUdMfAORPCneDm8IwpDuvRUsynDdRTIVK3kwSK3+KRHw
         5rMCTq+XO6A0kbgcSWlQN+lUXklGV8Tcp6KxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=5vvwrgdknn1K9gJFkCVHoS1UOMpaiXh3dfNKyE3vHCA=;
        b=bRhTNfN/lT8hqPgTiFB4Afc5VpiI5yxFrnSoSqAD5SfxGSUYs8pr3D9BlS7k/xNTHZ
         byGleuFzVa8E1ZUkeDpAxx1dtdajy45g9iQEstnDNlmD2YOQLemlFGnXNRIoonMmmB4D
         UADZ7wAZRoAZBGUIwHKrFrnKo+npl8leqUZrMXPrZC7gPhvcPKXZaQlK/afaTC3iuuRe
         9nVoMVX9Bvv8gkvlD2ZSW5rkhVJgFHGkdQFrca76SZd6I3U8G8kI7gI+kUEwB7SXxBpD
         61Is2IDnNMwd2etzR4tNWGnsFXPmo1peB+Y++dJ7bpH7ADT48D/Mm8goAQzxag5lHBT8
         2Exw==
X-Gm-Message-State: AOAM533WybfsSQg3puvkvNXkQz6uk1LdPntjOC2kWYpAGBD8EpM7HOGF
        DA03qb3K7i0pYNdOisGtLrXiwn2XkgEq1wqRWHJSpQ==
X-Google-Smtp-Source: ABdhPJwfbQOhuoavwnKuPwNYfxx7ThIu71YX1w2/3eSgITORUdWupWunN82u7ED3ykn9MRwPBeCHP/wkwS4CsJQhctI=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr3169953oap.193.1654716544865; Wed, 08
 Jun 2022 12:29:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 12:29:04 -0700
MIME-Version: 1.0
In-Reply-To: <1654696929-20205-3-git-send-email-quic_srivasam@quicinc.com>
References: <1654696929-20205-1-git-send-email-quic_srivasam@quicinc.com> <1654696929-20205-3-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 12:29:04 -0700
Message-ID: <CAE-0n53EY1eKqnVLhU__e7t63BbVoKz++6aijOpEw0k5Cxa8-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: qcom: soundwire: Add software clock gating
 requirement check
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@quicinc.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-06-08 07:02:09)
> Validate software clock gating required or not and do software
> clock gating on hclk if soundwire is operational and keep it
> running by adding flag in private dat structure.
> This is to avoid conflict between older architectures,
> where software clock gating is not required and on latest
> architectues, where software clock gating is mandatory.

This talks about software clock gating but the code is getting a reset
and asserting it. Is that because the power on reset value of the clock
gating is to have hardware clock gating disabled, but some earlier code
is enabling hardware clock gating?

>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 38c3bf5..ebd7479 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -659,7 +665,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>         val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, ctrl->rows_index);
>         val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, ctrl->cols_index);
>
> -       reset_control_reset(ctrl->audio_cgcr);
> +       if (ctrl->audio_cgcr)
> +               reset_control_reset(ctrl->audio_cgcr);
>
>         ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
>
> @@ -1494,7 +1506,8 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
>                 qcom_swrm_get_device_status(ctrl);
>                 sdw_handle_slave_status(&ctrl->bus, ctrl->status);
>         } else {
> -               reset_control_reset(ctrl->audio_cgcr);
> +               if (ctrl->audio_cgcr)
> +                       reset_control_reset(ctrl->audio_cgcr);

reset_control_reset() is a no-op if the pointer is NULL so the if
condition is not necessary in the above two statements.
