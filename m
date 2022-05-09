Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8384D52041A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiEISH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiEISHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6054028
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36ED8615DD
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B90FC385B4;
        Mon,  9 May 2022 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652119437;
        bh=RCqR7E+e88v1T6AamGxBpGhIcGsy4V7gM+0oan8ZkAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nc4O4PAMi8KjdjcpLV2zwGCVhL+a5FMfOdLsSBppvNtCRmUFWTooI0FQ3MmqTGRzJ
         vhVa8CGKwPA0MXtJr7w4nmmW7ichDCxqXahhZapcWgE2rkfNPZDW1EBTclw10XRcQ3
         Rh18x3oQfQHKYwOoRkzkv9HDn25eowcuD0JixPVA=
Date:   Mon, 9 May 2022 11:03:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     hughd@google.com, nathan@kernel.org, ndesaulniers@google.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] mm/shmem: restore setting of page variable
Message-Id: <20220509110356.3c1826c6bf1fd6a4d6ce6766@linux-foundation.org>
In-Reply-To: <20220509123232.3428667-1-trix@redhat.com>
References: <20220509123232.3428667-1-trix@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Mon,  9 May 2022 08:32:32 -0400 Tom Rix <trix@redhat.com> wrote:

> The clang build fails with
> mm/shmem.c:2337:8: error: variable 'page' is uninitialized when used here [-Werror,-Wuninitialized]
>   if (!page)
>        ^~~~
> 
> In the commit listed in the fixes, there was a change to the
> from
>   page = shmem_alloc_page(..);
> to
>   page = &shmem_alloc_folio(..)->page;
> But in this case, instead of replacing, the setting of page was
> deleted.  So restore page with its new api.
> 
> ...
>
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2334,6 +2334,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  
>  	if (!*pagep) {
>  		ret = -ENOMEM;
> +		page = &shmem_alloc_folio(gfp, info, pgoff)->page;
>  		if (!page)
>  			goto out_unacct_blocks;
>  

Thanks, this is fixed in v2 of Matthew's "Folio patches for 5.19"
series.

I've just now pushed all that out to kernel.org so next linux-next
should be a happier place.
