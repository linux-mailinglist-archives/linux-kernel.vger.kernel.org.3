Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEF51DAA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442255AbiEFOlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiEFOlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:41:49 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACBA6A41C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:38:05 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id s18-20020a056830149200b006063fef3e17so5025737otq.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=C/dvfq7UKDW/S628+lbUbCWkK48n01st45hR/4wo+Z0=;
        b=JqMnJvg2mt5r4iavW01xjEKcwD9Onfbq6BfkMM5CMLGRRNtg7B+2cQ3t7a9etEiACI
         lqroy682g14szmQVzx+g2FKuGjcs2kkcbxR05tiSkAIsEupgzPo8d0bpvtLa2rOQwnL5
         wTsBk6maXiF0rbeFMx++g9251+AM+/1fhu7Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=C/dvfq7UKDW/S628+lbUbCWkK48n01st45hR/4wo+Z0=;
        b=7Rv7apfqnsXV5KdZvOyjJqegGb5+6eO7xSvlzxmDAnWpQqcClGHzjKFVQ/H8gKRvez
         6x2o3ABjFbegv0BoszBC9uQU80kvDNAGlOkclwQUcXxlFGOdUw+Y56y9tVG75HBMIW64
         tVbMSVf2uts+fgyoFgT3IieysUwusvh/XkdVLeU4K2Gwpej31M1vWuwen6GEKT++RrT5
         CJCkS/mmvvZ2DH9ElV6lf3D3T2krcyMOerZGd3gzlrzoKt6BsAh0h3fCrtdexbFj4oS1
         6dce3VEg9obxNtiNHmhzvGDiRHLOSHeZoKZE+jyG6SXYPMQNsMEmvKWOTa6hqeA9+aty
         6WxQ==
X-Gm-Message-State: AOAM533e372EyXURHTtIO/ysfXLuDVK6ujMFEGfGqis0Hg1GU4kRBeat
        xywkyyPOHe7x0ZYI5cABr/Xahc95AqI0a1DUGwpTAg==
X-Google-Smtp-Source: ABdhPJx40iwS6HUc0rwCNu2O7HYUFSU94WfFeFUr/R9tL+AQy2EmEDMc5t9LPfFWR2XJA/lFq1b1829BAl16VL/+sKM=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr1152126oth.77.1651847884845; Fri, 06 May
 2022 07:38:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 May 2022 10:38:04 -0400
MIME-Version: 1.0
In-Reply-To: <1651742739-12338-7-git-send-email-quic_c_skakit@quicinc.com>
References: <1651742739-12338-1-git-send-email-quic_c_skakit@quicinc.com> <1651742739-12338-7-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 6 May 2022 10:38:04 -0400
Message-ID: <CAE-0n53N8D=-5K7q9CbVcoGE6g0kSuFmcSpwnOz_8f1vejksZA@mail.gmail.com>
Subject: Re: [PATCH V11 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-05-05 02:25:36)
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index 40a67f0..25e8d0b 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -150,6 +151,11 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
>         .max_register   = 0xFFFF,
>  };
>
> +struct regmap *pm8008_get_regmap(struct pm8008_data *chip)

can chip be const?

> +{
> +       return chip->regulators_regmap;
> +}

EXPORT_SYMBOL_GPL please. And the include is needed to avoid sparse
warning.

> +
>  static int pm8008_init(struct regmap *regmap)
>  {
>         int rc;
