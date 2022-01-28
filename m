Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786BA49F709
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347667AbiA1KRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347746AbiA1KRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:17:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D14C06175A;
        Fri, 28 Jan 2022 02:17:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7A8C61E3B;
        Fri, 28 Jan 2022 10:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C1BC340E0;
        Fri, 28 Jan 2022 10:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365034;
        bh=qSscwoImkGW0Lgs8qkgO5CPtEC7NcVAPM0YCkJG5tks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMf6LQMsdbPQwLHYf/mz9/220V0ACYO8PS2k4k7LpNmIifCvRqmvAfI9aLp58hXTU
         +nhTs8M4d+R0BAIL9E951ozxZHYZlHZU51sMoHJKISBPH3i1EHkNO9ZQxM+BPryY9h
         tl030WiTJSlTJvp14ukIXhEbUvLIejjhKqFQhB2M=
Date:   Fri, 28 Jan 2022 11:17:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: pci: cx23855-video.c: Fix a NULL pointer
 dereference in cx23885_video_register()
Message-ID: <YfPCp9Kz0SSXAlp6@kroah.com>
References: <20220124171620.61466-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124171620.61466-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:16:18AM +0800, Zhou Qingyang wrote:
> In cx23885_video_register(), the return value of cx23885_vdev_init() is
> assigned to dev->video_dev and there is a dereference of it after that.
> the return value of cx23885_vdev_init() could be NULL on failure of
> allocation, which could lead to a NULL pointer dereference.
> 
> the same as dev->vbi_dev.
> 
> Fix this bug by adding a NULL check of dev->video_dev and dev->vbi_dev.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 453afdd9ce33 ("[media] cx23885: convert to vb2")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/media/pci/cx23885/cx23885-video.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
> index a380e0920a21..1b95109eff8c 100644
> --- a/drivers/media/pci/cx23885/cx23885-video.c
> +++ b/drivers/media/pci/cx23885/cx23885-video.c
> @@ -1353,6 +1353,11 @@ int cx23885_video_register(struct cx23885_dev *dev)
>  	/* register Video device */
>  	dev->video_dev = cx23885_vdev_init(dev, dev->pci,
>  		&cx23885_video_template, "video");
> +	if (!dev->video_dev) {
> +		err = -ENOMEM;
> +		goto fail_unreg;
> +	}
> +
>  	dev->video_dev->queue = &dev->vb2_vidq;
>  	dev->video_dev->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
>  				      V4L2_CAP_AUDIO | V4L2_CAP_VIDEO_CAPTURE;
> @@ -1381,6 +1386,11 @@ int cx23885_video_register(struct cx23885_dev *dev)
>  	/* register VBI device */
>  	dev->vbi_dev = cx23885_vdev_init(dev, dev->pci,
>  		&cx23885_vbi_template, "vbi");
> +	if (!dev->vbi_dev) {
> +		err = -ENOMEM;
> +		goto fail_unreg;
> +	}
> +
>  	dev->vbi_dev->queue = &dev->vb2_vbiq;
>  	dev->vbi_dev->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
>  				    V4L2_CAP_AUDIO | V4L2_CAP_VBI_CAPTURE;
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

