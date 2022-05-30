Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5971353770E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiE3IsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiE3IsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:48:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21B29827
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:48:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f18so9783947plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feOMts/VuZSIeHiNfKMOMQaa2Lngj60rb3I4zPEV1nE=;
        b=LNETF7LxgwnA/JC0t0tE+Sqvi1bNtFJcfgCIdBpT5U7ElyPh/T0bXNGprsfa3V8DSt
         7Tub5LKllSyqzBTT6AuAdxpPkDLQbz79+uGOB8jMfe9/7ZWjiAYYoJIz4IBSpx762vij
         MgWxGEBT48SAuapEwntW/SUnMj54L9QUVITD7jvIME8pg0yvSnug2sVhYDtQlMyCLIRR
         oRkQXQy2GwH5Kq7RnF3l6xGwsOExEbkwE2gbil9tDR4ksW65hUToiUEBS1GUEr6Kmj8U
         gfHcqUhzgdoALSe550NiGZ/CZNFbSBO6lOmmWTDKrVPxTGAEw9f/wd1QzenBg0J/gbuL
         QkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feOMts/VuZSIeHiNfKMOMQaa2Lngj60rb3I4zPEV1nE=;
        b=fqt+0BxhEJM6jxrRnqXF/ez8kkdzVO2LhP/aWLlJNPbiXEpbtIBXJ/TZTeyJFHqGth
         pdB7Y5AGGnd06g8ijfrMuzH+sJzctj+8KN0q461dhf1DbhCe+YFc1IVSyEGy7oehwASw
         /a1mfk9+UtzsG5ZT5qpHKjRy39Y1PZiFyfRi19aA0AySi+iUQnNeG/kJ8v6qITSa5gWU
         XntBjNaj4yC2x2SAstD7Ss4UZxuVGqjRUW7k2K+X520qy98YvKZt25D1MqOgob+1Undr
         6b4qM1Y4rZclHIx+6vo02xzjDt9AVcd4BovR69+dn6mNiAoKE9PFUVP/2vXzxLTWC9U3
         DlVA==
X-Gm-Message-State: AOAM530Zq8dVN0LPvgK8y1orhUILtIakm5WvfyxhKDCnuGBO0C7AXgyj
        5g49Ch1lgjxfx5RVBORk5KuKABvIkDYVwg==
X-Google-Smtp-Source: ABdhPJxIwH4c5C0ZLb6rha+vdwojSirx7a3+VcyQmS6YlhYPt2JMS1+sU1SJOlQ41vMAnvpIGxNzLg==
X-Received: by 2002:a17:90b:17c6:b0:1e2:ab17:a8f9 with SMTP id me6-20020a17090b17c600b001e2ab17a8f9mr10709855pjb.68.1653900497365;
        Mon, 30 May 2022 01:48:17 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id k184-20020a6324c1000000b003c14af50615sm8122929pgk.45.2022.05.30.01.48.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 May 2022 01:48:16 -0700 (PDT)
Date:   Mon, 30 May 2022 16:48:43 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: fix 'backmost' member of
 z_erofs_decompress_frontend
Message-ID: <20220530164843.00002283.zbestahu@gmail.com>
In-Reply-To: <20220530075114.918874-1-o451686892@gmail.com>
References: <20220530075114.918874-1-o451686892@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 15:51:14 +0800
Weizhao Ouyang <o451686892@gmail.com> wrote:

> Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.
> 
> Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Good catch.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/zdata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 95efc127b2ba..94d2cb970644 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -214,7 +214,7 @@ struct z_erofs_decompress_frontend {
>  
>  #define DECOMPRESS_FRONTEND_INIT(__i) { \
>  	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> -	.mode = COLLECT_PRIMARY_FOLLOWED }
> +	.mode = COLLECT_PRIMARY_FOLLOWED, .backmost = true }
>  
>  static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
>  static DEFINE_MUTEX(z_pagemap_global_lock);

