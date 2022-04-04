Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5504F1E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381224AbiDDWIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379815AbiDDSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:10:43 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3B263C8;
        Mon,  4 Apr 2022 11:08:45 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2eb46d33db9so56222287b3.12;
        Mon, 04 Apr 2022 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOXzNn8YJXSBSPBTfEilUNoggTZ9fchh0UKh2uaYCkg=;
        b=kAwacWRlbua9Upr4P4y0HifVnz+enwieMp9UuW7TasoWWdBMX2U1ohTaSBrWezI3J4
         n8Y4/cnYmT1N5OVNnylsiVtO6xKHI0MRuTuJS1fgouuJ8TeX+ppvsGKAlvAyRLmkJJBg
         ikjG+PwSNdCzzWi8FuMpWlnjrJQqZwsLh19qWQh2Xuex9MvgE4RIICVNs/JpWawpigvy
         HLW0LKiUj7j8CdpRNQdOmvXk1DXFGpZvgZHNB7aKQxfGq643HieiLatKxO0S0EHIgK9E
         ApgQB6v2DcSfa0DJqSPnvW8XZE/CJP/ykJcn89IfSqAMBeb0T690o7Nx9p6lUGpZM4d5
         z81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOXzNn8YJXSBSPBTfEilUNoggTZ9fchh0UKh2uaYCkg=;
        b=G2C0nKfLgbw7gwcL+90Q/aVsOfWDic1DYBhmWxXd2aMKyd1GgnbQXpu4XGeMdVVsJd
         u94gZl/6dK1EWxPHtqfvPBmzDS1cspsE34s935HSd+M72G9l4gTzPVcDWLH5KpKfsCUo
         gLb2ndG4QtPcF/lmiJBoZLqe1rFBEBmlKfHPt7OFADKah2ykFHENbJ6rNlAVb6Wv8K6b
         fYBIDOcsH6deBOmKmFPYfnG+9zDaBJ3f1uZJLEbBICYJnm33weHEr19YM1l0o7wLluDo
         q49TWCY5VnhvvGnlkDnx2MCYy/+2VrbdWWIebKS0hdKSc//4FInzXEklrjGQIZjdNghd
         6FIg==
X-Gm-Message-State: AOAM53053lOXLSO8DoVoTvgGAWa7dUzgK7MXIt/es2BGOripESEsqVx0
        3FgkoM0rQzPfojybpUIn+JMn/+tAsCef8I3SXXo=
X-Google-Smtp-Source: ABdhPJwHTThe++LzZaFuJJpiBj0G7KqdzDNbWhNKwST/OCct//gzRJbyQFkNoyVVqsf/wWrhLf7CMN5kZJcG5A4F2gc=
X-Received: by 2002:a0d:e212:0:b0:2eb:4f2b:6e91 with SMTP id
 l18-20020a0de212000000b002eb4f2b6e91mr1221175ywe.78.1649095724281; Mon, 04
 Apr 2022 11:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922182F6302386EFF2ED66B86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922182F6302386EFF2ED66B86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Apr 2022 19:08:18 +0100
Message-ID: <CA+V-a8tdkw8-dUfrFG9kZizok8OQdcGHitAdb4E2tsBW3Xrh-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
 returning directly
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
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

Hi Biju,

Thank you for the review.

On Mon, Apr 4, 2022 at 7:02 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar and Pavel,
>
> Thanks for the patch.
>
> > Subject: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
> > returning directly
> >
> > Jump to error path "edisclk" instead of returning directly in case of
> > devm_reset_control_get_optional_exclusive() failure.
> >
> > Fixes: b4d86f37eacb7 ("mmc: renesas_sdhi: do hard reset if possible")
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/mmc/host/renesas_sdhi_core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> > b/drivers/mmc/host/renesas_sdhi_core.c
> > index 2797a9c0f17d..cddb0185f5fb 100644
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -1033,8 +1033,10 @@ int renesas_sdhi_probe(struct platform_device
> > *pdev,
> >               goto efree;
> >
> >       priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev,
> > NULL);
> > -     if (IS_ERR(priv->rstc))
> > -             return PTR_ERR(priv->rstc);
> > +     if (IS_ERR(priv->rstc)) {
> > +             ret = PTR_ERR(priv->rstc);
> > +             goto edisclk;
> > +     }
>
> Why can't devm_reset_control_get_optional_exclusive to be moved up before devm_clk_get?
>
In that case we will have to jump to the "efree" label Or if you don't
want goto at all this can be moved to the very beginning of the probe.

Wolfram, what is your preference on the above?

Cheers,
Prabhakar
