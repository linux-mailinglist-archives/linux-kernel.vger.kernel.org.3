Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CA505E43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347584AbiDRTOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347571AbiDRTN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:13:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710DD32EE6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02CBFB80E6E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDD1C385AA;
        Mon, 18 Apr 2022 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309076;
        bh=VegG9uE/cYW7iPEYsyywdBTiJppdUCAamOZypgp6yWg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dWKEoF6YDrqYBpKYvfAng6jhBLKMVcug1HKoz5+2L0SANk3CzFv06Gx4efZ7rQqom
         yoiB7TEUpR+DC0KRPMlEbkVOWEGrzBIlgQH0Xss/9Gwk94ImpPFBKRJj3w1Sege4SV
         l+SgzGOEzsHq9rUvnxfXSy58byJaX/PqgojrhXUXN+CniUyCzytq3UITOtzuB8qhYN
         uMJZP4NCtqRtorHPsjEjvxneczklbQvDrIG3Qpq+IeLtSzZqwCF8s6eb12AR9pvR0o
         C+X8FSqXeLzv22uwmwyy0S8kuDPOrc7QWkZkWTCOZVYN6hcOUHxkAr/TjiXDOpFQ9o
         DFmewThitLLsg==
Date:   Mon, 18 Apr 2022 12:11:16 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 4/6] virtio: Various updates to xen-virtio DMA ops
 layer
In-Reply-To: <84f5264c-6b98-6d56-b7ca-61c19dc502ca@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204181156280.915916@ubuntu-linux-20-04-desktop>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com> <1649963973-22879-5-git-send-email-olekstysh@gmail.com> <alpine.DEB.2.22.394.2204151302350.915916@ubuntu-linux-20-04-desktop> <84f5264c-6b98-6d56-b7ca-61c19dc502ca@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1608932710-1650308427=:915916"
Content-ID: <alpine.DEB.2.22.394.2204181201160.915916@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1608932710-1650308427=:915916
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2204181201161.915916@ubuntu-linux-20-04-desktop>

On Sun, 17 Apr 2022, Oleksandr wrote:
> On 16.04.22 01:02, Stefano Stabellini wrote:
> > On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
> > > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > 
> > > In the context of current patch do the following:
> > > 1. Update code to support virtio-mmio devices
> > > 2. Introduce struct xen_virtio_data and account passed virtio devices
> > >     (using list) as we need to store some per-device data
> > > 3. Add multi-page support for xen_virtio_dma_map(unmap)_page callbacks
> > > 4. Harden code against malicious backend
> > > 5. Change to use alloc_pages_exact() instead of __get_free_pages()
> > > 6. Introduce locking scheme to protect mappings (I am not 100% sure
> > >     whether per-device lock is really needed)
> > > 7. Handle virtio device's DMA mask
> > > 8. Retrieve the ID of backend domain from DT for virtio-mmio device
> > >     instead of hardcoding it.
> > > 
> > > Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > ---
> > >   arch/arm/xen/enlighten.c |  11 +++
> > >   drivers/xen/Kconfig      |   2 +-
> > >   drivers/xen/xen-virtio.c | 200
> > > ++++++++++++++++++++++++++++++++++++++++++-----
> > >   include/xen/xen-ops.h    |   5 ++
> > >   4 files changed, 196 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > > index ec5b082..870d92f 100644
> > > --- a/arch/arm/xen/enlighten.c
> > > +++ b/arch/arm/xen/enlighten.c
> > > @@ -409,6 +409,17 @@ int __init arch_xen_unpopulated_init(struct resource
> > > **res)
> > >   }
> > >   #endif
> > >   +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> > > +int arch_has_restricted_virtio_memory_access(void)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_XEN_HVM_VIRTIO_GRANT) && xen_hvm_domain())
> > > +		return 1;
> > Instead of xen_hvm_domain(), you can just use xen_domain(). Also there
> > is no need for the #ifdef
> > CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, given that:
> > 
> > CONFIG_XEN_HVM_VIRTIO_GRANT depends on XEN_VIRTIO which selects
> > ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> 
> 
> Yes, but please see my comments in commit #2 regarding
> CONFIG_XEN_HVM_VIRTIO_GRANT option and
> arch_has_restricted_virtio_memory_access() on Arm.
> 
> I propose to have the following on Arm:
> 
> int arch_has_restricted_virtio_memory_access(void)
> {
>      return xen_has_restricted_virtio_memory_access();
> }
> 
> 
> where common xen.h contain a helper to be used by both Arm and x86:
> 
> static inline int xen_has_restricted_virtio_memory_access(void)
> {
>      if (IS_ENABLED(CONFIG_XEN_VIRTIO) && (xen_pv_domain() ||
> xen_hvm_domain()))
>          return 1;
> 
>      return 0;
> }
> 
> 
> But I would be happy with what you propose as well.

As I wrote in the previous reply, I also prefer to share the code
between x86 and ARM, and I think it could look like:

int arch_has_restricted_virtio_memory_access(void)
{
     return xen_has_restricted_virtio_memory_access();
}
[...]
static inline int xen_has_restricted_virtio_memory_access(void)
{
     return (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain());
}

But let's check with Juergen and Boris.


> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
> > > +#endif
> > > +
> > >   static void __init xen_dt_guest_init(void)
> > >   {
> > >   	struct device_node *xen_node;
> > > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > > index fc61f7a..56afe6a 100644
> > > --- a/drivers/xen/Kconfig
> > > +++ b/drivers/xen/Kconfig
> > > @@ -347,7 +347,7 @@ config XEN_VIRTIO
> > >     config XEN_HVM_VIRTIO_GRANT
> > >   	bool "Require virtio for fully virtualized guests to use grant
> > > mappings"
> > > -	depends on XEN_VIRTIO && X86_64
> > > +	depends on XEN_VIRTIO && (X86_64 || ARM || ARM64)
> > you can remove the architectural dependencies
> 
> 
> According to the conversation in commit #2 we are considering just a single
> XEN_VIRTIO option, but it is going to has the
> same architectural dependencies: (X86_64 || ARM || ARM64)
> 
> By removing the architectural dependencies here, we will leave also X86_32
> covered (neither XEN_HVM_VIRTIO_GRANT nor XEN_PV_VIRTIO covered it). I don't
> know whether it is ok or not.
> 
> Shall I remove dependencies anyway?

No, good point. I don't know about X86_32. This is another detail where
Juergen or Boris should comment.
--8323329-1608932710-1650308427=:915916--
