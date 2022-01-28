Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7AC49F6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbiA1KRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344262AbiA1KQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:16:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D42C061748;
        Fri, 28 Jan 2022 02:16:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAB12B82515;
        Fri, 28 Jan 2022 10:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6E0C340E0;
        Fri, 28 Jan 2022 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365006;
        bh=aXFKQLcOD29T44S1AVz7fr49JBJ8TW2u/0pXBUvdriE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/EzRTWPRRDo9rnpTwxgH9Ov8siBFtU/hiXGLTQmD/9Ilseo/Zh5m3NzN0UoSTU3b
         5zl+bqcvOkann15pczsI1kqYEamXAUQLzAv2kr2JGuDsoWnJER073lqvZBbBi7gnow
         s2IPaDuG6WKtqJIapqr1JREI4Fx1W/2fKkd54zN8=
Date:   Fri, 28 Jan 2022 11:16:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Michael Schimek <mschimek@gmx.at>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: bttv: Fix a NULL pointer dereference in
 setup_window_lock()
Message-ID: <YfPCi3qijRdnHJFo@kroah.com>
References: <20220124170515.58519-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124170515.58519-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:05:13AM +0800, Zhou Qingyang wrote:
> In setup_window_lock(), the return value of videobuf_sg_alloc() is
> assigned to variable new and there is a dereference of it after
> that. the return value of videobuf_sg_alloc() could be NULL on
> failure of allocation, which could lead to a NULL pointer dereference.
> 
> Fix this bug by adding a NULL check of new.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: e5bd0260e7d3 ("V4L/DVB (5077): Bttv cropping support")
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
> index 8cc9bec43688..6338f98d845d 100644
> --- a/drivers/media/pci/bt8xx/bttv-driver.c
> +++ b/drivers/media/pci/bt8xx/bttv-driver.c
> @@ -2182,6 +2182,8 @@ static int setup_window_lock(struct bttv_fh *fh, struct bttv *btv,
>  		struct bttv_buffer *new;
>  
>  		new = videobuf_sg_alloc(sizeof(*new));
> +		if (!new)
> +			return -ENOMEM;
>  		new->crop = btv->crop[!!fh->do_crop].rect;
>  		bttv_overlay_risc(btv, &fh->ov, fh->ovfmt, new);
>  		retval = bttv_switch_overlay(btv,fh,new);
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

