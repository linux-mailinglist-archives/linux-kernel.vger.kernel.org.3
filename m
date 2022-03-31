Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457014EE2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiCaUbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiCaUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3F9B4E38B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648758570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNlFx2PooJMFm2xy1snu6RfmCBBcxtQoPC0oOQEAJxc=;
        b=I4+4Wo6bFCbFvIW14Vn6Ztkdm2QUGVRBMdSyj5yz5nPWb7GSGCiUdgbFm/tmaf98V7LgA1
        Nq4UB7IUIENdDegDVXcqUfbX05gxAaQtTSBn77jvAnFaDu3q4tWJG97rB4G/BXk9XXFAWU
        WrXDUnxXmb/P67EF10dkTfDXFQnnASA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-j_jZDBisPna5HVImVy8Fyg-1; Thu, 31 Mar 2022 16:29:28 -0400
X-MC-Unique: j_jZDBisPna5HVImVy8Fyg-1
Received: by mail-ed1-f72.google.com with SMTP id s9-20020a50d489000000b00418d556edbdso311617edi.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TNlFx2PooJMFm2xy1snu6RfmCBBcxtQoPC0oOQEAJxc=;
        b=q6uQQYL2GcGUFsg4C7VaI5iLwv2B4zA/1xMTS/KF45r3uVSN0emgw7hKvL9pbyemvT
         hIbVqDpqsBDOvV3NM1PaVH9LjJx/m/QxJJWmquhluRNKYzd6QhHEF+NCEP+bW+NBQdnH
         Jblfop9Gvt8Tp3SHRO+FynGRnbI5hKzY54Pbu7MRWQCJOnV/h2dDxzCqPV4CgXDLeYIM
         zj2C07lmPtjaJgGMvZ4W0hSbFENd2nkawbo1vDUxEOpdeZvSbG9UOes+3JiTrLeUK3+r
         1DwcyPJJjDMEKTV/Vg93hnugGy2ZmAWDPNokIWvGzEuW1+JIWGmRtDaz1+IJJu11nM/c
         sC4A==
X-Gm-Message-State: AOAM532vFQTl4A3is+aOUu+PmMeS65qhqJD+/tL5EN0q6N1WodvOF+kj
        vYKWjH5Nbvnfoj+pw9l1FOBfqtiCGq8K/+RPfED/czgzrUOiY/946nvHgnMarHihmn9yNNwfWR9
        gl9Bd/JPEyMbRoJq9D8ig6bed
X-Received: by 2002:a17:906:69c5:b0:6cf:d164:8b32 with SMTP id g5-20020a17090669c500b006cfd1648b32mr6446878ejs.233.1648758567235;
        Thu, 31 Mar 2022 13:29:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFvlcVRqREy8I/TC5GrsEtJG1laWJAB4YFvNef3zGZahgTDgLn3yOPFrprd6WT7iKiLrtgOw==
X-Received: by 2002:a17:906:69c5:b0:6cf:d164:8b32 with SMTP id g5-20020a17090669c500b006cfd1648b32mr6446867ejs.233.1648758566999;
        Thu, 31 Mar 2022 13:29:26 -0700 (PDT)
Received: from redhat.com ([2.55.151.201])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006d5b915f27dsm171256ejn.169.2022.03.31.13.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:29:26 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:29:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH] uio/uio_pci_generic: Introduce refcnt on open/release
Message-ID: <20220331162521-mutt-send-email-mst@kernel.org>
References: <1648692384-109967-1-git-send-email-yaohongbo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1648692384-109967-1-git-send-email-yaohongbo@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:06:24AM +0800, Yao Hongbo wrote:
> If two userspace programs both open the PCI UIO fd, when one
> of the program exits uncleanly, the other will cause IO hang
> due to bus-mastering disabled.

With two programs poking at the same device, how is this ever
supposed to work even while both are alive?

> It's a common usage for spdk/dpdk to use UIO.

Except people really should just use vfio ...

> So, introduce refcnt
> to avoid such problems.
> 
> Fixes: 865a11f("uio/uio_pci_generic: Disable bus-mastering on release")
> Reported-by: Xiu Yang <yangxiu.yx@alibaba-inc.com>
> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/uio/uio_pci_generic.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
> index e03f9b5..8add2cf 100644
> --- a/drivers/uio/uio_pci_generic.c
> +++ b/drivers/uio/uio_pci_generic.c
> @@ -31,6 +31,7 @@
>  struct uio_pci_generic_dev {
>  	struct uio_info info;
>  	struct pci_dev *pdev;
> +	atomic_t refcnt;
>  };
>  
>  static inline struct uio_pci_generic_dev *
> @@ -39,6 +40,14 @@ struct uio_pci_generic_dev {
>  	return container_of(info, struct uio_pci_generic_dev, info);
>  }
>  
> +static int open(struct uio_info *info, struct inode *inode)
> +{
> +	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> +
> +	atomic_inc(&gdev->refcnt);
> +	return 0;
> +}
> +
>  static int release(struct uio_info *info, struct inode *inode)
>  {
>  	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> @@ -51,7 +60,9 @@ static int release(struct uio_info *info, struct inode *inode)
>  	 * Note that there's a non-zero chance doing this will wedge the device
>  	 * at least until reset.
>  	 */
> -	pci_clear_master(gdev->pdev);
> +	if (atomic_dec_and_test(&gdev->refcnt))
> +		pci_clear_master(gdev->pdev);
> +
>  	return 0;
>  }
>  
> @@ -92,8 +103,11 @@ static int probe(struct pci_dev *pdev,
>  
>  	gdev->info.name = "uio_pci_generic";
>  	gdev->info.version = DRIVER_VERSION;
> +	gdev->info.open = open;
>  	gdev->info.release = release;
>  	gdev->pdev = pdev;
> +	atomic_set(&gdev->refcnt, 0);
> +
>  	if (pdev->irq && (pdev->irq != IRQ_NOTCONNECTED)) {
>  		gdev->info.irq = pdev->irq;
>  		gdev->info.irq_flags = IRQF_SHARED;
> -- 
> 1.8.3.1

