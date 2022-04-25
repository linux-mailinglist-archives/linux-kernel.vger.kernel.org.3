Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3697950D6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiDYBus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiDYBuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:50:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35F39832
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:47:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dk23so3491520ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2OlxvgRz6gwI5nNvMM3z7YvQr4q+ev7JP+nvVLGlUIY=;
        b=CNO2fSDrLBIBAxczUSliIXtW28R/XERsoBnUjAlUZxxNKQ+lP9wXTmyTy5JsdpxDcq
         8ULjO/ONYlzDUkxakL29bz13S4HF/CZzCzs52y549RXh9Nfk9PX2P5XaLGxhiaoQRE7S
         Eh5ti2EkrkvEMKwCFgZdZ9+EcFf3vYvR+CLy/7GechJkvF3+4U1NlD18oOzew3okaAuw
         HaHOJjGI6+PDMV9Uu602bIf7btdeFFyRMuxHjRyL0NH3oMfzP/eRuivYfWOuCDf6AYKt
         N7jtgi4nJf59hwl6ZvwW2G8vSJJq+7MjfJBpXKTGsYPu0wZjjUBAA38DXq0zC/GDajhT
         b+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OlxvgRz6gwI5nNvMM3z7YvQr4q+ev7JP+nvVLGlUIY=;
        b=vsTxTtyghdBUG+gIhwNFCgDlJdfH9aeqBRNfQbpOZwYXDj4CVeYwmoWQIVovEsc8cU
         3LgLteoTFNVWS/jNqnJ/ja6/WkPJqYCKuHStf2gAGxfRhj0oevZ4LrB0lZu0s6i8bweL
         VmQYovVZRLsbXCIbkc9qTB+6faDKJiYmREO/18svN2vj0FXrAky4DKGeCRV8dk0o1jXJ
         lY1F2oLPEAcNgXuBB/SYCw0zZCuImLAhdl/eqCBWfZB5bQ1zYz1B3qct0b1e5yTKmyDI
         Sq4UhwVwlah7y1uB6p8v897nKMKb8Z6cS+0YBWBcb79bw7phUISQGUm0lzTvbM/OJd1O
         0JPw==
X-Gm-Message-State: AOAM530QIVLh0YVxSESsspzyuioaCrhVAgAyd8z4eyJwpIXIqML2ks/v
        Q4mTh7FyGokpeZj2uCclck8=
X-Google-Smtp-Source: ABdhPJw9ejQFG3jJ9prY7xuqrqGbqsCetyeT+p8tkbMaxcD5/0MXfgMxEnUboAYeKMcePVBjaUZ4YQ==
X-Received: by 2002:a17:907:3d91:b0:6df:a01c:f7cd with SMTP id he17-20020a1709073d9100b006dfa01cf7cdmr14241217ejc.255.1650851261311;
        Sun, 24 Apr 2022 18:47:41 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm3082312ejd.72.2022.04.24.18.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 18:47:40 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Date:   Mon, 25 Apr 2022 03:47:38 +0200
Message-ID: <8929547.CDJkKcVGEf@leap>
In-Reply-To: <20220424104806.25396-1-fmdefrancesco@gmail.com>
References: <20220424104806.25396-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 24 aprile 2022 12:48:06 CEST Fabio M. De Francesco wrote:
> Call VM_BUG_ON() if offset + len > PAGE_SIZE.
> 
> This is an RFC patch because I'm not sure if we actually need to 
BUG_ON(),

Actually I considered VM_BUG_ON() for consistency with the other functions 
in highmem.h

What about VM_WARN_ON_ONCE() here and also in memset_page?

Thanks,

Fabio

> so I'd like to know what Maintainers and other developers think about 
this
> proposal.
> 
> Please note that memset_page() uses VM_BUG_ON() to prevent the same 
issue.
> 
> Furthermore, I also cannot understand why memset_page() does not call
> flush_dcache_page() after memset() but I suppose that the different
> implementations of these two functions should be addressed in another 
RFC.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  include/linux/highmem.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index c3d562b5f0c1..bdb16d5f8148 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -349,6 +349,8 @@ static inline void memcpy_to_page(struct page *page, 
size_t offset,
>  static inline void memzero_page(struct page *page, size_t offset, size_t 
len)
>  {
>  	char *addr = kmap_local_page(page);
> +
> +	VM_BUG_ON(offset + len > PAGE_SIZE);
>  	memset(addr + offset, 0, len);
>  	flush_dcache_page(page);
>  	kunmap_local(addr);
> -- 
> 2.34.1
> 
> 




