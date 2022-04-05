Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3534F20EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiDEDgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiDEDgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:36:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B874A1CE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:34:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3ECED6E;
        Mon,  4 Apr 2022 20:34:31 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBFD83F718;
        Mon,  4 Apr 2022 20:34:25 -0700 (PDT)
Message-ID: <ac9d171b-9995-13a8-8359-12291c835bec@arm.com>
Date:   Tue, 5 Apr 2022 09:04:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable
 HUGETLB_PAGE_FREE_VMEMMAP for arm64
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        Barry Song <21cnbao@gmail.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com>
 <dd980687-a1ef-f4b5-bb29-da14f89c087e@arm.com>
 <CAMZfGtX5NXudeAsYKU8mDtPn0+bw_3FhCsAW0PMBTqTTkp-fQQ@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAMZfGtX5NXudeAsYKU8mDtPn0+bw_3FhCsAW0PMBTqTTkp-fQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/22 17:31, Muchun Song wrote:
> On Mon, Apr 4, 2022 at 5:25 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> Hello Muchun,
>>
>> On 3/31/22 12:26, Muchun Song wrote:
>>> The feature of minimizing overhead of struct page associated with each
>>> HugeTLB page aims to free its vmemmap pages (used as struct page) to
>>> save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
>>
>> Enabling this feature saves us around 1.4/1.6 % memory but looking from
>> other way around, unavailability of vmemmap backing pages (~1.4GB) when
>> freeing up a corresponding HugeTLB page, could prevent ~1TB memory from
>> being used as normal page form (requiring their own struct pages), thus
>> forcing the HugeTLB page to remain as such ? Is not this problematic ?
>>
>> These additional 1TB memory in normal pages, from a HugeTLB dissolution
>> could have eased the system's memory pressure without this feature being
>> enabled.
> 
> You are right. If the system is already under heavy memory pressure, it could
> prevent the user from freeing HugeTLB pages to the buddy allocator. If the
> HugeTLB page are allocated from non-movable zone, this scenario may be
> not problematic since once a HugeTLB page is freed, then the system will

But how can even the first HugeTLB page be freed without vmemmmap which is
throttled due to lack of sufficient memory ?

> have memory to be allocated to be used as vmemmap pages, subsequent
> freeing of HugeTLB pages may be getting easier.  However, if the HUgeTLB
> pages are allocated from the movable zone, then the thing becomes terrible,
> which is documented in Documentation/admin-guide/mm/memory-hotplug.rst.
> 
> So there is a cmdline "hugetlb_free_vmemmap" to control if enabling this
> feature.  The user should enable/disable this depending on their workload.

Should there also be a sysfs interface for this knob as well ? Perhaps the
system usage might change on the way, without requiring a reboot.
