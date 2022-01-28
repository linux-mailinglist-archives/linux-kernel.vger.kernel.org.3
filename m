Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2149F6FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346100AbiA1KQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344358AbiA1KQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:16:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAA5C061756;
        Fri, 28 Jan 2022 02:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF9CE61E48;
        Fri, 28 Jan 2022 10:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC425C340E0;
        Fri, 28 Jan 2022 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643364999;
        bh=wY+NiK6roLe1EU72IIk54Y7t84UzbEvYs0eZ/MvO+Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SA9Wl11f0x3s7zm7GRHpMCu36U3aKJ+Jr85DTfWJeYln1c7lurpgWa0b7d2l1xgTX
         X+MXOIveTsJugQIWPu6iyhSHbR4wNVYb5URfmCKy/wLnsDm0W3apB4bwpUS84piZ7C
         QdiXCsd/tIKw/BKioo/XzezHKwWeuyRODCvSlpCI=
Date:   Fri, 28 Jan 2022 11:16:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Douglas Schilling Landgraf <dougsland@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: bttv: Fix a NULL pointer dereference in
 bttv_s_fbuf()
Message-ID: <YfPChJvNqzPhrdRX@kroah.com>
References: <20220124170411.58169-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124170411.58169-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:04:09AM +0800, Zhou Qingyang wrote:
> In bttv_s_fbuf(), the return value of videobuf_sg_alloc() is assigned
> to variable new and there is a dereference of it after that. the return
> value of videobuf_sg_alloc() could be NULL on failure of allocation,
> which could lead to a NULL pointer dereference.
> 
> Fix this bug by adding a NULL check of new.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code
> 
> Fixes: 402aa76aa5e5 ("V4L/DVB (6911): Converted bttv to use video_ioctl2")
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
>  drivers/media/pci/bt8xx/bttv-driver.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
> index 5aa46593ddc6..c0664cffb881 100644
> --- a/drivers/media/pci/bt8xx/bttv-driver.c
> +++ b/drivers/media/pci/bt8xx/bttv-driver.c
> @@ -2627,6 +2627,8 @@ static int bttv_s_fbuf(struct file *file, void *f,
>  			struct bttv_buffer *new;
>  
>  			new = videobuf_sg_alloc(sizeof(*new));
> +			if (!new)
> +				return -ENOMEM;
>  			new->crop = btv->crop[!!fh->do_crop].rect;
>  			bttv_overlay_risc(btv, &fh->ov, fh->ovfmt, new);
>  			retval = bttv_switch_overlay(btv, fh, new);
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

