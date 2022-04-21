Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B7950AB30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442346AbiDUWKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442340AbiDUWKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:10:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FB44D63F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E348CE265F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61277C385A7;
        Thu, 21 Apr 2022 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650578867;
        bh=I/y6oOj7Cgwu++f5BI+q+wJEZ/y1EIcrQV1iyYFhfgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fAHKB5NS6TUUgG/fPwvW64fCyMd7wN06IX2YWbRZ/UY5SxFYkb+NuC981FjzhnP5k
         pSOYiO8c14AzHfRbwFrOI9xSnFeXYrm+h8kWwHkZXgkv24/NraOAZfX3A9v3NdkQtW
         bHR6tkRGCLRko7/s+7RaHW0A0g6WlAoVzNx+71yw=
Date:   Thu, 21 Apr 2022 15:07:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     ryabinin.a.a@gmail.com, dvyukov@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] kasan: Prevent cpu_quarantine corruption when CPU
 offline and cache shrink occur at same time
Message-Id: <20220421150746.627e0f62363485d65c857010@linux-foundation.org>
In-Reply-To: <20220414025925.2423818-1-qiang1.zhang@intel.com>
References: <20220414025925.2423818-1-qiang1.zhang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 10:59:25 +0800 Zqiang <qiang1.zhang@intel.com> wrote:

> The kasan_quarantine_remove_cache() is called in kmem_cache_shrink()/
> destroy(), the kasan_quarantine_remove_cache() call is protected by
> cpuslock in kmem_cache_destroy(), can ensure serialization with
> kasan_cpu_offline(). however the kasan_quarantine_remove_cache() call
> is not protected by cpuslock in kmem_cache_shrink(), when CPU going
> offline and cache shrink occur at same time, the cpu_quarantine may be
> corrupted by interrupt(per_cpu_remove_cache operation). so add
> cpu_quarantine offline flags check in per_cpu_remove_cache().
> 
> ...
>

Could we please have some reviewer input here?

> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -330,6 +330,8 @@ static void per_cpu_remove_cache(void *arg)
>  	struct cpu_shrink_qlist *sq;
>  #endif
>  	q = this_cpu_ptr(&cpu_quarantine);
> +	if (READ_ONCE(q->offline))
> +		return;
>  #ifndef CONFIG_PREEMPT_RT
>  	qlist_move_cache(q, &to_free, cache);
>  	qlist_free_all(&to_free, cache);

It might be helpful to have a little comment which explains why we're
doing this?
