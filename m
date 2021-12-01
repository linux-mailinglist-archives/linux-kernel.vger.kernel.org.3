Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE495464770
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347043AbhLAG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhLAG4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:56:37 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB818C061574;
        Tue, 30 Nov 2021 22:53:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3AE3EA15;
        Wed,  1 Dec 2021 07:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638341595;
        bh=sDoEfSoAB5bQ3OBVNGdIuFjdJ/u6y+6SXSepJCSesI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jfrn0mxPyZloxFH8Ux5I+0cwcdasqN4qZOg+VUHiMQhC4pj923uEvfvlAk1bgQIbL
         TLjb+CGAFhBr0y5kJ+6UdMHhYFow9XYdEiqsVVXqnf1WqTl09yHMOALaNcwf4RBUDm
         34izDQlMWlIDbIM3HSzDkm5brshJSjew/Acoxfv4=
Date:   Wed, 1 Dec 2021 08:52:50 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH] media: Add 16-bit Bayer formats
Message-ID: <Yacbwm0VLzG1IJvS@pendragon.ideasonboard.com>
References: <20211019114718.827400-1-dorota.czaplejewicz@puri.sm>
 <163820077159.3059017.10242072140890692995@Monstersaurus>
 <20211129170356.7258d6db.dorota.czaplejewicz@puri.sm>
 <YaWNkcljqIR6BSdZ@pendragon.ideasonboard.com>
 <b1ddf6f61179c2445710d8540dd42ed6d71ae353.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1ddf6f61179c2445710d8540dd42ed6d71ae353.camel@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Tue, Nov 30, 2021 at 08:43:25AM +0100, Alexander Stein wrote:
> Am Dienstag, dem 30.11.2021 um 04:33 +0200 schrieb Laurent Pinchart:
> > On Mon, Nov 29, 2021 at 05:05:23PM +0100, Dorota Czaplejewicz wrote:
> > > On Mon, 29 Nov 2021 15:46:11 +0000 Kieran Bingham wrote:
> > > > Quoting Dorota Czaplejewicz (2021-10-19 12:59:29)
> > > > > 16-bit bayer formats are used by the i.MX driver.  
> > > > 
> > > > Can we expand upon this at all?
> > > > 
> > > > The Subject says "Add 16-bit Bayer formats" but this isn't adding the
> > > > format, it's purely extending the v4l2_format_info table with the
> > > > information for that format which is otherwise missing.
> > > 
> > > What do you suggest for a better commit message? My reasoning was that
> > > I'm adding entries to a table.
> > 
> > The format is defined by V4L2 but isn't present in that table. I'd state
> > the this patch is fixing an oversight, and reference the commit that
> > forgot to add these formats in a Fixes: tag. While at it, I'd also add
> > at least the 14bpp Bayer formats, and possibly the packed formats too.
> > 
> > > > I wonder what other formats are missing from that table too?
> > > > 
> > > > > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > > > ---
> > > > > Hello,
> > > > > 
> > > > > While working on the i.MX8 video driver, I discovered that
> > > > > `v4l2_fill_pixfmt` will fail when using 10-bit sensor formats.
> > > > > (For background, see the conversation at
> > > > > https://lkml.org/lkml/2021/10/17/93
> > > > >  .)
> > > > > 
> > > > > It appears that the video hardware will fill a 16-bit-per-pixel
> > > > > buffer when fed 10-bit-per-pixel Bayer data, making
> > > > > `v4l2_fill_pixfmt` effectively broken for this case.  
> > > > 
> > > > This statement is confusing to me. Are you saying you're programming the
> > > > hardware with 10 bit, and it's using 16 bits per pixel to store that
> > > > data? (Which is simply 'unpacked' I think ?)
> > > 
> > > I know the sensor I'm dealing with sends 10-bit data. I'm observing
> > > that the data arriving at this stage of the pipeline is encoded with
> > > 16 bits per pixel. As far as I understand, that's what i.MX8 does at
> > > some stage of the MIPI/CSI2 pipeline by design, but I can't elaborate
> > > at the moment, and I don't think it affects the validity of the
> > > addition.
> > 
> > Is the 10 bit data stored in the MSB or LSB of the 2 bytes ?
> 
> Oh, I get a dejavu here. I assume this is on an i.MX8QM or i.MX8QXP,
> but not one of the other i.MX8 ones. They have a similar name, but are
> very (!) diffeent in some aspects.
> 
> To answer your question, neither of those two alignments. The RM for
> i.MX8QM and i.MX8QXP states:
>
> > NOTE
> > The CSI data is right LSB aligned and zero padded depending
> > on data format. When interfacing ISI, CSI data is shifted 6-bits
> > due to ISI bits [5:0] always being zero
> > (0bxxCSIDATAxxxxxx). All RAW14, RAW12, RAW10,
> > RAW8, and RAW6 video data is filled from BIT[13] to LSB,
> > the remaining bits are zero padded. Only RAW16 input data
> > will be saved to memory from BIT[15] to LSB.

I think Dorota is working on the i.MX8MQ, which, unlike the QM and QXP,
isn't based on the ISI IP core but the CSI bridge IP core.

> See also [1]. 
> 
> This essentially means, unless you use RAW16, you will get RAW14 with a
> different amount of LSB bits set to 0.
> IIRC there was some patchset to introduce a RAW14 format ([2]) for
> exactly this use cas.
> There is also some kind of demo doing post-processing ([3]).
> 
> Best regards,
> Alexander
> 
> [1] https://community.nxp.com/t5/i-MX-Processors/i-MX8QM-MIPI-Raw-formats-not-working-correctly/m-p/1040832/highlight/true#M153336
> [2] https://yhbt.net/lore/all/20200226151431.GY5379@paasikivi.fi.intel.com/T/
> [3] https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/i-MX8QXP-capture-raw-bayer-data-and-debayer/ta-p/1098963

-- 
Regards,

Laurent Pinchart
