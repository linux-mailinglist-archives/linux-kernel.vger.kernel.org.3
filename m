Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E48B54707F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 02:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbiFKAV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 20:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKAV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 20:21:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6E659B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:21:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so545770plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=orRX8bHVwIqsWUTRBwudWprTpQENg/NL+oJ4ZA+qZSY=;
        b=XX855K/KCSKksyKnZmDsq5LuDRpawKh8kCwaNYSD3SP6Ep0RiA+aK04+29Hj15VSGb
         JWWokbqxXkNXk/jZGM6Zx1c7qXldpMbhCf0V+NzDjbCOcz56XaWgu2mHkMMGwa0gD4UC
         JCS2kRNxOsPLQk7JnL2qpSjI23R1MXgtlteHAW5Ln6pSPe8Y53VzOlBg4TW3vgWhxmo2
         CftyR7g9fpPW7NcbSV6OUggXfrDWTDIPMZ+vp7AEm7/C19WKRF0ytvoS8QjC6WZkIm/d
         NEZleUq8wTkzzh2Qj8KQnRCQL0n98GNqnngu6b0GWxeN0mjYmDtSNrINCfnCrs5tMxkI
         MwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=orRX8bHVwIqsWUTRBwudWprTpQENg/NL+oJ4ZA+qZSY=;
        b=47PH0jRBOx56zKhvEVcX6LOP2HDy5yEdBWRuzV3UpO5x3EOxsESVpddVzELHL2tYo0
         FdET8a1oh31y5qwWWecLv0qgZU62ZJINzubTC0IrIV8vzilRH6hv2Rs4ysl2H9Xu6W/K
         WCWHooHW+d7Sp+Lf3PB7ggzkUY6pOnKuy2tAIkXhIBkbd4hnNSTDnzU3i/Guc+avnx51
         fhqv5794/l9r9I1qGncaIeakQCM7dHu6B+fmdEY45K/t1BHuSUdf7Cu9USn1GT0d4y5Q
         68Xm1uQQWS9yrYQJG5EeeREwcANGMeSpXQv+wGrgUJdRz97rZhFSv2lITHGayz/4XOMm
         +B+g==
X-Gm-Message-State: AOAM5333B4RtAE3fT7+mQWLnDdQcUGMTil4fiY3M4V/r2TwmQzafLFe7
        6TWc9fZnRLtDS2kHe1YVAZY=
X-Google-Smtp-Source: ABdhPJzKHW5ysdJSDgBl6PDlb7cpzIxSRALSt4qhbmbmz70oiMOuX0yoegoVqE9ep9iTSoq7MYirrg==
X-Received: by 2002:a17:90b:1b48:b0:1e8:5885:f8b with SMTP id nv8-20020a17090b1b4800b001e858850f8bmr2354020pjb.122.1654906914680;
        Fri, 10 Jun 2022 17:21:54 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6481:5f82:42f7:8bcc])
        by smtp.gmail.com with ESMTPSA id w1-20020a62c701000000b0050dc7628148sm162963pfg.34.2022.06.10.17.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 17:21:54 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 10 Jun 2022 17:21:52 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com, jgg@ziepe.ca,
        david@redhat.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Message-ID: <YqPgIJ2+OaltxRmV@google.com>
References: <165490039431.944052.12458624139225785964.stgit@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165490039431.944052.12458624139225785964.stgit@omen>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:35:13PM -0600, Alex Williamson wrote:
> The commit referenced below subtly and inadvertently changed the logic
> to disallow pinning of zero pfns.  This breaks device assignment with
> vfio and potentially various other users of gup.  Exclude the zero page
> test from the negation.
> 
> Fixes: 1c563432588d ("mm: fix is_pinnable_page against a cma page")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> At least I assume this was inadvertent...  If there's a better fix,
> please run with it as I'm out of the office the 1st half of next
> week and would like to see this fixed ASAP.  Thanks!
> 
>  include/linux/mm.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..781fae17177d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1600,7 +1600,7 @@ static inline bool is_pinnable_page(struct page *page)
>  	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>  		return false;
>  #endif
> -	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
> +	return !is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page));

Thanks for catching!

I don't think zero pfn could stay in the movable zone or CMA area.

Acked-by: Minchan Kim <minchan@kernel.org>
