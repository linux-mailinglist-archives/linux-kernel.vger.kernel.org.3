Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE765906F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiHKTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiHKTaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:30:24 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEAEB05
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=PiIxReYkxtBzv66jtBR4FROfX82syegstNTwPa+ySR0=;
        b=J4WnXA650B9xrqJFOUNC99f85fvYDJAQp733iypsjAv6EqqJCkAK7OOrj2HmV44IcKdnV3v+7OM2Q
         VBI5UDXOx9WDYcqqlqUYamwCxt9veZ0xDP0M1tZNhzKtiTJk3LKqmoJvowc6jzgVcl1XbWbLHnWGaj
         prL9zk8v75TMw3wvqpIdOSgv8OKdHSseFmbRB9/hcaUaQsxV1ggShec0sc4PVydd3U/hZl73hVvHxr
         y/LkQkCaLbhyFGuCCwyE98HrhJ5vXM2lzB//fk+kRnBtI4dkJsF4/Qd47/hCwSJohfSbz0YxDuEoJO
         R1XE1Hodc/OUYnY5cMcYNsOsE7lki1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=PiIxReYkxtBzv66jtBR4FROfX82syegstNTwPa+ySR0=;
        b=lud6DSUj9xxo1AbujB4/Ho0gbti2rokDDTZkDXnKk5P5Gu4jnxPiTtmV5CE+z6T/r+e1iMKDNB/Wp
         EGowbZsDQ==
X-HalOne-Cookie: 52a4d43754f5de879c648bea03fabce90926a481
X-HalOne-ID: 07f25d33-19ac-11ed-8245-d0431ea8bb10
Received: from mailproxy4.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 07f25d33-19ac-11ed-8245-d0431ea8bb10;
        Thu, 11 Aug 2022 19:30:17 +0000 (UTC)
Date:   Thu, 11 Aug 2022 21:30:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v3 01/10] drm/fourcc: Add drm_format_info_bpp() helper
Message-ID: <YvVYyKZNDGfhGjb5@ravnborg.org>
References: <cover.1657294931.git.geert@linux-m68k.org>
 <1cae5ebc28513ec1c91c66b00647ce3ca23bfba7.1657294931.git.geert@linux-m68k.org>
 <YvPVxy4kYKdzWgT8@phenom.ffwll.local>
 <CAMuHMdVMuuXgYW-AkyB+G77Wsjkm715u1ifDvaY=5DufXjryRA@mail.gmail.com>
 <YvUqPL5l8/+XbvaQ@phenom.ffwll.local>
 <YvVKe72jYBjucmkz@ravnborg.org>
 <CAMuHMdVD37MCXau4w87=x_jk9j-NMJCmu0d9qPuMqmHA_vPQRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVD37MCXau4w87=x_jk9j-NMJCmu0d9qPuMqmHA_vPQRQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert.

> > >
> > > Yeah I don't think we should describe these with bpp or cpp or anything
> > > like that. bpp < 8 makes sense since that's how this has been done since
> > > decades, but trying to extend these to funny new formats is a bad idea.
> > > This is also why cpp and depth refuse to compute these (or at least
> > > should).
> >
> > Daniel and I discussed this on irc. Let me try to recap here.
> > Using the bits per pixel info from drm_format_info is something we shall
> > try to avoid as this is often a sign of the wrong abstraction/design (my
> > words based on the irc talk).
> > So we shall limit the use of drm_format_info_bpp() to what we need now,
> > thus blocky formats should not be supported - to try to avoid seeing
> > this used more than necessary.
> >
> > Daniel suggested a rename to drm_format_info_legacy_bpp() to make it
> > obvious that this is often/always the wrong solution. I did not jump on
> > doing the rename as I do not know stuff good enough to tell people what
> > to use when this is not the right solution. The rename is simple, it is
> > the follow-up that keep me away.
> >
> > On top of this there is a few formats in drm_drourcc that has a depth
> > field set which should be dropped. .depth is only for the few legacy
> > formats where it is used today.
> >
> > We would also like to convert the fbdev helpers to drm_format_info,
> > and doing so will likely teach us a bit more what we need and what we
> > can drop.
> >
> > Geert - can you give drm_format_info_bpp() a spin so it is limited to
> > the formats used now (not the blocky ones).
> 
> You mean return 0 if char_per_block[] > 1?
if char_per_block[] > 1 AND block_w[] > 0 AND block_h[] > 0 should be
enough.

> I'm not sure it's actually safe to do so (and make this change this late
> in the development cycle), as this is used in drm_client_buffer_create(),
> drm_client_buffer_addfb(), and drm_mode_getfb().

drm_client_buffer_create() and drm_client_buffer_addfb() both get their
format from  drm_mode_legacy_fb_format() which do not produce any blocky
formats - so they are good.

drm_mode_getfb() looks up a framebuffer originally created using one of
the above (I think), so here it should also be fine.
I do not see the need to push this to fixes, so it has a full cycle to
mature if it causes issues.

	Sam
