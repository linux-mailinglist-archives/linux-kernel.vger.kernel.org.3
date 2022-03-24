Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1F4E639E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbiCXMr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiCXMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:47:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CD4D63D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SEe56zLZugRIS2AzzpTha7A/J25pZy6DnvCcHtv9Yo4=; b=aEM1Gvinp6XNa6RFWnZa9IMOug
        7zBnJI8RNDVO0ZpsvroUrW9Id0dtanscK1wFYzZkJhNJqZkOLV8LAzenD1nOADShEJOGuTWJuVr9S
        gWm4FCJBFeQYLZnJWP60YRGG4DQHCHesMSS9oYyUFvAYF3GoTAzY6LMUBVZdVq8aMzSFPzal046WQ
        aX1RaMhurNYhvJrL/FvvO4fVeZ7pGzsRMGijSg0pAfVH9KivcSEnXWxDbViWpqpzSvSxboS741BmB
        seVcCxjlLoNkA50vDuZGj8LIohCxzWsYsBZ8VxsKjAGqhJ7vm/HNw2UG67a8Ov0LEINRWxED+EAMB
        aja8aaXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXMqF-00DRPE-99; Thu, 24 Mar 2022 12:45:27 +0000
Date:   Thu, 24 Mar 2022 12:45:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, david@redhat.com,
        yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn,
        yang.shi@linux.alibaba.com, dave.hansen@linux.intel.com,
        minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v3] mm/vmstat: add events for ksm cow
Message-ID: <Yjxn53YcdKDcV7zX@casper.infradead.org>
References: <20220324104332.2350482-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324104332.2350482-1-yang.yang29@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:43:33AM +0000, cgel.zte@gmail.com wrote:
> +++ b/include/linux/vm_event_item.h
> @@ -131,6 +131,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		SWAP_RA_HIT,
>  #ifdef CONFIG_KSM
>  		KSM_SWPIN_COPY,
> +		COW_KSM,

Shouldn't we call this KSM_COW?

> +++ b/mm/vmstat.c
> @@ -1390,6 +1390,7 @@ const char * const vmstat_text[] = {
>  	"swap_ra_hit",
>  #ifdef CONFIG_KSM
>  	"ksm_swpin_copy",
> +	"cow_ksm",

... and this "ksm_cow"?
