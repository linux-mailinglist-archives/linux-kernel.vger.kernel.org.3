Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9524C4AA188
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbiBDVCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:02:21 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:35751 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiBDVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:02:20 -0500
Received: by mail-io1-f46.google.com with SMTP id 9so8979425iou.2;
        Fri, 04 Feb 2022 13:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=io04bmdGVqb9L2Bxd+sAlyc8gW4AQtHE1d41YIHwSP4=;
        b=f5K09bfB2V8VOpwD5UTblb8pag1oDpq95g5udCLeVRmEgm9kxF7LZcjM56peHbtKtH
         G8IqQ5dXQ+x+VfP4wKO4+cP9AGvMzJJg76sGrAh3T6kolc95/BDogPEos6MXzO19ONpw
         ZZQ7c5mu+6qmvVx6k7D38u2l0S40v9Xb9ZQBTuwDWfMteP/HnjynCkw1ax+XAwpbqsOZ
         WlN46qkLJAVGmHO20CLtarhwIRCf+Hl6GTcb0O1eiTRDNRts7FjhjyuaKFr4mMfXjcJi
         /5Z+sGVQNBU/XVLAw9y3DD20r1WTp1HbubvyxsGvF+ZDlrDStLCAKhTkrgVnGYZ//dII
         14XQ==
X-Gm-Message-State: AOAM533BBBzu68cQeBF6sQdbNRfy3Rw5awiVQNTNTke955tlXaV/q0dn
        lA14pB/en+fulUKxkH1//XEE6dd9oMQyTJBzdh0=
X-Google-Smtp-Source: ABdhPJxrFRPQc2dIB/rpJG3OFUuQ3pqcG6UwllwxN96YeNR7QHh9tWGlPWYKr5Z1Fter5IjlcEsyr2Pk7BW+lIpqJYs=
X-Received: by 2002:a05:6602:158b:: with SMTP id e11mr418853iow.93.1644008539441;
 Fri, 04 Feb 2022 13:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20220204134347.1187749-1-javierm@redhat.com> <20220204134347.1187749-2-javierm@redhat.com>
 <47100413-db63-1efa-45e9-028dfc430b7e@suse.de>
In-Reply-To: <47100413-db63-1efa-45e9-028dfc430b7e@suse.de>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 4 Feb 2022 16:02:08 -0500
Message-ID: <CAKb7UvgxhLFT4aqYSE+=dpqfuTkvr62tsGmQP5H46mAytaQBRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/format-helper: Add drm_fb_{xrgb8888,gray8}_to_mono_reversed()
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 10:53 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 04.02.22 um 14:43 schrieb Javier Martinez Canillas:
> > Add support to convert XR24 and 8-bit grayscale to reversed monochrome for
> > drivers that control monochromatic panels, that only have 1 bit per pixel.
> >
> > The drm_fb_gray8_to_mono_reversed() helper was based on the function that
> > does the same in the drivers/gpu/drm/tiny/repaper.c driver.
> >
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> >
> > (no changes since v1)
> >
> >   drivers/gpu/drm/drm_format_helper.c | 80 +++++++++++++++++++++++++++++
> >   include/drm/drm_format_helper.h     |  7 +++
> >   2 files changed, 87 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> > index 0f28dd2bdd72..cdce4b7c25d9 100644
> > --- a/drivers/gpu/drm/drm_format_helper.c
> > +++ b/drivers/gpu/drm/drm_format_helper.c
> > @@ -584,3 +584,83 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
> >       return -EINVAL;
> >   }
> >   EXPORT_SYMBOL(drm_fb_blit_toio);
> > +
> > +static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, size_t pixels)
> > +{
> > +     unsigned int xb, i;
> > +
> > +     for (xb = 0; xb < pixels / 8; xb++) {
>
> In practice, all mode widths are multiples of 8 because VGA mandated it.
> So it's ok-ish to assume this here. You should probably at least print a
> warning somewhere if (pixels % 8 != 0)

Not sure if it's relevant, but 1366x768 was a fairly popular laptop
resolution. There's even a dedicated drm_mode_fixup_1366x768 in
drm_edid.c. (Would it have killed them to add 2 more horizontal
pixels? Apparently.)

Cheers,

  -ilia
