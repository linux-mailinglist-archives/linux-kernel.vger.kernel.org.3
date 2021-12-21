Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF247C6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhLUSrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbhLUSrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640112455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMJgqxOu6NETB3OMkfBKIVZjo/kuIriDF1hJexd9PzM=;
        b=Bs/b0/UdvT0skdQ6nbN7pf3g2YlbuHehL4AV959ixHyZUUXaauEZQYilKdN9zhbMQmmccP
        KS9EGMi6+i2kXWHSZK/bFThiy52Xfp2PZQRhAq4FfC2kB/KhA4GZ4Ya97uT1MuxsbL8rRD
        4EaXCondleixE3HaHjkhLqB1QWmUSfk=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-t_-8XtajM4C0KowwzMk9CQ-1; Tue, 21 Dec 2021 13:47:34 -0500
X-MC-Unique: t_-8XtajM4C0KowwzMk9CQ-1
Received: by mail-oo1-f70.google.com with SMTP id v2-20020a4ae6c2000000b002c622008d77so44860oot.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMJgqxOu6NETB3OMkfBKIVZjo/kuIriDF1hJexd9PzM=;
        b=ky9GZt8NcHQkk22wdXpauNBsYWMQAQw9jFjueGvH5pX6jQp7l1WdbZ6AIg5b6DhxCt
         OiTdUkzQ5F7o+rDdteJMCjX+E918VgfZW7n5WwKk2AVljqv1w4+KJNUbgrWPNrkb1Bxp
         t31HEKK6Y00p0R9PjyrKwsLDKF3dKpDpp0TE2c4ur/SPju4VFG036utQyHYxrqQkahi7
         Qpg8OPeJiwXGyAKA4gtrHpPovixdeSqaGOq+Skr/nm1kKs/Di4lBZBsU9mQ616Z9j4JV
         1Dhu6Rc2QsStHgmDf6xNSTMwAJbFFjNzadFND9W+OZfye1lDumtc3uXdAzs5XQ9VkpHc
         lECg==
X-Gm-Message-State: AOAM533AYW0alRDwQt6HNh5DQ2+omgk93CIdSQf9o1pLtlwmNc8cRzv0
        wgT5dtiWlDEHiCXe48mlqn6e10rvlom+3kJVzMK7229SMpoS6OI4vh0Ecf5o7oxdIqDsvxpUgUa
        ofZ7lTltkETzyDQOZc0xA389x
X-Received: by 2002:a4a:a44b:: with SMTP id w11mr2894072ool.66.1640112453918;
        Tue, 21 Dec 2021 10:47:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFK45DDoCU2XRxEstAIRZ1MmGBeMtD3eMoZ3u3pu7fxEDrFN8lOpeiB1zFxZ0v3QTOeosTvA==
X-Received: by 2002:a4a:a44b:: with SMTP id w11mr2894046ool.66.1640112453637;
        Tue, 21 Dec 2021 10:47:33 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id n26sm31334oij.5.2021.12.21.10.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:47:33 -0800 (PST)
Date:   Tue, 21 Dec 2021 11:47:31 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/32] vfio-pci/zdev: wire up group notifier
Message-ID: <20211221114731.21752d54.alex.williamson@redhat.com>
In-Reply-To: <20211207205743.150299-27-mjrosato@linux.ibm.com>
References: <20211207205743.150299-1-mjrosato@linux.ibm.com>
        <20211207205743.150299-27-mjrosato@linux.ibm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Dec 2021 15:57:37 -0500
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
>  drivers/vfio/pci/vfio_pci_zdev.c | 54 ++++++++++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    | 12 +++++++
>  4 files changed, 70 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_pci.h b/arch/s390/include/asm/kvm_pci.h
> index 97e3a369135d..6526908ac834 100644
> --- a/arch/s390/include/asm/kvm_pci.h
> +++ b/arch/s390/include/asm/kvm_pci.h
> @@ -17,6 +17,7 @@
>  #include <linux/kvm.h>
>  #include <linux/pci.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <asm/pci_insn.h>
>  #include <asm/pci_dma.h>
>  
> @@ -33,6 +34,7 @@ struct kvm_zdev {
>  	u64 rpcit_count;
>  	struct kvm_zdev_ioat ioat;
>  	struct zpci_fib fib;
> +	struct notifier_block nb;
>  };
>  
>  extern int kvm_s390_pci_dev_open(struct zpci_dev *zdev);
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
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index ea4c0d2b0663..cfd7f44b06c1 100644
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
> @@ -136,3 +137,56 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
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
> +		if (kvm_s390_pci_attach_kvm(kzdev->zdev, data))
> +			return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +int vfio_pci_zdev_open(struct vfio_pci_core_device *vdev)
> +{
> +	unsigned long events = VFIO_GROUP_NOTIFY_SET_KVM;
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	int ret;
> +
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	ret = kvm_s390_pci_dev_open(zdev);
> +	if (ret)
> +		return -ENODEV;
> +
> +	zdev->kzdev->nb.notifier_call = vfio_pci_zdev_group_notifier;
> +
> +	ret = vfio_register_notifier(vdev->vdev.dev, VFIO_GROUP_NOTIFY,
> +				     &events, &zdev->kzdev->nb);
> +	if (ret)
> +		kvm_s390_pci_dev_release(zdev);
> +
> +	return ret;

None of these error return paths are realized by the call site.  Thanks,

Alex

> +}
> +
> +int vfio_pci_zdev_release(struct vfio_pci_core_device *vdev)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev || !zdev->kzdev)
> +		return -ENODEV;
> +
> +	vfio_unregister_notifier(vdev->vdev.dev, VFIO_GROUP_NOTIFY,
> +				 &zdev->kzdev->nb);
> +
> +	kvm_s390_pci_dev_release(zdev);
> +
> +	return 0;
> +}
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 5e2bca3b89db..14079da409f1 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -198,12 +198,24 @@ static inline int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)
>  #ifdef CONFIG_VFIO_PCI_ZDEV
>  extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				       struct vfio_info_cap *caps);
> +int vfio_pci_zdev_open(struct vfio_pci_core_device *vdev);
> +int vfio_pci_zdev_release(struct vfio_pci_core_device *vdev);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int vfio_pci_zdev_open(struct vfio_pci_core_device *vdev)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int vfio_pci_zdev_release(struct vfio_pci_core_device *vdev)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  /* Will be exported for vfio pci drivers usage */

