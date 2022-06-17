Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC854EFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379969AbiFQDIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379936AbiFQDIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:08:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1A905DE4F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:08:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D2A912FC;
        Thu, 16 Jun 2022 20:08:14 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9533F73B;
        Thu, 16 Jun 2022 20:08:11 -0700 (PDT)
Message-ID: <f5fe2622-5003-707c-a1b3-0f5de18c4912@arm.com>
Date:   Fri, 17 Jun 2022 08:37:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 0/2] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <1fe37a32-f11b-fbc4-7fca-46dcc89b50c4@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <1fe37a32-f11b-fbc4-7fca-46dcc89b50c4@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 10:52, Christophe Leroy wrote:
> 
> 
> Le 16/06/2022 à 06:09, Anshuman Khandual a écrit :
>> __SXXX/__PXXX macros is an unnecessary abstraction layer in creating the
>> generic protection_map[] array which is used for vm_get_page_prot(). This
>> abstraction layer can be avoided, if the platforms just define the array
>> protection_map[] for all possible vm_flags access permission combinations.
>>
>> This series drops __SXXX/__PXXX macros from across platforms in the tree.
>> First it makes protection_map[] array private (static) on platforms which
>> enable ARCH_HAS_VM_GET_PAGE_PROT, later moves protection_map[] array into
>> arch for all remaining platforms (!ARCH_HAS_VM_GET_PAGE_PROT), dropping
>> the generic one. In the process __SXXX/__PXXX macros become redundant and
>> thus get dropped off completely. I understand that the diff stat is large
>> here, but please do suggest if there is a better way. This series applies
>> on v5.19-rc1 and has been build tested for multiple platforms.
> 
> Maybe this patch could be split with one patch per architecture. All you 
> have to do for that is to guard the generic protection_map declaration 
> with #ifdef __S000 , then the architectures can be migrated one by one.
> 
>>
>> The CC list for this series has been reduced to just minimum, until there
>> is some initial agreement.
> 
> Agreement with who if people don't know this series exists ?
> 
> I think you should keep the architecture lists in copy allthough you 
> don't include individual maintainers/reviewers for now.

Sure, will do.

> 
>>
>> - Anshuman
>>
>> Changes in V3:
>>
>> - Fix build issues on powerpc and riscv
>>
>> Changes in V2:
> 
> I guess V2 was only sent to linux-mm as well ? Too bad.

I was in a dilemma, whether to first arrive at something more acceptable or
just engage all stake holders from the beginning. I understand your concern
and hence will copy architecture mailing lists from next time onward.
