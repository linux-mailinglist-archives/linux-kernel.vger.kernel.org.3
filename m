Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5C511F17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbiD0RHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243738AbiD0RH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:07:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8AE9FC7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 154C3B828A2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960DAC385A7;
        Wed, 27 Apr 2022 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651079052;
        bh=dlbegSDeOSUitJNljuKiN9X6VAGW8TSj+wga6up/0sI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FbVXI2r4uJ/piHLa7nOqx5fwgHLqi2ulk36UbsjNO9nyk3Ta2UsSRxa7Ds6uCijys
         0WKksg/fVJ+Y7GVLqMsP/GsHQbH/pEOdRKS/Kin6QbkZRQTl1EIcU4YTWi7EJrQn9G
         aFGYiaHQINuQCugftafHUp7PGN7LncIQDIsAotjY=
Date:   Wed, 27 Apr 2022 10:04:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
Message-Id: <20220427100411.8eaf54c51767c3e2b0b070a5@linux-foundation.org>
In-Reply-To: <20220427121413.168468-3-wangkefeng.wang@huawei.com>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
        <20220427121413.168468-3-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 20:14:11 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Add special check hook for architecture to verify addr, size
> or prot when ioremap() or iounmap(), which will make the generic
> ioremap more useful.
> 
> ...
>
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -964,6 +964,9 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> +bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
> +bool arch_iounmap_check(void __iomem *addr);

Pet peeve.  The word "check" is a poor one.  I gives no sense of what
the function is checking and it gives no sense of how the function's
return value relates to the thing which it checks.

Maybe it returns 0 on success and -EINVAL on failure.  Don't know!

Don't you think that better names would be io_remap_ok(),
io_remap_valid(), io_remap_allowed(), etc?


Other than that, 

Acked-by: Andrew Morton <akpm@linux-foundation.org>
