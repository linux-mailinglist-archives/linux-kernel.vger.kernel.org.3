Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF323539923
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbiEaV4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiEaV4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:56:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 457EF5AA57
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:56:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0032C23A;
        Tue, 31 May 2022 14:56:03 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7883F66F;
        Tue, 31 May 2022 14:56:01 -0700 (PDT)
Message-ID: <417bd608-0eeb-b3a0-31e3-8e241ab75e59@arm.com>
Date:   Tue, 31 May 2022 22:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/10] dmapool: improve accuracy of debug statistics
Content-Language: en-GB
To:     Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        iommu@lists.linux-foundation.org, Keith Busch <kbusch@kernel.org>,
        kernel-team@fb.com
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <a922c30f-d6d7-dde2-554f-254441290331@cybernetics.com>
 <b97645ed-b524-a505-2993-e04a37b50d35@arm.com>
 <a57d3dde-ac45-be9c-5c16-263415060334@cybernetics.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a57d3dde-ac45-be9c-5c16-263415060334@cybernetics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 20:52, Tony Battersby wrote:
> On 5/31/22 15:48, Robin Murphy wrote:
>> On 2022-05-31 19:17, Tony Battersby wrote:
>>
>>>    				 pool->name, blocks,
>>> -				 (size_t) pages *
>>> -				 (pool->allocation / pool->size),
>>> +				 (size_t) pages * pool->blks_per_alloc,
>>>    				 pool->size, pages);
>>>    		size -= temp;
>>>    		next += temp;
>>> @@ -168,6 +168,9 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
>>>    	retval->size = size;
>>>    	retval->boundary = boundary;
>>>    	retval->allocation = allocation;
>>> +	retval->blks_per_alloc =
>>> +		(allocation / boundary) * (boundary / size) +
>>> +		(allocation % boundary) / size;
>> Do we really need to store this? Sure, 4 divisions (which could possibly
>> be fewer given the constraints on boundary) isn't the absolute cheapest
>> calculation, but I still can't imagine anyone would be polling sysfs
>> stats hard enough to even notice.
>>
> The stored value is also used in patch #5, in more performance-critical
> code, although only when debug is enabled.

Ah, fair enough. On second look I think 64-bit systems could effectively 
store this for free anyway, if patch #2 moved "size" down past "dev" in 
struct dma_pool, such that blks_per_alloc then ends up padding out the 
hole again.

FWIW the mathematician in me also now can't help seeing the algebraic 
reduction to at least "(allocation + (allocation % boundary)) / size", 
but is now too tired to reason about the power-of-two constraints and 
whether the intermediate integer truncations matter...

Cheers,
Robin.
