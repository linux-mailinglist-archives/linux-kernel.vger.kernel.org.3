Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDC349F72B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiA1KTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:19:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57838 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244125AbiA1KTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:19:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3EF61DE2;
        Fri, 28 Jan 2022 10:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0060BC340E0;
        Fri, 28 Jan 2022 10:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365179;
        bh=ZH9rmx9Q+0dQimBRliRAOB9/hhg4360bakM3y/qowXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwNamkS7wIAp2FbQaa2QHXrxJPmY7SNK5dJs3Y+ExSLnnsF84KiiCbegD9Xf3FnmV
         mFjQwl+hHWuGsQilhg+3P/Guwqv0PGaZ44ISK9RWy1ewK9zS/GW+oqZeBtW3NPRnlD
         ICKQ5jgjVT8t5dqc0vH+Hc20Bnl05ZSXSLhQZ0G0=
Date:   Fri, 28 Jan 2022 11:19:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ti-vpe: cal: Fix a NULL pointer dereference in
 cal_ctx_v4l2_init_formats()
Message-ID: <YfPDOOtlGPRfp3Vo@kroah.com>
References: <20220124172001.62457-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124172001.62457-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:20:01AM +0800, Zhou Qingyang wrote:
> In cal_ctx_v4l2_init_formats(), devm_kzalloc() is assigned to fw and there
> is a dereference of it after that, which could lead to NULL pointer
> dereference on failure of devm_kzalloc().
> 
> Fix this bug by adding a NULL check of ctx->active_fmt.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 7168155002cf ("media: ti-vpe: cal: Move format handling to cal.c and expose helpers")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> --
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/media/platform/ti-vpe/cal-video.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
> index 7799da1cc261..3e936a2ca36c 100644
> --- a/drivers/media/platform/ti-vpe/cal-video.c
> +++ b/drivers/media/platform/ti-vpe/cal-video.c
> @@ -823,6 +823,9 @@ static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
>  	/* Enumerate sub device formats and enable all matching local formats */
>  	ctx->active_fmt = devm_kcalloc(ctx->cal->dev, cal_num_formats,
>  				       sizeof(*ctx->active_fmt), GFP_KERNEL);
> +	if (!ctx->active_fmt)
> +		return -ENOMEM;
> +
>  	ctx->num_active_fmt = 0;
>  
>  	for (j = 0, i = 0; ; ++j) {
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

