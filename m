Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F53584C87
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiG2H1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiG2H1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:27:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBA80491
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B510561AB3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C863BC433C1;
        Fri, 29 Jul 2022 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659079649;
        bh=F53e3bQCi5VSjoYJytdJxDYdjCMvg5RkmdKiXFozHOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRWAzYLEg1sS8ntUOOhIaAtUFUqYGWsM+tqTX1pelES2vWAeoACG57Ko68pA4jIEX
         wWqb+0lnIqUjDq7NIoyYiap5zZRO4/E3pJSbRYUnw5qVaLj7zxXCGn+Xri85GyGk51
         /VWwfSXYMJ5tBNJJcoUp3wIxpFhP5l9jG1XlBaJ9AFEyyoUFaSC1F28j8EH3zZfPDd
         AiFk8FfKt5YNHjZe1sh/8+qGvDZgenxIrngqtBPELFc85ZDYVtc2c1VQ5mBWH/vT7X
         GvVvzjsdYiLNMFdNgRA+QWu2PqgzP8yR4fywI7oxypEP+fxNVcLbaW/AaQnwA+HsGm
         NOQ9wiKrfw9TA==
Date:   Fri, 29 Jul 2022 10:27:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     mawupeng1@huawei.com, jrdr.linux@gmail.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] memblock tests: fix compilation errors
Message-ID: <YuOL0xVjXwgEaJSX@kernel.org>
References: <1658916453-26312-1-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658916453-26312-1-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 06:07:33PM +0800, Liu Xinpeng wrote:
> Do 'make -C tools/testing/memblock', get the following errors:
> 
> memblock.o: In function `memblock_find_in_range.constprop.9':
> memblock.c:(.text+0x4651): undefined reference to `pr_warn_ratelimited'
> memblock.o: In function `memblock_mark_mirror':
> memblock.c:(.text+0x7171): undefined reference to `mirrored_kernelcore'
> 
> Fixes: 902c2d91582c ("memblock: Disable mirror feature if kernelcore is not specified")
> Fixes: 14d9a675fd0d ("mm: Ratelimited mirrored memory related warning messages")
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>

Applied, thanks!
 
> ---
> Changelog:
> V3 -> V4: Changed the title and add how to reproduce this issue.
> V2 -> V3: Fixs should not have word wrap.
> V1 -> V2: Removed comma in macro define and addressed review comments.
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
