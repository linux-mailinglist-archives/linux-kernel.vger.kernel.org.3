Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17649E3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiA0Npr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbiA0Npp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:45:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D3C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:45:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m11so3661866edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtKbL9VFRGZ4IG0MK9ycnh7MZHJevnbKDerPRyEA610=;
        b=aQSEhB4CvtRQWEAU3IHB6XOETTp0S2WzCX8WVQf9fuM6ealYIyYC1vnWD9QvNgKZZA
         qNsjxsTdAJ4IYCu7aUksuf34dS+VIgt3Kde1KLVAqRNbGPD+spIr62aHddSUSaE3Zumu
         cKNvSBSU57NfFVrrRqRdy6nCdWAYS7gVqCCI10esJeidmQ//P02e2Tojyg+9Lwx5z81R
         MmdkqPEGQmfz+Pwn11afwEFFwX8aXKwPGzbwpGYFNr97GNLJ5xbe4XLcMX/gPrTtSrsz
         FkI7ZIlk2CQvUD0GAdOiZOB/ujvtp1Pebj+mNeBxnHi24J+wrO34ftT17azFGSqha5Jb
         /J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtKbL9VFRGZ4IG0MK9ycnh7MZHJevnbKDerPRyEA610=;
        b=7erJVV7F3fFksL+xDl+KYhZHmUUegUJjcI/DieN1Mg5rDVxuX6GVPGe1cYM/iWIntB
         VzgiV2DcYTRS9GDkeDuyIrVGpPW2vQYiuH2Llx+SqBu8IQHiIj01UGwN+HhLeL+X5Gxz
         4j77WfCyErLlzf0G8nO2+9iPU1BIqL5zX7NyJF7Ik5uRrZVegz0w62/8EOWbyxcrBWTD
         HPPkdnyaIsE5Y2et3zfnECLELAG42xk9XucsFOhIIfZtMwQSCxi8hbxsXoUMW91kfw2Q
         eUgoUoTl7Eg/vAKlBOn6Azcv85gwK3OTJ53u0uS2p/Kkaord7Z7aKyc7lUmQ0/AEgF2r
         Tfqw==
X-Gm-Message-State: AOAM5321tEOz3Ig8oNmBQrlOWe3FtIA+eqUPTPB4KwSPZ5A0uD8/G6BY
        jBXAOxPJxJROLxOsrfmcP5bE4jtTxm2zGrABemunL2iAnnTTwg==
X-Google-Smtp-Source: ABdhPJxKR5Xtl5Kl0BFX7FJnrmsGRVNDzMawcGgJRRdy/b5xk3w7C1a/7I3Bjmqk5rL+OcPLzih9R+ww9/B3KWHxNz8=
X-Received: by 2002:aa7:c043:: with SMTP id k3mr3752391edo.184.1643291143936;
 Thu, 27 Jan 2022 05:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20220127100947.150555-1-jeanmichel.hautbois@ideasonboard.com>
In-Reply-To: <20220127100947.150555-1-jeanmichel.hautbois@ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 27 Jan 2022 13:45:25 +0000
Message-ID: <CAPY8ntBQUtO08BU5aAQXZ6=ChVy3UypwSb1ZLFJtE2kfJKET0A@mail.gmail.com>
Subject: Re: [PATCH] media: adv7180: Fix media bus format
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        lars@metafoo.de, Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel

On Thu, 27 Jan 2022 at 10:09, Jean-Michel Hautbois
<jeanmichel.hautbois@ideasonboard.com> wrote:
>
> MEDIA_BUS_FMT_UYVY8_2X8 isn't correct for CSI-2. Use
> MEDIA_BUS_FMT_UYVY8_1X16 instead.

2X8 isn't correct for CSI-2, but it is correct for the parallel
configuration that is also supported by this driver.

Referencing the adv7180 datasheet[1] page 76, OF_SEL (bits [5:2] of
register 0x03) are 0010b for 16bit, or 0011b for 8 bit.
[2] in the driver sets these bits to 0011b, so it is in 2x8 mode.

You may be able to get away with a simple check of
if (state->chip_info->flags & ADV7180_FLAG_MIPI_CSI2)
  fmt->code = MEDIA_BUS_FMT_UYVY8_1X16;
else
  fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
but I haven't examined all the potential options.

  Dave

[1] https://www.analog.com/media/en/technical-documentation/data-sheets/ADV7180.pdf
[2] https://github.com/torvalds/linux/blob/master/drivers/media/i2c/adv7180.c#L1006

> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  drivers/media/i2c/adv7180.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> index d9a99fcfacb1..cbededfb6b3f 100644
> --- a/drivers/media/i2c/adv7180.c
> +++ b/drivers/media/i2c/adv7180.c
> @@ -655,7 +655,7 @@ static int adv7180_enum_mbus_code(struct v4l2_subdev *sd,
>         if (code->index != 0)
>                 return -EINVAL;
>
> -       code->code = MEDIA_BUS_FMT_UYVY8_2X8;
> +       code->code = MEDIA_BUS_FMT_UYVY8_1X16;
>
>         return 0;
>  }
> @@ -665,7 +665,7 @@ static int adv7180_mbus_fmt(struct v4l2_subdev *sd,
>  {
>         struct adv7180_state *state = to_state(sd);
>
> -       fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
> +       fmt->code = MEDIA_BUS_FMT_UYVY8_1X16;
>         fmt->colorspace = V4L2_COLORSPACE_SMPTE170M;
>         fmt->width = 720;
>         fmt->height = state->curr_norm & V4L2_STD_525_60 ? 480 : 576;
> --
> 2.32.0
>
