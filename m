Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215A951E94B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386957AbiEGS7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiEGS7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:59:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9A516582
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 11:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5E18B8068C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 18:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46292C385A6;
        Sat,  7 May 2022 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651949712;
        bh=7rn33Sp/e6WnCbFwK/qpy6Dee1uaXAmD+nFiEx4fKm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EptbxKmh5IABjgpAEmn6sOR4C+RQQsW3FGxSo6190QIdcApQ3SBVTMm7924/fdRTq
         pr0D5/E0vWYsA+sRvZ+Iw4RqlSYpzL39jj1VueSiuxyGLTcrhAM/IJVOQ1T4HKZx3s
         +JV9jx5SCOdwIU3G/RF8vWJjSDNZxzyjizrZyZOY=
Date:   Sat, 7 May 2022 11:55:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cgel.zte@gmail.com
Cc:     hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/shmem: fix build failure when
 CONFIG_TRANSPARENT_HUGEPAGE is not set
Message-Id: <20220507115511.bfe87f9126aefad64894807e@linux-foundation.org>
In-Reply-To: <20220505113354.202979-1-xu.xin16@zte.com.cn>
References: <20220505113354.202979-1-xu.xin16@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 May 2022 11:33:55 +0000 cgel.zte@gmail.com wrote:

> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> shmem_add_to_page_cache() use THP_FILE_FALLBACK even if
> CONFIG_TRANSPARENT_HUGEPAGE is not set and triggers this
> compile error.
> 
> Add ifdef CONFIG_TRANSPARENT_HUGEPAGE in shmem_add_to_page_cache().

Thanks.

> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -717,10 +717,12 @@ static int shmem_add_to_page_cache(struct folio *folio,
>  	if (!folio_test_swapcache(folio)) {
>  		error = mem_cgroup_charge(folio, charge_mm, gfp);
>  		if (error) {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  			if (folio_test_large(folio)) {
>  				count_vm_event(THP_FILE_FALLBACK);
>  				count_vm_event(THP_FILE_FALLBACK_CHARGE);
>  			}
> +#endif
>  			goto error;
>  		}
>  	}

I believe Matthew address this in version 2 of "Folio patches for
5.19".

I'm aiming to get that (and much more!) pushed out or Monday's linux-next.
