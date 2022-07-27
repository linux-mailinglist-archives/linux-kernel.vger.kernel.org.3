Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10D658232C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiG0Jdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiG0Jdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC8A286D0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9DA4617AD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1E8C433C1;
        Wed, 27 Jul 2022 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658914417;
        bh=6Mk43boL7n4AfNnssO3TRzTylRUQVCu7yWdz07hbC5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npDt2sUoMwyKg8WwtJeoFBJwPiY+9K+He+v6kiOSBPXh0JOfeLqelTMS6uGRqBB9g
         mIQT2BJ2B5bcEp6PSm4MyDv1vl/wp8omH6D7gVAmFI1U5h3BeYxUYPx+mykSESVjWR
         zvw6vD1DT3aa/7f66oeJ2Hupd5UGxXR+L7hDdFRhNNJOFYZ0whblf+bxe/PGd9EGZz
         aKBZkx457mFkzxf6ta1jzIrIFkQG1FmeV0IVD90Siy8fIu6cfwHOye9yLg3yHp6BNS
         FWGSOrNZW7ZhhVG6PyshKkH/T3GbHtCjPcrKBcOoGRJmkTut0tnSVlIPa4TxoZvq/k
         ntSsno6Chr42g==
Date:   Wed, 27 Jul 2022 12:33:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     mawupeng1@huawei.com, jrdr.linux@gmail.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memblock tests: compiling error
Message-ID: <YuEGZKpXCoj7P/pV@kernel.org>
References: <1658889585-20778-1-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658889585-20778-1-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 27, 2022 at 10:39:45AM +0800, Liu Xinpeng wrote:
> Subject: [PATCH v3] memblock tests: compiling error

"fix compilation errors" looks better, don't you think?

Another thing, is when you post vN of a patch please add a "patch
changelog" that describes the changes to the previous version.

I'd suggest to take a look at sections "Respond to review comments" and
"Don't get discouraged - or impatient" of the submitting patches guide.

https://kernel.org/doc/html/latest/process/submitting-patches.html

> memblock.o: In function `memblock_find_in_range.constprop.9':
> memblock.c:(.text+0x4651): undefined reference to `pr_warn_ratelimited'
> memblock.o: In function `memblock_mark_mirror':
> memblock.c:(.text+0x7171): undefined reference to `mirrored_kernelcore'

As people pointed in v1 thread, the description on how to reproduce this is
missing.
 
> Fixes: 902c2d91582c ("memblock: Disable mirror feature if kernelcore is not specified")
> Fixes: 14d9a675fd0d ("mm: Ratelimited mirrored memory related warning messages")
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  tools/testing/memblock/internal.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
> index c2a492c05e0c..fdb7f5db7308 100644
> --- a/tools/testing/memblock/internal.h
> +++ b/tools/testing/memblock/internal.h
> @@ -9,6 +9,10 @@
>  static int memblock_debug = 1;
>  #endif
>  
> +#define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__)
> +
> +bool mirrored_kernelcore = false;
> +
>  struct page {};
>  
>  void memblock_free_pages(struct page *page, unsigned long pfn,
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.
