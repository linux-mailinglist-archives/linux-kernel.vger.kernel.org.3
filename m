Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB99049C042
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiAZAkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:40:05 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:43758 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiAZAkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:40:02 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9DD9A71;
        Wed, 26 Jan 2022 01:40:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643157600;
        bh=39YQOO8kiCwng87xf7Zi6eCskEERmKQqrn0Nu4BVpXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5GW3Mw0xK410gpYL/hg5EKhG13Pk5J9eQsuwXEGGwu3iWTpk5ztm3RaWKR5iJWK+
         Ul7h8kQgjTaHfgRMYLCqTgvEckdp7PU/9Nnu4/eHfhuqjILkkBrj1L6NWqvLVDk/r5
         ssOGzA/8uQYPMtpDmnMFlTcxOtyabQXxEac5qMVM=
Date:   Wed, 26 Jan 2022 02:39:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ti-vpe: cal: Fix a NULL pointer dereference in
 cal_ctx_v4l2_init_formats()
Message-ID: <YfCYTfnQQx8wuoD3@pendragon.ideasonboard.com>
References: <20220124172001.62457-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124172001.62457-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Thank you for the patch.

On Tue, Jan 25, 2022 at 01:20:01AM +0800, Zhou Qingyang wrote:
> In cal_ctx_v4l2_init_formats(), devm_kzalloc() is assigned to fw and there

What do you mean by "fw" here ? It could be replaced with "is assigned
to ctx->active_fmt". If you're fine with this change, there's no need to
resend, I can fix this when applying.

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

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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

-- 
Regards,

Laurent Pinchart
