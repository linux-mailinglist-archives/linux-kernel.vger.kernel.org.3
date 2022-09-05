Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C56E5AD6E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiIEPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiIEPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:51:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18BE25E575
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:51:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E6EC139F;
        Mon,  5 Sep 2022 08:51:16 -0700 (PDT)
Received: from [10.57.15.199] (unknown [10.57.15.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131AD3F534;
        Mon,  5 Sep 2022 08:51:08 -0700 (PDT)
Message-ID: <318d9157-6f2b-4ae5-70fc-a54d5919496e@arm.com>
Date:   Mon, 5 Sep 2022 16:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/3] iova: Some misc changes
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
 <11d9f054-fe7b-7646-a8f4-7d45a22e2a96@huawei.com>
 <e8b232be-dfe9-0a67-c464-83fe5109070e@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e8b232be-dfe9-0a67-c464-83fe5109070e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-02 13:18, John Garry wrote:
> On 17/08/2022 11:24, John Garry wrote:
>> On 17/08/2022 11:09, John Garry wrote:
>>> This series includes:
>>> - remove checks in the code which are not required
>>> - the re-org, which I had originally posted separately
>>
>> BTW, Can we drop the !IOMMU_IOVA stubs in iova.h? I could not find a 
>> kernel config which actually exercises that code (so testing changes 
>> there is difficult).
> 
> Any thoughts on this? Since I got no review of patch #3 I assume that it 
> is not keenly welcome either.

Yeah, I applied patch #3 to have a look at the result, but couldn't 
really convince myself either way - there are certainly a few functions 
in weirdly incongruous places at the moment, but afterwards we end up 
with certain other things in rather contrived order for the sake of 
avoiding declarations, so overall it just didn't feel objectively better 
to me. Plus the fact that rewriting nearly 2/3 of the file stands to 
make backporting tweaks or fixes unnecessarily painful is hard to 
overlook. Hence I guess I'm leaning towards "worth trying to see how it 
looked, but let's not".

As for the stubs, it seems that they're currently unused due to linkage 
issues with IOMMU_IOVA=m - if we want better compile-test coverage, I 
wonder if we couldn't replace the IS_ENABLED() with IS_REACHABLE() and 
restore some of the previously-conditional selects?

Robin.
