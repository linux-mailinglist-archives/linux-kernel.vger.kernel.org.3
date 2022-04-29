Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4F514113
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiD2Da0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiD2DaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:30:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D5D3BF300
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:26:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2825711FB;
        Thu, 28 Apr 2022 20:26:59 -0700 (PDT)
Received: from [192.168.225.246] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F1303F73B;
        Thu, 28 Apr 2022 20:26:56 -0700 (PDT)
Message-ID: <fe6a2311-b343-55af-0e10-0e04169cf7c5@arm.com>
Date:   Fri, 29 Apr 2022 08:57:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] mm/memory_hotplug: use pgprot_val to get value of
 pgprot
To:     liusongtang <liusongtang@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        nixiaoming@huawei.com, young.liuyang@huawei.com,
        trivial@kernel.org, wangkefeng@huawei.com
References: <20220426071302.220646-1-liusongtang@huawei.com>
Content-Language: en-US
In-Reply-To: <20220426071302.220646-1-liusongtang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 12:43, liusongtang wrote:
> pgprot.pgprot is a non-portable code, it should be replaced by
> portable macro pgprot_val.
> 
> Signed-off-by: liusongtang <liusongtang@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> 
> ---
> v2: add 'memory_hotplug' in the subject line
> v1: https://lore.kernel.org/all/a5b58a66-bdc3-94df-6af5-c647da888c17@huawei.com/
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 416b38c..bf7d181 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -303,7 +303,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  	int err;
>  	struct vmem_altmap *altmap = params->altmap;
>  
> -	if (WARN_ON_ONCE(!params->pgprot.pgprot))
> +	if (WARN_ON_ONCE(!pgprot_val(params->pgprot)))
>  		return -EINVAL;
>  
>  	VM_BUG_ON(!mhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false));
