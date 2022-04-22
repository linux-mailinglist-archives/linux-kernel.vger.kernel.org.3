Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16E50C4BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiDVX0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiDVXZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:25:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1CF80234
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 214BAB83305
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 23:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6B6C385A0;
        Fri, 22 Apr 2022 23:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650668453;
        bh=Tt3wwME8ZrAnjoqNSv/eny+SL/xKTMCNW0YOwL5HtmU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pbkp72Syh6ze1/sVyi2ZMLT+cvAgwDIUvVnmDhf93VYSNywj5WeHzORptbyE6qnCp
         Kj0veLD6zjTWSl2azkAW3joi+nFnQJPt4r/40N62vmTbpV8HQk0UAypHp4iJt9mvhb
         VbCPtoxYVel6jnB7YSXPTl1xFeMsUV7fkRz+W0JFs6lfFbQiORL+7ALl8VgRQFMwzz
         WgbYAr7QXc/+YIBuhsGqgGJ/aWpcXxJ3bmWsmxsHklj4NSJDY+EbVYRYxltALvFvFn
         bOoCfKQq8f7CkYyjMLMJ9/2i1c3g7V8uz0QOmYsPhnz29cg0NlwTAulTy+D9D5kY0I
         zZC4ySq0Nur6w==
Date:   Fri, 22 Apr 2022 16:00:53 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V1 6/6] arm/xen: Assign xen-grant DMA ops for xen-grant
 DMA devices
In-Reply-To: <1650646263-22047-7-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204221537160.915916@ubuntu-linux-20-04-desktop>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com> <1650646263-22047-7-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> As the main (and single at the moment) purpose of xen-grant
> DMA devices is to enable using virtio devices in Xen guests
> in a safe manner, assign xen-grant DMA ops only if restricted
> access to the guest memory is enabled.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Changes RFC -> V1:
>    - update commit subject/description
>    - remove #ifdef CONFIG_XEN_VIRTIO
>    - re-organize the check taking into the account that
>      swiotlb and virtio cases are mutually exclusive
>    - update according to the new naming scheme:
>      s/virtio/grant_dma
> ---
>  include/xen/arm/xen-ops.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
> index 288deb1..26954e5 100644
> --- a/include/xen/arm/xen-ops.h
> +++ b/include/xen/arm/xen-ops.h
> @@ -2,12 +2,17 @@
>  #ifndef _ASM_ARM_XEN_OPS_H
>  #define _ASM_ARM_XEN_OPS_H
>  
> +#include <linux/virtio_config.h>
>  #include <xen/swiotlb-xen.h>
> +#include <xen/xen-ops.h>
>  
>  static inline void xen_setup_dma_ops(struct device *dev)
>  {
>  #ifdef CONFIG_XEN
> -	if (xen_swiotlb_detect())
> +	if (arch_has_restricted_virtio_memory_access() &&
> +			xen_is_grant_dma_device(dev))
> +		xen_grant_setup_dma_ops(dev);
> +	else if (xen_swiotlb_detect())
>  		dev->dma_ops = &xen_swiotlb_dma_ops;
>  #endif
>  }
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
