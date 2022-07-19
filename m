Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B263057A579
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbiGSRgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiGSRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBCC4C63A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 361C061542
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4BAC341C6;
        Tue, 19 Jul 2022 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658252176;
        bh=gDYE8ppwu4c1VBpCapCFmc8Ncr59buDgfCRpCfpBWao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ/tzIcYwRa/8vFPHrtwoZ3BQGroiMAvYMrUVB3PvCWLsfF/G0f/UfevKmHRyA0CP
         Lwen4a4231vb+tULXGgwtqcFCtu8tAzfv5TjBvW2Eyt6nYiZV4ihTCNnT6BJINjtHd
         bKWVdEAjLu7cqXSwJ30axvps5Gq329wcV5Gnt/xGbVCMeXcXfJy0YdC/cmgZs1znc2
         jNGI/WQ4uq4KId6yDE4GzKKfVRfA+bur5CcEGQqivTLpsILKKtjPaIgJk2yfviuY3Y
         yovmdFzePKMyFjghQStzwMmJyfM6uLFmc3RzZJ2AvAssPvo7t9MThV2FdGVnmZjObg
         IF4e6Io1MioiA==
Date:   Tue, 19 Jul 2022 18:36:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Subkhankulov Rustam <subkhankulov@ispras.ru>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: Re: [POSSIBLE BUG] iommu/io-pgtable-arm: possible dereferencing of
 NULL pointer
Message-ID: <20220719173610.GA14526@willie-the-truck>
References: <28df50012344fb1c925a7ceaf55ae400152ffb48.camel@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28df50012344fb1c925a7ceaf55ae400152ffb48.camel@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:20:06PM +0300, Subkhankulov Rustam wrote:
> Version: 5-19-rc6
> 
> In function '__arm_lpae_alloc_pages' pointer 'dev' is compared with 
> NULL at [drivers/iommu/io-pgtable-arm.c: 203]. This means that the 
> pointer can be NULL.
> 
> -----------------------------------------------------------------------
> 203 	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
> 204 			     gfp | __GFP_ZERO, order);
> -----------------------------------------------------------------------
> 
> Then, if cfg->coherent_walk == 0 at [drivers/iommu/io-pgtable-arm.c: 
> 209], function 'dma_map_single', which is defined as 
> 'dma_map_single_attrs', is called and pointer dev is passed as 
> first parameter.
> 
> -----------------------------------------------------------------------
> 209 	if (!cfg->coherent_walk) {
> 208 		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
> -----------------------------------------------------------------------
> 
> Therefore, pointer 'dev' passed to function 'dev_driver_string' 
> in macro 'dev_WARN_ONCE' at [include/linux/dma-mapping.h: 326], 
> where it is dereferenced at [drivers/base/core.c: 2091].
> 
> -----------------------------------------------------------------------
> 2083	const char *dev_driver_string(const struct device *dev)
> 2084	{
> 2085		struct device_driver *drv;
> 2086
> ---
> 2091		drv = READ_ONCE(dev->driver);
> -----------------------------------------------------------------------
> 
> Thus, if it is possible that 'dev' is null at the same time 
> that flag 'coherent_walk' is 0, then NULL pointer will be 
> dereferenced.
> 
> Should we somehow avoid NULL pointer dereference or is this 
> situation impossible and we should remove comparison with NULL?

I think 'dev' is only null in the case of the selftest initcall
(see arm_lpae_do_selftests()), and 'coherent_walk' is always true there.

Will
