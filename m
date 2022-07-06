Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDC5689DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiGFNnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:43:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 143FE5FF1;
        Wed,  6 Jul 2022 06:43:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25437106F;
        Wed,  6 Jul 2022 06:43:48 -0700 (PDT)
Received: from [10.57.86.2] (unknown [10.57.86.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7F813F792;
        Wed,  6 Jul 2022 06:43:45 -0700 (PDT)
Message-ID: <3d613192-f673-852e-9c52-b8a913d25616@arm.com>
Date:   Wed, 6 Jul 2022 14:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/15] iommu: Always register bus notifiers
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
 <1fab4c8a-7bc5-9a50-d48a-0dc590cac7a6@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1fab4c8a-7bc5-9a50-d48a-0dc590cac7a6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-06 02:53, Baolu Lu wrote:
> On 2022/7/6 01:08, Robin Murphy wrote:
>>   /*
>>    * Use a function instead of an array here because the domain-type is a
>>    * bit-field, so an array would waste memory.
>> @@ -152,6 +172,10 @@ static int __init iommu_subsys_init(void)
>>               (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>>                   "(set via kernel command line)" : "");
>> +    /* If the system is so broken that this fails, it will WARN 
>> anyway */
> 
> Can you please elaborate a bit on this? iommu_bus_init() still return
> errors.

Indeed, it's commenting on the fact that we don't try to clean up or 
propagate an error value further even if it did ever manage to return 
one. I feared that if I strip the error handling out of iommu_bus_init() 
itself on the same reasoning, we'll just get constant patches from the 
static checker brigade trying to add it back, so it seemed like the 
neatest compromise to keep that decision where it's obviously in an 
early initcall, rather than in the helper function which can be viewed 
out of context. However, I'm happy to either expand this comment or go 
the whole way and make iommu_bus_init() return void if you think it's 
worthwhile.

Cheers,
Robin.

> 
>> +    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
>> +        iommu_bus_init(iommu_buses[i]);
>> +
>>       return 0;
> 
> Best regards,
> baolu
