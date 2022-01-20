Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5A494632
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358355AbiATDhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:37:15 -0500
Received: from foss.arm.com ([217.140.110.172]:49052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232151AbiATDhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:37:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D8BC1FB;
        Wed, 19 Jan 2022 19:37:13 -0800 (PST)
Received: from [10.163.74.136] (unknown [10.163.74.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 522953F766;
        Wed, 19 Jan 2022 19:37:07 -0800 (PST)
Subject: Re: [PATCH] vmap(): don't allow invalid pages
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <Yedgj+Lo2eru8197@casper.infradead.org>
 <cfe4c63e-57c0-2a9d-c3e9-959bc77b87c6@arm.com>
 <CAAH8bW_=KtrwLpg4tx+1tdMjN2mUiuLOoZH6nvbn8qNjU6aB3A@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5b62ed03-8da8-a94d-cc48-a8cac1eae1c9@arm.com>
Date:   Thu, 20 Jan 2022 09:07:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAH8bW_=KtrwLpg4tx+1tdMjN2mUiuLOoZH6nvbn8qNjU6aB3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/22 10:52 PM, Yury Norov wrote:
>> Why should not this just scan over the entire user provided struct page
>> array and make sure that all pages there in are valid via above method,
>> but in vmap() itself before calling vmap_pages_range(). Because seems
>> like a single invalid page detected in vmap_pages_pte_range() will
>> anyways abort the entire vmap(). This will also enable us to drop the
>> existing NULL check above.
>
> I can do this, but why is it any better than the current approach?

Because it will just return on the first instance where the valid page
check fails, saving us some CPU cycles and an incomplete mapping ?
