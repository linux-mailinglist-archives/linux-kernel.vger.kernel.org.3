Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B2E5A86EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiHaTof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiHaTod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:44:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A6F95E6C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:44:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nc14so25538617ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VkN9kjUhyzdT4oetnRVdj6WFy3Q+ODyLNUTLMRrWCOU=;
        b=jnoZz37Afx7vOS3iOdri3YbmU0nJL11sAICLa1IjRRdteBOcSQ5fX36C+GB7uY3uGu
         too9RUznebC7dzqDpYIK3uXi/9G08AmaqAcLs8pe3WN9b6IJuUlgenI+VyBrjJjdEZVX
         0ddZzfaG8Xzeeg2bfYcoEZM2lbICLrUl7G5ire3Y9SQkv/wu9j+i/FzJpJ0VY9rTKl3L
         /7Rigmgjj5uv0du2sNg5piTTMDSAR76wW31GEitWfq39WHqqeYgH2F1YnJIg74MKvFIS
         VQCL0nl5uNkT7xX1XLvTaCypGIvDgP98djxfCWKA9lSPQXDau+Z/4cXWwu0yxY25kybe
         3Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VkN9kjUhyzdT4oetnRVdj6WFy3Q+ODyLNUTLMRrWCOU=;
        b=wyn0NXjQacmfaqGVkT0NmBu+v2wVRs7kkzgxijBIiJCOOp3QhGdbVzIuebSbcOGElh
         dP3U08s+/pdlS2mHbVl29m8cY+qP83o58VzjGWTAw9E5C5tc0TmCUNHtRrz333iFMpEA
         rlXL5aumUibFpMVY1iOGQbA8/XilDbILiL/NYFRegCtp1Wft6Ck5ZB10nmvLJCp3prEw
         aP6VTmV6eFrKwIZq4w8uIbyS1ioo13EvVdcHlrl1S+kVLaBpSUQc9yGCSG7tNO8+t4Qe
         qm97svBmun9lw8Hk4f5eTX5PiIRzsmAUt13XmPn+a3kXZQ3Od4INoEpg8THxRJ7v1HIo
         fR4g==
X-Gm-Message-State: ACgBeo3hYBvh2dWwBijhh2NftRFXJbesnpoEBDEkN2MVeDzmeTFRD9Bw
        teaIy3uzisjCR2iae4mLRIS5BNSXsvrhONWvYaNjdkJkgEg=
X-Google-Smtp-Source: AA6agR5MTT/5X3Lj28oVpccvJJVfK2uwoHcuj+zttvxgOp9gs/MFWIZrWXRK1OSYY83eGMl2c3TmmiX4+nzizsps4Z4=
X-Received: by 2002:a17:907:7254:b0:731:61c6:ecf9 with SMTP id
 ds20-20020a170907725400b0073161c6ecf9mr21837260ejc.101.1661975070397; Wed, 31
 Aug 2022 12:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
 <20220829133923.1114555-5-martyn.welch@collabora.com> <CAMRc=McbNwLRq_OBo_=xwFJJ-_8C5VfjQt75dvSVC9SqUYTpFg@mail.gmail.com>
 <e89ccd1ecb675ab899dba0f08624a3dde195c970.camel@collabora.com>
In-Reply-To: <e89ccd1ecb675ab899dba0f08624a3dde195c970.camel@collabora.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 21:44:19 +0200
Message-ID: <CAMRc=MdKU0nWQnOqyMpMk-fwZ2svRhQJ+jgE_u20jLmRKCmPZw@mail.gmail.com>
Subject: Re: [PATCH 5/5] gpio: pca953x: Add support for PCAL6534 and compatible
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel@collabora.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 6:30 PM Martyn Welch <martyn.welch@collabora.com> wrote:
>
> On Wed, 2022-08-31 at 13:57 +0200, Bartosz Golaszewski wrote:
> > On Mon, Aug 29, 2022 at 3:39 PM Martyn Welch
> > <martyn.welch@collabora.com> wrote:
> > >
> > > Add support for the NXP PCAL6534 and Diodes Inc. PI4IOE5V6534Q.
> > > These
> > > devices, which have identical register layouts and features, are
> > > broadly a
> > > 34-bit version of the PCAL6524.
> > >
> > > However, whilst the registers are broadly what you'd expect for a
> > > 34-bit
> > > version of the PCAL6524, the spacing of the registers has been
> > > compacted. This has the unfortunate effect of breaking the bit
> > > shift
> > > based mechanism that is employed to work out register locations
> > > used by
> > > the other chips supported by this driver, resulting in special
> > > handling
> > > needing to be introduced in pca953x_recalc_addr() and
> > > pca953x_check_register().
> > >
> > > Datasheet: https://www.nxp.com/docs/en/data-sheet/PCAL6534.pdf
> > > Datasheet:
> > > https://www.diodes.com/assets/Datasheets/PI4IOE5V6534Q.pdf
> > > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > > ---
> >
> > Is this series complete? I don't have patch 1/5 in my inbox and
> > neither does patchwork.
> >
>
> I used get_maintainers to generate the recipients, it's a patch for the
> binding documentation relating to the driver so didn't get sent to the
> same lists:
>
> https://lore.kernel.org/lkml/20220829133923.1114555-3-martyn.welch@collabora.com/T/
>
> Martyn
>
> > Bart
>

Ah, ok. Just for completeness, please send the entire series to
everyone unless it's lots of patches.

Bart
