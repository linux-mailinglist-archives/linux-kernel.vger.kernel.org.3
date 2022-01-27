Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946CF49E362
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiA0N2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiA0N2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:28:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FDC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v4R+MNxGDgvnMIoJyFCcOJOTz5XsOTVIOqF2Bb/omEc=; b=hgsE8gRvbfG2JlRme+qpvJKT/B
        SQuQT31cYgQK9w+KwtDvjpsX+XMQEW3qI3ziLuifc6HvKMwRx3c9mF17jeEv+7Gghi9ZgzhsNRPoE
        YtQ6/JrFn6P5y5OvdW8H2eQpRJI3QlPpPyBgnFW6O17SO81xJLWst9DAV+HhV9KvAA35xuySD6OM2
        3KCUpppL9QsKXKfjauclAOiTir5JxRPvw7O9JCmKsQ46wDNRO78wz54meFyxGDp9QGcI5eyDuuNlT
        M4TZcSlmCq4z65LgUUJ0DahtMA9oWi8GWmx1E6D9N5QwKhSM977+Ua1td0BeleC2W7P7XZTn6IT9k
        JYeca9eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD4pT-005GiJ-1P; Thu, 27 Jan 2022 13:28:47 +0000
Date:   Thu, 27 Jan 2022 13:28:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] tools: Move gfp.h and slab.h from radix-tree to lib
Message-ID: <YfKeD8xqPu60GJUf@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <777d0cfcf531357cfe39d53987aa964a3a42ce8b.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777d0cfcf531357cfe39d53987aa964a3a42ce8b.1643206612.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:21:19PM +0100, Karolina Drobnik wrote:
> +#include <linux/types.h>
> +
> +#define __GFP_ZERO		0x8000u
> +#define __GFP_DIRECT_RECLAIM	0x400000u
> +
> +#define __GFP_BITS_SHIFT 26
> +#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
> +
> +#define __GFP_HIGH		0x20u
> +#define __GFP_IO		0x40u
> +#define __GFP_FS		0x80u
> +#define __GFP_NOWARN		0x200u
> +#define __GFP_ATOMIC		0x80000u
> +#define __GFP_ACCOUNT		0x100000u
> +#define __GFP_KSWAPD_RECLAIM	0x2000000u

Why have you reordered the bits here?

> -#define __GFP_BITS_SHIFT 26
> -#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
> -
> -#define __GFP_HIGH		0x20u
> -#define __GFP_IO		0x40u
> -#define __GFP_FS		0x80u
> -#define __GFP_NOWARN		0x200u
> -#define __GFP_ZERO		0x8000u
> -#define __GFP_ATOMIC		0x80000u
> -#define __GFP_ACCOUNT		0x100000u
> -#define __GFP_DIRECT_RECLAIM	0x400000u
> -#define __GFP_KSWAPD_RECLAIM	0x2000000u

The original ordering makes more sense to me (but then it would; I did
it)
