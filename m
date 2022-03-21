Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38284E2EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351749AbiCURSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351741AbiCURSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:18:41 -0400
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9E064BFE;
        Mon, 21 Mar 2022 10:17:15 -0700 (PDT)
Received: by rosenzweig.io (Postfix, from userid 1000)
        id 567F241E29; Mon, 21 Mar 2022 17:17:14 +0000 (UTC)
Date:   Mon, 21 Mar 2022 17:17:14 +0000
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
Message-ID: <YjizGmjlAhyU6bC6@rosenzweig.io>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-5-sven@svenpeter.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Adds the region [paddr, paddr+size] to the DMA allow list.
> + *
> + * @sart: SART reference
> + * @paddr: Start address of the region to be used for DMA
> + * @size: Size of the region to be used for DMA.
> + */
> +int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
> +				  size_t size);
> +
> +/*
> + * Removes the region [paddr, paddr+size] from the DMA allow list.
> + *
> + * Note that exact same paddr and size used for apple_sart_add_allowed_region
> + * have to be passed.
> + *
> + * @sart: SART reference
> + * @paddr: Start address of the region no longer used for DMA
> + * @size: Size of the region no longer used for DMA.
> + */
> +int apple_sart_remove_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
> +				     size_t size);

Might it be simpler for add_allowed_region to return a handle that
remove_allowed_region takes instead of paddr+size? Then
remove_allowed_region doesn't have to walk anything, and the requirement
to use the same paddr/size is implicit.
