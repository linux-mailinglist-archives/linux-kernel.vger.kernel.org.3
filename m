Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288545AFFD9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIGJF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiIGJFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:05:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1762AB7F5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:05:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19831D6E;
        Wed,  7 Sep 2022 02:06:01 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7C553F73D;
        Wed,  7 Sep 2022 02:06:20 -0700 (PDT)
Message-ID: <af4182e5-c162-3067-8461-0d31bf09aea2@arm.com>
Date:   Wed, 7 Sep 2022 10:05:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        Ethan Zhao <haifeng.zhao@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
 <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
 <cc950d77-2a97-ac75-4a1d-19aaf864a3be@huawei.com>
 <ad67a859-dc57-e30f-e422-3f9a0cb5239b@arm.com>
 <ef7622de-c1f3-c6cd-a50e-bbcbf8288b64@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ef7622de-c1f3-c6cd-a50e-bbcbf8288b64@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-07 09:46, John Garry wrote:
> On 06/09/2022 19:25, Robin Murphy wrote:
>>>
>>> Caveat: on the chance that the IOVA domain init fails due to the 
>>> rcache init failing, then, if there were another device in the group 
>>> which probes later, its probe would be ok as the start_pfn is set. 
>>> Not Good.
>>
>> Yeah, there's a lot not to like about iommu_dma_init_domain() - I've 
>> been banking on it all getting cleaned up when I get to refactoring 
>> that area of probing (remember the issue you reported years ago with 
>> PCI groups being built in the wrong order? All related...), but in 
>> fact since the cookie management got pulled into core code, we can 
>> probably tie the IOVA domain setup to that right now without much 
>> other involvement. That could be a cheap win, so I'll give it a go soon.
> 
> ok, great.
> 
> On a related topic, another thing to consider is that errors in IOVA 
> domain init are not handled gracefully in terms of how we deal with the 
> device probe and setting dma mapping ops, ref iommu_setup_dma_ops(). I 
> assume you know all this.
> 
>>
>>> - vdpa just fails to create the domain in vduse_domain_create()
>>>
>>>> That makes a fair amount of sense, but does mean that we're missing 
>>>> the equivalent in iova_rcache_insert() for it to actually work. Or 
>>>> we just remove it and tighten up the documentation to say that's not 
>>>> valid 
>>>
>>> I'd be more inclined to remove it. I would rather remove fathpath 
>>> checks as much as possible and have robust error handling in the 
>>> domain init.
>>>
>>> Afterall I do have the "remove check" craze going.
>>
>> Sure, like I say I'm happy to be consistent either way. If I do end up 
>> reinstating such a check I think I'd prefer to have it explicit in 
>> {alloc,free}_iova_fast() anyway, rather than buried in internal 
>> implementation details.
> 
> I'm not sure what you would like to see now, if anything.
> 
> I could just remove the iovad->rcache check in iova_rcache_get().  It's 
> pretty useless (on its own) since we don't have the same check on the 
> "insert" path.

Yup, just remove it. Sorting iommu-dma is yet another issue, but let's 
skip straight to fixing that properly by allocating the IOVA domain 
up-front with the cookie (is this the last remnant of my 7-year-old 
misunderstanding of dma_32bit_pfn? Let's hope so...)

Thanks,
Robin.
