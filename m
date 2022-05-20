Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2258B52F44B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353408AbiETUO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiETUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:14:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC02185407
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:14:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q8so11152685oif.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=HWJji6gVytG9NaepPJsUpOE+oqctRwW53y/Rg2/3daI=;
        b=L5wdilZPPhLeZ6H9txo7C+yQMMnJoaeLu6EewH66Q73sZn7CgIshPVfGQt58p2T1rF
         z7QeS2uLJnC624MbM5zt8fBPnBh+VHRq7OO8RY0kOqZapAwf1WxaNEnVe9wSh6nhfAU1
         u6lKg8SoY9PqpD/V98ioNwwwLlmY/2daDSeTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=HWJji6gVytG9NaepPJsUpOE+oqctRwW53y/Rg2/3daI=;
        b=qhj2/rJOT1K9ufYjG0h12RV5t5eCTKQkVKgo/28uUfZsn/fT/0M21IXygRHvu9FQIY
         sUJ7TNH6g8t8VDdmIEEJr7I4Tnt+0d4vbuiAihjlSDj/MEELPKBfYootHG0ll3zzxUaz
         5isR/qkMBS0bsOT0OAjNvyLmzfRIDvVmb/kW2llE4iEVCYv3Pyy0CH7+1F6ijRhXkQaS
         MJcCdcdCvgTXXC6Lpc0ZHEZjDNsxQ4tdi4O79+sHa1D1OlF6rLa2fdNZotcblD2DXppe
         QawJfdo+EPj9vpAO61cuKnjTSifr8LR+wSo23AkPBI6RH8WqlPBw3wUrbpvu4CsNpXOw
         +OuA==
X-Gm-Message-State: AOAM5334DA9VPbANF6YLHxLDr+cKw/E67rGux04eUZQar2L6qcK8jCZM
        dL/YSNAHX4VVQXDFt0WknGGPBnyx0/Z4kyK1b9dOiw==
X-Google-Smtp-Source: ABdhPJwP7L0SMXKFI6625vEQZTfFfECarUErW2tlmkzH+D2As2PkcfrO1Fh8376ZDCpcT7+qRqUbX8ACus/aB+6rZHQ=
X-Received: by 2002:a05:6808:23c3:b0:326:bd8d:7993 with SMTP id
 bq3-20020a05680823c300b00326bd8d7993mr6601653oib.63.1653077663519; Fri, 20
 May 2022 13:14:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 May 2022 13:14:23 -0700
MIME-Version: 1.0
In-Reply-To: <1653077167-16684-2-git-send-email-quic_khsieh@quicinc.com>
References: <1653077167-16684-1-git-send-email-quic_khsieh@quicinc.com> <1653077167-16684-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 20 May 2022 13:14:23 -0700
Message-ID: <CAE-0n51B3Crb0ZFUppu2MXAGfCEfRcO9FX-6KMTTcPia3w8TkQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] phy: qcom-edp: add regulator_set_load to edp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-05-20 13:06:05)
> This patch add regulator_set_load() before enable regulator at
> eDP phy driver.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index cacd32f..0b7f318 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -639,6 +639,9 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       regulator_set_load(edp->supplies[0].consumer, 21800); /* 1.2 V vdda-phy */
> +       regulator_set_load(edp->supplies[1].consumer, 36000); /* 0.9 V vdda-pll */

Why aren't there checks for errors on these API calls?
