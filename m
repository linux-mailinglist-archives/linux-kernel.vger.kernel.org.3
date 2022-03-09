Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511FB4D2878
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiCIFcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiCIFci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52CA11451F5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646803899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y27yK8mxYkUsBc+4/wjGD0QD87yh3tgDYSNNIdSemVA=;
        b=YNU5SXNMTOxpLa5hSYJJZvmrQs7Jc7WhCvZML0yvm0QgZZSc1qQzgAPDczELOboiloL52p
        75H76WFU4wGudMzVs31OkS9GKtIHTf1APix7bt/i79ZwoW18DJnPW8TpmVg0YXC+EUbYfn
        0LrP02YFbKGo8xneRhXEpqF/zK9Rtqo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-BFEz8atmMcKqgN35SQDGyg-1; Wed, 09 Mar 2022 00:31:38 -0500
X-MC-Unique: BFEz8atmMcKqgN35SQDGyg-1
Received: by mail-lf1-f70.google.com with SMTP id d14-20020a05651233ce00b004475964142aso459526lfg.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 21:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y27yK8mxYkUsBc+4/wjGD0QD87yh3tgDYSNNIdSemVA=;
        b=GsrJPDHXhfmZzHwESaBKRgQxg3e0UVZtDCUKR9rtMLiSpewoo6jUUSjo4rTuwI0VAy
         y1ZldhWD02kiA/LYtBw+HXtPzRCLb8hWiA1kODHl1AsIvj5mrWOUphTR0wfkzjZYwpRO
         66GanGoqOS9mdzzazf2k3OllIUe/eu2wMP1/dvNR72mas/VaT5YKhxfLFPuPBb2S4TK1
         l5bIRS6wYeUuANa2UG69X/H5qypd4vYIDxW0vCYloxFWXs4C+GFmJRRt7TprAeSj+Te9
         ecChJ6ATCFyUqs5XBibJB95127TeW2VoRTCfnfftske3qxJ60RG8PkO1S9Y5Uk40r3FP
         l/7g==
X-Gm-Message-State: AOAM533+SRzjQXfkw/OEHct+YmEnHORkLqTlu4OxAO/n9gXCYN0j6xvv
        YymoxzwSOEvnmOlwO2aQXOf3FTJaxgmhv/W5js2KJQtFtQYRone/329eWanF32sWlGPzwhhBrtO
        bBaifwJxiNc8cak0JqvuqRWTjHHiG6q5tDv4N82DM
X-Received: by 2002:a05:651c:556:b0:247:eb02:8ab7 with SMTP id q22-20020a05651c055600b00247eb028ab7mr7047965ljp.104.1646803896694;
        Tue, 08 Mar 2022 21:31:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQKO23ep/IMvNlaSY3vPsiMpj83PyarnhIuUYSHQKCrTp0ItQmaJP9fhP/baoBeMzfcwWe7WHl/14CGWd+5Vs=
X-Received: by 2002:a05:651c:556:b0:247:eb02:8ab7 with SMTP id
 q22-20020a05651c055600b00247eb028ab7mr7047951ljp.104.1646803896248; Tue, 08
 Mar 2022 21:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20220223090648.41989-1-hpa@redhat.com> <20220223090648.41989-2-hpa@redhat.com>
 <YiCF0Ze+mPxYQ2NP@paasikivi.fi.intel.com>
In-Reply-To: <YiCF0Ze+mPxYQ2NP@paasikivi.fi.intel.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Wed, 9 Mar 2022 13:31:25 +0800
Message-ID: <CAEth8oFk8qq2yogwKGN62qfF_53Z7PKX8JxTa6qjz53ZbXCLdw@mail.gmail.com>
Subject: Re: [PATCH 1/1] staging: media: ipu3: Fix AF x_start position when
 rightmost stripe is used
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans De Goede <hdegoede@redhat.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, Mar 3, 2022 at 5:09 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Kate,
>
> Thank you for the patch.
>
> On Wed, Feb 23, 2022 at 05:06:48PM +0800, Kate Hsuan wrote:
> > For the AF configuration, if the rightmost stripe is used, the AF scene
> > will be at the incorrect location of the sensor.
> >
> > The AF coordinate may be set to the right part of the sensor. This
> > configuration would lead to x_start being greater than the
> > down_scaled_stripes offset and the leftmost stripe would be disabled
> > and only the rightmost stripe is used to control the AF coordinate. If
> > the x_start doesn't perform any adjustments, the AF coordinate will be
> > at the wrong place of the sensor since down_scaled_stripes offset
> > would be the new zero of the coordinate system.
> >
> > In this patch, if only the rightmost stripe is used, x_start should
> > minus down_scaled_stripes offset to maintain its correctness of AF
> > scene coordinate.
> >
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/staging/media/ipu3/ipu3-css-params.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
> > index d9e3c3785075..efe4de8ef205 100644
> > --- a/drivers/staging/media/ipu3/ipu3-css-params.c
> > +++ b/drivers/staging/media/ipu3/ipu3-css-params.c
> > @@ -2556,6 +2556,14 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
> >               /* Enable only for rightmost stripe, disable left */
> >               acc->af.stripes[0].grid_cfg.y_start &=
> >                       ~IPU3_UAPI_GRID_Y_START_EN;
> > +             acc->af.stripes[0].grid_cfg.x_start -=
> > +                     acc->stripe.down_scaled_stripes[1].offset;
> > +             acc->af.stripes[0].grid_cfg.x_end -=
> > +                     acc->stripe.down_scaled_stripes[1].offset;
> > +             acc->af.stripes[1].grid_cfg.x_start -=
> > +                     acc->stripe.down_scaled_stripes[1].offset;
> > +             acc->af.stripes[1].grid_cfg.x_end -=
> > +                     acc->stripe.down_scaled_stripes[1].offset;
>
> The grid x/y ends are calculated from the width when both grids are enabled
> and I think it should work the same way here. There's also masking of the
> bits that aren't in use.

Thanks for clarifying this :)

>
> The first stripe isn't enabled so changing values there has no effect as
> far as I can tell.
>

Okay. I would remove the setting of the first stripe in the v2 patch.

Thank you

> Looking at the code a little, it seems all awb_fr, ae and af seem to suffer
> from the same issue. Let's still iron out the fix for af first before
> considering those.
>
> >       } else if (acc->af.config.grid_cfg.x_end <=
> >                  acc->stripe.bds_out_stripes[0].width - min_overlap) {
> >               /* Enable only for leftmost stripe, disable right */
> > @@ -2563,7 +2571,6 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
> >                       ~IPU3_UAPI_GRID_Y_START_EN;
> >       } else {
> >               /* Enable for both stripes */
> > -
> >               acc->af.stripes[0].grid_cfg.width =
> >                       (acc->stripe.bds_out_stripes[0].width - min_overlap -
> >                        acc->af.config.grid_cfg.x_start + 1) >>
>
> --
> Kind regards,
>
> Sakari Ailus
>


-- 
BR,
Kate

