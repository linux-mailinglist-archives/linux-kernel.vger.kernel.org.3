Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C249F70E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347810AbiA1KRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:17:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39448 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346361AbiA1KRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:17:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9139CB82510;
        Fri, 28 Jan 2022 10:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B666EC340E0;
        Fri, 28 Jan 2022 10:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365052;
        bh=7IY9KOWgCR5BpPK5LveSg3llEn4MIOAt9my1ok1ECak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0HtHGTZC61bd/7Hw2gWVVmvQPPSgIB3+eBK+N2dduFmUcu1uXGcwGDmD9aUxi1Xh
         wmYvSR4j+Kt6ZUplujn/2qy6AQvONxXUGqKx5LyCqNSDk51iEkPJRFKjXS+08pOcUS
         dQv2v5ggzRH8atl8I2H97Lksrp6hZWAqgUyNUoZw=
Date:   Fri, 28 Jan 2022 11:17:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tasos Sahanidis <tasos@tasossah.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: saa7134: Fix a NULL pointer dereference in
 saa7134_initdev()
Message-ID: <YfPCtGNkN0qfF4PV@kroah.com>
References: <20220124171931.62174-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124171931.62174-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:19:30AM +0800, Zhou Qingyang wrote:
> In saa7134_initdev(), the return value of vdev_init() is assigned to
> dev->video_dev and there is a dereference of it after that. The return
> value of vdev_init() will be NULL on the failure allocation, which could
> lead to NULL pointer dereference.
> 
> The same as dev->vbi_dev.
> 
> Fix this bug by adding a NULL check of dev->video_dev and dev->vbi_dev.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: a9622391acb ("V4L/DVB (6792): Fix VBI support")
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
>  drivers/media/pci/saa7134/saa7134-core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/media/pci/saa7134/saa7134-core.c b/drivers/media/pci/saa7134/saa7134-core.c
> index 96328b0af164..0de0b00540b6 100644
> --- a/drivers/media/pci/saa7134/saa7134-core.c
> +++ b/drivers/media/pci/saa7134/saa7134-core.c
> @@ -1202,6 +1202,11 @@ static int saa7134_initdev(struct pci_dev *pci_dev,
>  		pr_info("%s: Overlay support disabled.\n", dev->name);
>  
>  	dev->video_dev = vdev_init(dev,&saa7134_video_template,"video");
> +	if (!dev->video_dev) {
> +		err = -ENOMEM;
> +		goto err_unregister_video;
> +	}
> +
>  	dev->video_dev->ctrl_handler = &dev->ctrl_handler;
>  	dev->video_dev->lock = &dev->lock;
>  	dev->video_dev->queue = &dev->video_vbq;
> @@ -1224,6 +1229,11 @@ static int saa7134_initdev(struct pci_dev *pci_dev,
>  	       dev->name, video_device_node_name(dev->video_dev));
>  
>  	dev->vbi_dev = vdev_init(dev, &saa7134_video_template, "vbi");
> +	if (!dev->vbi_dev) {
> +		err = -ENOMEM;
> +		goto err_unregister_video;
> +	}
> +
>  	dev->vbi_dev->ctrl_handler = &dev->ctrl_handler;
>  	dev->vbi_dev->lock = &dev->lock;
>  	dev->vbi_dev->queue = &dev->vbi_vbq;
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

