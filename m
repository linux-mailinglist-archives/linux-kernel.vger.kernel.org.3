Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8620350CC4D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiDWQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiDWQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:35:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58B2F023
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tm0gSqV7/P9ncZVPB8LqYHR3Gz1xeU6baJ61OHE1BW8=; b=udvQngrutqjVgHNdHAkQtTYj4Z
        uj9eaEdm3fjU1uTVZOIo8pU0/Xxa1IKlKSUeYPCiWaC9FpsXAJEnJgqJz/yitw2wTHWU0tEc7LSB0
        X0fJM5ntfIPoWNdpv6L+CjuafNJPUUUUSwV8L4ktUqnMQ1hQBI8wsyqfk1dQwn/uh4gWv85fnhRh5
        /2X1dbCuYTh75gIu7ru2dCAx8PLj/duLjwK9+USlnlkZAl5R53zH9b1eckSJdfd8QiJmEOQ/WBdN7
        56vfH6cgCE6eS5U3OAlXcaMK1noDeWW7GbezDKIaRw7AZsWDTsNetOJKT90zCvQ8NQKBlrdbciioY
        HZy5IN0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niIgK-004dlm-8q; Sat, 23 Apr 2022 16:32:24 +0000
Date:   Sat, 23 Apr 2022 09:32:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Kees Cook <keescook@chromium.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V1 1/6] arm/xen: Introduce xen_setup_dma_ops()
Message-ID: <YmQqGOoNDwkKSbZr@infradead.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-2-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650646263-22047-2-git-send-email-olekstysh@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:50:58PM +0300, Oleksandr Tyshchenko wrote:
> +#ifndef _ASM_ARM_XEN_OPS_H
> +#define _ASM_ARM_XEN_OPS_H
> +
> +#include <xen/swiotlb-xen.h>
> +
> +static inline void xen_setup_dma_ops(struct device *dev)
> +{
> +#ifdef CONFIG_XEN
> +	if (xen_swiotlb_detect())
> +		dev->dma_ops = &xen_swiotlb_dma_ops;
> +#endif

Maybe create a proper !CONFIG_XEN stub for xen_swiotlb_detect instead
of the ifdef here, but otherwise this looks good to me.
