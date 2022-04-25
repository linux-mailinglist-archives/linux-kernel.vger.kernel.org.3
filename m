Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAFD50DDDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiDYKb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbiDYKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:31:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DB1C63ED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:28:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CD641FB;
        Mon, 25 Apr 2022 03:28:17 -0700 (PDT)
Received: from [10.163.40.250] (unknown [10.163.40.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A8713F73B;
        Mon, 25 Apr 2022 03:28:12 -0700 (PDT)
Message-ID: <f9e48ed2-0e90-1a2d-c62e-739c33c4cc53@arm.com>
Date:   Mon, 25 Apr 2022 15:59:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: use pgprot_val to get value of pgprot
Content-Language: en-US
To:     liusongtang <liusongtang@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        nixiaoming@huawei.com, young.liuyang@huawei.com, trivial@kernel.org
References: <20220425081736.249130-1-liusongtang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220425081736.249130-1-liusongtang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should have added 'memory_hotplug' in the subject line. Otherwise
this does not specify where the change is (neither does the commit
message below).

mm/memory_hotplug: use pgprot_val to get value of pgprot

On 4/25/22 13:47, liusongtang wrote:
> pgprot.pgprot is a non-portable code, it should be replaced by
> portable macro pgprot_val.
> 
> Signed-off-by: liusongtang <liusongtang@huawei.com>
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
Otherwise LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
