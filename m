Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8927851A40E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352490AbiEDPct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352473AbiEDPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:32:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3546544A24
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5D07B82636
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB5C385A5;
        Wed,  4 May 2022 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651678146;
        bh=QIU27fzKTY/CQoj384QAnXrhZazknJGFeNmDxiM8zIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giXU8X8c7z0ilKqpw7teGTS4DvwGRzMpxd2AW4D9uMc+/VPDJaDAUYcBHtnRoqYs6
         IqEVCKwbC5uARb1XgtSSU9XkxvKiA34qpeFHvs/2bm0/hHzFmFThjt+LsOThxToR8M
         ZCH4E4y9pYA+I2wyIUAvsqsxxsrgbvkT+A9de7mI=
Date:   Wed, 4 May 2022 17:29:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Indan Zupancic <indan.zupancic@mep-info.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UIO: Let uio_pdrv_genirq support cached memory
Message-ID: <YnKbwVGwqp9n73sV@kroah.com>
References: <436ea1f019d26d28ab4fce4ee28f609b@mep-info.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436ea1f019d26d28ab4fce4ee28f609b@mep-info.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:52:53PM +0200, Indan Zupancic wrote:
> If 'cacheable' DT property exists, the memory mapping will be
> done with UIO_MEM_IOVA instead of the default UIO_MEM_PHYS.
> ---
>  Documentation/driver-api/uio-howto.rst | 3 ++-
>  drivers/uio/uio_pdrv_genirq.c          | 8 ++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/uio-howto.rst
> b/Documentation/driver-api/uio-howto.rst
> index 907ffa3b38f5..3cb48fc757d9 100644
> --- a/Documentation/driver-api/uio-howto.rst
> +++ b/Documentation/driver-api/uio-howto.rst
> @@ -413,7 +413,8 @@ probed with the ``"of_id"`` module parameter set to the
> ``"compatible"``
>  string of the node the driver is supposed to handle. By default, the
>  node's name (without the unit address) is exposed as name for the
>  UIO device in userspace. To set a custom name, a property named
> -``"linux,uio-name"`` may be specified in the DT node.
> +``"linux,uio-name"`` may be specified in the DT node. If a property
> +named ``cacheable`` exists, the memory will be mapped cacheable.
> 
>  Using uio_dmem_genirq for platform devices
>  ------------------------------------------
> diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
> index 63258b6accc4..269784ce0ba3 100644
> --- a/drivers/uio/uio_pdrv_genirq.c
> +++ b/drivers/uio/uio_pdrv_genirq.c
> @@ -115,6 +115,7 @@ static int uio_pdrv_genirq_probe(struct platform_device
> *pdev)
>  	struct uio_mem *uiomem;
>  	int ret = -EINVAL;
>  	int i;
> +	int memtype = UIO_MEM_PHYS;
> 
>  	if (node) {
>  		const char *name;
> @@ -132,7 +133,10 @@ static int uio_pdrv_genirq_probe(struct platform_device
> *pdev)
>  		else
>  			uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  						       "%pOFn", node);
> -
> +		if (of_get_property(node, "cacheable", NULL)) {
> +			dev_info(&pdev->dev, "%s cacheable\n", uioinfo->name);
> +			memtype = UIO_MEM_IOVA;
> +		}
>  		uioinfo->version = "devicetree";
>  		/* Multiple IRQs are not supported */
>  	}
> @@ -204,7 +208,7 @@ static int uio_pdrv_genirq_probe(struct platform_device
> *pdev)
>  			break;
>  		}
> 
> -		uiomem->memtype = UIO_MEM_PHYS;
> +		uiomem->memtype = memtype;
>  		uiomem->addr = r->start & PAGE_MASK;
>  		uiomem->offs = r->start & ~PAGE_MASK;
>  		uiomem->size = (uiomem->offs + resource_size(r)
> -- 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
