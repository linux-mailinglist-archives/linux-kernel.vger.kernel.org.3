Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62674B3C32
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 17:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiBMQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:00:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiBMQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:00:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44F5A091;
        Sun, 13 Feb 2022 08:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=SXQfB7kbT48CWKMa0ZX7Y7yooHLKNEo9Hwc9PGnJWAQ=; b=R5etCFnU6kJ8Q16aqktN5TbUrL
        bzbzHIqQdpk0I+fjWy2aPaQHIVjbk27VHm12uyFxM7ehAKVkYZzlALmE8/ddBsQ9eG/zh/xG9Y5uD
        azweoivO9Tjp6jnkoK79p9cVreuw+zuxUUhWcuhT2UiHIx1mX49xUWTu2CfIUcYQYSgjvok1KdB14
        lQu8exn4z7sOg1baCsSL3qPJlUYP+xoPjxBzHuX6QUJ7O2n3lFk+oM5A+ujZEPg49XX0pdAmW0jQq
        MLdxkhpF8iifbaI8m/UfNSABN8Hi/iMdi4naRqLwCjyqKFmjPB0+9CD5eNBxbsV4IevoYaF4FTdSr
        fYMAOYJA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJHIT-009gP6-HY; Sun, 13 Feb 2022 16:00:21 +0000
Message-ID: <98208fa3-4b28-cdeb-7699-dbd9d66bfa60@infradead.org>
Date:   Sun, 13 Feb 2022 08:00:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/1] csky: Fixup compile warning
Content-Language: en-US
To:     wonder_rock@126.com, guoren@kernel.org
Cc:     axboe@kernel.dk, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220213142850.31526-1-wonder_rock@126.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220213142850.31526-1-wonder_rock@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2/13/22 06:28, wonder_rock@126.com wrote:
> From: Deyan Wang <wonder_rock@126.com>
> 
> arch/csky/include/asm/io.h: 8 linux/version.h not needed.
> arch/csky/kernel/process.c: 5 linux/version.h not needed.
> arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.
> 
> Signed-off-by: Deyan Wang <wonder_rock@126.com>

The patch makes sense but these are not compile warnings.
They come from scripts/checkversion.pl, which can be called
by 'make versioncheck', so I suppose that something in your
build system is running 'make versioncheck'.

You could just say "csky: fix versioncheck warnings"


> ---
>  arch/csky/include/asm/io.h | 1 -
>  arch/csky/kernel/process.c | 1 -
>  arch/csky/mm/dma-mapping.c | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> index f82654053dc0..ed53f0b47388 100644
> --- a/arch/csky/include/asm/io.h
> +++ b/arch/csky/include/asm/io.h
> @@ -5,7 +5,6 @@
>  
>  #include <linux/pgtable.h>
>  #include <linux/types.h>
> -#include <linux/version.h>
>  
>  /*
>   * I/O memory access primitives. Reads are ordered relative to any
> diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> index 3d0ca22cd0e2..5de04707aa07 100644
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -2,7 +2,6 @@
>  // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
>  
>  #include <linux/module.h>
> -#include <linux/version.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/debug.h>
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index c3a775a7e8f9..82447029feb4 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -9,7 +9,6 @@
>  #include <linux/mm.h>
>  #include <linux/scatterlist.h>
>  #include <linux/types.h>
> -#include <linux/version.h>
>  #include <asm/cache.h>
>  
>  static inline void cache_op(phys_addr_t paddr, size_t size,

-- 
~Randy
