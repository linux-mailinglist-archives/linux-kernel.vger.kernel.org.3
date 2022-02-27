Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26674C5F2B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiB0VwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiB0VwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:52:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE730517C5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:51:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678DF6113C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 21:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CDDC340E9;
        Sun, 27 Feb 2022 21:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645998689;
        bh=BmmJIepf1iiX/4lbzXOg/zxx9xG02hnaEb7WP56p4+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MuVkZFwOgSj62tmUAeFZOPXv2Zc8eeN8SH0dZDvxs+vAjTZuj3tr4WLZ0JkRPXram
         vHuY1DzRXmGPBS+n2S411n/mX1OvwRE8qu6KKC1W3N8g3p2FLeUyH+F6FoB7aRoqXG
         qP+JA/2PZJmpGlT8A8GS0Cr9twYVO49eeRJwGAy0=
Date:   Sun, 27 Feb 2022 13:51:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     pasha.tatashin@soleen.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use strtobool for param parsing
Message-Id: <20220227135128.3f5aabca43c7a33acea91cc8@linux-foundation.org>
In-Reply-To: <20220227181038.126926-1-linux@treblig.org>
References: <20220227181038.126926-1-linux@treblig.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 18:10:39 +0000 "Dr. David Alan Gilbert" <linux@treblig.org> wrote:

> Use strtobool rather than open coding "on" and "off" parsing in
> mm/hugetlb_vmemmap.c and mm/page_table_check.c.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  mm/hugetlb_vmemmap.c  | 12 +-----------
>  mm/page_table_check.c | 10 +---------
>  2 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c540c21e26f5b..919411386e547 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -192,17 +192,7 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
>  		return 0;
>  	}
>  
> -	if (!buf)
> -		return -EINVAL;
> -
> -	if (!strcmp(buf, "on"))
> -		hugetlb_free_vmemmap_enabled = true;
> -	else if (!strcmp(buf, "off"))
> -		hugetlb_free_vmemmap_enabled = false;
> -	else
> -		return -EINVAL;
> -
> -	return 0;
> +	return strtobool(buf, &hugetlb_free_vmemmap_enabled);
>  }
>  early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);

This part falls afoul of the changes in
https://lkml.kernel.org/r/20211101031651.75851-3-songmuchun@bytedance.com

> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 3763bd077861a..2458281bff893 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -23,15 +23,7 @@ EXPORT_SYMBOL(page_table_check_disabled);
>  
>  static int __init early_page_table_check_param(char *buf)
>  {
> -	if (!buf)
> -		return -EINVAL;
> -
> -	if (strcmp(buf, "on") == 0)
> -		__page_table_check_enabled = true;
> -	else if (strcmp(buf, "off") == 0)
> -		__page_table_check_enabled = false;
> -
> -	return 0;
> +	return strtobool(buf, &__page_table_check_enabled);
>  }

But this works OK.
