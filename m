Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2598C589E87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiHDPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiHDPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:19:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B92BEF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:19:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 204so32324907yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=E+zIQJdDSIsnF29JGSHf6MgKfWZ9Z3UpZ6ByAbNq6I0=;
        b=dzGfpV7x5A71PXm2AUz1e4RdDwItrRhV/Pr9yS/w5yEsH8RD5tyT8tW2muX7t8G1gn
         k/AxRMIRURXp05DjviFz7ZWgzfm8gGnXU+/IIYYF6RwYNRyx8G40Y5IvhzLwE8azxvvp
         dpWxh6k0mJHexX5A4eqjWZYxmNc386LCpH17yW/E74Me7FTg43ohymIYMxWxKe6fW2/n
         +37XzGL5mC7TRtZcVkz2SZIvuq7d8NGWMhm5hj7ZQRfPr0Nz2NFI/WPRyL7JKZDMZIEG
         N4UPEeUach16sGdWTXTRf0dI3sj4KNETTNxMCq832A+1xjzb8m33JLzSx+oF+h6bEo6i
         lP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=E+zIQJdDSIsnF29JGSHf6MgKfWZ9Z3UpZ6ByAbNq6I0=;
        b=vntc5BmDQVdkup+0tMVZqJw9CpkZpKtIcYu7023J7LN3wgJgY4SOh26soxX02M3R2s
         cWX2RlHm/uPnYX5KmuWwUyh98YF3Eqy06/KPwsjg8NahfWO8e6s4OWOm+8TronG5EOrJ
         /j7WKR36pszD/Muu6PpakK8WVGJ+vpxXYj6sPg8TMI2Oc6sz9lR0Sr4JPrdo/wScwd/T
         uWTafQRRE0rgxJvU8jE/8GoSlLovinO0P5/BFko7A78bjdmZS+YMoU/0ASuoW+GOVdz+
         3cO6tIimYq5fd/rGAfO0F7vYgxp9tDRXCF9LJ7WEYSPx/QnikEm3Nm2M4r0lL6ZebA2e
         hxkA==
X-Gm-Message-State: ACgBeo3ZSjF35SvEMkIcFmMUPTcuRxFNt3LLuTqkGWCK8sj0yaM/3DRj
        qCPj6aMLXaJJG7GPk4E5SabSVUfInzFVDnAHg8rfOw==
X-Google-Smtp-Source: AA6agR4y1DyU0XfLFhiIQx3AkNTe71kP7Jg9EJ5Xb+8XaTvblijUI84dDcr7Z++d374Pdnsvgn+Xk02yMaNPTfkpudo=
X-Received: by 2002:a05:6902:245:b0:670:a73b:f87d with SMTP id
 k5-20020a056902024500b00670a73bf87dmr1790482ybs.643.1659626384875; Thu, 04
 Aug 2022 08:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220803191236.3037591-1-bhupesh.sharma@linaro.org> <e5465f6f-d602-b4c3-e049-f25d0d1f3124@arm.com>
In-Reply-To: <e5465f6f-d602-b4c3-e049-f25d0d1f3124@arm.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 4 Aug 2022 20:49:33 +0530
Message-ID: <CAH=2NtyBCfuz+dtO47mNNjcojQg0H776KjD9XJyxVhOTpGm1Qw@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: Fix crash observed on Qcom ETM parts
 with 'Low power override'
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, 4 Aug 2022 at 19:02, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Bhupesh,
>
>
> On 03/08/2022 20:12, Bhupesh Sharma wrote:
> > Some Qualcomm ETM implementations require skipping powering up
> > the trace unit, as the ETMs are in the same power domain as
> > their CPU cores.
> >
> > Via commit 5214b563588e ("coresight: etm4x: Add support for
> > sysreg only devices"), the setting of 'skip_power_up' flag was
> > moved after the 'etm4_init_arch_data' function is called, whereas
> > the flag value is itself used inside the function. This causes
> > a crash when ETM mode 'Low-power state behavior override' is set
> > on some Qualcomm parts.
> >
> > Fix the same.
> >
>
> Thanks for the patch. The patch is correct. But please see my comment
> below.
>
> > Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index d39660a3e50c..cf6254b87fd5 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1943,6 +1943,16 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
> >       init_arg.csa = &desc.access;
> >       init_arg.pid = etm_pid;
> >
> > +     /*
> > +      * Some Qualcomm implementations require skipping powering up the trace unit,
> > +      * as the ETMs are in the same power domain as their CPU cores.
> > +      *
> > +      * Since the 'skip_power_up' flag is used inside 'etm4_init_arch_data' function,
> > +      * initialize it before the function is called.
> > +      */
> > +     if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> > +             drvdata->skip_power_up = true;
> > +
> >       if (smp_call_function_single(drvdata->cpu,
> >                               etm4_init_arch_data,  &init_arg, 1))
> >               dev_err(dev, "ETM arch init failed\n");
> > @@ -1951,8 +1961,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
> >               return -EINVAL;
> >
> >       /* TRCPDCR is not accessible with system instructions. */
> > -     if (!desc.access.io_mem ||
> > -         fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> > +     if (!desc.access.io_mem)
> >               drvdata->skip_power_up = true;
> >
>
> Please could you move this setting into "etm4_init_sysreg_access()" ? It
> looks a bit odd to split the check in the same function. Moving this to
> the sysreg_access() makes it explicit.

Sure, let me fix this in v2.

Regards,
Bhupesh

> >       major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
>
