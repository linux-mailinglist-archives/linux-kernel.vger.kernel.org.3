Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29C9529F47
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbiEQKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344102AbiEQKUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:20:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B24B4C7B1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:19:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07EF31042;
        Tue, 17 May 2022 03:19:01 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DADC3F66F;
        Tue, 17 May 2022 03:18:59 -0700 (PDT)
Message-ID: <0e9356ee-9ae0-fd6d-b4ba-b1f05d8ba144@arm.com>
Date:   Tue, 17 May 2022 11:18:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iommu/dma: Fix check for error return from
 iommu_map_sg_atomic()
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20220513153948.310119-1-schnelle@linux.ibm.com>
 <20220517083657.GA16377@lst.de>
 <27ae8b9f8e61dce4b31a37622e98b1c57b21b104.camel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <27ae8b9f8e61dce4b31a37622e98b1c57b21b104.camel@linux.ibm.com>
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

On 2022-05-17 11:17, Niklas Schnelle wrote:
> On Tue, 2022-05-17 at 10:36 +0200, Christoph Hellwig wrote:
>> On Fri, May 13, 2022 at 05:39:48PM +0200, Niklas Schnelle wrote:
>>> In __iommu_dma_alloc_noncontiguous() the value returned by
>>> iommu_map_sg_atomic() is checked for being smaller than size. Before
>>> commit ad8f36e4b6b1 ("iommu: return full error code from
>>> iommu_map_sg[_atomic]()") this simply checked if the requested size was
>>> successfully mapped.
>>>
>>> After that commit iommu_map_sg_atomic() may also return a negative
>>> error value. In principle this too would be covered by the existing
>>> check. There is one problem however, as size is of type size_t while the
>>> return type of iommu_map_sg_atomic() is now of type ssize_t the latter gets
>>> converted to size_t and negative error values end up as very large
>>> positive values making the check succeed. Fix this by making the return
>>> type visible with a local variable and add an explicit cast to ssize_t.
>>>
>>> Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>
>> I don't see what the point of the newly added local variable is here.
>> Just casting size should be all that is needed as far as I can tell.
> 
> No technical reason just found it easier to read and more descriptive.
> I'll sent a v2 with just the cast, it does simplify the commit message.

Note that this is already fixed upstream, though:

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=core&id=a3884774d731f03d3a3dd4fb70ec2d9341ceb39d

Robin.
