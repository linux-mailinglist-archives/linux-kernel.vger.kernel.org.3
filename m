Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA6F4F11EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353733AbiDDJ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245503AbiDDJ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:27:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A71763A196
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:25:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6636A1FB;
        Mon,  4 Apr 2022 02:25:57 -0700 (PDT)
Received: from [10.163.37.159] (unknown [10.163.37.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C533F3F718;
        Mon,  4 Apr 2022 02:25:51 -0700 (PDT)
Message-ID: <dd980687-a1ef-f4b5-bb29-da14f89c087e@arm.com>
Date:   Mon, 4 Apr 2022 14:56:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable
 HUGETLB_PAGE_FREE_VMEMMAP for arm64
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, bodeddub@amazon.com,
        osalvador@suse.de, mike.kravetz@oracle.com, rientjes@google.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, james.morse@arm.com,
        21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220331065640.5777-2-songmuchun@bytedance.com>
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

Hello Muchun,

On 3/31/22 12:26, Muchun Song wrote:
> The feature of minimizing overhead of struct page associated with each
> HugeTLB page aims to free its vmemmap pages (used as struct page) to
> save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).

Enabling this feature saves us around 1.4/1.6 % memory but looking from
other way around, unavailability of vmemmap backing pages (~1.4GB) when
freeing up a corresponding HugeTLB page, could prevent ~1TB memory from
being used as normal page form (requiring their own struct pages), thus
forcing the HugeTLB page to remain as such ? Is not this problematic ?

These additional 1TB memory in normal pages, from a HugeTLB dissolution
could have eased the system's memory pressure without this feature being
enabled.

- Anshuman
