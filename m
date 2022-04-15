Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C79E503166
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356256AbiDOWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiDOWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:05:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4E3AA60
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BDD4B8311F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B080C385A4;
        Fri, 15 Apr 2022 22:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650060165;
        bh=jMIyyGQ4CRdsA1X7oxI8CTQb0IBKbJqeD84G5GJpvrs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DXvqR0Keim+tfwUUwYyM6574yaiWEcj28C/cHng/0XCSegk9hetkQruScA8hrYQlS
         /ZD/C1AjvTcFvA+XXBN77pc/acwLax0/RDIpW6c218usILvr5ehxi1F/0eyj6WXzi0
         O1cDrfH+NOQVSkSKclpyrjWv3CIlYFatU0R4G+J4pyaE20kPRekBJxB7JLzPqRIi6V
         30Zgqtkgwwv4XNEXn71dvq+Z2MUUCB9bMJs4PyIAj1Q+y/GnNOBNaGU0Est8neT7EQ
         qOK3sD4Gg9vLArJLSsNa+wTCI6qfW56EyOoPpLezZK1AlyLe43X1zlkbJFNu3ymWJS
         /vTcXwOaDkD2w==
Date:   Fri, 15 Apr 2022 15:02:45 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
In-Reply-To: <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com> <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Call xen_virtio_setup_dma_ops() only for Xen-aware virtio devices
> in Xen guests if restricted access to the guest memory is enabled.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
>  include/xen/arm/xen-ops.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
> index 621da05..28b2ad3 100644
> --- a/include/xen/arm/xen-ops.h
> +++ b/include/xen/arm/xen-ops.h
> @@ -2,12 +2,19 @@
>  #ifndef _ASM_ARM_XEN_OPS_H
>  #define _ASM_ARM_XEN_OPS_H
>  
> +#include <linux/virtio_config.h>
>  #include <xen/swiotlb-xen.h>
> +#include <xen/xen-ops.h>
>  
>  static inline void xen_setup_dma_ops(struct device *dev)
>  {
>  	if (xen_swiotlb_detect())
>  		dev->dma_ops = &xen_swiotlb_dma_ops;
> +
> +#ifdef CONFIG_XEN_VIRTIO
> +	if (arch_has_restricted_virtio_memory_access() && xen_is_virtio_device(dev))
> +		xen_virtio_setup_dma_ops(dev);
> +#endif

This makes sense overall. Considering that the swiotlb-xen case and the
virtio case are mutually exclusive, I would write it like this:

	if (arch_has_restricted_virtio_memory_access() && xen_is_virtio_device(dev))
		xen_virtio_setup_dma_ops(dev);
	else if (xen_swiotlb_detect())
		dev->dma_ops = &xen_swiotlb_dma_ops;

There is no need for #ifdef (also see other comments).
