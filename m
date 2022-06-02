Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A699753B3D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiFBGqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiFBGqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:46:42 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37AB2A3A04;
        Wed,  1 Jun 2022 23:46:40 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g4so6705644ybf.12;
        Wed, 01 Jun 2022 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BszKUWBoDhe4QochGZDZFlBkPYZcs7PuZmpP6HGKNOM=;
        b=CZpI41s86ZMmSgVndxepBehDJn37LAJpF4lJD+Vv9uqU+84sORclP23vCS8vNJxFnJ
         XmmR7jhK63Mtpjn57lySuY0YBXb9mjRD+2golXeTaoes3dAvAbL5qnqi3urd4uColD/c
         VCaG3IpEZXRfY3xosx7rpsHyWKm+vWV3mQbXPrdsqzPEEWenjjQBaV/4Pzn/zFM9wKyl
         5Z//gVMqTYJXp+EkufKYVEjH+m9X47ZXFY8TbXQHa5JOhAqgS4xCJFnVVmAHMShjSyJa
         O5SkMlogQV25sswqgweGLR/4L+vv59Nxu+gCELogE9FQZEDR+JNPRCBPU2cjIti/YK4m
         1fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BszKUWBoDhe4QochGZDZFlBkPYZcs7PuZmpP6HGKNOM=;
        b=m0Q88LG5ykSbnRatc88mSG5KjMaVy882YOi/N2Qb84+v88JQXEXFEOam+/4XlqK3Ng
         vtEC5jjrHG9OtmlsC2N+0koXRPwEPCzPUqTCftlxb5ybDOXGp9ZyR8c+8jnY0jofOAKU
         c1O7USu3Amd/ypUdXTvRCRW3ELx7X2cvE7Jqhkci+RiC9E1Bl+eY5+oLocGhj0HcBUVf
         XNCKs7fmoWswv5JIjdg2YLlSLUlIwORZpWh5BsdySSvFqQ+biWhSiK9VL06iHi7Dq20+
         LS1DXbx5AKLd5T3/8xRCqlAJqWx9I/k/Nvk/0RXFMPu0+bADiPGoNDbceDzgnoCj3khJ
         Yfvw==
X-Gm-Message-State: AOAM530dj8D5accccFHcNEaJBh9xM7eImGjBdrVP86FUnKa2btEBD2NE
        kQmZ0gCH2QyRxhdEqq+IKzwlmVQM5q/HMEZALXU=
X-Google-Smtp-Source: ABdhPJzcjK3Ou9Sihzm14OPh2Y0uzrI4p+hQtSOakPQVOIeVXabsHkZORABZ+BFkVxF4tfYOR0TNSILzFlX2DxhynKg=
X-Received: by 2002:a5b:691:0:b0:64d:ab44:f12e with SMTP id
 j17-20020a5b0691000000b0064dab44f12emr3640214ybq.533.1654152400227; Wed, 01
 Jun 2022 23:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220520114242.150235-1-benchuanggli@gmail.com> <CAPDyKFoQP=4OSwcjj6bJOxDXvrWjqwi-MpvpMe4L5ftWwkEhFQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoQP=4OSwcjj6bJOxDXvrWjqwi-MpvpMe4L5ftWwkEhFQ@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Thu, 2 Jun 2022 14:46:29 +0800
Message-ID: <CACT4zj9x34TV_cTTV37crgtMqLEd-=rHkKUmdi=FsJDy3xpeYA@mail.gmail.com>
Subject: Re: [RESEND, PATCH] mmc: sdhci-pci-gli: Fix GL9763E runtime PM when
 the system resumes from suspend
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        SeanHY.Chen@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw,
        kane.chen@intel.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 9:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 20 May 2022 at 13:43, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > When the system resumes from suspend (S3 or S4), the power mode is
> > MMC_POWER_OFF. In this status, gl9763e_runtime_resume() should not enable
> > PLL. Add a condition to this function to enable PLL only when the power
> > mode is MMC_POWER_ON.
> >
> > Fixes: d607667bb8fa (mmc: sdhci-pci-gli: Add runtime PM for GL9763E)
> > Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
>
> Sorry for the delay, I have been out traveling. Unfortunately this
> didn't make it for v5.18, although I have queued it up for v5.19 and
> added a stable tag.
>
> Thanks and kind regards
> Uffe
>

It's ok. Thank you for the explanation.

Best regards,
Ben

>
> > ---
> > Hi,
> >
> > Sorry, resend this patch because typo two email addresses.
> > Sorry for Adrian and Kane.
> >
> > Best regards,
> > Ben
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index d09728c37d03..d81e5dc90e15 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -972,6 +972,9 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> >         struct sdhci_host *host = slot->host;
> >         u16 clock;
> >
> > +       if (host->mmc->ios.power_mode != MMC_POWER_ON)
> > +               return 0;
> > +
> >         clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >
> >         clock |= SDHCI_CLOCK_PLL_EN;
> > --
> > 2.36.0
> >
