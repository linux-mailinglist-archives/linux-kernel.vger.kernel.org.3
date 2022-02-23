Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED34C1FED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244931AbiBWXjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbiBWXif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:38:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D2945A5A4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645659485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQseIfHyNHbxRxCOXDDjbxsPCfu7bqnMBIdUTwy6mvg=;
        b=M0EjJ+aZoVau9eCd5yPlEPOBTF+Fola8l2gwVMsKjbIRk2goaVuJFxZk6mo1MvZThODJfv
        FdfvaxAtY5nQ+1gvXGNuRegi2n1pkj171Hhvtws3Frv7iIrrxBlcVX7Xqx5tucgMOzsCRt
        Sw4kmdQAIfD32yHb4xvg7D2u2ydMMdE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-h3xkzUNTP1ed_xToa-LuVA-1; Wed, 23 Feb 2022 18:38:04 -0500
X-MC-Unique: h3xkzUNTP1ed_xToa-LuVA-1
Received: by mail-ot1-f71.google.com with SMTP id m7-20020a9d7e87000000b005af1551b419so152647otp.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=TQseIfHyNHbxRxCOXDDjbxsPCfu7bqnMBIdUTwy6mvg=;
        b=6GJA5wn6a66Zr2105FI8WLa/qf9PuRuDcgR68SYcYRUhiwc0qzWiy8Sq2Ld92VEVIr
         m9kUbep/11uPfwJHOPTCMn7Lxmbvlk4JkIQpsrlqmgZnqlHKlR/0Dz5424lkdyA4xjg7
         AIRDyqGzdfEkqIjuqgElfF6jQctvQxGrzQykd7AsYaEfT/yilWc0tXEGdzPYoBAdglnQ
         9bFT8/hdzDPyer/lK+lGw6FJQTxtD6EjH/et9ZhvjCZQpcvYqvFIx7wAEI5S2r0s4vRa
         FRcDWtP6oOKYzpL1vI5YxzQF25Amw5nsfiD/lwzUGZGwar8I1bVx9S+An+FmgeFvCTxq
         UJ0g==
X-Gm-Message-State: AOAM533OuPfnXJL1pmbbLJuoryc7VI+fykraRh1H+PsqTYJHvulLElkI
        eKfAjwO2edQFPdE8a5VOlLJQPLdYtLu0D3Y6EuK4JZZnW2a2WR+xIR8hOLSMi5qIXs5fl1z4MLn
        bcgabYeUbtFT0rWKduIWPY2ZT
X-Received: by 2002:a05:6808:1597:b0:2d4:c9fd:b11c with SMTP id t23-20020a056808159700b002d4c9fdb11cmr1090222oiw.319.1645659483401;
        Wed, 23 Feb 2022 15:38:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTOMQrxcWbrjZEEnIVd77niRF3IebauKAnN/LNVNCDSL2buHj2AtUPxw2dFUF8pky3GMpDWg==
X-Received: by 2002:a05:6808:1597:b0:2d4:c9fd:b11c with SMTP id t23-20020a056808159700b002d4c9fdb11cmr1090208oiw.319.1645659483191;
        Wed, 23 Feb 2022 15:38:03 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y17sm475713otk.70.2022.02.23.15.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:38:02 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:38:01 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <jgg@nvidia.com>,
        <cohuck@redhat.com>, <mgurtovoy@nvidia.com>, <yishaih@nvidia.com>,
        <linuxarm@huawei.com>, <liulongfang@huawei.com>,
        <prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v5 7/8] hisi_acc_vfio_pci: Add support for VFIO live
 migration
Message-ID: <20220223163801.10f32e99.alex.williamson@redhat.com>
In-Reply-To: <20220221114043.2030-8-shameerali.kolothum.thodi@huawei.com>
References: <20220221114043.2030-1-shameerali.kolothum.thodi@huawei.com>
        <20220221114043.2030-8-shameerali.kolothum.thodi@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 11:40:42 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> @@ -159,23 +1110,46 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>  
>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  {
> -	struct vfio_pci_core_device *vdev =
> -		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
> +			struct hisi_acc_vf_core_device, core_device.vdev);
> +	struct vfio_pci_core_device *vdev = &hisi_acc_vdev->core_device;
>  	int ret;
>  
>  	ret = vfio_pci_core_enable(vdev);
>  	if (ret)
>  		return ret;
>  
> -	vfio_pci_core_finish_enable(vdev);
> +	if (core_vdev->migration_flags != VFIO_MIGRATION_STOP_COPY) {

This looks like a minor synchronization issue with
hisi_acc_vfio_pci_migrn_init(), I think it might be cleaner to test
core_vdev->ops against the migration enabled set.

> +		vfio_pci_core_finish_enable(vdev);
> +		return 0;
> +	}
> +
> +	ret = hisi_acc_vf_qm_init(hisi_acc_vdev);
> +	if (ret) {
> +		vfio_pci_core_disable(vdev);
> +		return ret;
> +	}
>  
> +	hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;

Change the polarity of the if() above and encompass this all within
that branch scope so we can use the finish/return below for both cases?

> +
> +	vfio_pci_core_finish_enable(vdev);
>  	return 0;
>  }
>  
> +static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
> +			struct hisi_acc_vf_core_device, core_device.vdev);
> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +
> +	iounmap(vf_qm->io_base);
> +	vfio_pci_core_close_device(core_vdev);
> +}
> +
>  static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {
>  	.name = "hisi-acc-vfio-pci",
>  	.open_device = hisi_acc_vfio_pci_open_device,
> -	.close_device = vfio_pci_core_close_device,
> +	.close_device = hisi_acc_vfio_pci_close_device,
>  	.ioctl = hisi_acc_vfio_pci_ioctl,
>  	.device_feature = vfio_pci_core_ioctl_feature,
>  	.read = hisi_acc_vfio_pci_read,
> @@ -183,6 +1157,8 @@ static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {
>  	.mmap = hisi_acc_vfio_pci_mmap,
>  	.request = vfio_pci_core_request,
>  	.match = vfio_pci_core_match,
> +	.migration_set_state = hisi_acc_vfio_pci_set_device_state,
> +	.migration_get_state = hisi_acc_vfio_pci_get_device_state,
>  };
>  
>  static const struct vfio_device_ops hisi_acc_vfio_pci_ops = {
> @@ -198,38 +1174,71 @@ static const struct vfio_device_ops hisi_acc_vfio_pci_ops = {
>  	.match = vfio_pci_core_match,
>  };
>  
> +static int
> +hisi_acc_vfio_pci_migrn_init(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> +			     struct pci_dev *pdev, struct hisi_qm *pf_qm)
> +{
> +	int vf_id;
> +
> +	vf_id = pci_iov_vf_id(pdev);
> +	if (vf_id < 0)
> +		return vf_id;
> +
> +	hisi_acc_vdev->vf_id = vf_id + 1;
> +	hisi_acc_vdev->core_device.vdev.migration_flags =
> +					VFIO_MIGRATION_STOP_COPY;
> +	hisi_acc_vdev->pf_qm = pf_qm;
> +	hisi_acc_vdev->vf_dev = pdev;
> +	mutex_init(&hisi_acc_vdev->state_mutex);
> +
> +	return 0;
> +}
> +
>  static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> -	struct vfio_pci_core_device *vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev;
> +	struct hisi_qm *pf_qm;
>  	int ret;
>  
> -	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
> -	if (!vdev)
> +	hisi_acc_vdev = kzalloc(sizeof(*hisi_acc_vdev), GFP_KERNEL);
> +	if (!hisi_acc_vdev)
>  		return -ENOMEM;
>  
> -	vfio_pci_core_init_device(vdev, pdev, &hisi_acc_vfio_pci_ops);
> +	pf_qm = hisi_acc_get_pf_qm(pdev);
> +	if (pf_qm && pf_qm->ver >= QM_HW_V3) {
> +		ret = hisi_acc_vfio_pci_migrn_init(hisi_acc_vdev, pdev, pf_qm);
> +		if (ret < 0) {
> +			kfree(hisi_acc_vdev);
> +			return ret;
> +		}

This error path can only occur if the VF ID lookup fails, but should we
fall through to the non-migration ops, maybe with a dev_warn()?  Thanks,

Alex

> +
> +		vfio_pci_core_init_device(&hisi_acc_vdev->core_device, pdev,
> +					  &hisi_acc_vfio_pci_migrn_ops);
> +	} else {
> +		vfio_pci_core_init_device(&hisi_acc_vdev->core_device, pdev,
> +					  &hisi_acc_vfio_pci_ops);
> +	}

