Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4095008FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbiDNI76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbiDNI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:59:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15B75689B5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A86CD139F;
        Thu, 14 Apr 2022 01:57:18 -0700 (PDT)
Received: from [10.32.36.25] (e121896.Emea.Arm.com [10.32.36.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F3203F5A1;
        Thu, 14 Apr 2022 01:57:17 -0700 (PDT)
Message-ID: <b3e647de-8efd-4db2-a910-77e37b026ae7@arm.com>
Date:   Thu, 14 Apr 2022 09:57:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 00/15] Make ETM register accesses consistent with
 sysreg.h
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220304171913.2292458-1-james.clark@arm.com>
 <20220323162257.GC3248686@p14s>
 <4ef77445-b58d-a71a-0ddc-70e308ea99c8@arm.com> <20220413170844.GA547134@p14s>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220413170844.GA547134@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/04/2022 18:08, Mathieu Poirier wrote:
> On Mon, Mar 28, 2022 at 11:41:48AM +0100, James Clark wrote:
>>
>>
>> On 23/03/2022 16:22, Mathieu Poirier wrote:
>>> On Fri, Mar 04, 2022 at 05:18:57PM +0000, James Clark wrote:
>>>> Changes since v2:
>>>>  * Implement Mike's suggestion of not having _SHIFT and using the existing
>>>>    FIELD_GET and FIELD_PREP methods.
>>>>  * Dropped the change to add the new REG_VAL macro because of the above.
>>>>  * FIELD_PREP could be used in some trivial cases, but in some cases the
>>>>    shift is still required but can be calculated with __bf_shf
>>>>  * Improved the commit messages.
>>>>  * The change is still binary equivalent, but requires an extra step 
>>>>    mentioned at the end of this cover letter.
>>>>
>>>> Applies to coresight/next 3619ee28488
>>>> Also available at https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-register-refactor-v3
>>>>
>>>> To check for binary equivalence follow the same steps in the cover letter
>>>> of v2, but apply the following change to coresight-priv.h. This is because
>>>> the existing version of the macros wrap the expression in a new scope {}
>>>> that flips something in the compiler:
>>>>
>>>>   #undef FIELD_GET
>>>>   #define FIELD_GET(_mask, _reg) (((_reg) & (_mask)) >> __bf_shf(_mask))
>>>>   #undef FIELD_PREP
>>>>   #define FIELD_PREP(_mask, _val) (((_val) << __bf_shf(_mask)) & (_mask))
>>>>
>>>> Thanks
>>>> James
>>>>
>>>> James Clark (15):
>>>>   coresight: etm4x: Cleanup TRCIDR0 register accesses
>>>>   coresight: etm4x: Cleanup TRCIDR2 register accesses
>>>>   coresight: etm4x: Cleanup TRCIDR3 register accesses
>>>>   coresight: etm4x: Cleanup TRCIDR4 register accesses
>>>>   coresight: etm4x: Cleanup TRCIDR5 register accesses
>>>>   coresight: etm4x: Cleanup TRCCONFIGR register accesses
>>>>   coresight: etm4x: Cleanup TRCEVENTCTL1R register accesses
>>>>   coresight: etm4x: Cleanup TRCSTALLCTLR register accesses
>>>>   coresight: etm4x: Cleanup TRCVICTLR register accesses
>>>>   coresight: etm3x: Cleanup ETMTECR1 register accesses
>>>>   coresight: etm4x: Cleanup TRCACATRn register accesses
>>>>   coresight: etm4x: Cleanup TRCSSCCRn and TRCSSCSRn register accesses
>>>>   coresight: etm4x: Cleanup TRCSSPCICRn register accesses
>>>>   coresight: etm4x: Cleanup TRCBBCTLR register accesses
>>>>   coresight: etm4x: Cleanup TRCRSCTLRn register accesses
>>>>
>>>>  .../coresight/coresight-etm3x-core.c          |   2 +-
>>>>  .../coresight/coresight-etm3x-sysfs.c         |   2 +-
>>>>  .../coresight/coresight-etm4x-core.c          | 136 +++++--------
>>>>  .../coresight/coresight-etm4x-sysfs.c         | 180 +++++++++---------
>>>>  drivers/hwtracing/coresight/coresight-etm4x.h | 122 ++++++++++--
>>>>  5 files changed, 244 insertions(+), 198 deletions(-)
>>>
>>> I am done reviewing this set.  I will wait until rc1 or rc2 before moving
>>> forward.  If there are other comments needing a respin then I will wait for the
>>> next revision.  Otherwise I will apply this one after correcting the extra lines
>>> at the end of patch 15.
>>>  
>>
>> Thanks for the review!
>>
> 
> I have applied this set.

Thanks Mathieu

> 
>>> Thanks,
>>> Mathieu
>>>
>>>>
>>>> -- 
>>>> 2.28.0
>>>>
