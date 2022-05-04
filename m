Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA7519B32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346908AbiEDJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbiEDJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:12:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806821CFD0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:08:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b18so1231637lfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5c+QX1+5JA50duqNcGfay1+wV5nv/a3KdvPCeKfT4pc=;
        b=NgK54GM4aokbIxczLXJ/dN+bzF9IL8vgtmdlpX/nVXRf5t8fI32yFeXyQlczYwfCcP
         fveCnS7cBOQMlGcio9DlALNY4kdogFFxRp0/EFtjSBVzabeJpl21BpC8SnxyDl5OdfqM
         88jX1lR4VpS2zLX+72dTPRf6wrur0W8pLYDFK43igYmBh9e/wNi6wRG8lv+h2XlURl/U
         6gGbKpAE5zDLDeVK9AC9Qbz86yrkgYHn+PHJ9lB9Kpg9LWt0l4U+s6EPAY7l8JUKDQxB
         +wtT1eypWJu4Y2quanC+E21OSpLxe7NxQfgudO7uAL1hHOR+w4QauqDU8YD7nqbfawbG
         isKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5c+QX1+5JA50duqNcGfay1+wV5nv/a3KdvPCeKfT4pc=;
        b=EA48bP1Dn1GWZOvQ8P9GfncDChpEOnnXUS2BuqI/zN2cSZdbcuATge6/RCkiOis+D/
         twA3ZYhfIi/Y6k304ej3jcxl+OHrtLZX6J/UNhj8Bbt6AVjUAOlXgL0eAhPNKjNAr0gl
         qC9umPEdRszVv0IrJl8xK2gZueuDPAR3UgVq5uWs+pQTpWz7JqD5nwk0u3krktSmaYuU
         CFlZLfUziJ1hSsQKcUsMGK7I1GnCJ+bxe0yTo6VW6NQWmbgXfXG0DS8NxBgLAqsarGAD
         Ya1V2ABKiE+cbIGrC0Zko9TPg5KeheoG4gZPE4RUPkHcw6Er1QHCBY3uj9b3th49p8Tr
         HpDw==
X-Gm-Message-State: AOAM53000AqM3+FtaMoDdB1XWvKgsSQexHbWrJ/IvDSM4o2CC5KNKECi
        AvbyXy3OiM4VwW/UFyooVeVZeiX6ieWwt+e91XisUA==
X-Google-Smtp-Source: ABdhPJzLbEZ5HQ1NesIENes4Oo5j6+uhU6gI2bADA0qJA1+mznHE+1x8wdW8SsACfpqsFaiA2T3ppaIfc4ww7y3dKCc=
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id
 o11-20020a05651205cb00b004720f7ea5f5mr13010182lfo.358.1651655335817; Wed, 04
 May 2022 02:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220304105656.149281-1-ulf.hansson@linaro.org>
 <CAPDyKFr1PzSaiKqB4ZoqTS_8bGsEH=aB3ARhxyGu+cYeRqeBew@mail.gmail.com> <20220504054652.GA7851@math.uni-bielefeld.de>
In-Reply-To: <20220504054652.GA7851@math.uni-bielefeld.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 11:08:19 +0200
Message-ID: <CAPDyKFrBVyYx+BybGR2P8paS6qA=V2EHAXH+vPUc9JzxoXn6+g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND
To:     Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 at 07:46, Jean Rene Dawin
<jdawin@math.uni-bielefeld.de> wrote:
>
> Ulf Hansson wrote on Mon  7/03/22 13:17:
> > On Fri, 4 Mar 2022 at 11:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Commit 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1"),
> > > significantly decreased the polling period from ~10-12ms into just a couple
> > > of us. The purpose was to decrease the total time spent in the busy polling
> > > loop, but unfortunate it has lead to problems, that causes eMMC cards to
> > > never gets out busy and thus fails to be initialized.
> > >
> > > To fix the problem, but also to try to keep some of the new improved
> > > behaviour, let's start by using a polling period of 1-2ms, which then
> > > increases for each loop, according to common polling loop in
> > > __mmc_poll_for_busy().
> > >
> > > Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> > > Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> > > Cc: Huijin Park <huijin.park@samsung.com>
> > > Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Jean Rene and H. Nikolaus, if this doesn't work, please try extending the
> > > the MMC_OP_COND_PERIOD_US a bit, to so see if we can find a value that always
> > > works.
> > >
> > > Kind regards
> > > Uffe
>
> >
> > Applied for fixes and by adding two tested-by tags from you, thanks!
> >
> > Kind regards
> > Uffe
>
> Hi,
>
> with the current value of MMC_OP_COND_PERIOD_US = 1ms I still see
>
> mmc1: Card stuck being busy! __mmc_poll_for_busy
> mmc1: error -110 doing runtime resume
>
> regularly. The same with 2ms. Setting it to 4ms makes the messages go
> away. Would it be ok to increase MMC_OP_COND_PERIOD_US to 4ms?

It doesn't look like we have a very good alternative - unless the
problem is tied to a particular type of eMMC card, is it? (If so, we
can add a card-quirk).

The only other option I see, would then be to add a generic DT
property for eMMCs, that allows us to specify the OP_COND polling
period for it. See
Documentation/devicetree/bindings/mmc/mmc-card.yaml.

Kind regards
Uffe


>
>
> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 180d7e9d3400..1fd57f342842 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -21,7 +21,7 @@
>
>  #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
>  #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
> -#define MMC_OP_COND_PERIOD_US          (1 * 1000) /* 1ms */
> +#define MMC_OP_COND_PERIOD_US          (4 * 1000) /* 1ms */
>  #define MMC_OP_COND_TIMEOUT_MS         1000 /* 1s */
>
>  static const u8 tuning_blk_pattern_4bit[] = {
> --
> 2.35.1
>
>
> Regards,
> Jean Rene
