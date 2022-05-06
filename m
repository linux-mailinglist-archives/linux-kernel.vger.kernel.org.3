Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F251DA3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442121AbiEFORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352292AbiEFORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:17:45 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EED3F68317
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651846442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6EwxLss5z9pqfmNAfnE+750spjOXcHfkOQWWavm7Z64=;
        b=UU4bChygMyu6Q2KSaonmzzLdUevkH8oMIFDdBRT+Sog0Mlb00mU+tHfkfWymK4m8Qy8Dcp
        hXc2osSD+/URTfQfFlxKPdvMRHHTNLlQp5zC3nJlS+WftZdx97EdNQlQ7lv0umoTa/041i
        3Q/Jcto6OrFir+VAEkZxCzUJdz9Kqwk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-oaabJTABN3Kd8yISprFEqg-1; Fri, 06 May 2022 10:14:00 -0400
X-MC-Unique: oaabJTABN3Kd8yISprFEqg-1
Received: by mail-ej1-f71.google.com with SMTP id sd38-20020a1709076e2600b006f3e54b1dbcso2536952ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6EwxLss5z9pqfmNAfnE+750spjOXcHfkOQWWavm7Z64=;
        b=6x/ckdrafJE0GMruBbbsvOF5ripXnllSuw3RZHG1ofhnH5RVxhTzqXHr1XQ8auALii
         npygG4CGQUpbHB8WEX67UUiuOUkbOr5ao/oZlt+xjTVdTqppupEU3atV6/e6JBA63Hlh
         X6wFb0Y7dscdcdCLnQQ99dswSqzxeHXBOlLAhR+cW7b7+PdOGP6hp0l38NalAUZPTTMF
         WPJwyhB7s0iv4x0spKVZccJ9Ss01TXXHAUzSsrop4uw9fyDV80n6fGexWRDvx5IOGHvw
         T6sLsInfJLt3p13iBgtFaJTuJH+lXGGQ45ZrFzdLy8xj5k6+F5x5jNZf0jVBdGRg3llF
         PLUA==
X-Gm-Message-State: AOAM530goak+QPkCkLztH2yn04YlvQ3A5m8yk2wUH/DGBrhV9GDDGPTM
        Z4lCfnB5l9KyNhxh0aX6lPhozfH5RfM9ubkwwdVJD3hRoFUmLTcxjUQAjuD4cMiXHmAH7KTiZoI
        IqoiuoMH1tC/5pE02PzXfLHbf
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id mp30-20020a1709071b1e00b006d731b0e821mr3152142ejc.334.1651846439145;
        Fri, 06 May 2022 07:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyckf4ruK6WdXTZnQq2U7aWMOvfIW+9+F+1UXGr2zoM6PiRjmvaqZw5/Ho5iGuSVQegyf/HHg==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id mp30-20020a1709071b1e00b006d731b0e821mr3152126ejc.334.1651846438898;
        Fri, 06 May 2022 07:13:58 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b006f3ef214e4asm1940876ejc.176.2022.05.06.07.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 07:13:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     vdasa@vmware.com
Cc:     pv-drivers@vmware.com, linux-kernel-review@vmware.com,
        Cyprien Laplace <claplace@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Bryan Tan <bryantan@vmware.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] VMCI: Add support for ARM64
In-Reply-To: <20220414193316.14356-1-vdasa@vmware.com>
References: <20220414193316.14356-1-vdasa@vmware.com>
Date:   Fri, 06 May 2022 16:13:57 +0200
Message-ID: <87levezr2y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdasa@vmware.com writes:

> From: Vishnu Dasa <vdasa@vmware.com>
>
> Add support for ARM64 architecture so that the driver can now be built
> and VMCI device can be used.
>
> Update Kconfig file to allow the driver to be built on ARM64 as well.
> Fail vmci_guest_probe_device() on ARM64 if the device does not support
> MMIO register access.  Lastly, add virtualization specific barriers
> which map to actual memory barrier instructions on ARM64, because it
> is required in case of ARM64 for queuepair (de)queuing.
>

FWIW, it seems you're doing three things at once, better split this into
a 3-patch series.

> Reviewed-by: Bryan Tan <bryantan@vmware.com>
> Reviewed-by: Cyprien Laplace <claplace@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> ---
>  drivers/misc/vmw_vmci/Kconfig           |  2 +-
>  drivers/misc/vmw_vmci/vmci_guest.c      |  4 ++++
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 12 ++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/vmw_vmci/Kconfig b/drivers/misc/vmw_vmci/Kconfig
> index 605794aadf11..b6d4d7fd686a 100644
> --- a/drivers/misc/vmw_vmci/Kconfig
> +++ b/drivers/misc/vmw_vmci/Kconfig
> @@ -5,7 +5,7 @@
>  
>  config VMWARE_VMCI
>  	tristate "VMware VMCI Driver"
> -	depends on X86 && PCI
> +	depends on (X86 || ARM64) && !CPU_BIG_ENDIAN && PCI
>  	help
>  	  This is VMware's Virtual Machine Communication Interface.  It enables
>  	  high-speed communication between host and guest in a virtual
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index 57a6157209a1..aa7b05de97dd 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -614,6 +614,10 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  	}
>  
>  	if (!mmio_base) {
> +		if (IS_ENABLED(CONFIG_ARM64)) {
> +			dev_err(&pdev->dev, "MMIO base is invalid\n");
> +			return -ENXIO;
> +		}
>  		error = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
>  		if (error) {
>  			dev_err(&pdev->dev, "Failed to reserve/map IO regions\n");
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index 94ebf7f3fd58..8f2de1893245 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -2577,6 +2577,12 @@ static ssize_t qp_enqueue_locked(struct vmci_queue *produce_q,
>  	if (result < VMCI_SUCCESS)
>  		return result;
>  
> +	/*
> +	 * This virt_wmb() ensures that data written to the queue
> +	 * is observable before the new producer_tail is.
> +	 */
> +	virt_wmb();
> +
>  	vmci_q_header_add_producer_tail(produce_q->q_header, written,
>  					produce_q_size);
>  	return written;
> @@ -2620,6 +2626,12 @@ static ssize_t qp_dequeue_locked(struct vmci_queue *produce_q,
>  	if (buf_ready < VMCI_SUCCESS)
>  		return (ssize_t) buf_ready;
>  
> +	/*
> +	 * This virt_rmb() ensures that data from the queue will be read
> +	 * after we have determined how much is ready to be consumed.
> +	 */
> +	virt_rmb();
> +
>  	read = (size_t) (buf_ready > buf_size ? buf_size : buf_ready);
>  	head = vmci_q_header_consumer_head(produce_q->q_header);
>  	if (likely(head + read < consume_q_size)) {

-- 
Vitaly

