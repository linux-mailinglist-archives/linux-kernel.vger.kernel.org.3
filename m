Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE8553AC1D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356398AbiFARmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354124AbiFARmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:42:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B289F53728
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:42:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cx11so2713285pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tv+lrJqQ4Et9gRDXAG4uoZgL+FzMyJaBz4gkWA0oo5U=;
        b=CEBnpwn7U8OOk2f91B9RzYtl5plgtoA6dQd0KO6OZZqujXGWSQ0c8e3hqmG5vJKa4S
         23N7rY52Mu0KLNHSCkGA69MgZ/XrSpktd+3Hk9AeLccvgQdZiXb/JocKbvzGwaVv8c/O
         wUAAlO/432IEqXF2/0b4ZIZKaARt35imKrx4Cc9WBrE7MGVCINVDJQAq0atRb2V2ks8N
         viSSVCeuHE4vAtviTM49W9Sf/qaRiWp3o59fFCYgZyJdDN3riC0MaLRBwHh92FOzqKxC
         MkfoQ6s7N2UtBM7Fp5tDOmS/Di8e/0k2BB4Sc2XlXIdigGNchLDR22gV/bqcmZNJEd7T
         n6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tv+lrJqQ4Et9gRDXAG4uoZgL+FzMyJaBz4gkWA0oo5U=;
        b=mb94mngsOMbSVIVA7QRGAlH9gfokSAOeN8xgWlBL/RFjFe5JHS8rlaHIQ7Ked4eXWj
         3nN2qNIDzoISvCiaI+e4z22W2wtpEnoik2R/EJIa3G6hG/pynhTbug+oPYHT22SolWrh
         7KyJ/OVOrdZ0AJcWHoYC2o9VVnF+iALoEbBbx8AWgfdgKtJragcBrDmZKRpdcWFmMkcJ
         fUB8+ZWhs2/6GBHRujBSfTUfmNxECyH/ggPak5kzgA78aVejyvO1Hvo7JbQH/94pRVz2
         EiEzZOxPlvkyqL5dZvb9Gskrd7muJwW+LGgTvXca175LnMxDoDo7l4pmnI1Ydc2acubs
         Oa3Q==
X-Gm-Message-State: AOAM531QibzAqmdOwqMVFRkWbKo59QGc20Wd7R4t76gIY6Zx4KG8w0cY
        Uzlr3s+QKYhJnGFaOK/Ek2KQpK/mQpnnCg==
X-Google-Smtp-Source: ABdhPJw2yoeUzjbSj9ybeuQTKhogIf8O8EKVnSQU7o4hWlgDt6lfiDzhSUwWuNKXeuDUnfNfGDALIg==
X-Received: by 2002:a17:90a:8b18:b0:1e0:b1cd:aa9a with SMTP id y24-20020a17090a8b1800b001e0b1cdaa9amr35619537pjn.103.1654105323224;
        Wed, 01 Jun 2022 10:42:03 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 193-20020a6215ca000000b0050dc76281a4sm1782788pfv.126.2022.06.01.10.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:42:01 -0700 (PDT)
Date:   Wed, 1 Jun 2022 11:41:59 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [RFC PATCH v5 2/4] remoteproc: core: Introduce
 rproc_register_rvdev function
Message-ID: <20220601174159.GD531268@p14s>
References: <20220406095446.1187968-1-arnaud.pouliquen@foss.st.com>
 <20220406095446.1187968-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406095446.1187968-3-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 11:54:44AM +0200, Arnaud Pouliquen wrote:
> The rproc structure contains a list of registered rproc_vdev structure.

This should be rproc_rvdev.

> To be able to move the management of the rproc_vdev structure in
> remoteproc_virtio.c (i.e rproc_rvdev_add_device and
> rproc_rvdev_remove_device functions), introduce the rproc_register_rvdev
> and rproc_unregister_rvdev functions.

The name of those functions doesn't match the content of the patch.

> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 3a469220ac73..081bea39daf4 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -484,6 +484,18 @@ static int copy_dma_range_map(struct device *to, struct device *from)
>  	return 0;
>  }
>  
> +static void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
> +{
> +	if (rvdev && rproc)
> +		list_add_tail(&rvdev->node, &rproc->rvdevs);
> +}
> +
> +static void rproc_remove_rvdev(struct rproc_vdev *rvdev)
> +{
> +	if (rvdev)
> +		list_del(&rvdev->node);
> +}
> +
>  static struct rproc_vdev *
>  rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
>  {
> @@ -547,7 +559,7 @@ rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
>  			goto unwind_vring_allocations;
>  	}
>  
> -	list_add_tail(&rvdev->node, &rproc->rvdevs);
> +	rproc_add_rvdev(rproc, rvdev);
>  
>  	rvdev->subdev.start = rproc_vdev_do_start;
>  	rvdev->subdev.stop = rproc_vdev_do_stop;
> @@ -576,7 +588,7 @@ static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
>  	}
>  
>  	rproc_remove_subdev(rproc, &rvdev->subdev);
> -	list_del(&rvdev->node);
> +	rproc_remove_rvdev(rvdev);

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	device_unregister(&rvdev->dev);
>  }
>  
> -- 
> 2.25.1
> 
