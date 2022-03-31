Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD904EE2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbiCaUb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiCaUbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BC944ECC8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648758607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C9tkZ0sWDj5SRnNl4Qqaa2tLWJtytFn7iNzV9fK4gs=;
        b=Ai0wSJrfbAQMW38pUhOoBrLwbBw6miAt0vp229rPgVdQgTYUjJ9Wo4nPiYrBIElerpTYG5
        cDjkImZCFOxsYhSo+QR8em7pDrq3M0L5ZvCGa3aln0JLow42JTGQcSfsN54ol6hoiSupYL
        mQ1UxMPxUq6N/MtrjLjzbTumLZ7loJA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-2-wIVK8zO3Gfuy9aAZ3pIw-1; Thu, 31 Mar 2022 16:30:05 -0400
X-MC-Unique: 2-wIVK8zO3Gfuy9aAZ3pIw-1
Received: by mail-wm1-f69.google.com with SMTP id r82-20020a1c4455000000b0038c15a1ed8cso1833526wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4C9tkZ0sWDj5SRnNl4Qqaa2tLWJtytFn7iNzV9fK4gs=;
        b=Ap6RsAvYJShPomGEUvY+krMT/8zaBOVGDcuJx093YmDmV6tuJVWc6hDfbqK0Bo7CTj
         pg5e1myTR7PRfZ9/aCAtQTfKCU2p1V5bxlm9ucNfgRFLJkyx+KCXce/1kmObTyt3L9lL
         k6JrYrPoqjZ8ykfbK9PMGz77gwJdHTNfrSSm1/E2VKniLzm93GOg7HWghxW2mnP7jX1u
         UmqCAASty5BncOOlcm53LFNi4idunEEYb9zQ38egINVgcxD3N5UcDaU3VTmzfV7vxoBb
         QaRejkS3ACJMSyolQdfxELrI1X40JfSp2QYDse8BG+q99SJ8NE6eOkYPA+LbJrwTnatE
         wJQg==
X-Gm-Message-State: AOAM532nrmNt4Guyhl/yY4e7MTzqAGkg8+DAodhQ7yavRcmQ5jbnG5uQ
        qrj0YaT1RVLdXNzbj98vKYi9e0z9jq6i2jooLJmCoa2VVntVFBCKL54lwZfJoEo5OdyHBtxtEGr
        NUg5I5DxkHjDpxdTEiR96iuu9
X-Received: by 2002:a7b:c195:0:b0:38c:ea91:c0b3 with SMTP id y21-20020a7bc195000000b0038cea91c0b3mr6018348wmi.38.1648758604542;
        Thu, 31 Mar 2022 13:30:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKkVAV7cGUNTrAfsy+ak787QoCfLUdh3YBGnxRF0ryqMItgG6hdmWfn9EepYs8rgI8iRLaOQ==
X-Received: by 2002:a7b:c195:0:b0:38c:ea91:c0b3 with SMTP id y21-20020a7bc195000000b0038cea91c0b3mr6018336wmi.38.1648758604279;
        Thu, 31 Mar 2022 13:30:04 -0700 (PDT)
Received: from redhat.com ([2.55.151.201])
        by smtp.gmail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm343666wrh.87.2022.03.31.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:30:03 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:30:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH RESEND] uio/uio_pci_generic: Introduce refcnt on
 open/release
Message-ID: <20220331162952-mutt-send-email-mst@kernel.org>
References: <1648693432-129409-1-git-send-email-yaohongbo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1648693432-129409-1-git-send-email-yaohongbo@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:23:52AM +0800, Yao Hongbo wrote:
> If two userspace programs both open the PCI UIO fd, when one
> of the program exits uncleanly, the other will cause IO hang
> due to bus-mastering disabled.

With two programs poking at the same device, how is this ever
supposed to work even while both are alive?

> It's a common usage for spdk/dpdk to use UIO. So, introduce refcnt
> to avoid such problems.
> 
> Fixes: 865a11f("uio/uio_pci_generic: Disable bus-mastering on release")
> Reported-by: Xiu Yang <yangxiu.yx@alibaba-inc.com>
> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
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

