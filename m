Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2C58EFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiHJQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiHJQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:02:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531D65557
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:02:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso1252226wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=l8/2lnja9nL6p7OH6ZMKU6YrHDC9nL9IFx4bCiysLJE=;
        b=SoMYGdDBirjwK82ZiHhEwxiAU2LXgo/qmYKwj25kGDmr/2HQjxmBszjBG+ULV6eN/7
         +LPICEEUIULROP4JVJdX8Fw5tdWWZcrRdnATTDyJxvXDXn3OTvsv8XTktqud9gtj8wc7
         +y9+jUTHVYAuXJCsCx8wvPIMnMJVqxt22+liQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=l8/2lnja9nL6p7OH6ZMKU6YrHDC9nL9IFx4bCiysLJE=;
        b=QnM2G6dYJdAh/ApbZiDU34Q5fVxAZgEmxTLY3YEsrHTxRalqoFIPyMPo6sfZQR7yRG
         RKfVHg1C/yDfGBXs0DYe1HsgqxpODaGdIsxDvInHH6KkbaRtCx6lb8qCffCDleUpCYP4
         aOWlIxOwJ8NfZxNcNoHI24nO/oA9I3w1Z4knr0uIEYGZGgTgxBp5/8p9KDRTiHBv6QU/
         dhTrGpc/fR9E8YiFEyXaNHGQkF+kjDsTptt/7DQRfLTglecP83nltNq3eCiHxnBoM177
         YCLf+i1kmkMsq5DEnJdj+UDLSJSebjm9ZU6H6FLZF/Sj8XFuQ9IIhmNBA2EbBP7XbQbn
         kgnA==
X-Gm-Message-State: ACgBeo0vy08PumHAN1nflAdQV7zKEQNqLZkAPjvkLFtB+z7PYi5SBrxK
        M6Woj1xyKvB73dSIiCulgahHYg==
X-Google-Smtp-Source: AA6agR6ZnGhaEqcnZ+/Gihz1HN0O86s73EJ4JBla34lVdwPmBl6ZdnsId1glDTd6IlfJ2YXJxSqa2w==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr2999393wmh.154.1660147333609;
        Wed, 10 Aug 2022 09:02:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i5-20020a1c3b05000000b003a503a64e5esm2973492wma.15.2022.08.10.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:02:12 -0700 (PDT)
Date:   Wed, 10 Aug 2022 18:02:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] drm: Add support for low-color frame buffer
 formats
Message-ID: <YvPWghWg/+rmc5nx@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1657294931.git.geert@linux-m68k.org>
 <YsmE1D8lGp4XKs99@ravnborg.org>
 <d6e5204e-5bbb-fe51-fd29-5452198bf368@suse.de>
 <Ysvpk4fzef6caO5y@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysvpk4fzef6caO5y@ravnborg.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:12:51AM +0200, Sam Ravnborg wrote:
> Hi Thomas,
> 
> On Mon, Jul 11, 2022 at 10:50:00AM +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 09.07.22 um 15:38 schrieb Sam Ravnborg:
> > > Hi Geert,
> > > 
> > > On Fri, Jul 08, 2022 at 08:20:45PM +0200, Geert Uytterhoeven wrote:
> > > > 	Hi all,
> > > > 
> > > > A long outstanding issue with the DRM subsystem has been the lack of
> > > > support for low-color displays, as used typically on older desktop
> > > > systems, and on small embedded displays.
> > 
> > For the patchset
> > 
> > Acked-by: Thomas Zimemrmann <tzimmermann@suse.de>
> > 
> > > 
> > > IT is super to have this addressed - thanks!
> > > 
> > > > 
> > > > This patch series adds support for color-indexed frame buffer formats
> > > > with 2, 4, and 16 colors.  It has been tested on ARAnyM using a
> > > > work-in-progress Atari DRM driver supporting 2, 4, 16, 256, and 65536
> > > > colors, with text console operation, fbtest, and modetest.
> > > > 
> > > > Overview:
> > > >    - Patch 1 introduces a helper, to be used by later patches in the
> > > >      series,
> > > >    - Patch 2 introduces a flag to indicate color-indexed formats,
> > > >    - Patches 3 and 4 correct calculations of bits per pixel for sub-byte
> > > >      pixel formats,
> > > >    - Patches 5 and 6 introduce the new C[124] formats,
> > > >    - Patch 7 fixes an untested code path,
> > > >    - Patch 8 documents the use of "red" for light-on-dark displays,
> > > >    - Patches 9 and 10 add more fourcc codes for light-on-dark and
> > > >      dark-on-light frame buffer formats, which may be useful for e.g. the
> > > >      ssd130x and repaper drivers.
> > > 
> > > Applied all patches to drm-misc (drm-misc-next), including the last two
> > > RFC patches as we then have the formats ready when a user pops up.
> > 
> > I know it's v3 already, but give people at least a workday for reviewing
> > before merging patches of this size and impact. Friday-evening patches are
> > not supposed to be merged on Saturday afternoons.
> 
> Sorry for being too enthusiastic on this one.
> Will wait a bit more in the future for these kind of patches.

Took me a bit longer to unburry and get to this, and lgtm except patch 1
where I have a semantic concern. Can you pls do the quick patch to adjust
that? Since this is all about the Cx/Rx/Dx formats I don't think it'll
matter really.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
