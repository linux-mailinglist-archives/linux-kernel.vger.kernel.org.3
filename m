Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7849F7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347998AbiA1LFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:05:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56522 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347954AbiA1LFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:05:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB25EB82522;
        Fri, 28 Jan 2022 11:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09BEC340E6;
        Fri, 28 Jan 2022 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643367917;
        bh=Fy8fSwWrO9PBF9y7AwCtzfTK3/Gmd6gbNMF0WbTJoOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aT7G6qWBv7DTguP2bNkQQg5HB8sAURSvsjzkw7GB+s7SeIyA+UjSCNaRE1oRIS/QU
         vrAeiR7AaRcx4hr+CMDMTAs7uoJNMofgoxLaPZtPwGyrL1Ta7Bmm7by+iK5jGz67pS
         tF+pdQZv9VCgZbiifFveRtGj1yYXMPSEtVQuyqsw=
Date:   Fri, 28 Jan 2022 12:05:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Zhou Qingyang <zhou1615@umn.edu>, kjlu@umn.edu,
        Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ti-vpe: cal: Fix a NULL pointer dereference in
 cal_ctx_v4l2_init_formats()
Message-ID: <YfPN6u4LGufH2gLe@kroah.com>
References: <20220124172001.62457-1-zhou1615@umn.edu>
 <YfPDOOtlGPRfp3Vo@kroah.com>
 <YfPGPssBW5l1r8ew@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfPGPssBW5l1r8ew@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:32:30PM +0200, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Fri, Jan 28, 2022 at 11:19:36AM +0100, Greg KH wrote:
> > On Tue, Jan 25, 2022 at 01:20:01AM +0800, Zhou Qingyang wrote:
> > > In cal_ctx_v4l2_init_formats(), devm_kzalloc() is assigned to fw and there
> > > is a dereference of it after that, which could lead to NULL pointer
> > > dereference on failure of devm_kzalloc().
> > > 
> > > Fix this bug by adding a NULL check of ctx->active_fmt.
> > > 
> > > This bug was found by a static analyzer.
> > > 
> > > Builds with 'make allyesconfig' show no new warnings,
> > > and our static analyzer no longer warns about this code.
> > > 
> > > Fixes: 7168155002cf ("media: ti-vpe: cal: Move format handling to cal.c and expose helpers")
> > > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > > --
> > > The analysis employs differential checking to identify inconsistent 
> > > security operations (e.g., checks or kfrees) between two code paths 
> > > and confirms that the inconsistent operations are not recovered in the
> > > current function or the callers, so they constitute bugs. 
> > > 
> > > Note that, as a bug found by static analysis, it can be a false
> > > positive or hard to trigger. Multiple researchers have cross-reviewed
> > > the bug.
> > > 
> > >  drivers/media/platform/ti-vpe/cal-video.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
> > > index 7799da1cc261..3e936a2ca36c 100644
> > > --- a/drivers/media/platform/ti-vpe/cal-video.c
> > > +++ b/drivers/media/platform/ti-vpe/cal-video.c
> > > @@ -823,6 +823,9 @@ static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
> > >  	/* Enumerate sub device formats and enable all matching local formats */
> > >  	ctx->active_fmt = devm_kcalloc(ctx->cal->dev, cal_num_formats,
> > >  				       sizeof(*ctx->active_fmt), GFP_KERNEL);
> > > +	if (!ctx->active_fmt)
> > > +		return -ENOMEM;
> > > +
> > >  	ctx->num_active_fmt = 0;
> > >  
> > >  	for (j = 0, i = 0; ; ++j) {
> > 
> > As stated before, umn.edu is still not allowed to contribute to the
> > Linux kernel.  Please work with your administration to resolve this
> > issue.
> 
> I thought this had been resolved, my bad. I can drop the patch, but it
> fixes a real bug (although unlikely). Should I re-author this fix ?

If you think it actually fixes something, and does not cause a leak,
yes, please re-author it and feel free to take it.

But be aware that other submissions in this "set" are incorrect, and the
process we were working on with umn.edu was totally ignored, so feel
free to just drop it if you don't want to worry about it.  Failures of
kcalloc are pretty much impossible to hit as we all know.

thanks,

greg k-h
