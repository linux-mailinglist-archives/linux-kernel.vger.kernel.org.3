Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34BB46DC8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbhLHT74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234014AbhLHT7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638993382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qG4PVtbNoLN8AVmrX8I4VEzhm2Rfsmwm+zKfClLGO8w=;
        b=Zl6r3PyKlMbSTFFAwDw+NatHJwsqT/tS1MVQ5TFpeIeiHmjOdA/XQBXncsNfwb2Coc03Nl
        BGVXyFeTj+HzaAw5sbFKHzQB9il7iAivRKq78fj9IqXQHRWMqgiAAwtalLzdMUNgZXNAHZ
        GHvTMbCw6nEYBjxGy3g534hiQCi5NzY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-t3eXp2VaOy6MPEbg9dPbYA-1; Wed, 08 Dec 2021 14:56:21 -0500
X-MC-Unique: t3eXp2VaOy6MPEbg9dPbYA-1
Received: by mail-wm1-f70.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so1828068wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qG4PVtbNoLN8AVmrX8I4VEzhm2Rfsmwm+zKfClLGO8w=;
        b=KATKugbhfQDygp+TDMU+PfC/OSCfD314EjzdbW7+8NBBkvf1FOaWO2PPlDvajb+Qdb
         3s4MNEHAV+JtqPwtLNFlnLFr7m2S1xUBkRNFCV6kiOwaXBB2j5/k13b2UYTiP0jw1rW3
         7ZRT//wgHeFz7m6uw1scVliyWmt91GkqXf6ROxUjUW7rq33cVaXgKvU/2VFtImW7Ha48
         wPAfSo6lzs5C1tnXJy7jTXRhxBIHyUHAwu3KbaU/EaqWhFYCnF0xwXUSdZlFmgs56J5Y
         TdGx34jgFqhdwc1u7S+g9UWG1j0ADVUDej1WFfGBerbhF96uPW2I9Bpc/ZxLOUe6eRfx
         CA5g==
X-Gm-Message-State: AOAM530Xqy2plbApYW/XbK7a0t/vgsB89IpQOgi7cD7Ruw82yQgr3ESh
        aAqpe7tWYHlRD2n70y48vUR6cq2s7gqAsUjiYXrfwh26DQ8gYCuwjTnpLXgRBm+Cw64wBkiG7d4
        711mCB6QzzVMq1qSxAqWl4yCl
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr891100wrz.159.1638993380129;
        Wed, 08 Dec 2021 11:56:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGLz8QJuT+yslhyH4pgav06KTCxu5937pbGMbW3hVwzuMPBhu7Mm6xS6Af8u9XCeDE2JmTJw==
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr891083wrz.159.1638993379958;
        Wed, 08 Dec 2021 11:56:19 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id y15sm4921076wry.72.2021.12.08.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:56:18 -0800 (PST)
Date:   Wed, 8 Dec 2021 14:56:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
Message-ID: <20211208144916-mutt-send-email-mst@kernel.org>
References: <20211203185522.692489-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203185522.692489-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 07:55:14PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When VIRTIO_PCI_LIB is not built-in but the alibaba driver is, the
> kernel runs into a link error:
> 
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
> eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
> eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
> eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
> eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
> eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
> x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':
> 
> Selecting VIRTIO_PCI_LIB_LEGACY is not sufficient here since that is
> only part of the VIRTIO_PCI_LIB support.
> 
> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Confused. These are all part of
drivers/virtio/virtio_pci_legacy_dev.c

and
obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o

what gives?


> ---
>  drivers/vdpa/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d037611..04466603021f 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -80,6 +80,7 @@ config VP_VDPA
>  
>  config ALIBABA_ENI_VDPA
>  	tristate "vDPA driver for Alibaba ENI"
> +	select VIRTIO_PCI_LIB
>  	select VIRTIO_PCI_LIB_LEGACY
>  	depends on PCI_MSI && X86
>  	help
> -- 
> 2.29.2

