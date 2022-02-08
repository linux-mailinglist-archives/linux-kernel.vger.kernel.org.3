Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BAC4ADFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384378AbiBHRn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241855AbiBHRn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A222AC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644342204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTAtQQtX8ynRTOTjJerCkOOYhkWBiy04WDPWHFPH1vo=;
        b=Wd+6ZGHbb/6CvWy9FZTpSuRaPdJhZntm7ziR772mS+0VCpvQbC5/Jy/DU1oYetPd54muxP
        eyo8+CPX+4CFe3WDZm833hf3uJ5v/lFZ+HI6Jpzm057JiEABQZFBp0j5wbr8dE62CT520Y
        0Qchh7+0eQNsPytxFQMS3fVIzjFKmQs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-B1AfAqMiPKmdMBsSu0qI-Q-1; Tue, 08 Feb 2022 12:43:23 -0500
X-MC-Unique: B1AfAqMiPKmdMBsSu0qI-Q-1
Received: by mail-oo1-f69.google.com with SMTP id t10-20020a4ad0aa000000b002fd44c52176so11866388oor.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fTAtQQtX8ynRTOTjJerCkOOYhkWBiy04WDPWHFPH1vo=;
        b=J/rERayi0gX53PVYoX0g1ZyOJbNRMwKa/H11sgGjD65mAdgIG7Kwhq2eYkMfAKH9Ea
         iK4gCJEK+C7b/kLluqEmer3S8mMgKJ9xtucP1yC+91qqSQqEgQqYoaHohmJaO1oe7GPu
         9pVPNdzP3Uu8QoSZmSzmzFQ1spONxUBqs8kGsEsjvVgJhz8GqY2Rxz5+k13fT6OxABGb
         vfe25rRip6yLQYKLBP5DMhUUwzf84Oo/62y0ZakSBedk90atU/e1tXQWKSr7lc9SZjni
         hM6pQ5I/fufhe21dsLQlUDQkSvvj+8gaFfy1ZDhtK3oH84cF1ruWxzL0BQw7XOXco3jJ
         1BKg==
X-Gm-Message-State: AOAM532aoJALRhVSzWmEq36uHJliIkKd3RXygludm4lCI7BF+/X3uQIf
        kFuysy4DnRCjnArCBFsRr9h3UE73eaB2kU4kxf3DaWJFdYEsih3J0hlHImr0C64joUTP8KwkE+N
        EmJYO0eUICMUmqm29wdsnTuJE
X-Received: by 2002:a9d:7745:: with SMTP id t5mr2336028otl.254.1644342201839;
        Tue, 08 Feb 2022 09:43:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwO9ltSzIoG91Af/O1KWvnxNeiLqj6JxqFTQKli+Ed+9vVShlH1mHu2H9ZNDPJSfzOIE9vpMQ==
X-Received: by 2002:a9d:7745:: with SMTP id t5mr2336007otl.254.1644342201559;
        Tue, 08 Feb 2022 09:43:21 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 12sm6101166oaj.31.2022.02.08.09.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:43:21 -0800 (PST)
Date:   Tue, 8 Feb 2022 10:43:19 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 24/30] vfio-pci/zdev: wire up group notifier
Message-ID: <20220208104319.4861fb22.alex.williamson@redhat.com>
In-Reply-To: <20220204211536.321475-25-mjrosato@linux.ibm.com>
References: <20220204211536.321475-1-mjrosato@linux.ibm.com>
        <20220204211536.321475-25-mjrosato@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2022 16:15:30 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> KVM zPCI passthrough device logic will need a reference to the associated
> kvm guest that has access to the device.  Let's register a group notifier
> for VFIO_GROUP_NOTIFY_SET_KVM to catch this information in order to create
> an association between a kvm guest and the host zdev.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_pci.h  |  2 ++
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_zdev.c | 46 ++++++++++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    | 10 +++++++
>  4 files changed, 60 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_pci.h b/arch/s390/include/asm/kvm_pci.h
> index e4696f5592e1..16290b4cf2a6 100644
> --- a/arch/s390/include/asm/kvm_pci.h
> +++ b/arch/s390/include/asm/kvm_pci.h
> @@ -16,6 +16,7 @@
>  #include <linux/kvm.h>
>  #include <linux/pci.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <asm/pci_insn.h>
>  #include <asm/pci_dma.h>
>  
> @@ -32,6 +33,7 @@ struct kvm_zdev {
>  	u64 rpcit_count;
>  	struct kvm_zdev_ioat ioat;
>  	struct zpci_fib fib;
> +	struct notifier_block nb;
>  };
>  
>  int kvm_s390_pci_dev_open(struct zpci_dev *zdev);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f948e6cd2993..fc57d4d0abbe 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -452,6 +452,7 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  
>  	vfio_pci_vf_token_user_add(vdev, -1);
>  	vfio_spapr_pci_eeh_release(vdev->pdev);
> +	vfio_pci_zdev_release(vdev);
>  	vfio_pci_core_disable(vdev);
>  
>  	mutex_lock(&vdev->igate);
> @@ -470,6 +471,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_close_device);
>  void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
>  {
>  	vfio_pci_probe_mmaps(vdev);
> +	vfio_pci_zdev_open(vdev);
>  	vfio_spapr_pci_eeh_open(vdev->pdev);
>  	vfio_pci_vf_token_user_add(vdev, 1);
>  }

If this handling were for a specific device, I think we'd be suggesting
this is the point at which we cross over to a vendor variant making use
of vfio-pci-core rather than hooking directly into the core code.  But
this is meant to extend vfio-pci proper for the whole arch.  Is there a
compromise in using #ifdefs in vfio_pci_ops to call into zpci specific
code that implements these arch specific hooks and the core for
everything else?  SPAPR code could probably converted similarly, it
exists here for legacy reasons. [Cc Jason]

Also, please note the DEVICE_FEATURE generalizations in the latest
series from NVIDIA for mlx5 migration support:

https://lore.kernel.org/all/20220207172216.206415-8-yishaih@nvidia.com/

If this series were to go in via the s390 tree, I'd request a branch so
that we can continue to work on this in vfio code as well.  Thanks,

Alex

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index ea4c0d2b0663..9f8284499111 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -13,6 +13,7 @@
>  #include <linux/vfio_zdev.h>
>  #include <asm/pci_clp.h>
>  #include <asm/pci_io.h>
> +#include <asm/kvm_pci.h>
>  
>  #include <linux/vfio_pci_core.h>
>  
> @@ -136,3 +137,48 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  
>  	return ret;
>  }
> +
> +static int vfio_pci_zdev_group_notifier(struct notifier_block *nb,
> +					unsigned long action, void *data)
> +{
> +	struct kvm_zdev *kzdev = container_of(nb, struct kvm_zdev, nb);
> +
> +	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
> +		if (!data || !kzdev->zdev)
> +			return NOTIFY_DONE;
> +		kzdev->kvm = data;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +void vfio_pci_zdev_open(struct vfio_pci_core_device *vdev)
> +{
> +	unsigned long events = VFIO_GROUP_NOTIFY_SET_KVM;
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev)
> +		return;
> +
> +	if (kvm_s390_pci_dev_open(zdev))
> +		return;
> +
> +	zdev->kzdev->nb.notifier_call = vfio_pci_zdev_group_notifier;
> +
> +	if (vfio_register_notifier(vdev->vdev.dev, VFIO_GROUP_NOTIFY,
> +				   &events, &zdev->kzdev->nb))
> +		kvm_s390_pci_dev_release(zdev);
> +}
> +
> +void vfio_pci_zdev_release(struct vfio_pci_core_device *vdev)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev || !zdev->kzdev)
> +		return;
> +
> +	vfio_unregister_notifier(vdev->vdev.dev, VFIO_GROUP_NOTIFY,
> +				 &zdev->kzdev->nb);
> +
> +	kvm_s390_pci_dev_release(zdev);
> +}
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 5e2bca3b89db..05287f8ac855 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -198,12 +198,22 @@ static inline int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)
>  #ifdef CONFIG_VFIO_PCI_ZDEV
>  extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				       struct vfio_info_cap *caps);
> +void vfio_pci_zdev_open(struct vfio_pci_core_device *vdev);
> +void vfio_pci_zdev_release(struct vfio_pci_core_device *vdev);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline void vfio_pci_zdev_open(struct vfio_pci_core_device *vdev)
> +{
> +}
> +
> +static inline void vfio_pci_zdev_release(struct vfio_pci_core_device *vdev)
> +{
> +}
>  #endif
>  
>  /* Will be exported for vfio pci drivers usage */

