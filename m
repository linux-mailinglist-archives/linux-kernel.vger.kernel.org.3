Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3C0547AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiFLPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiFLPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:44:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30EE2ED63
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:44:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j7so3545401pjn.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sDXoUvF9HvlqoQcYGACYQ/XDUHt968ekXwv/rzATOLg=;
        b=uYODikCP+VbMeXAeEkPfiA0/WPN47Gy8epeNTvX4VPR2T9patprusHUG4n0DD+88S6
         L4MLSE8fLQzbNjPb9FApack4csETvvbZVFtpVI3fBAOCn/99ahV56lZTzPJMucV4FuFg
         gcktDO51ig0rLKU3JSEm5n0t7X9UI/me+uvROdyhblDRomOf1j+RhVDOvUqZCQnVnqpO
         ntNAJhRg89EH/2TpoZcnaStdB8ybLLvVDrr/IYhyyGUsME99RFklvLvFKIOcYgHDA63G
         cabmuMvQjNfRSQsRA4JR15IgLuAGPIABm54VfNnayT7FT+CLWZJWiTwnHA5WzVVzwQPa
         dVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDXoUvF9HvlqoQcYGACYQ/XDUHt968ekXwv/rzATOLg=;
        b=kTqaQlSDPUADEZFHljen7BpBoZJ7ytMhTs+ZLfCi8JitwZdTp1N659LMA/OUsjN+dY
         9G83p7NOHrmHWTBl7/z3lkeykqwAl51gQcOrVFrJ9LzNvRe0mmV9m+5WvPBNr3pLAuxr
         SwteBtL+QqAQfGoH4UAoB93X+hIlAWBvMF0Mf98UKB0/ZRL1BqJxwREdXIl56GSyRRbi
         lys5hmuy8zeEGODEececYIJnrT8XeiDJWtHvvul1Y8XdFoX9KGB6Tm0fibkvoqz7J5vf
         6a25EsqS0DTMOXpJrCNXnlFE+Nr9XtHS+BRh5YNHyM3vXldfRoeIJ4NBm3ZWPd8vhDqF
         Q1GQ==
X-Gm-Message-State: AOAM5336nKEmRCWLXPqohXSXUqsx5LYzehXJiJ6E4hFPjZ18UE4phfE4
        xAP9QKzYtaWTQPHXXoBxytVM33992bViiA==
X-Google-Smtp-Source: ABdhPJxCoE6EY4u6oA+K5cxA2kNS0LpB6DJ9qb0GGxknSxzY5UxyIDF2pHUD34LJmFweEv5WPDQxGA==
X-Received: by 2002:a17:902:ac8f:b0:163:fbb7:b057 with SMTP id h15-20020a170902ac8f00b00163fbb7b057mr55066011plr.67.1655048693203;
        Sun, 12 Jun 2022 08:44:53 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:f58b:e20:6b56:4b57])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903208a00b001689e31ff9dsm3243826plc.9.2022.06.12.08.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 08:44:52 -0700 (PDT)
Date:   Sun, 12 Jun 2022 23:44:47 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, joao.m.martins@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: minor clean up for
 memmap_init_compound()
Message-ID: <YqYJ771HRncznTy1@FVFYT0MHHV2J.googleapis.com>
References: <20220611021352.13529-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611021352.13529-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 10:13:52AM +0800, Miaohe Lin wrote:
> Since commit 5232c63f46fd ("mm: Make compound_pincount always available"),
> compound_pincount_ptr is stored at first tail page now. So we should call
> prep_compound_head() after the first tail page is initialized to take
> advantage of the likelihood of that tail struct page being cached given
> that we will read them right after in prep_compound_head().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> ---
> v2:
>   Don't move prep_compound_head() outside loop per Joao.
> ---
>  mm/page_alloc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4c7d99ee58b4..048df5d78add 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6771,13 +6771,18 @@ static void __ref memmap_init_compound(struct page *head,
>  		set_page_count(page, 0);
>  
>  		/*
> -		 * The first tail page stores compound_mapcount_ptr() and
> -		 * compound_order() and the second tail page stores
> -		 * compound_pincount_ptr(). Call prep_compound_head() after
> -		 * the first and second tail pages have been initialized to
> -		 * not have the data overwritten.
> +		 * The first tail page stores compound_mapcount_ptr(),
> +		 * compound_order() and compound_pincount_ptr(). Call
> +		 * prep_compound_head() after the first tail page have
> +		 * been initialized to not have the data overwritten.
> +		 *
> +		 * Note the idea to make this right after we initialize
> +		 * the offending tail pages is trying to take advantage
> +		 * of the likelihood of those tail struct pages being
> +		 * cached given that we will read them right after in
> +		 * prep_compound_head().
>  		 */
> -		if (pfn == head_pfn + 2)
> +		if (unlikely(pfn == head_pfn + 1))
>  			prep_compound_head(head, order);

For me it is weird not to put this out of the loop. I saw the reason
is because of the caching suggested by Joao. But I think this is not
a hot path and putting it out of the loop may be more intuitive at least
for me.  Maybe this optimization is unnecessary (maybe I am wrong).
And it will be consistent with prep_compound_page() (at least it does
not do the similar optimization) if we drop this optimization.

Hi Joao,

I am wondering is it a significant optimization for zone device memory?
I found this code existed from the 1st version you introduced.  So
I suspect maybe you have some numbers, would you like to share with us?

Thanks.

