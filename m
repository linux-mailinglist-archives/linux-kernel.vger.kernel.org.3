Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FFF520C25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiEJDlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiEJDlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB881AF11
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 20:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B2860FEF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA34AC385A6;
        Tue, 10 May 2022 03:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652153853;
        bh=u0w2ountQEspnJx1OvB2xdh1GwR7pdX0UpLOdtxe4No=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gcsYmCSOoAIwhc5cmUD0Dp6prNRhWcGrWK3kOdCYa7lT6TAUqs7SrTI4LEwGg31Xa
         v3ugo6H39von+tP/vYGROB5IjTTjuno0WEsz89L19+6CodY7claO0bYjDZ6eN8biEx
         hEwOo3dBW6F2gz88FgpNebscQBOtWDMy1bLJKfqU=
Date:   Mon, 9 May 2022 20:37:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yuanzheng Song <songyuanzheng@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: usercopy: move the virt_addr_valid() below the
 is_vmalloc_addr()
Message-Id: <20220509203732.951da2e00ddfa628decf24a2@linux-foundation.org>
In-Reply-To: <20220505071037.4121100-1-songyuanzheng@huawei.com>
References: <20220505071037.4121100-1-songyuanzheng@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew & Kees,

On Thu, 5 May 2022 07:10:37 +0000 Yuanzheng Song <songyuanzheng@huawei.com> wrote:

> The is_kmap_addr() and the is_vmalloc_addr() in the check_heap_object()
> will not work, because the virt_addr_valid() will exclude the kmap and
> vmalloc regions. So let's move the virt_addr_valid() below
> the is_vmalloc_addr().

The author,

> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>

Tells me off-list that this fix:

> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -163,9 +163,6 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  {
>  	struct folio *folio;
>  
> -	if (!virt_addr_valid(ptr))
> -		return;
> -
>  	if (is_kmap_addr(ptr)) {
>  		unsigned long page_end = (unsigned long)ptr | (PAGE_SIZE - 1);
>  
> @@ -190,6 +187,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  		return;
>  	}
>  
> +	if (!virt_addr_valid(ptr))
> +		return;
> +
>  	folio = virt_to_folio(ptr);
>  
>  	if (folio_test_slab(folio)) {

is required to fix patches "mm/usercopy: Check kmap addresses properly"
and "mm/usercopy: Detect vmalloc overruns".


