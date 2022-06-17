Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF04154FC29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383256AbiFQRWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382911AbiFQRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:22:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2FED2612
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:22:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F03EE1474;
        Fri, 17 Jun 2022 10:22:40 -0700 (PDT)
Received: from [10.57.84.65] (unknown [10.57.84.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0344E3F792;
        Fri, 17 Jun 2022 10:22:39 -0700 (PDT)
Message-ID: <88080559-0c96-ec91-6f72-df05a2d0c5af@arm.com>
Date:   Fri, 17 Jun 2022 18:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: helping with remapping vmem for dma
Content-Language: en-GB
To:     Frank Wunderlich <frank-w@public-files.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <trinity-2d26eb5e-6a3f-485a-aed7-134c1e164942-1655482643278@3c-app-gmx-bap03>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <trinity-2d26eb5e-6a3f-485a-aed7-134c1e164942-1655482643278@3c-app-gmx-bap03>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 17:17, Frank Wunderlich wrote:
> Am 15. Juni 2022 15:17:00 MESZ schrieb Christoph Hellwig <hch@lst.de>:
>> On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
>>> Put simply, if you want to call dma_map_single() on a buffer, then that
>>> buffer needs to be allocated with kmalloc() (or technically alloc_pages(),
>>> but then dma_map_page() would make more sense when dealing with entire
>>> pages.
>>
>> Yes.  It sounds like the memory here comes from the dma coherent
>> allocator, in which case the code need to use the address returned
>> by that and not create another mapping.
> 
> Hi
> 
> traced it to buffer allocated as simple uint8-array [1]:
> 
> UINT_8 aucBuffer[sizeof(INIT_HIF_RX_HEADER_T) + sizeof(INIT_EVENT_CMD_RESULT)];

Ah, so it's trying to do DMA with a stack variable? CONFIG_DMA_API_DEBUG 
is your friend; it should have screamed about that specifically. 
Allocate this buffer properly to begin with, and free it again on the 
way out of the function (it's surely not worth having to make a 
temporary copy further down the callchain). The kmalloc flags can 
probably be regular GFP_KERNEL, unless this can be called from more 
restrictive contexts like an IRQ handler - the fact that it might be 
mapped for DMA later is essentially irrelevant in that respect.

Thanks,
Robin.

> 
> and then called as
> 
> nicRxWaitResponse(prAdapter,0,aucBuffer,sizeof(INIT_HIF_RX_HEADER_T) + sizeof(INIT_EVENT_CMD_RESULT),/* 4B + 4B */
> 					&u4RxPktLength)
> 
> this calls [2]:
> 
> WLAN_STATUS
> nicRxWaitResponse(IN P_ADAPTER_T prAdapter,
> 		  IN UINT_8 ucPortIdx, OUT PUINT_8 pucRspBuffer, IN UINT_32 u4MaxRespBufferLen, OUT PUINT_32 pu4Length)
> {
> ...
> HAL_PORT_RD(prAdapter,ucPortIdx == 0 ? MCR_WRDR0 : MCR_WRDR1, u4PktLen, pucRspBuffer, u4MaxRespBufferLen);
> }
> 
> 
> nicRxWaitResponse contains a do-while(true)-loop, but it looks like this is failing on first call (i see my debug before call of HAL_PORT_RD only once)...
> 
> do i need kmalloc before call of nicRxWaitResponse and if yes which flags are right here?
> https://www.kernel.org/doc/htmldocs/kernel-api/API-kmalloc.html
> 
> callstack is like this:
> 
> [  126.919569]  __dma_page_dev_to_cpu from kalDevPortRead+0x3a0/0x6b4 [wlan_gen2]
> [  126.928643]  kalDevPortRead [wlan_gen2] from nicRxWaitResponse+0x4c0/0x61c [wlan_gen2]
> [  126.939752]  nicRxWaitResponse [wlan_gen2] from wlanImageSectionDownloadStatus.part.0+0xd0/0x26c [wlan_gen2]
> [  126.952783]  wlanImageSectionDownloadStatus.part.0 [wlan_gen2] from wlanImageSectionDownload+0x168/0x36c [wlan_gen2]
> [  126.966511]  wlanImageSectionDownload [wlan_gen2] from wlanAdapterStart+0x674/0xf94 [wlan_gen2]
> [  126.978367]  wlanAdapterStart [wlan_gen2] from wlanProbe+0x318/0xbe8 [wlan_gen2]
> [  126.988951]  wlanProbe [wlan_gen2] from HifAhbProbe+0x54/0x88 [wlan_gen2]
> [  126.998905]  HifAhbProbe [wlan_gen2] from wmt_func_wifi_on+0x4c/0x150
> 
> regards Frank
> 
> [1] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/common/wlan_lib.c#L3046
> [2] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/nic/nic_rx.c#L3604
