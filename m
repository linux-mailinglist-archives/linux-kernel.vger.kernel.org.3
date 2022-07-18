Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53584577E86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiGRJUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiGRJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:20:26 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5324AE5B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:20:22 -0700 (PDT)
Received: from [10.10.132.242] (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 28A5B40737DF;
        Mon, 18 Jul 2022 09:20:17 +0000 (UTC)
Message-ID: <28df50012344fb1c925a7ceaf55ae400152ffb48.camel@ispras.ru>
Subject: [POSSIBLE BUG] iommu/io-pgtable-arm: possible dereferencing of NULL
 pointer
From:   Subkhankulov Rustam <subkhankulov@ispras.ru>
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Date:   Mon, 18 Jul 2022 12:20:06 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version: 5-19-rc6

In function '__arm_lpae_alloc_pages' pointer 'dev' is compared with 
NULL at [drivers/iommu/io-pgtable-arm.c: 203]. This means that the 
pointer can be NULL.

-----------------------------------------------------------------------
203 	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
204 			     gfp | __GFP_ZERO, order);
-----------------------------------------------------------------------

Then, if cfg->coherent_walk == 0 at [drivers/iommu/io-pgtable-arm.c: 
209], function 'dma_map_single', which is defined as 
'dma_map_single_attrs', is called and pointer dev is passed as 
first parameter.

-----------------------------------------------------------------------
209 	if (!cfg->coherent_walk) {
208 		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
-----------------------------------------------------------------------

Therefore, pointer 'dev' passed to function 'dev_driver_string' 
in macro 'dev_WARN_ONCE' at [include/linux/dma-mapping.h: 326], 
where it is dereferenced at [drivers/base/core.c: 2091].

-----------------------------------------------------------------------
2083	const char *dev_driver_string(const struct device *dev)
2084	{
2085		struct device_driver *drv;
2086
---
2091		drv = READ_ONCE(dev->driver);
-----------------------------------------------------------------------

Thus, if it is possible that 'dev' is null at the same time 
that flag 'coherent_walk' is 0, then NULL pointer will be 
dereferenced.

Should we somehow avoid NULL pointer dereference or is this 
situation impossible and we should remove comparison with NULL?

Found by Linux Verification Center (linuxtesting.org) with SVACE.

regards,
Rustam Subkhankulov

