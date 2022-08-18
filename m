Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB29B598636
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbiHROnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245512AbiHROnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:43:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828DBBB682
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:43:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FFE05C0E6;
        Thu, 18 Aug 2022 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660833781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehxxtYiT/7vGJ/TPD19SxbCiDD4CS1ffwYO+jD11F24=;
        b=x2Oooyr1rv5hXpbjYlHXDOOrE7K3hD6lAiVEA/XSyALwUdztMiSJmLy/KS/ZdGualdBWTt
        e/krfuSrm5lscR0XntpSI3/pHprH8hNZt/eLknXIuEzKfhpbu0cyb6e7VQmHAGONS1IeOv
        ytEJ2cMsMP8GH/7JrD6tFG8Pmvc2vE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660833781;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehxxtYiT/7vGJ/TPD19SxbCiDD4CS1ffwYO+jD11F24=;
        b=moUWDkKjDbNLwr6Zj/MMtN8mOrAGY4g+PoTls3SPvljI+DDA29zMEAeHT0nC40swNDfHxf
        Nza99WP4WdzTTkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8032133B5;
        Thu, 18 Aug 2022 14:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zlr7LfRP/mJNAwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 18 Aug 2022 14:43:00 +0000
Message-ID: <9ef46ec0-f0fc-3712-b140-53e1471dd5d2@suse.cz>
Date:   Thu, 18 Aug 2022 16:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9] mm/page_owner.c: add llseek for page_owner
Content-Language: en-US
To:     Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org,
        vbabka@kernel.org
Cc:     minchan@kernel.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220818022425.31056-1-quic_yingangl@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220818022425.31056-1-quic_yingangl@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 04:24, Kassey Li wrote:
> It is too slow to dump all the pages, in some usage we just want dump
> a given start pfn, for example: CMA range or a single page.
> 
> To speed up and save time, this change allows specify start pfn
> by add llseek for page_onwer.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  Documentation/mm/page_owner.rst |  5 +++++
>  mm/page_owner.c                 | 24 +++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
> index f5c954afe97c..f18fd8907049 100644
> --- a/Documentation/mm/page_owner.rst
> +++ b/Documentation/mm/page_owner.rst
> @@ -94,6 +94,11 @@ Usage
>  	Page allocated via order XXX, ...
>  	PFN XXX ...
>  	// Detailed stack
> +    By default, it will do full pfn dump, to start with a given pfn,
> +    page_owner supports fseek.
> +
> +    FILE *fp = fopen("/sys/kernel/debug/page_owner", "r");
> +    fseek(fp, pfn_start, SEEK_SET);
>  
>     The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
>     in buf, uses regexp to extract the page order value, counts the times
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e4c6f3f1695b..25720d81bc26 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -497,8 +497,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		return -EINVAL;
>  
>  	page = NULL;
> -	pfn = min_low_pfn + *ppos;
> -
> +	if (*ppos == 0)
> +		pfn = min_low_pfn;
> +	else
> +		pfn = *ppos;
>  	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
>  	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
>  		pfn++;
> @@ -561,7 +563,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  			continue;
>  
>  		/* Record the next PFN to read in the file offset */
> -		*ppos = (pfn - min_low_pfn) + 1;
> +		*ppos = pfn + 1;
>  
>  		return print_page_owner(buf, count, pfn, page,
>  				page_owner, handle);
> @@ -570,6 +572,21 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  	return 0;
>  }
>  
> +static loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
> +{
> +	switch (orig) {
> +	case SEEK_SET:
> +		file->f_pos = offset;
> +		break;
> +	case SEEK_CUR:
> +		file->f_pos += offset;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return file->f_pos;
> +}
> +
>  static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>  {
>  	unsigned long pfn = zone->zone_start_pfn;
> @@ -660,6 +677,7 @@ static void init_early_allocated_pages(void)
>  
>  static const struct file_operations proc_page_owner_operations = {
>  	.read		= read_page_owner,
> +	.llseek		= lseek_page_owner,
>  };
>  
>  static int __init pageowner_init(void)

