Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1352BBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiERNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiERNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:45:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38330261D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:45:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C350923A;
        Wed, 18 May 2022 06:45:14 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EB493F73D;
        Wed, 18 May 2022 06:45:13 -0700 (PDT)
Message-ID: <f88ea085-2161-02ff-ee36-a004b9e48338@arm.com>
Date:   Wed, 18 May 2022 14:45:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, m.szyprowski@samsung.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        liyihang6@hisilicon.com
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
 <20220518131237.GA26019@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220518131237.GA26019@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-18 14:12, Christoph Hellwig wrote:
> On Tue, May 17, 2022 at 11:40:52AM +0100, Robin Murphy wrote:
>> Indeed, sorry but NAK for this being nonsense. As I've said at least once
>> before, if the unnecessary SAC address allocation attempt slows down your
>> workload, make it not do that in the first place. If you don't like the
>> existing command-line parameter then fine, there are plenty of other
>> options, it just needs to be done in a way that doesn't break x86 systems
>> with dodgy firmware, as my first attempt turned out to.
> 
> What broke x86?

See the thread at [1] (and in case of curiosity the other IVRS patches I 
refer to therein were at [2]). Basically, undescribed limitations lead 
to DMA address truncation once iommu-dma starts allocating from what it 
thinks is the full usable IOVA range. Your typical desktop PC is 
unlikely to have enough concurrent DMA-mapped memory to overflow the 
32-bit IOVA space naturally, so this has probably been hiding an untold 
multitude of sins over the years.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com/
[2] 
https://lore.kernel.org/linux-iommu/20200605145655.13639-1-sebott@amazon.de/
