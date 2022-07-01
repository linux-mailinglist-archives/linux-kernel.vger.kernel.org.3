Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8256329D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiGALdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGALdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:33:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E22B250
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:33:18 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LZCdf3yhHz6H71B;
        Fri,  1 Jul 2022 19:29:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 13:33:16 +0200
Received: from [10.126.173.51] (10.126.173.51) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 12:33:15 +0100
Message-ID: <51af869a-83d4-631a-2d91-edb8b066bf4d@huawei.com>
Date:   Fri, 1 Jul 2022 12:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
To:     Feng Tang <feng.tang@intel.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Lameter" <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
 <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
 <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
 <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
 <20220701035622.GB14806@shbuild999.sh.intel.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220701035622.GB14806@shbuild999.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.51]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2022 04:56, Feng Tang wrote:
>>> inclination.
>>>
>> ok, what you are saying sounds reasonable. I just remember that when we
>> analyzed the longterm aging issue that we concluded that the FQ size and its
>> relation to the magazine size was a factor and this change makes me a little
>> worried about new issues. Better the devil you know and all that...
>>
>> Anyway, if I get some time I might do some testing to see if this change has
>> any influence.
>>
>> Another thought is if we need even store the size in the iova_magazine? mags
>> in the depot are always full. As such, we only need worry about mags loaded
>> in the cpu rcache and their sizes, so maybe we could have something like
>> this:
>>
>> struct iova_magazine {
>> -       unsigned long size;
>>         unsigned long pfns[IOVA_MAG_SIZE];
>> };
>>
>> @@ -631,6 +630,8 @@ struct iova_cpu_rcache {
>>         spinlock_t lock;
>>         struct iova_magazine *loaded;
>>         struct iova_magazine *prev;
>> +       int loaded_size;
>> +       int prev_size;
>> };
>>
>> I haven't tried to implement it though..
> I have very few knowledge of iova, so you can chose what's the better
> solution. I just wanted to raise the problem and will be happy to see
> it solved:)

I quickly tested your patch for performance and saw no noticeable 
difference, which is no surprise.

But I'll defer to Robin if he thinks that your patch is a better 
solution - I would guess that he does. For me personally I would prefer 
that this value was not changed, as I mentioned before.

thanks,
John
