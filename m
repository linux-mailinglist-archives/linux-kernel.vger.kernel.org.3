Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4135A5AF172
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiIFRAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbiIFQ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:59:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 700922BE5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:47:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02EB6139F;
        Tue,  6 Sep 2022 09:47:41 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6FC43F534;
        Tue,  6 Sep 2022 09:47:33 -0700 (PDT)
Message-ID: <3e9e0f77-af41-54ef-f497-423f88fd3585@arm.com>
Date:   Tue, 6 Sep 2022 17:47:28 +0100
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
 <318d9157-6f2b-4ae5-70fc-a54d5919496e@arm.com>
 <1fd99fb4-bec1-9695-89f3-499477c88bb7@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1fd99fb4-bec1-9695-89f3-499477c88bb7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-06 12:59, John Garry wrote:
> On 05/09/2022 16:51, Robin Murphy wrote:
>>>
>>> Any thoughts on this? Since I got no review of patch #3 I assume that 
>>> it is not keenly welcome either.
>>
>> Yeah, I applied patch #3 to have a look at the result, but couldn't 
>> really convince myself either way - there are certainly a few 
>> functions in weirdly incongruous places at the moment, but afterwards 
>> we end up with certain other things in rather contrived order for the 
>> sake of avoiding declarations, so overall it just didn't feel 
>> objectively better to me. Plus the fact that rewriting nearly 2/3 of 
>> the file stands to make backporting tweaks or fixes unnecessarily 
>> painful is hard to overlook. 
> 
> Yeah, that was my main concern. But if it is going to be done, then now 
> is as good a time as ever...
> 
>> Hence I guess I'm leaning towards "worth trying to see how it looked, 
>> but let's not".
>>
> 
> ok, fine. But I do still feel that iova.c does need tidying to some 
> extent along these lines.
> 
>> As for the stubs, it seems that they're currently unused due to 
>> linkage issues with IOMMU_IOVA=m - if we want better compile-test 
>> coverage, I wonder if we couldn't replace the IS_ENABLED() with 
>> IS_REACHABLE() and restore some of the previously-conditional selects?
> 
> Sorry, but I am not familiar - what were some examples of 
> previously-conditional selects?

Commits 84db889e6d82 and c8a203647488 were the ones that most readily 
stood out from the current "select IOMMU_IOVA" lines.

Cheers,
Robin.
