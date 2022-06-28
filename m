Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0918355E6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbiF1O7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347233AbiF1O7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A672B1B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656428346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aErs5J0PWDeHLJbFtfkDMT+d/kxZ2NI6oKnOd4kVTIE=;
        b=bAjeaTVYj7wyyKqN8lAeIDzmSJGFRGSYvbOZJazBeag5iUMzn6m2sE5F8EvULoCZTKNjZP
        6zFF//Clu1ZDTq0VRFLTSWRMohaaDECawPM7oTMCKnnY/zzmKPiXcha8RvdFJLLErtZqd/
        ejkL7ZAIBidAP8hiNAAsnWRQq/WHfpY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-_NIYT7YBOZ2X2INtPtrJuQ-1; Tue, 28 Jun 2022 10:59:05 -0400
X-MC-Unique: _NIYT7YBOZ2X2INtPtrJuQ-1
Received: by mail-il1-f200.google.com with SMTP id u8-20020a056e021a4800b002d3a5419d1bso7447929ilv.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aErs5J0PWDeHLJbFtfkDMT+d/kxZ2NI6oKnOd4kVTIE=;
        b=dvJeSJL76Vzj0nOBqUQGt3CZwWTUM9nCNvvzN8dIDy/rG35EWadN/yXtgt6K0PZNxP
         kH7AP9DmhMshge2AHpjpktIvDndERCNVceySUPcFpzhgJdSVBZd4sRwel5snDQtWyEfb
         9sU0fgIdL9kuVWWrsypuqP0Hp+s4yBR+m/RcWQi7RjnuKAhpzTUJzDe2+Pl1MyGpy1Xb
         JcqY1Bt09dH6TD0kTTfBwBmAkZHBUOl9Xhbkr1SskpGeNRBvzWleVj8T+DCNIH+5tqij
         OHAwrrDBHMRdmY/9NSfke8qwpRuaATqCUt6SvGNZMnjFfsoOuEgp9cn0SDC29YUgn6xW
         59oA==
X-Gm-Message-State: AJIora+PZ0rjauYMOCmLghKoAYi7zVaZaOf/uRh+cAfYrtqHUtIPlbi2
        Hw+QDT8La+XRgUXiqKw4+w/CVIW0NlJNtnWPsq7yEh0v/0dBd6WSwhh/Ewv2ZUTo4Td2UXodX4H
        HjrdJaA4HF+VdvyI2ePA/OTLx
X-Received: by 2002:a05:6602:1d4:b0:672:4ea0:e34a with SMTP id w20-20020a05660201d400b006724ea0e34amr9399837iot.107.1656428344725;
        Tue, 28 Jun 2022 07:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ufpxgA/kaaUg+eSobaX7s+4Q0m1hZPsKdJjvg6M//DeHs6h8kNvyoKWaVYQFIRjH52wQRQtQ==
X-Received: by 2002:a05:6602:1d4:b0:672:4ea0:e34a with SMTP id w20-20020a05660201d400b006724ea0e34amr9399813iot.107.1656428344519;
        Tue, 28 Jun 2022 07:59:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id bm13-20020a05663842cd00b0032ead96ee5csm5987285jab.165.2022.06.28.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:59:04 -0700 (PDT)
Date:   Tue, 28 Jun 2022 08:59:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        jgg@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 17/21] vfio-pci/zdev: add open/close device hooks
Message-ID: <20220628085902.208c106e.alex.williamson@redhat.com>
In-Reply-To: <20220606203325.110625-18-mjrosato@linux.ibm.com>
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
        <20220606203325.110625-18-mjrosato@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jun 2022 16:33:21 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> During vfio-pci open_device, pass the KVM associated with the vfio group
> (if one exists).  This is needed in order to pass a special indicator
> (GISA) to firmware to allow zPCI interpretation facilities to be used
> for only the specific KVM associated with the vfio-pci device.  During
> vfio-pci close_device, unregister the notifier.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 10 +++++++++-
>  drivers/vfio/pci/vfio_pci_zdev.c | 24 ++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    | 10 ++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a0d69ddaf90d..b1e5cfbadf38 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -316,10 +316,14 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		pci_write_config_word(pdev, PCI_COMMAND, cmd);
>  	}
>  
> -	ret = vfio_config_init(vdev);
> +	ret = vfio_pci_zdev_open_device(vdev);
>  	if (ret)
>  		goto out_free_state;
>  
> +	ret = vfio_config_init(vdev);
> +	if (ret)
> +		goto out_free_zdev;
> +
>  	msix_pos = pdev->msix_cap;
>  	if (msix_pos) {
>  		u16 flags;
> @@ -340,6 +344,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  
>  	return 0;
>  
> +out_free_zdev:
> +	vfio_pci_zdev_close_device(vdev);
>  out_free_state:
>  	kfree(vdev->pci_saved_state);
>  	vdev->pci_saved_state = NULL;
> @@ -418,6 +424,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	vdev->needs_reset = true;
>  
> +	vfio_pci_zdev_close_device(vdev);
> +
>  	/*
>  	 * If we have saved state, restore it.  If we can reset the device,
>  	 * even better.  Resetting with current state seems better than
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index ea4c0d2b0663..686f2e75e392 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -11,6 +11,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
>  #include <linux/vfio_zdev.h>
> +#include <linux/kvm_host.h>
>  #include <asm/pci_clp.h>
>  #include <asm/pci_io.h>
>  
> @@ -136,3 +137,26 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  
>  	return ret;
>  }
> +
> +int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	if (!vdev->vdev.kvm)
> +		return 0;
> +
> +	return kvm_s390_pci_register_kvm(zdev, vdev->vdev.kvm);
> +}
> +
> +void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev || !vdev->vdev.kvm)
> +		return;
> +
> +	kvm_s390_pci_unregister_kvm(zdev);
> +}
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 63af2897939c..d5d9e17f0156 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -209,12 +209,22 @@ static inline int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)
>  #ifdef CONFIG_VFIO_PCI_ZDEV_KVM
>  extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				       struct vfio_info_cap *caps);
> +int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
> +void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> +{
> +	return 0;
> +}
> +
> +static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> +{}
>  #endif
>  
>  /* Will be exported for vfio pci drivers usage */

