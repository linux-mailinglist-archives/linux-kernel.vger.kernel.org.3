Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579F856BD4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbiGHP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbiGHPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:25:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72030F43
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:25:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 136so6563708ybl.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIFiVH9lUi23KkCa9V/IOGOENSKqD85uGqpTdZl7zAY=;
        b=fWK7HkQgFIGRyNUeE7G9RPw3OTeLrtzQBU6e4ZqpzOQamkRYX5OaqR/9XQ1BNla4l8
         fJVA0X6+czUZHqfcGk1SUUtBiciNfPjS8ygo/Q6RuZd7jfYz/j2GMp1DCbjY/7bRvfpJ
         F5onpKz8wwWV2aFzs1edfnh8TuAa9hui6zfGFkGILvjlCaqauUH3edoBJz90XprJjq5m
         sMhL3cew/FXdjmQBFlFsMQ+Ru5D5bCwlsKsBL01juon4WXx5g2yHPcu1T1hPjrqs7dWS
         LKo91I2os4Gs4yuSPHvZW0PEQrbAREEz95O7WuFrbHmojuhknjtDUp7BdZBRHGa+lJhT
         bafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIFiVH9lUi23KkCa9V/IOGOENSKqD85uGqpTdZl7zAY=;
        b=s+jjh8bHFbeSWgo1aR21vwEo8SJnxU/aRr5P4uZr2Z7/pJC0K/Axksit6b2W184AdK
         3SlWdVHWGSFlZyMi4AY+/yHQjIiC2rXaXHEw/0KO8T9ECDLkoVG/hacOevQrnlQBJQta
         vx2n0uInNbRC0llZk8L8HTLwQuylFtSbYduHKR8dANQmzEpVC6GJzxQS28+mCf+YloRr
         qS3C06K/uonCgCDg8vr2W73hgKR7vxGNzVsX8fJ1oeghbptL+IaU8TopF/f8v2sax3jt
         XOpPfunARn6sRxgaxYCgC1LlXic8lNatOnR5hHWn2ygvN1ScsDWismj/WzzDMUw8R/jE
         gc/w==
X-Gm-Message-State: AJIora+hUgTbdVsFqu7NUaDXT6kT9o3hGEe1nDh4Zo2m6GRtqs/Un854
        scchR589K+8tSgyxGW+00mAXk0/wMGTAeAxFK+I=
X-Google-Smtp-Source: AGRyM1uhtmB9cS/RxSD8hUp+5PnXY+7NZya0HJicQKj7l3rlxuBdooljqAlXBFkG9G+H4axTI+jmt9UBpj3HctV9YRg=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr4307324ybg.79.1657293957266; Fri, 08
 Jul 2022 08:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com> <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com> <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
In-Reply-To: <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 17:25:20 +0200
Message-ID: <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 2:34 PM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
> On 08/07/2022 15:30, Andy Shevchenko wrote:
> > On Fri, Jul 08, 2022 at 02:13:14PM +0200, Cezary Rojewski wrote:

...

> > It seems you are missing the (1). The code has checks for the case wher=
e you
> > can do get number upfront, it would just require two passes, but it's n=
othing
> > in comparison of heave realloc().
> >
> >   unsigned int *tokens;
> >   char *p;
> >   int num;
> >
> >   p =3D get_options(str, 0, &num);
> >   if (num =3D=3D 0)
> >       // No numbers in the string!
> >
> >   tokens =3D kcalloc(num + 1, sizeof(*tokens), GFP_KERNEL);
> >   if (!tokens)
> >       return -ENOMEM;
> >
> >   p =3D get_oprions(str, num, &tokens);
> >   if (*p)
> >       // String was parsed only partially!
> >       // assuming it's not a fatal error
> >
> >   return tokens;

> This diff is tested and works:

Thanks, Peter!

But at least you can memove() to avoid second allocation.
ideally to refactor that the result of get_options is consumed as is
(it may be casted to struct tokens { int n; u32 v[]; })

...

> Could be made nicer with some brain work put to it, we need strict u32 wi=
thin the IPC message for the array...

True, it needs to be thought through. But I guess you got the idea of
how to use existing library routines.

--=20
With Best Regards,
Andy Shevchenko
