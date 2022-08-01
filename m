Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4B5867E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiHALHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiHALHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:07:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5C0225EB9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:07:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342D6139F;
        Mon,  1 Aug 2022 04:07:04 -0700 (PDT)
Received: from [10.57.10.23] (unknown [10.57.10.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ECE63F67D;
        Mon,  1 Aug 2022 04:07:02 -0700 (PDT)
Message-ID: <71774d67-6c7f-ea42-2911-a3eb1955777d@arm.com>
Date:   Mon, 1 Aug 2022 12:06:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [POSSIBLE BUG] iommu/io-pgtable-arm: possible dereferencing of
 NULL pointer
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>,
        Subkhankulov Rustam <subkhankulov@ispras.ru>
Cc:     Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
References: <28df50012344fb1c925a7ceaf55ae400152ffb48.camel@ispras.ru>
 <20220719173610.GA14526@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220719173610.GA14526@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-19 18:36, Will Deacon wrote:
> On Mon, Jul 18, 2022 at 12:20:06PM +0300, Subkhankulov Rustam wrote:
>> Version: 5-19-rc6
>>
>> In function '__arm_lpae_alloc_pages' pointer 'dev' is compared with
>> NULL at [drivers/iommu/io-pgtable-arm.c: 203]. This means that the
>> pointer can be NULL.
>>
>> -----------------------------------------------------------------------
>> 203 	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
>> 204 			     gfp | __GFP_ZERO, order);
>> -----------------------------------------------------------------------
>>
>> Then, if cfg->coherent_walk == 0 at [drivers/iommu/io-pgtable-arm.c:
>> 209], function 'dma_map_single', which is defined as
>> 'dma_map_single_attrs', is called and pointer dev is passed as
>> first parameter.
>>
>> -----------------------------------------------------------------------
>> 209 	if (!cfg->coherent_walk) {
>> 208 		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
>> -----------------------------------------------------------------------
>>
>> Therefore, pointer 'dev' passed to function 'dev_driver_string'
>> in macro 'dev_WARN_ONCE' at [include/linux/dma-mapping.h: 326],
>> where it is dereferenced at [drivers/base/core.c: 2091].
>>
>> -----------------------------------------------------------------------
>> 2083	const char *dev_driver_string(const struct device *dev)
>> 2084	{
>> 2085		struct device_driver *drv;
>> 2086
>> ---
>> 2091		drv = READ_ONCE(dev->driver);
>> -----------------------------------------------------------------------
>>
>> Thus, if it is possible that 'dev' is null at the same time
>> that flag 'coherent_walk' is 0, then NULL pointer will be
>> dereferenced.
>>
>> Should we somehow avoid NULL pointer dereference or is this
>> situation impossible and we should remove comparison with NULL?
> 
> I think 'dev' is only null in the case of the selftest initcall
> (see arm_lpae_do_selftests()), and 'coherent_walk' is always true there.

Indeed, the intent is that cfg->iommu_dev == NULL is a special case for 
the selftest, which must always claim coherency as well for this reason. 
I suppose we could add an explicit assertion along those lines in 
alloc_pgtable if anyone really thinks it matters.

Cheers,
Robin.
