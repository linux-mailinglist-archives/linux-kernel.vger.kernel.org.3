Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B852DAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiESRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiESRG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B83454248F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652979986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRL5o/FQVle6yNv8MI9P3EbCDe/tXM8yzChiqerKbfo=;
        b=BuzvswUQL7U8jPACMK+J8CwEFhbfGG2pDDusC9oGN8b3PpwZBobswmWw5Kz2Xc6hU4v/iu
        xjugkkm1qfqWRJQHRjZg6P/ehLVH1PODEnFwSrq0trOhCa7YjkLhemwzU42unujogi7HGn
        OCYsJJVRzWfXCStlE0B2zajKcZjC8+c=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-qHh03Xe1MEKgMeKZ7QK2BQ-1; Thu, 19 May 2022 13:06:25 -0400
X-MC-Unique: qHh03Xe1MEKgMeKZ7QK2BQ-1
Received: by mail-il1-f197.google.com with SMTP id h19-20020a056e021d9300b002d11f6f002bso3511879ila.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fRL5o/FQVle6yNv8MI9P3EbCDe/tXM8yzChiqerKbfo=;
        b=CqwfR9rmuegNwllVSQH/CiYpA3xd+JyIziQoJx/JaEUCf3NifzP5fUPFKMtfP5nvQL
         H/YB/aA7tkYxozUs12w4zUu4g4dB63mYwCopacO6DhAeojyZI992jL3kkcmwjw88rV+2
         var7HGf6XAC+lPuny639vYM92NiKWRidPNhG9bs6JJIrWl5xf7jmXJjmr403YEPi8QFA
         rp/J7F0gBHSrjs36WHH5pLPNkhzOuBuDIJ8nvQf7+bZ4K7R2Cq9icW8X/4G7ISG2sx9b
         Tu4KD4UUR1weLzVBCDRoyWwLAifPyvBJddiPhEUbLaiUlgTpPXS1UhC8cO2xf5Gb+ub7
         jteg==
X-Gm-Message-State: AOAM533SXWhZc46PaVC1gpiTdZmqI3JiaxCyV/kPTFm2EAndi+CcL0f4
        WC/lyjbnSc4tVbOv4j6bqVpfVutzrW2T6zdR+SKaRsH29lQqwLG6rHPlo71y8P3OMdpTyvT9YDa
        sDL+w1ttLN+0wvvp2trZcyzZa
X-Received: by 2002:a05:6e02:17ca:b0:2d1:409f:b088 with SMTP id z10-20020a056e0217ca00b002d1409fb088mr3352189ilu.92.1652979984719;
        Thu, 19 May 2022 10:06:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyFo4F3ERGBEdtU5xkpoaJeFSgi4OWnY2QMaC/0WPrUhvtcrp0n83HluBTJpmKGEgTGWOXig==
X-Received: by 2002:a05:6e02:17ca:b0:2d1:409f:b088 with SMTP id z10-20020a056e0217ca00b002d1409fb088mr3352176ilu.92.1652979984493;
        Thu, 19 May 2022 10:06:24 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id v189-20020a6bc5c6000000b0065a47e16f3asm858586iof.12.2022.05.19.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:06:24 -0700 (PDT)
Date:   Thu, 19 May 2022 11:06:22 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sheng Bi <windy.bi.enflame@gmail.com>
Cc:     helgaas@kernel.org, bhelgaas@google.com, lukas@wunner.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix no-op wait after secondary bus reset
Message-ID: <20220519110622.6fd065d2.alex.williamson@redhat.com>
In-Reply-To: <20220518115432.76183-1-windy.bi.enflame@gmail.com>
References: <20220516165740.6256af51.alex.williamson@redhat.com>
        <20220518115432.76183-1-windy.bi.enflame@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 19:54:32 +0800
Sheng Bi <windy.bi.enflame@gmail.com> wrote:

> pci_bridge_secondary_bus_reset() triggers SBR followed by 1 second sleep,
> and then uses pci_dev_wait() for waiting device ready. The dev parameter
> passes to the wait function is currently the bridge itself, but not the
> device been reset.
> 
> If we call pci_bridge_secondary_bus_reset() to trigger SBR to a device,
> there is 1 second sleep but not waiting device ready, since the bridge
> is always ready while resetting downstream devices. pci_dev_wait() here
> is a no-op actually. This would be risky in the case which the device
> becomes ready after more than 1 second, especially while hotplug enabled.
> The late coming hotplug event after 1 second will trigger hotplug module
> to remove/re-insert the device.
> 
> Instead of waiting ready of bridge itself, changing to wait all the
> downstream devices become ready with timeout PCIE_RESET_READY_POLL_MS
> after SBR, considering all downstream devices are affected during SBR.
> Once one of the devices doesn't reappear within the timeout, return
> -ENOTTY to indicate SBR doesn't complete successfully.
> 
> Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")
> Signed-off-by: Sheng Bi <windy.bi.enflame@gmail.com>
> ---
>  drivers/pci/pci.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index eb7c0a08ff57..32b7a5c1fa3a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5049,6 +5049,34 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  	}
>  }
>  
> +static int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
> +{
> +	struct pci_dev *dev;
> +	int delay = 0;
> +
> +	if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
> +		return 0;
> +
> +	list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
> +		while (!pci_device_is_present(dev)) {
> +			if (delay > timeout) {
> +				pci_warn(dev, "not ready %dms after secondary bus reset; giving up\n",
> +					delay);
> +				return -ENOTTY;
> +			}
> +
> +			msleep(20);
> +			delay += 20;

Your previous version used the same exponential back-off as used in
pci_dev_wait(), why the change here to poll at 20ms intervals?  Thanks,

Alex

> +		}
> +
> +		if (delay > 1000)
> +			pci_info(dev, "ready %dms after secondary bus reset\n",
> +				delay);
> +	}
> +
> +	return 0;
> +}
> +
>  void pci_reset_secondary_bus(struct pci_dev *dev)
>  {
>  	u16 ctrl;
> @@ -5092,7 +5120,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
>  	pcibios_reset_secondary_bus(dev);
>  
> -	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> +	return pci_bridge_secondary_bus_wait(dev, PCIE_RESET_READY_POLL_MS);
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>  
> 
> base-commit: 617c8a1e527fadaaec3ba5bafceae7a922ebef7e

