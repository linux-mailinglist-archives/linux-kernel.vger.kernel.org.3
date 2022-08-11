Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5179459064D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiHKS31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiHKS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:29:23 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE519D13A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
         date:from;
        bh=sKZBJV8eQGMq/ZtuPBdn6Snt6tkAa1UDvnyVBqh6Oro=;
        b=Qxe5JBXrnaGrvbdkqhMMLhw530WFVz0xC3rxVYe3pAMMrhtUg6gR3hklOlywV9CWXI/b9W4ljsOXN
         1Z2vsYLWGKwvWtf+gO/oX6PBIJIFBHWUxgWnvUFnRzF46pZ3nqghBXzHuGNUxvj+0QzXc2kq3NJfhs
         jmEcEHokoCjqFW32am7xnpd7ZWCqux1Fcmmsjapc61+ml+PD8M3b/lg0VonmTpWnuoHXolpnbY+pyq
         DmaHFdE8V1R/z/TDHGRmkAk7IW9l5sfCnV8l3RMv74iTgBdSPm5gVlD6FefHmO4E2k69Xdjb10jZHD
         Dq+2wvJsvvCHqxt4ylELm3ysSv2qwOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
         date:from;
        bh=sKZBJV8eQGMq/ZtuPBdn6Snt6tkAa1UDvnyVBqh6Oro=;
        b=r9pvE5VcuydSSXg9Z3uj1+fMpwaQkhPTmRjpoztlo8ZkOioNzACwlYIDdVDplFPn/wenL+YfsBMT4
         0lS9CgoBg==
X-HalOne-Cookie: 27507c0df40bd684608bd38a3ffd911f8aa0fb92
X-HalOne-ID: 81f9a990-19a3-11ed-a6cc-d0431ea8a283
Received: from mailproxy4.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 81f9a990-19a3-11ed-a6cc-d0431ea8a283;
        Thu, 11 Aug 2022 18:29:17 +0000 (UTC)
Date:   Thu, 11 Aug 2022 20:29:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v3 01/10] drm/fourcc: Add drm_format_info_bpp() helper
Message-ID: <YvVKe72jYBjucmkz@ravnborg.org>
References: <cover.1657294931.git.geert@linux-m68k.org>
 <1cae5ebc28513ec1c91c66b00647ce3ca23bfba7.1657294931.git.geert@linux-m68k.org>
 <YvPVxy4kYKdzWgT8@phenom.ffwll.local>
 <CAMuHMdVMuuXgYW-AkyB+G77Wsjkm715u1ifDvaY=5DufXjryRA@mail.gmail.com>
 <YvUqPL5l8/+XbvaQ@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvUqPL5l8/+XbvaQ@phenom.ffwll.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert, Daniel.

On Thu, Aug 11, 2022 at 06:11:40PM +0200, Daniel Vetter wrote:
> On Thu, Aug 11, 2022 at 09:59:39AM +0200, Geert Uytterhoeven wrote:
> > Hi Daniel,
> > 
> > On Wed, Aug 10, 2022 at 5:59 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Fri, Jul 08, 2022 at 08:20:46PM +0200, Geert Uytterhoeven wrote:
> > > > Add a helper to retrieve the actual number of bits per pixel for a
> > > > plane, taking into account the number of characters and pixels per
> > > > block for tiled formats.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > 
> > > > --- a/drivers/gpu/drm/drm_fourcc.c
> > > > +++ b/drivers/gpu/drm/drm_fourcc.c
> > > > @@ -370,6 +370,25 @@ unsigned int drm_format_info_block_height(const struct drm_format_info *info,
> > > >  }
> > > >  EXPORT_SYMBOL(drm_format_info_block_height);
> > > >
> > > > +/**
> > > > + * drm_format_info_bpp - number of bits per pixel
> > > > + * @info: pixel format info
> > > > + * @plane: plane index
> > > > + *
> > > > + * Returns:
> > > > + * The actual number of bits per pixel, depending on the plane index.
> > > > + */
> > > > +unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
> > > > +{
> > > > +     if (!info || plane < 0 || plane >= info->num_planes)
> > > > +             return 0;
> > > > +
> > > > +     return info->char_per_block[plane] * 8 /
> > > > +            (drm_format_info_block_width(info, plane) *
> > > > +             drm_format_info_block_height(info, plane));
> > >
> > > Do we really needs this for blocky formats where this is potentially
> > > ill-defined? I think if there's no need then this should also return 0
> > > when block_width/height != 1, it doesn't make much sense to compute bpp
> > > when it's not really bits per _pixel_.
> > 
> > Yes, we do need this.  For low-color formats, the number of bits
> > per pixel is less than eight, and block_width is larger than one.
> > That is actually the point of this patch.
> 
> Hm right, I didn't realize that this is how we have to describe the
> formats with less than 8 bpp.
> 
> I think we can include them easily with a check for char_per_block == 1
> and then making sure that the division does not have a reminder (just in
> case someone does something really funny, it could e.g. be a 332 layout or
> something like that for 3 pixels).
> 
> > > Minimally this needs to check whether the division actually makes sense or
> > > whether there's a reminder, and if there's  reminder, then fail. But that
> > > feels like a bad hack and I think we should avoid it if it's not
> > > absolutely necessary.
> > 
> > Looking at drivers/gpu/drm/drm_fourcc.c, the only supported format
> > where there can be a remainder is P030, which has 2 spare bits per
> > 32-bit word, and thus is special anyway.
> > Still, 4 * 8 / 3 = 10, so you get the correct numbers of bits for
> > the first plane.  For the second plane, you get 8 * 8 / 3 = 21,
> > but as .is_yuv = true, you have to divide that result by two again,
> > so you get 10 again.
> 
> Yeah I don't think we should describe these with bpp or cpp or anything
> like that. bpp < 8 makes sense since that's how this has been done since
> decades, but trying to extend these to funny new formats is a bad idea.
> This is also why cpp and depth refuse to compute these (or at least
> should).

Daniel and I discussed this on irc. Let me try to recap here.
Using the bits per pixel info from drm_format_info is something we shall
try to avoid as this is often a sign of the wrong abstraction/design (my
words based on the irc talk).
So we shall limit the use of drm_format_info_bpp() to what we need now,
thus blocky formats should not be supported - to try to avoid seeing
this used more than necessary.

Daniel suggested a rename to drm_format_info_legacy_bpp() to make it
obvious that this is often/always the wrong solution. I did not jump on
doing the rename as I do not know stuff good enough to tell people what
to use when this is not the right solution. The rename is simple, it is
the follow-up that keep me away.

On top of this there is a few formats in drm_drourcc that has a depth
field set which should be dropped. .depth is only for the few legacy
formats where it is used today.

We would also like to convert the fbdev helpers to drm_format_info,
and doing so will likely teach us a bit more what we need and what we
can drop.

Geert - can you give drm_format_info_bpp() a spin so it is limited to
the formats used now (not the blocky ones).

	Sam
