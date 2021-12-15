Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C947650F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhLOV70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:59:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58334 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhLOV7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:59:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BC0861ADD;
        Wed, 15 Dec 2021 21:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B94AC36AE2;
        Wed, 15 Dec 2021 21:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639605564;
        bh=DVg54QbMWu+0DdObQKJN9dF5Q1puv+DkorrIi0OFPFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZkjPXSi+PKmQfTY3OXjEFGlXW2uD/kzBLrimazVJbPzcfud+jl81BX41iCcMEd8s
         cVR8upjEpWY577HmriQTkSCzTyR5DPqJFW6+h0xGRMa0jhXa+egPUl44MkKcUUuYMp
         oHZ4bZJgFgy+I1zPjCynd7G2J/GneX5J+SvysYv4rfVDmaZHWZYF3lg8wCZcmNSfBz
         +6TQScSMXyclEt318c9dWMBNkHxov8H43aFqm5eB7mqd7ovh7/5kAR/V0EWGUEvz/n
         ucpIZOe7c1pcX8DaI4R4Xx8Q5cL8M1P+WdGJGs50NTmu9j7izUvksfr1cEeugES6CI
         mvrp+V7gD5sRw==
Date:   Wed, 15 Dec 2021 16:05:05 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] media: omap3isp: Use struct_group() for memcpy() region
Message-ID: <20211215220505.GB21862@embeddedor>
References: <20211118184352.1284792-1-keescook@chromium.org>
 <20211213232416.GA60133@embeddedor>
 <202112150937.8E4974D35@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112150937.8E4974D35@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 09:38:55AM -0800, Kees Cook wrote:
> On Mon, Dec 13, 2021 at 05:24:16PM -0600, Gustavo A. R. Silva wrote:
> > On Thu, Nov 18, 2021 at 10:43:52AM -0800, Kees Cook wrote:
> > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > > intentionally writing across neighboring fields. Wrap the target region
> > > in struct_group(). This additionally fixes a theoretical misalignment
> > > of the copy (since the size of "buf" changes between 64-bit and 32-bit,
> > > but this is likely never built for 64-bit).
> > > 
> > > FWIW, I think this code is totally broken on 64-bit (which appears to
> > > not be a "real" build configuration): it would either always fail (with
> > > an uninitialized data->buf_size) or would cause corruption in userspace
> > > due to the copy_to_user() in the call path against an uninitialized
> > > data->buf value:
> > > 
> > > omap3isp_stat_request_statistics_time32(...)
> > >     struct omap3isp_stat_data data64;
> > >     ...
> > >     omap3isp_stat_request_statistics(stat, &data64);
> > > 
> > > int omap3isp_stat_request_statistics(struct ispstat *stat,
> > >                                      struct omap3isp_stat_data *data)
> > >     ...
> > >     buf = isp_stat_buf_get(stat, data);
> > > 
> > > static struct ispstat_buffer *isp_stat_buf_get(struct ispstat *stat,
> > >                                                struct omap3isp_stat_data *data)
> > > ...
> > >     if (buf->buf_size > data->buf_size) {
> > >             ...
> > >             return ERR_PTR(-EINVAL);
> > >     }
> > >     ...
> > >     rval = copy_to_user(data->buf,
> > >                         buf->virt_addr,
> > >                         buf->buf_size);
> > > 
> > > Regardless, additionally initialize data64 to be zero-filled to avoid
> > > undefined behavior.
> > > 
> > > Fixes: 378e3f81cb56 ("media: omap3isp: support 64-bit version of omap3isp_stat_data")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

> > > ---
> > >  drivers/media/platform/omap3isp/ispstat.c |  5 +++--
> > >  include/uapi/linux/omap3isp.h             | 21 +++++++++++++--------
> > >  2 files changed, 16 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/omap3isp/ispstat.c
> > > index 5b9b57f4d9bf..68cf68dbcace 100644
> > > --- a/drivers/media/platform/omap3isp/ispstat.c
> > > +++ b/drivers/media/platform/omap3isp/ispstat.c
> > > @@ -512,7 +512,7 @@ int omap3isp_stat_request_statistics(struct ispstat *stat,
> > >  int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
> > >  					struct omap3isp_stat_data_time32 *data)
> > >  {
> > > -	struct omap3isp_stat_data data64;
> > > +	struct omap3isp_stat_data data64 = { };
> > >  	int ret;
> > >  
> > >  	ret = omap3isp_stat_request_statistics(stat, &data64);
> > > @@ -521,7 +521,8 @@ int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
> > >  
> > >  	data->ts.tv_sec = data64.ts.tv_sec;
> > >  	data->ts.tv_usec = data64.ts.tv_usec;
> > > -	memcpy(&data->buf, &data64.buf, sizeof(*data) - sizeof(data->ts));
> > > +	data->buf = (uintptr_t)data64.buf;
> > 
> > Shouldn't this be
> > 
> > 	data->buf = (uintptr_t)(void *)data64.buf;
> > 
> > instead?
> 
> This is already a void *:
> 
> struct omap3isp_stat_data {
> 	...
>         void __user *buf;
> };
> 
> But I agree, the mix of structures in here is confusing! :)

Yep; you're right. :)

Thanks
--
Gustavo
