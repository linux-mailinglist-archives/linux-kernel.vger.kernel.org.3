Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C827250CC63
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiDWQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiDWQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:45:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1B3D1D4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BbU4qU1u+ib3z06jcjxtpWxewOhWeGRACT3SUClYfQU=; b=AhrDqdLN83fA5xLD4BM2GP2cPe
        ZPFamzRoBUWgZ6TueAJd/LnTpCkqpIraOwxxnFdhh10vSqfwomorASN5nrlTp8V9Dry0dnGRxjjEw
        v7JuhY6ox9FidKp5Hlp3HLTXDr3Vz4TBvr3dE48LvKPTfesNhxqNIb3L+LJJZDQI1E1E05OFk7nZJ
        fdgfnxdUNoQrEcTt1wwc5Cy5Dh82uK7C4oGDIf7aO2Wy+2OHkl7W87Jqi1aFlc6+I3039Se/GEDo3
        evKCQOC1ENaEsIIIjNzCQtGidYDx7645wDthEjcAzr29ZEXmNny8nn/OVrakWVtN9qIAf8TKvLahV
        rbi2qx6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niIpu-004etX-T8; Sat, 23 Apr 2022 16:42:18 +0000
Date:   Sat, 23 Apr 2022 09:42:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
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
Message-ID: <YmQsagqMn56jidFZ@infradead.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-7-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650646263-22047-7-git-send-email-olekstysh@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:51:03PM +0300, Oleksandr Tyshchenko wrote:
>  static inline void xen_setup_dma_ops(struct device *dev)
>  {
>  #ifdef CONFIG_XEN
> -	if (xen_swiotlb_detect())
> +	if (arch_has_restricted_virtio_memory_access() &&
> +			xen_is_grant_dma_device(dev))
> +		xen_grant_setup_dma_ops(dev);
> +	else if (xen_swiotlb_detect())

I don't think that arch_has_restricted_virtio_memory_access
check should be there as it still is a bit of a layering violation.

