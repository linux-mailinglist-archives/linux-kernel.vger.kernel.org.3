Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76F54ABEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448689AbiBGNMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446746AbiBGMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:43:52 -0500
X-Greylist: delayed 943 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 04:41:05 PST
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A3E02C23C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:41:05 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jslgm5HKqzbjxB;
        Mon,  7 Feb 2022 20:24:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 20:25:20 +0800
Subject: Re: [PATCH] mm: Remove usercopy_warn()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <5f26643fc70b05f8455b60b99c30c17d635fa640.1644231910.git.christophe.leroy@csgroup.eu>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b6e9e005-1269-d591-77b0-7db2edd996f4@huawei.com>
Date:   Mon, 7 Feb 2022 20:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5f26643fc70b05f8455b60b99c30c17d635fa640.1644231910.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/7 19:05, Christophe Leroy wrote:
> Users of usercopy_warn() were removed by
> commit 53944f171a89 ("mm: remove HARDENED_USERCOPY_FALLBACK")
> 
> Remote it.

s/Remote/Remove/

Except the above nit, this patch looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> 
> Cc: Stephen Kitt <steve@sk2.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/uaccess.h |  2 --
>  mm/usercopy.c           | 11 -----------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index ac0394087f7d..bca27b4e5eb2 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -401,8 +401,6 @@ static inline void user_access_restore(unsigned long flags) { }
>  #endif
>  
>  #ifdef CONFIG_HARDENED_USERCOPY
> -void usercopy_warn(const char *name, const char *detail, bool to_user,
> -		   unsigned long offset, unsigned long len);
>  void __noreturn usercopy_abort(const char *name, const char *detail,
>  			       bool to_user, unsigned long offset,
>  			       unsigned long len);
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index d0d268135d96..e7b0cb49daa1 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -70,17 +70,6 @@ static noinline int check_stack_object(const void *obj, unsigned long len)
>   * kmem_cache_create_usercopy() function to create the cache (and
>   * carefully audit the whitelist range).
>   */
> -void usercopy_warn(const char *name, const char *detail, bool to_user,
> -		   unsigned long offset, unsigned long len)
> -{
> -	WARN_ONCE(1, "Bad or missing usercopy whitelist? Kernel memory %s attempt detected %s %s%s%s%s (offset %lu, size %lu)!\n",
> -		 to_user ? "exposure" : "overwrite",
> -		 to_user ? "from" : "to",
> -		 name ? : "unknown?!",
> -		 detail ? " '" : "", detail ? : "", detail ? "'" : "",
> -		 offset, len);
> -}
> -
>  void __noreturn usercopy_abort(const char *name, const char *detail,
>  			       bool to_user, unsigned long offset,
>  			       unsigned long len)
> 

