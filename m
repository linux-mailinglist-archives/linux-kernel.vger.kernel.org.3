Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E052AC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351336AbiEQUDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbiEQUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C4CB3CFD3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652817782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZvQF1GwCmP4prUQjVWzJaiNAyuFxuT+W3i/r8i+LWA=;
        b=iXA6fvP7qtd01YwbV8wxwokQFKAS5ANoOHImNpEtlB69IsBaUh1N8mUMPcU5cgUi0PQH4M
        mQZa11iYLsZjDHas8xBLN0K0zED74YPmc4NlN7T5RULuYpxcS3hPdn/XtGFOOS6rBQfxQo
        9jvolQ/p3I4T+g7EIQEU8VD0CvdkIqA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-vQDGIQ-QMXO-Lb2cAI3YLw-1; Tue, 17 May 2022 16:03:01 -0400
X-MC-Unique: vQDGIQ-QMXO-Lb2cAI3YLw-1
Received: by mail-il1-f198.google.com with SMTP id n2-20020a056e021ba200b002d12462a1d1so48008ili.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dZvQF1GwCmP4prUQjVWzJaiNAyuFxuT+W3i/r8i+LWA=;
        b=UdhJL2bdMNUNvmK54ggxJ5RPXfdnz1ABVyCKyi3OfVYX4O4ZsBaO5mp3L0qsCRMrEI
         xvVhNU/UJnFmSaEZ5i+jGUlpdWF6b5/c47gI0NtESPyFB+awPIrIohsX9vG87gqUr64O
         tYJY6VxD7LtbB0hgqwrA0a81tEwahz7ctvkZ3nEQR3InbxnC0o/9Zdh6MtWvDwj1VZca
         nF7jpeVnPesby0owZUetL6sZmhM8P8e+oF7fO1qh6lpNXZihmZ85mb/QY5DxJkm7b2Ng
         Iu38b28c9PvjA2RlN6gDtX422H3y7/g8fSlAMBs+AjV2vIAjkndTqnfbM4PIH3tMJlJl
         H7qw==
X-Gm-Message-State: AOAM531U4gWp81CeBLD3awDtP8Nadxg6tsUy8xDiTEwj/jjcV8cq/YCZ
        zdkmDfnsilIzeOhJA+UB3JqOEYoKUM3IQtkLAYadg2HzbPn24u883SaX2EmmyrtuWEYXHblivq/
        nn/Mxe+nFFfvsnc7F+end9MOn
X-Received: by 2002:a05:6602:2b8e:b0:5e9:74e7:6b01 with SMTP id r14-20020a0566022b8e00b005e974e76b01mr11249794iov.127.1652817780434;
        Tue, 17 May 2022 13:03:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyntAUeW4lha2aGOg3y8Bptsqwfn5SzFR5laZVpBDYf/r+hBmSUEVPPsIAvMAoK3MIR7YXk7w==
X-Received: by 2002:a05:6602:2b8e:b0:5e9:74e7:6b01 with SMTP id r14-20020a0566022b8e00b005e974e76b01mr11249785iov.127.1652817780260;
        Tue, 17 May 2022 13:03:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z11-20020a056638214b00b0032b3a78174asm14307jaj.14.2022.05.17.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:02:59 -0700 (PDT)
Date:   Tue, 17 May 2022 14:02:59 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] vfio/pci: Move the unused device into low power
 state with runtime PM
Message-ID: <20220517140259.1021cf85.alex.williamson@redhat.com>
In-Reply-To: <20220517100219.15146-5-abhsahu@nvidia.com>
References: <20220517100219.15146-1-abhsahu@nvidia.com>
        <20220517100219.15146-5-abhsahu@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 15:32:19 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 4fe9a4efc751..5ea1b3099036 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -156,7 +156,7 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
>  }
>  
>  struct vfio_pci_group_info;
> -static bool vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set);
> +static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set);
>  static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  				      struct vfio_pci_group_info *groups);
>  
> @@ -275,6 +275,19 @@ void vfio_pci_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
>  	up_write(&vdev->memory_lock);
>  }
>  
> +#ifdef CONFIG_PM

Neither of the CONFIG_PM checks added are actually needed afaict, both
struct dev_pm_ops and the pm pointer on struct device_driver are defined
regardless.  Thanks,

Alex

