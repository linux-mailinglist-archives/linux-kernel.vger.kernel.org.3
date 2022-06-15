Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324954C98F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbiFONPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347332AbiFONPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:15:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011702A27B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:15:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9BA139F;
        Wed, 15 Jun 2022 06:15:39 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6C03F66F;
        Wed, 15 Jun 2022 06:15:38 -0700 (PDT)
Message-ID: <6e58b50c-cd05-a37b-07e1-10ee24fb972f@arm.com>
Date:   Wed, 15 Jun 2022 14:15:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: helping with remapping vmem for dma
Content-Language: en-GB
To:     Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>
References: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-15 13:11, Frank Wunderlich wrote:
> Hi,
> 
> i have upported a wifi-driver (mt6625l for armhf) for some time and fall now (at least 5.18) in the
> "rejecting DMA map of vmalloc memory" error [1].
> 
> maybe anybody here can guide me on how to nail it down and maybe fix it.
> 
> as far as i have debugged it, it uses dma_map_single [2] to get dma memory from a previous
> allocated memory region.
> 
> this function "kalDevPortRead" in [2] is used via macro HAL_PORT_RD [3] (used in HAL_READ_RX_PORT
> and HAL_READ_INTR_STATUS in same hal.h file)
> 
> HAL_READ_INTR_STATUS is always called with an empty int array as buf which i guess is not the problem.
> I think the issue is using the use with an preallocated prSDIOCtrl struct (have not completely traced
> it back where it is allocated).

Put simply, if you want to call dma_map_single() on a buffer, then that 
buffer needs to be allocated with kmalloc() (or technically 
alloc_pages(), but then dma_map_page() would make more sense when 
dealing with entire pages.

Robin.

> calls of HAL_PORT_RD/HAL_READ_RX_PORT are in nic{,_rx}.c (with sdio-struct) ([4] as example)
> 
> maybe there is a simple way to get an address in preallocated memory as replacement for the dma_map_simple call (and the unmap of course).
> 
> regards Frank
> 
> [1] https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L327
> [2] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/os/linux/hif/ahb/ahb.c#L940
> [3] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/include/nic/hal.h#L176
> [4] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/nic/nic_rx.c#L3604
