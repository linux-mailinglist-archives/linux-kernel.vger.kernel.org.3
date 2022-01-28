Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59D49F701
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347768AbiA1KRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:17:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39134 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbiA1KQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:16:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10DAEB8250F;
        Fri, 28 Jan 2022 10:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B971C340EB;
        Fri, 28 Jan 2022 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365012;
        bh=L1Ekx2OO3TF2p45CkBw+hlZqHckVYlcP5aDSAh4JfqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHCFDZxMW561/OdD+iu0QHkKIw1maK5XNk2YsZ1PqmE8GRcF6AWxmMGJL1QQu3SC/
         OVn7QpMRevsvNvWhvVcUZbjDsimxOCK+P+Q8zZJ/sIYW+H8SsFjxllLXIdmee1HPJd
         XkHLppmUxniry02AbQDgK/oLPj+VMc8B4fmiL5i8=
Date:   Fri, 28 Jan 2022 11:16:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: media/pci: Fix a NULL pointer dereference in
 cx23885_417_register()
Message-ID: <YfPCkRuJzmLbNxSY@kroah.com>
References: <20220124170611.58864-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124170611.58864-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:06:10AM +0800, Zhou Qingyang wrote:
> In cx23885_417_register(), the return value of cx23885_video_dev_alloc() 
> is assigned to dev->v4l_device() and there is a dereference of it after
> that. the return value of cx23885_video_dev_alloc() could be NULL on 
> failure of allocation, which could lead to a NULL pointer dereference.
> 
> Fix this bug by adding a NULL check of dev->v4l_device.
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
>  drivers/media/pci/cx23885/cx23885-417.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/pci/cx23885/cx23885-417.c b/drivers/media/pci/cx23885/cx23885-417.c
> index 434677bd4ad1..fcc9c1117ed1 100644
> --- a/drivers/media/pci/cx23885/cx23885-417.c
> +++ b/drivers/media/pci/cx23885/cx23885-417.c
> @@ -1521,6 +1521,8 @@ int cx23885_417_register(struct cx23885_dev *dev)
>  	/* Allocate and initialize V4L video device */
>  	dev->v4l_device = cx23885_video_dev_alloc(tsport,
>  		dev->pci, &cx23885_mpeg_template, "mpeg");
> +	if (!dev->v4l_device)
> +		return -ENOMEM;
>  	q = &dev->vb2_mpegq;
>  	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>  	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

