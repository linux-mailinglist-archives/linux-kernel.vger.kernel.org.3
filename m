Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72B51DAE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442358AbiEFOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442355AbiEFOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:46:58 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0427F6AA63
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:43:15 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e5e433d66dso7389019fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=j9vt1yipzaOT5UP41ruP3lJvG1u1FqPCCBy9SB2G458=;
        b=hQ8zhDt04Zos+3OEE5PEq6PyFUfP0o7Viueu/yuzeUjuztLargM9ZJ5KDmCUjnBs8o
         VOjo3CInXknwKuMPDn2h1y9fF5GzuUAQ+xD3pSmmjSPwPzbqH373HcR3+aMkCxx/0oZH
         Y/jOeaAzsjIJZ9AeGCc+oDh4scuoNoLrSWJ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=j9vt1yipzaOT5UP41ruP3lJvG1u1FqPCCBy9SB2G458=;
        b=Yie470ghGFjRaAfgTz1lagYqm4EJqqXY2NtoQsag8iu2YiV1SSDNR9J/2F1+nTFmfv
         mfHO32RsTuJ0KRaurPcvhWb22KkdRxJ6AaK76+fDfhHIFOaKcr3SupjN2qg3pffeAius
         LeFi8yn7haEMP00mCvYC0PolQFJcejn4U6UCLlWpLIunS9yQI1y/mQnaJT5hcb0tdelp
         F8HkMJjneeKu2hPDeZCXGo52hJTxn3SBFMyDUNK3Pe8mWRCGVKTHhVoEdBWE/0vUqpGl
         Qm+vmLpaCs4jBHw9LxTjx1j6gnEKRnOsGv1ele8Y6gBB1xCcYNqyaTT4dLU8MibS3JGD
         QQfA==
X-Gm-Message-State: AOAM530aDuTfLNU+8d1gRlXSS1sbUELk4oEq2lvFr7BTC/+0II+rZ5k9
        p+Vp0kpgWH/ddmnJO8v7gO20xlPrpaVrxxclkzfoNA==
X-Google-Smtp-Source: ABdhPJxYtv5uc08UqyhYLoy9R0UzFUFg/K0f4VRcH5MLWGPU/j+wMPYuHdhPfZr0426ZWQ3zBWnpHL/oUfz/zOFwbaU=
X-Received: by 2002:a05:6870:40c1:b0:ed:9a12:3f95 with SMTP id
 l1-20020a05687040c100b000ed9a123f95mr1408352oal.193.1651848194402; Fri, 06
 May 2022 07:43:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 May 2022 10:43:14 -0400
MIME-Version: 1.0
In-Reply-To: <1651742739-12338-8-git-send-email-quic_c_skakit@quicinc.com>
References: <1651742739-12338-1-git-send-email-quic_c_skakit@quicinc.com> <1651742739-12338-8-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 6 May 2022 10:43:14 -0400
Message-ID: <CAE-0n51jx1nkgezHFz7748i10pLtT0Nk_XM-kjPfYbiPHT41TA@mail.gmail.com>
Subject: Re: [PATCH V11 7/9] regulator: Add a regulator driver for the PM8008 PMIC
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-05-05 02:25:37)
> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> new file mode 100644
> index 0000000..9e2d531
> --- /dev/null
> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> @@ -0,0 +1,216 @@
[...]
> +
> +static const struct linear_range pldo_ranges[] = {
> +       REGULATOR_LINEAR_RANGE(1504000, 0, 237, 8000),
> +};
> +
> +static const struct pm8008_regulator_data reg_data[] = {
> +       /* name  parent       base   min_uv  max_uv  headroom_uv voltage_range */
> +       { "ldo1", "vdd_l1_l2", 0x4000,  528000, 1504000, 225000, nldo_ranges, },

Why can't 'base' come from the reg property in DT?

> +       { "ldo2", "vdd_l1_l2", 0x4100,  528000, 1504000, 225000, nldo_ranges, },
> +       { "ldo3", "vdd_l3_l4", 0x4200, 1504000, 3400000, 300000, pldo_ranges, },
> +       { "ldo4", "vdd_l3_l4", 0x4300, 1504000, 3400000, 300000, pldo_ranges, },
> +       { "ldo5", "vdd_l5",    0x4400, 1504000, 3400000, 200000, pldo_ranges, },
> +       { "ldo6", "vdd_l6",    0x4500, 1504000, 3400000, 200000, pldo_ranges, },
> +       { "ldo7", "vdd_l7",    0x4600, 1504000, 3400000, 200000, pldo_ranges, },
> +};
