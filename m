Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C184F4805
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357251AbiDEVZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573451AbiDETLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:11:08 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D8C15
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:09:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v75so115611oie.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+2fqXM8JUf5DwDQtzJxsOwkBtwJFw5Gqvt+WmQEX/uI=;
        b=Veprx3ttQggks5cQbO8i0KUCPvNxmYkyfrcSQ+dlu3r2KMUxM/prPRRkNKK5FkgA2R
         c4CMJOLTqifeczv3jis31FaBbFJr2bIqERUgorEjNOU0V2V+N4ZvmF+nHzXQ5CnyEMc8
         RDmXuuwu8EOiCntCCDni1oO9KhooSgBPnYRIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+2fqXM8JUf5DwDQtzJxsOwkBtwJFw5Gqvt+WmQEX/uI=;
        b=eZvdcxcJ4HmUZg1dGTUGnkWv4N/v6MEbxdqSC4ZnpQjeUpME0pocPJdmpkWywMSDGI
         InVAVHEkWyhcMObAldaz0kFpI6hSebx9ju6T/36yAfKjmynepBSp+2KV3lYD/3qGm0Il
         bNNRNV8EdMV6x48WcrzyCEN1a6ryu1BBdPzGeoV++bla2eu2smkrLv4zpwAWxq6y7efb
         Xw/NbaF0lrU9dU6WnNK/Mxee3kGY0MosBACRfe6eLceIVHyrLP8klIL9219eKu1IjYqu
         F8ghIXDqVTI9rSPkCZozNQnj5jkfHdl0oYV0WMjEgnrWjgmiD2ccTBQYMPrnaaLDgLnd
         2yWA==
X-Gm-Message-State: AOAM530tObdd+2Tcwr7f06I3yvmft9UKfCsa6O8VjIx3vGnPeNc2f2R8
        R4QDpMzaPACShQPcDZCutyhDU+XpAq32DpnKsebtfQ==
X-Google-Smtp-Source: ABdhPJxVQrIJEEsLECgeyAlKa1nOMAx8Ihqi51fqzaMW25crPXGyzU/YYh2XyyOqf5FeQzVxwuGnAmkOZ7o/RtTL9XY=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr1993155oie.193.1649185747131; Tue, 05
 Apr 2022 12:09:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Apr 2022 14:09:06 -0500
MIME-Version: 1.0
In-Reply-To: <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com> <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Apr 2022 14:09:06 -0500
Message-ID: <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008 PMIC
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-04-05 06:50:31)
> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> new file mode 100644
> index 0000000..0f6d5cb
> --- /dev/null
> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> @@ -0,0 +1,205 @@
[...]
> +
> +static struct platform_driver pm8008_regulator_driver = {

Why isn't this an i2c driver?

> +       .driver = {
> +               .name           = "qcom,pm8008-regulators",
> +       },
> +       .probe  = pm8008_regulator_probe,
> +};
