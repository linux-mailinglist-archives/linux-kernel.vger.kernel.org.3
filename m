Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8658CB52
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbiHHPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiHHPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA5B1402F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656EA60FEF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878CFC433C1;
        Mon,  8 Aug 2022 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659972804;
        bh=J5FsusRrW5B5/TeZ/yTNVF8WN/lOPPDf1oC/gh0cyJc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W/LlGgb5ZUDFm7AYGCvV4/DhP8WP087urVvNBdUKjZkOG/TAiuI6uHdkjTz9kuYDx
         +t8ynnlwkLBeaMh6X2Bj87XXjcuLoxparNc3T+rg4paHbNcXjjiAfiIqClNmBqSY6t
         PnKUkXZ9t5Vp4v9h8R+rxMW3ENKNIZEW+RXuHfR/tiJN1MSpxm+3f/QYTKv4P6gLAl
         vj1f8/sRcNHzgvIVTvcLkmdfmETOrgkBnDa26wnH1sOMlK3dlOZR6xN8EyR274ODzU
         KQEDCvY7rSxf+KSnKEZAEE8NUTs10NXr5GIgHCDmbonUyaS59sLW/c6H3rqmp2vqHE
         ODq9frtLfNIWA==
Message-ID: <fc1094f4-bf62-9e9d-1473-5b2595830b60@kernel.org>
Date:   Mon, 8 Aug 2022 17:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v4] mm/page_owner.c: add llseek for page_owner
Content-Language: en-US
To:     Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org
Cc:     minchan@kernel.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220808073606.29666-1-quic_yingangl@quicinc.com>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20220808073606.29666-1-quic_yingangl@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 09:36, Kassey Li wrote:
> There is usage to dump a given cma region page_owner
> instead of all page's.
> 
> This change allows to specify a ppos as start_pfn
> by fseek.
> 
> Any invalid ppos will be skipped, so it did not
> broken the origin dump feature.
> 
> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks, but please change it to Vlastimil Babka <vbabka@suse.cz>
It was some mistake between me and thunderbird that it was sent from @k.o.

> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  mm/page_owner.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e4c6f3f1695b..231b1877af99 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -497,8 +497,8 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		return -EINVAL;
>  
>  	page = NULL;
> -	pfn = min_low_pfn + *ppos;
>  
> +	pfn = *ppos;

Maybe we could still optimize the typical case a bit such that when it's 0,
we skip to min_low_pfn immediately.

>  	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
>  	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
>  		pfn++;
> @@ -561,7 +561,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  			continue;
>  
>  		/* Record the next PFN to read in the file offset */
> -		*ppos = (pfn - min_low_pfn) + 1;
> +		*ppos = pfn + 1;
>  
>  		return print_page_owner(buf, count, pfn, page,
>  				page_owner, handle);
> @@ -570,6 +570,21 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  	return 0;
>  }
>  
> +static loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
> +{
> +	loff_t retval = 0;
> +	switch (whence) {
> +		case SEEK_CUR:

It's not correct for SEEK_CUR to behave like this, no?
Can we perhaps reuse the existing mem_lseek() ?

Also we should update Documentation/mm/page_owner.rst to document the lseek
support and that it works with a pfn.

Thanks!

> +		case SEEK_SET:
> +			file->f_pos = offset;
> +			break;
> +		default:
> +			retval = -ENXIO;
> +	}
> +
> +	return retval;
> +}
> +
>  static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>  {
>  	unsigned long pfn = zone->zone_start_pfn;
> @@ -660,6 +675,7 @@ static void init_early_allocated_pages(void)
>  
>  static const struct file_operations proc_page_owner_operations = {
>  	.read		= read_page_owner,
> +	.llseek 	= llseek_page_owner,
>  };
>  
>  static int __init pageowner_init(void)

