Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4634C1FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiBWXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244880AbiBWXhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B52535A5BA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645659435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8aSBb/VoBYcQvKUpDDSg+cPg7cKg8nOk6XOiSIXQhhk=;
        b=b06AXcNdZZEfzKhWRc+jf79T/mDj9jFtRd8B1vIrjhvkG2EMbr+l6PRI36U+RzVjGPtOxC
        bhybJUn6zxTbOrM+1041i3AnP35Kq6IGKcWtGUr5XMa6r5fwz1XFeBylpuXJaOgcBq5qbT
        SJdqIbtdL0NrJ44pOSFO1NS51XEzVkA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-fsl3q_7jOtGY1K1w0hgIqg-1; Wed, 23 Feb 2022 18:37:14 -0500
X-MC-Unique: fsl3q_7jOtGY1K1w0hgIqg-1
Received: by mail-oo1-f72.google.com with SMTP id a22-20020a4a8dd6000000b0031c074ab4b1so300227ool.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8aSBb/VoBYcQvKUpDDSg+cPg7cKg8nOk6XOiSIXQhhk=;
        b=hwHkZzJ7uzUrYxy8mAX0xv9/LGZN0S0PITzR7gUkFOYocwBgbcch2aFnAnk0d3vLat
         cZrqAM2faTGw29u9fFUJGhc4ZOFW6auZYhchzADRpmIG1Wov1FE3qAIXswbfkG1Fwvtd
         OrCZVQdgjRCUqmgDl+iu3kt9ObNhPU7w0tySl4eatxjDMSPCFA3kTFmOZXN2vn6S0fVF
         CvcW0fJU/R1TJHYkROge3xspksm1SZr+hmV74P27cm1HPE2qET+oWxoaQgQnNIhGMp/r
         tnfVHQIHfzmooLT49KZuV/CtUgqkPaPwDuv+tO/TnzJqWE3y9pBC05B4MnqMXpBKXCdk
         JrZQ==
X-Gm-Message-State: AOAM532udHWl7+G2Q3z6+nmMXQfsdi7jp+NCf83xbQGMWiWcWDrIkmRi
        gyZWaKFO3KhBWGiUR59oN9sQZ/zqNaKpcDzvABUwbfV7dUWwzQhHIpu/uNA6BhmEj4e47HCLgvE
        nL/7z80tofgdwstoH1O8m2YDu
X-Received: by 2002:a05:6808:1406:b0:2d4:f822:578e with SMTP id w6-20020a056808140600b002d4f822578emr3871oiv.338.1645659433456;
        Wed, 23 Feb 2022 15:37:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznNClK9/UStphScNTKJaAAaGciiCfDkCBkb4WaYTlVNDrZwr4pfhqYR+GafH5TyVRk/JPZCw==
X-Received: by 2002:a05:6808:1406:b0:2d4:f822:578e with SMTP id w6-20020a056808140600b002d4f822578emr3863oiv.338.1645659433265;
        Wed, 23 Feb 2022 15:37:13 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 5sm481997otf.30.2022.02.23.15.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:37:12 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:37:11 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <jgg@nvidia.com>,
        <cohuck@redhat.com>, <mgurtovoy@nvidia.com>, <yishaih@nvidia.com>,
        <linuxarm@huawei.com>, <liulongfang@huawei.com>,
        <prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v5 6/8] hisi_acc_vfio_pci: Add helper to retrieve the PF
 qm data
Message-ID: <20220223163711.42c5d928.alex.williamson@redhat.com>
In-Reply-To: <20220221114043.2030-7-shameerali.kolothum.thodi@huawei.com>
References: <20220221114043.2030-1-shameerali.kolothum.thodi@huawei.com>
        <20220221114043.2030-7-shameerali.kolothum.thodi@huawei.com>
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

On Mon, 21 Feb 2022 11:40:41 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Provides a helper function to retrieve the PF QM data associated
> with a ACC VF dev. This makes use of the  pci_iov_get_pf_drvdata()
> to get PF drvdata safely. Introduces helpers to retrieve the ACC
> PF dev struct pci_driver pointers as this is an input into the
> pci_iov_get_pf_drvdata().
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c     |  6 ++++
>  drivers/crypto/hisilicon/sec2/sec_main.c      |  6 ++++
>  drivers/crypto/hisilicon/zip/zip_main.c       |  6 ++++
>  drivers/vfio/pci/hisilicon/Kconfig            |  7 +++++
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 30 +++++++++++++++++++
>  include/linux/hisi_acc_qm.h                   |  5 ++++
>  6 files changed, 60 insertions(+)
> 
> diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
> index ba4043447e53..80fb9ef8c571 100644
> --- a/drivers/crypto/hisilicon/hpre/hpre_main.c
> +++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
> @@ -1189,6 +1189,12 @@ static struct pci_driver hpre_pci_driver = {
>  	.driver.pm		= &hpre_pm_ops,
>  };
>  
> +struct pci_driver *hisi_hpre_get_pf_driver(void)
> +{
> +	return &hpre_pci_driver;
> +}
> +EXPORT_SYMBOL(hisi_hpre_get_pf_driver);

Curious why none of these are _GPL symbols.  Thanks,

Alex

