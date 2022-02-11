Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F664B2745
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350589AbiBKNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:35:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242462AbiBKNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:35:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196931DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:34:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so7328371wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c5deOdUwH9zFHVJq1pi2VKNXJFMRgY+QuG1cj9vFjqQ=;
        b=Rfj5VrN/yMm394gXaeO7hjRbBBeWfKjzMqjHXiaIKAisSdLwvcldHfcvdV7ERsHB72
         FPoNWOGSf3oknBlmAzP6F5P+qcLQTCMzBlQ1CowdiRR3vqkh7YishnoPkT5LYy/MWFRE
         EPQlX+T8SRRsyujB0z5nSyhcRHC0jaR9Su+yXHtVfgWRUVDBr2q/Lkq76//h0iSfyqZu
         8HJTrz9cS91MNCBJFKqMlqHTM4okkWeBK1qQDuyzsS97eUDtFD241pDTZg2KE9dKCubj
         PW+6ufOpcZAzilHI4OMjckUmLJSKtJXYNAjYi5GnzzOmop8j1pOJmCh8eURoOE7uYa9c
         oRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c5deOdUwH9zFHVJq1pi2VKNXJFMRgY+QuG1cj9vFjqQ=;
        b=Wxda98govaLm3vTdXsTd3ak9ESXc7PZippXuXFyb40C6kqRKIdU9oNVmPlHJnomf5z
         jjQsWbrtO1lJ7auflMCKnt4bqD2gvHDj1SqrOHKgGLi8k6MRmKrCawYgCI6P1HKbbkvB
         8muqzifldc4ysHd/i1ceLddheNxmQHx92eawRngJna7ed2xF4KbKXwnJMUq74ZSiOxjC
         thsVUh7f+cMIzD2HIjDAZEj/pKrgfQILeezpPkH+Xfmkiw03eAW2t9TKlVSGHByfIkb4
         d4b1w76CtZzg3ju/i3I8jUybAiYzrb+izsdaK7Bj9zJFk+WI2S6Ne99ud3fl+s4n9WST
         ePDQ==
X-Gm-Message-State: AOAM532JGdfKaldEf20zjfTnucnp5jJtrFyFMwTUl4yUD7ABr9biRI9x
        1aK5wPpxQ1xhPjHGLatJ0FJ5qQ==
X-Google-Smtp-Source: ABdhPJwoiWu6Gub9EjFxOlYmHUW4hTC3OOADG2ozsrv8m0wDwOFoJmprbJXpHvCheuveojhx8N5uAQ==
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr329697wmr.176.1644586497566;
        Fri, 11 Feb 2022 05:34:57 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id s187sm5030128wme.14.2022.02.11.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:34:57 -0800 (PST)
Date:   Fri, 11 Feb 2022 13:34:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V5 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
Message-ID: <YgZl/0fC8ruM0f7Y@google.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-4-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52B4heY5fcbz71JPOqvMVvmqsXO94V+Z0qTTw_XXextJw@mail.gmail.com>
 <bd5636b0-b975-1084-f285-87e458249b1a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd5636b0-b975-1084-f285-87e458249b1a@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Satya Priya Kakitapalli (Temp) wrote:

> 
> On 2/10/2022 7:02 AM, Stephen Boyd wrote:
> > Quoting Satya Priya (2022-02-08 06:52:17)
> > > diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> > > index c472d7f..e8569cc 100644
> > > --- a/drivers/mfd/qcom-pm8008.c
> > > +++ b/drivers/mfd/qcom-pm8008.c
> > > @@ -8,6 +8,7 @@
> > >   #include <linux/interrupt.h>
> > >   #include <linux/irq.h>
> > >   #include <linux/irqdomain.h>
> > > +#include <linux/mfd/core.h>
> > >   #include <linux/module.h>
> > >   #include <linux/of_device.h>
> > >   #include <linux/of_platform.h>
> > > @@ -27,6 +28,37 @@
> > >   #define INT_EN_CLR_OFFSET              0x16
> > >   #define INT_LATCHED_STS_OFFSET         0x18
> > > 
> > > +static const struct mfd_cell pm8008_regulator_devs[] = {
> > Is there some way to not allocate this structure statically forever?
> 
> 
> I think No.
> 
> I found that some of the drivers are just using one cell with .name to match
> with regulator driver and then probing regulators using a loop. I'll do that
> too.
> 
> static const struct mfd_cell pm8008_regulator_devs[] = {
>         {
>                 .name = "qcom,pm8008-regulators",
>         },
>  };

Please use MFD_CELL_NAME() for these.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
