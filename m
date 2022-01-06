Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2704867DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiAFQqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241355AbiAFQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:46:35 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF6AC061245;
        Thu,  6 Jan 2022 08:46:35 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id k69so9167768ybf.1;
        Thu, 06 Jan 2022 08:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zIoGPb0w1waJx+7EREYXSDgP/ERx+/rhpioA04nP17w=;
        b=ChsDYcrEDaZZ6uvwQQwerdRLztwrsoFAdBlbitlWrCZILmWm9vNkuf9FVaaNoXcc5v
         qFmR0K1d9QgJzd41UmCkmVOQNvvZ5eSvNUN4by+DdRee7TQ3G0CmtT2cxJIs6JeAx6u8
         v01SAfhGY2Zx2Zgl+A2VPoNN+sRI80D0+Arx1Pn8FQ8BKthi+ruUWy7PlCh/fgXPKnVG
         TFi2Im1UQKnxIkVZnUqLftUqJfEVL4LEBOx4Fp4aAEq6g0OeguHvkS7GalKrVnqk2k8/
         SZl6UgNBuF7xBDVSzKNdVcblc/FxGhS9CHs2DdRdG2V4HF3XOS+zaJK2zu6KAAAf1luf
         SJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zIoGPb0w1waJx+7EREYXSDgP/ERx+/rhpioA04nP17w=;
        b=TvVXlDuiHk0DaNK/tclB/ox5bNo9uovcnC3I37j0L3oIyYTP6O7vkbRVg+Nai3+COV
         cqKbTXwwIu7K45nhhK41Cs5CqkfY2Ez84TiUdVG64DBCroRCxJqjyxpVEYv1F5Tv5VQo
         36WUh2u225JNvekIkuLW8zCkgbTmsNTHt2OTBW6tYtFRddAoP2ASWoNspROZLfEMFEoK
         +aQB58aicm4TMkaEYgY5g90JwBUzJ9c1NpuCeR9BR5zQaxM2ZfaQLPn8ykEzqnZl8ooh
         h9Q7hBDHuLUB08Z0DVWkwXVyq3gA0sh7FScq86zH7ZA/LELCv5mIau0y0R2MiFnMOLCy
         0oPw==
X-Gm-Message-State: AOAM530hnRL2274gEWYRyru4SaD5ZgS3F24fhuF91XLyyu1cvO4Akvi2
        ZaoScDqpxR8RViHt/G7Gy6/tQ+Ug1m713vXrtS0=
X-Google-Smtp-Source: ABdhPJy0ElabrYEUHp7sFabg0ACHf2gSJ89O/5WHr9gFD0ywbYBheELFmTFP9ntW7Z84dAv/+jdbBWURPtzM8VxxYy4=
X-Received: by 2002:a25:44c:: with SMTP id 73mr59986688ybe.186.1641487594225;
 Thu, 06 Jan 2022 08:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
 <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
 <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
 <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com>
 <CAHp75VdiTw7R=MSM=4nzn8m863tomSza+yxx7pXLU-Xj8aouOg@mail.gmail.com>
 <CAHp75VexoYCBBJ1BFgnsb38Q79jG6NB2xBBHmAafTK2FHkTsbQ@mail.gmail.com>
 <CA+V-a8sbcebVnqGaLOxVhG_0wm3cM4bu0SebAa1Mkuv9GNBGnQ@mail.gmail.com>
 <CAHp75Vfy0M_mF0+2V0dzrQNnZ2wz4bSEnvUj=WeQ7EgwwVy_CA@mail.gmail.com>
 <CA+V-a8sYQ+7Wcsh5qyPjcQbJ8UGpBXoecqC3Vhqvn_3tsTMN2Q@mail.gmail.com> <CAHp75Vcxrq+zNuAe7Lr+=BeXLUnpQpLLTik1UGe-sZRcH7uWHg@mail.gmail.com>
In-Reply-To: <CAHp75Vcxrq+zNuAe7Lr+=BeXLUnpQpLLTik1UGe-sZRcH7uWHg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 6 Jan 2022 16:46:08 +0000
Message-ID: <CA+V-a8s22x28R2Y_1rVADgSzv9+em-EhtvfzC4zZd_9sop6bVQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Jan 6, 2022 at 4:28 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 6, 2022 at 6:11 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Jan 6, 2022 at 4:02 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Jan 6, 2022 at 5:27 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Thu, Jan 6, 2022 at 2:15 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Thu, Jan 6, 2022 at 3:43 PM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Wed, Jan 5, 2022 at 7:41 PM Lad, Prabhakar
> > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > On Wed, Jan 5, 2022 at 9:43 AM Andy Shevchenko
> > >
> > > ...
> > >
> > > > > > >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)      =
           \
> > > > > > > -       {                                                    =
           \
> > > > > > > +       (struct resource) {                                  =
   \
> > > > > >
> > > > > > Yep, that's it.
> > > > > >
> > > > > > >                 .start =3D (_start),                         =
             \
> > > > > > >                 .end =3D (_start) + (_size) - 1,             =
             \
> > > > > > >                 .name =3D (_name),                           =
             \
> > > > > > >
> > > > > > > But there are some instances which need to be touched, for ex=
ample
> > > > > > > vexpress-sysreg.c [1]. Are you OK with files to be changed?
> > > > > >
> > > > > > Nice! That's exactly my point and you can sell it to the commun=
ity
> > > > > > because there are already users of it like this.
> > > > > >
> > > > > > Yes, I'm fine, but it seems it needs to be done treewide in one=
 patch.
> > > > > > Btw, how many of those already in use?
> > > > >
> > > > > Actually you don't need to change that. It's an array of resource=
s and
> > > > > everything should be kept as is there.
> > > > >
> > > > I do get below build failures, with the above literal change for
> > > > vexpress-sysreg.c.
> > > >
> > > > drivers/mfd/vexpress-sysreg.c: At top level:
> > > > drivers/mfd/vexpress-sysreg.c:64:37: error: initialiser element is =
not constant
> > > >    64 |   .resources =3D (struct resource []) {
> > > >       |                                     ^
> > > > drivers/mfd/vexpress-sysreg.c:64:37: note: (near initialisation for
> > > > =E2=80=98vexpress_sysreg_cells[0]=E2=80=99)
>
> > > Hmm... Interesting, so I suppose the fix is to drop (struct resource
> > > []) parts from the driver?
> > >
> > A bit more than that like something below:
>
> > - .resources =3D (struct resource []) {
> > - DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),
> > - },
> > + .resources =3D &DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),
>
> This is not an equivalent change.
> The warning is about const qualifier. Can it rather be  const struct
> resource [] ?
>
No, since it's just a single resource, just the below should be OK.

.resources =3D &DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),

[1] https://elixir.bootlin.com/linux/v5.16-rc8/source/include/linux/mfd/cor=
e.h#L108

On the other note I could use the below without changing the macro:

if (dev_of_node(...))
  res_irq =3D (struct resource) DEFINE_RES_IRQ_NAMED(...)
else
  res_irq =3D  (struct resource) DEFINE_RES_IRQ(...);
res_irq->flags |=3D irq_get_trigger_type(irq);

Cheers,
Prabhakar
