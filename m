Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF75A779B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiHaHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaHhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557CAFAF6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661931459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPfv20m8zbbkOILlJ7mqdR3+5PwtptpQm0e1PHBqTYA=;
        b=Z3pdyanOhh5d4gE+Jfu3SknmcbdvfLa0c4L8VJLtMNqxN622zBBv0tZ+KIHN/+s1gln3LG
        TObUeKIT3A+WGUc1Be94Xh+Fj6OuGq7v3ppo+3DPVeBrI/oTKMGzNgIoxHr0/RRhsr9x7p
        BFYlE6xzcd0Mq91j+T8wN8+Xusb0mhM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-zPm5yYWbOaWdrOkP8bXzoA-1; Wed, 31 Aug 2022 03:37:37 -0400
X-MC-Unique: zPm5yYWbOaWdrOkP8bXzoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 533741C07821;
        Wed, 31 Aug 2022 07:37:37 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C3FC2166B2A;
        Wed, 31 Aug 2022 07:37:36 +0000 (UTC)
Date:   Wed, 31 Aug 2022 15:37:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songliubraving@fb.com, Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Message-ID: <Yw8PvP/SjDCE6DDX@MiWiFi-R3L-srv>
References: <20220831052734.3423079-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831052734.3423079-1-song@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 at 10:27pm, Song Liu wrote:
> find_vmap_lowest_match() is now able to handle different roots. Make
> similar changes to find_vmap_lowest_match_check() and
> find_vmap_lowest_linear_match() to handle different trees.

Good catch. Guess usually nobody eables DEBUG_AUGMENT_LOWEST_MATCH_CHECK
to trigger compilation of the code.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Fixes: f9863be49312 ("mm/vmalloc: extend __alloc_vmap_area() with extra arguments")
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  mm/vmalloc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dd6cdb201195..088b421601c4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1300,12 +1300,12 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
>  #include <linux/random.h>
>  
>  static struct vmap_area *
> -find_vmap_lowest_linear_match(unsigned long size,
> +find_vmap_lowest_linear_match(struct list_head *head, unsigned long size,
>  	unsigned long align, unsigned long vstart)
>  {
>  	struct vmap_area *va;
>  
> -	list_for_each_entry(va, &free_vmap_area_list, list) {
> +	list_for_each_entry(va, head, list) {
>  		if (!is_within_this_va(va, size, align, vstart))
>  			continue;
>  
> @@ -1316,7 +1316,8 @@ find_vmap_lowest_linear_match(unsigned long size,
>  }
>  
>  static void
> -find_vmap_lowest_match_check(unsigned long size, unsigned long align)
> +find_vmap_lowest_match_check(struct rb_root *root, struct list_head *head,
> +			     unsigned long size, unsigned long align)
>  {
>  	struct vmap_area *va_1, *va_2;
>  	unsigned long vstart;
> @@ -1325,8 +1326,8 @@ find_vmap_lowest_match_check(unsigned long size, unsigned long align)
>  	get_random_bytes(&rnd, sizeof(rnd));
>  	vstart = VMALLOC_START + rnd;
>  
> -	va_1 = find_vmap_lowest_match(size, align, vstart, false);
> -	va_2 = find_vmap_lowest_linear_match(size, align, vstart);
> +	va_1 = find_vmap_lowest_match(root, size, align, vstart, false);
> +	va_2 = find_vmap_lowest_linear_match(head, size, align, vstart);
>  
>  	if (va_1 != va_2)
>  		pr_emerg("not lowest: t: 0x%p, l: 0x%p, v: 0x%lx\n",
> @@ -1513,7 +1514,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  		return vend;
>  
>  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> -	find_vmap_lowest_match_check(size, align);
> +	find_vmap_lowest_match_check(root, head, size, align);
>  #endif
>  
>  	return nva_start_addr;
> -- 
> 2.30.2
> 

