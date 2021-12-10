Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C417A470506
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhLJQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:01:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236700AbhLJQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639151846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UjRrEEFV0RnFo1gRn0fkwiU82fcIwIzn2KvghaQzERo=;
        b=gme75gujrndD7S5ntXY3qaHieQs0fP9kqmc0LNEtHMA2zNaeiQuoLTIDtrcT04k6+rTwTT
        pN/KP64IS6OfXtus1cuUzyDtLFNWVPagTvCqqJmAF/oNH+qqo3Wd9VpBNCOZ0LJAlsa0Qx
        9fMEm0Nuveo71Vg3GsKOl3U1+cPvU0g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-cHGZISYfMbO1U-MnWqlcAg-1; Fri, 10 Dec 2021 10:57:25 -0500
X-MC-Unique: cHGZISYfMbO1U-MnWqlcAg-1
Received: by mail-qk1-f199.google.com with SMTP id o4-20020a05620a2a0400b0046dbce64beaso10722621qkp.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UjRrEEFV0RnFo1gRn0fkwiU82fcIwIzn2KvghaQzERo=;
        b=kudkDxgMGOFa/9TatqBamo1dIiismNqPBjdeU42RLRPXUtkua5yDxKRNV+RowC5NGI
         HTh57o9Vj8/qrMv6nf2PKy/ZkoHYu7E29OZ+mu/dwvaFVQWpAq/QflBcTYWoPqMS4o7D
         yNgEp6RRSnfB8KQP0MVIzJ9ya15D7tF7G30ktpjddVBCONh3raT65bL5ZZUfsaMkC7wZ
         gb1hxGsV2DPxohaMQzDF/PRy6Zp08t5pGaGgtkwgnNSHUGw08eeg0vkDP7aaOTIDwzCs
         h86DvQO8JChQ1gLWUswsQIsUEpeJGvWE45qzZH4UjQBCVYE9Y7r+Ts0HWIoGUT2CM2Ul
         gDxA==
X-Gm-Message-State: AOAM533TXDs7R3Mypn3o8l0o9xKIznk8AfaGbxTYqEuL5BNJPiwDHL7R
        UE77orhWdNFe/vSiDKAYUWlt/0hO2WAhfRv0CeAluU9j4kXD/XEE2fFQp0T5gOFB0ZGvrUyVhfT
        drVsEfMi83Jm89ha95WsCNCje
X-Received: by 2002:a05:6214:2623:: with SMTP id gv3mr26529282qvb.63.1639151844015;
        Fri, 10 Dec 2021 07:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzs+LzmUpOama6unBO927f2nSILl4Bmq0c61+mViRdU6k0JP+iu8wBoSgzkRmRq8fOU8h1alQ==
X-Received: by 2002:a05:6214:2623:: with SMTP id gv3mr26529251qvb.63.1639151843813;
        Fri, 10 Dec 2021 07:57:23 -0800 (PST)
Received: from steredhat (host-87-21-203-138.retail.telecomitalia.it. [87.21.203.138])
        by smtp.gmail.com with ESMTPSA id f1sm2185250qtf.74.2021.12.10.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:57:23 -0800 (PST)
Date:   Fri, 10 Dec 2021 16:57:19 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dapeng Mi <dapeng1.mi@intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: fix a typo in function "vp_modern_remove"
 comments.
Message-ID: <20211210155719.i3men2finfug47ux@steredhat>
References: <20211210073546.700783-1-dapeng1.mi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211210073546.700783-1-dapeng1.mi@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:35:46PM +0800, Dapeng Mi wrote:
>Function name "vp_modern_remove" in comments is written to
>"vp_modern_probe" incorrectly. Change it.
>
>Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
>---
> drivers/virtio/virtio_pci_modern_dev.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>index e11ed748e661..e8b3ff2b9fbc 100644
>--- a/drivers/virtio/virtio_pci_modern_dev.c
>+++ b/drivers/virtio/virtio_pci_modern_dev.c
>@@ -345,7 +345,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> EXPORT_SYMBOL_GPL(vp_modern_probe);
>
> /*
>- * vp_modern_probe: remove and cleanup the modern virtio pci device
>+ * vp_modern_remove: remove and cleanup the modern virtio pci device
>  * @mdev: the modern virtio-pci device
>  */
> void vp_modern_remove(struct virtio_pci_modern_device *mdev)
>-- 
>2.30.2
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

