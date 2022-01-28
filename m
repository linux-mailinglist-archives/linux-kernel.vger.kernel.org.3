Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02749F754
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347887AbiA1Kcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347878AbiA1Kcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:32:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DDFC061747;
        Fri, 28 Jan 2022 02:32:54 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7FA23471;
        Fri, 28 Jan 2022 11:32:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643365971;
        bh=QVy9zl0W8jMMsuagrjFHi3f0S0j/21GAM2lTr0325W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeUrFGsKU4F+E6XXqPJtoup86EbTlroJpYbUqeD5i+PX4+dXjEb7W9340/J4SIcHd
         T37s/gyVQQei5Dn+UprtOlaaFCdjISEtPNMZQVcYMGwPMcPQ+b26YTkac5DKDejO2u
         cEgyqZu4Auv8KCmFfYgT5K8vk6CnArkU8ZvSAVsI=
Date:   Fri, 28 Jan 2022 12:32:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zhou Qingyang <zhou1615@umn.edu>, kjlu@umn.edu,
        Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ti-vpe: cal: Fix a NULL pointer dereference in
 cal_ctx_v4l2_init_formats()
Message-ID: <YfPGPssBW5l1r8ew@pendragon.ideasonboard.com>
References: <20220124172001.62457-1-zhou1615@umn.edu>
 <YfPDOOtlGPRfp3Vo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfPDOOtlGPRfp3Vo@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jan 28, 2022 at 11:19:36AM +0100, Greg KH wrote:
> On Tue, Jan 25, 2022 at 01:20:01AM +0800, Zhou Qingyang wrote:
> > In cal_ctx_v4l2_init_formats(), devm_kzalloc() is assigned to fw and there
> > is a dereference of it after that, which could lead to NULL pointer
> > dereference on failure of devm_kzalloc().
> > 
> > Fix this bug by adding a NULL check of ctx->active_fmt.
> > 
> > This bug was found by a static analyzer.
> > 
> > Builds with 'make allyesconfig' show no new warnings,
> > and our static analyzer no longer warns about this code.
> > 
> > Fixes: 7168155002cf ("media: ti-vpe: cal: Move format handling to cal.c and expose helpers")
> > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > --
> > The analysis employs differential checking to identify inconsistent 
> > security operations (e.g., checks or kfrees) between two code paths 
> > and confirms that the inconsistent operations are not recovered in the
> > current function or the callers, so they constitute bugs. 
> > 
> > Note that, as a bug found by static analysis, it can be a false
> > positive or hard to trigger. Multiple researchers have cross-reviewed
> > the bug.
> > 
> >  drivers/media/platform/ti-vpe/cal-video.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
> > index 7799da1cc261..3e936a2ca36c 100644
> > --- a/drivers/media/platform/ti-vpe/cal-video.c
> > +++ b/drivers/media/platform/ti-vpe/cal-video.c
> > @@ -823,6 +823,9 @@ static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
> >  	/* Enumerate sub device formats and enable all matching local formats */
> >  	ctx->active_fmt = devm_kcalloc(ctx->cal->dev, cal_num_formats,
> >  				       sizeof(*ctx->active_fmt), GFP_KERNEL);
> > +	if (!ctx->active_fmt)
> > +		return -ENOMEM;
> > +
> >  	ctx->num_active_fmt = 0;
> >  
> >  	for (j = 0, i = 0; ; ++j) {
> 
> As stated before, umn.edu is still not allowed to contribute to the
> Linux kernel.  Please work with your administration to resolve this
> issue.

I thought this had been resolved, my bad. I can drop the patch, but it
fixes a real bug (although unlikely). Should I re-author this fix ?

-- 
Regards,

Laurent Pinchart
