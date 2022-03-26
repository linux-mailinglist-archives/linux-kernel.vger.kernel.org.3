Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447224E8032
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 10:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiCZJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiCZJpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 05:45:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766443DA5B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:43:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id yy13so19632367ejb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yfxgj/Ew8GtsKZPCVL1uR3/Y8py+M2d0hw2Q0ogbCkI=;
        b=gBouKIs8Cm2K91cJDxQvJqFumF11BVgxktUUcRlEDjkG3oM2XZ7TlqtxXZ2C8VFc/y
         kqWbx9oGwyr5gGQeJ7D/uWMwIru03efmlgaYKysu9FC0iWokBYPo50gWhMJ7iImBAruS
         GWkzT3va1fxi+LbTB6l+UKWEzEOc4b/WZScwTenQFCa2maAp6R1tMcM1ybWUzQEequwH
         v1odE+x4MZJFnHfseevplpTk0n3HdQx64de2jCihjZZ9XSrYB+5XdMgkDDc0l5zZzT2y
         Bic5c6weSYRh5SIhCZfZGBD5XpuDnXiv3lrSxxDPD8QrbcOr54uHURhT+7UcQL1h1COX
         0i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yfxgj/Ew8GtsKZPCVL1uR3/Y8py+M2d0hw2Q0ogbCkI=;
        b=T4uACI/kfO6BtqxzRw5F1d6japJr05fAumr0eIkNFzwH3NLYlb+fLEaLu50TlwVE3F
         WTWRvXl2gDGYWQcHKX10/Wt+cTBicvf/lyMFTP3iBqnwwAqLmkmTQFkvXcxYHjxUAeXS
         +a/KzRloif7ZYju3zcFb+wWVMaPKdJFUT1RpBT1nP7T8iknQAgAT8pHJVcoekd6XyWuF
         L6a6DxlSMxUcLh7hbiCwhy+JQ5GIWV3UcGAd9fR5EvXLX9gv6Bg98c/Si3AWnUj2azDi
         TJ5B90JpnhPKCKwIk0r7gKK1dmev0p1qrTwDuCDGIxN7QibzaIJfksOSv2PHJC2SD19K
         uagw==
X-Gm-Message-State: AOAM53247uKA40fjeLMXLHguGjSX5LtvLuYK7jqvENH/6tWmj6M7xCbN
        eR0ZfbD1vrTwvZbg0cANefE=
X-Google-Smtp-Source: ABdhPJwhYZcJ/HIuTsMeyvFWiwSv8qlUjBWvjL7XMyKXmWQ27W5gDtxRSRtaE7WfQtgi7WNA6Bxn8g==
X-Received: by 2002:a17:907:8a1c:b0:6df:ecd6:b6ea with SMTP id sc28-20020a1709078a1c00b006dfecd6b6eamr16335029ejc.530.1648287808769;
        Sat, 26 Mar 2022 02:43:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm3935992edt.70.2022.03.26.02.43.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Mar 2022 02:43:28 -0700 (PDT)
Date:   Sat, 26 Mar 2022 09:43:27 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: use helper isolation_suitable
Message-ID: <20220326094327.hofczncyzqyrxdxw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220322110750.60311-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322110750.60311-1-linmiaohe@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 07:07:50PM +0800, Miaohe Lin wrote:
>Use helper isolation_suitable to check whether page is suitable to isolate
>to simplify the code. Minor readability improvement.
>
>Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/compaction.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/compaction.c b/mm/compaction.c
>index c3e37aa9ff9e..86f34053c39d 100644
>--- a/mm/compaction.c
>+++ b/mm/compaction.c
>@@ -899,7 +899,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> 		 * not falsely conclude that the block should be skipped.
> 		 */
> 		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
>-			if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
>+			if (!isolation_suitable(cc, page)) {
> 				low_pfn = end_pfn;
> 				page = NULL;
> 				goto isolate_abort;
>-- 
>2.23.0

-- 
Wei Yang
Help you, Help me
