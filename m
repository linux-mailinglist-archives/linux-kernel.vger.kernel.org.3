Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64E254285A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiFHHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiFHHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:45:07 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3836027229D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:09:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 73E6480A;
        Wed,  8 Jun 2022 09:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654672125;
        bh=iYqkLmv/t3PUIjg6ZpZgts1wvyz/0BVaHNALwRAdXBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TE+jXYIFdaNlUNcylQzO5o+r6cIoxuQGwiJHoPWVijA/+aGOplvXmAgmO6gFXiTEC
         XnGZ3P8ZZwn5AOGrkTtYALn65a65MFgksjsX0D2RILXLvA+n7VHSeAE9kkIXAFSc3/
         B0vrxPUfGD3m1MKQFVhsO75jTWjUTRxB5ur44G20=
Date:   Wed, 8 Jun 2022 10:08:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: shmobile: Use backlight helper
Message-ID: <YqBK+GXrIx3XX+Km@pendragon.ideasonboard.com>
References: <20220607183132.1123648-1-steve@sk2.org>
 <20220607230537.70020736@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607230537.70020736@heffalump.sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Jun 07, 2022 at 11:05:37PM +0200, Stephen Kitt wrote:
> On Tue,  7 Jun 2022 20:31:32 +0200, Stephen Kitt <steve@sk2.org> wrote:
> > backlight_properties.fb_blank is deprecated. The states it represents
> > are handled by other properties; but instead of accessing those
> > properties directly, drivers should use the helpers provided by
> > backlight.h.
> 
> Apologies for the misleading boilerplate, this patch came about as a result
> of cleaning up fb_blank usage but doesn't involve fb_blank itself.

No worries. Would you like to submit a v2 with a better commit message ?
The patch otherwise looks good to me.

> > Instead of retrieving the backlight brightness in struct
> > backlight_properties manually, and then checking whether the backlight
> > should be on at all, use backlight_get_brightness() which does all
> > this and insulates this from future changes.
> > 
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > ---
> >  drivers/gpu/drm/shmobile/shmob_drm_backlight.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
> > b/drivers/gpu/drm/shmobile/shmob_drm_backlight.c index
> > f6628a5ee95f..794573badfe8 100644 ---
> > a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c +++
> > b/drivers/gpu/drm/shmobile/shmob_drm_backlight.c @@ -18,11 +18,7 @@ static
> > int shmob_drm_backlight_update(struct backlight_device *bdev) struct
> > shmob_drm_connector *scon = bl_get_data(bdev); struct shmob_drm_device
> > *sdev = scon->connector.dev->dev_private; const struct
> > shmob_drm_backlight_data *bdata = &sdev->pdata->backlight;
> > -	int brightness = bdev->props.brightness;
> > -
> > -	if (bdev->props.power != FB_BLANK_UNBLANK ||
> > -	    bdev->props.state & BL_CORE_SUSPENDED)
> > -		brightness = 0;
> > +	int brightness = backlight_get_brightness(bdev);
> >  
> >  	return bdata->set_brightness(brightness);
> >  }
> > 
> > base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56

-- 
Regards,

Laurent Pinchart
