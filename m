Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9C4FEB77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiDLXhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiDLXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6C52B24
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EE6761B74
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B34C385A1;
        Tue, 12 Apr 2022 21:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649798559;
        bh=c/Bsdvokirgu31USN90XM/QAQckJDOY6WxAtFbseFUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2EH85EKs9Vt8PFzqWMQA4N8GKNtH7P1OK3fhtS36nW2eQYYLTD8+XeW4QV6doYBjc
         NGmySNJe0BWz0xx9Xl6RdMoCPZBooEkutWGP8AsQi7svaschKGlLPUC7j6FrDmeWtw
         sWaBk2xckdV9/DUk2+R0d8jABGrU3rF07+sJwp9E=
Date:   Tue, 12 Apr 2022 14:22:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     lipeifeng@oppo.com
Cc:     michel@lespinasse.org, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
        zhangshiming@oppo.com
Subject: Re: [PATCH] mm: fix align-error when get_addr in
 unmapped_area_topdown
Message-Id: <20220412142238.93e36cc4095e4e0b362db348@linux-foundation.org>
In-Reply-To: <20220412081014.399-1-lipeifeng@oppo.com>
References: <20220412081014.399-1-lipeifeng@oppo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 16:10:14 +0800 lipeifeng@oppo.com wrote:

> From: lipeifeng <lipeifeng@oppo.com>
> 
> when we found a suitable gap_end(> info->high_limit), gap_end
> must be set to info->high_limit. And we will get the gap_end
> after computing highest gap address at the desired alignment.
> 
> 2096 found:
> 2097         if (gap_end > info->high_limit)
> 2098                 gap_end = info->high_limit;
> 2099
> 2100 found_highest:
> 2101         gap_end -= info->length;
> 2102         gap_end -= (gap_end - info->align_offset) & info->align_mask;
> 2103
> 2104         VM_BUG_ON(gap_end < info->low_limit);
> 2105         VM_BUG_ON(gap_end < gap_start);
> 2106         return gap_end;
> 
> so we must promise: info->high_limit - info->low_limit >=
> info->length + info->align_mask.
> Or in rare cases(info->high_limit - info->low_limit <
> info->length + info->align_mask) we will get the addr in
> align-error if found suitable gap_end(> info->high_limit).
> 

Thanks.

What are the runtime affects of this bug, and how are you able to
trigger it?

> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2009,7 +2009,6 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  	if (length < info->length)
>  		return -ENOMEM;
>  
> -	length = info->length;
>  	/*
>  	 * Adjust search limits by the desired length.
>  	 * See implementation comment at top of unmapped_area().
> @@ -2021,6 +2020,8 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  
>  	if (info->low_limit > high_limit)
>  		return -ENOMEM;
> +
> +	length = info->length;
>  	low_limit = info->low_limit + length;
>  
>  	/* Check highest gap, which does not precede any rbtree node */
> -- 
> 2.7.4
