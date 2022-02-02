Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE604A7B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348048AbiBBXRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiBBXRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:17:21 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E14FC061714;
        Wed,  2 Feb 2022 15:17:21 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso967448otj.2;
        Wed, 02 Feb 2022 15:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SmM5LOXhBptwLoFRQx1xbAsZgGTvkZX2rXC6lKb25Rc=;
        b=afYIE2hcFMLGO3iC6MkgeyjxvbwUqtd06XMSOBgKA1JmeSorzZXwTl1okvDiOYnB9l
         I0H4UD7lxXr3PUThf/7IcIvIOsF5sWw5thHdOOKBvrdXNNtS/fD9Ym1WoVqea2HcAfwi
         6eEM+v9OMcXZhik2LMP/jIpsfUBHKKr1qXWqemYWSWpEtU8twc7PHCgRkvAj36dDXHKE
         uLVrjqstlVzY4jSFwk3Jc70uwRhAL+ie85/Q+5kwNmZl1ItfbAGYUKAEGF4u54rFb7cz
         Sw3GPDOyJc4VqVkcsGaX8KF/n9Nh4c/uPgrvkaSGfcBxTVFi0X7Uj8fFeP1i1rAsy4Ge
         cYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=SmM5LOXhBptwLoFRQx1xbAsZgGTvkZX2rXC6lKb25Rc=;
        b=UqPqRF20x5tjKZkHKVP93C2ErgpMRCYMEsjHTraMZHAKixjfI615vUBzN+oavEAP+x
         tUFwRDmIt6BOpS049uiBG2haLJ9dz+N6L6s71MJqX/hlkzlTZWSAS46P4hHWyeT2Ai4N
         WN92pl2BjlZ9naQIRwf/0IHj3HX0Hbnp8mrKB0iDx4uqU9MpU+BacbuoIXjX7qOHAulU
         CJ9Sv67rujDLRD5DSKaEuL29HvT879wfHJx8wCSTHe+nC/py23/SteMb0v0aH1Ccpxtr
         akp0/QErGDBhBnyJ3oxxJPOVmB/JOuHiLrBw/jzpRAo/SqJYY3vywgVj/y1v7ICiLf+5
         7Pfw==
X-Gm-Message-State: AOAM533x7ZZ4bkqShICCNu7fKrg03k9IvoDqw5JaidA5P6k2OEQZuFcu
        wfJkV6iOu03h/51x7EIoewH04eEwQ1KmGQ==
X-Google-Smtp-Source: ABdhPJzc1hV3sMwz9XpV4qq85jnj4BL44Eb+9Yn1lIeZrVv16PjI9mAH8w4AtSHfVcFztirlAFzaaQ==
X-Received: by 2002:a05:6830:4409:: with SMTP id q9mr18658445otv.316.1643843840802;
        Wed, 02 Feb 2022 15:17:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15sm21399821oil.13.2022.02.02.15.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:17:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Feb 2022 15:17:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alpha: Silence -Warray-bounds warnings
Message-ID: <20220202231718.GA2539669@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:18:25PM -0800, Kees Cook wrote:
> GCC 11 (incorrectly[1]) assumes that literal values cast to (void *)
> should be treated like a NULL pointer with an offset, and raises
> diagnostics when doing bounds checking:
> 
> In function '__memset',
>     inlined from '__bad_pagetable' at arch/alpha/mm/init.c:79:2:
> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
> In function '__memset',
>     inlined from '__bad_page' at arch/alpha/mm/init.c:86:2:
> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
> In function '__memset',
>     inlined from 'paging_init' at arch/alpha/mm/init.c:256:2:
> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);
> 
> This has been solved in other places[2] already by using the recently
> added absolute_pointer() macro. Do the same here.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
> [2] https://lore.kernel.org/all/20210912160149.2227137-1-linux@roeck-us.net/
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/alpha/mm/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
> index f6114d03357c..7511723b7669 100644
> --- a/arch/alpha/mm/init.c
> +++ b/arch/alpha/mm/init.c
> @@ -76,14 +76,14 @@ pgd_alloc(struct mm_struct *mm)
>  pmd_t *
>  __bad_pagetable(void)
>  {
> -	memset((void *) EMPTY_PGT, 0, PAGE_SIZE);
> +	memset(absolute_pointer(EMPTY_PGT), 0, PAGE_SIZE);
>  	return (pmd_t *) EMPTY_PGT;
>  }
>  
>  pte_t
>  __bad_page(void)
>  {
> -	memset((void *) EMPTY_PGE, 0, PAGE_SIZE);
> +	memset(absolute_pointer(EMPTY_PGE), 0, PAGE_SIZE);
>  	return pte_mkdirty(mk_pte(virt_to_page(EMPTY_PGE), PAGE_SHARED));
>  }
>  
> @@ -253,7 +253,7 @@ void __init paging_init(void)
>  	free_area_init(max_zone_pfn);
>  
>  	/* Initialize the kernel's ZERO_PGE. */
> -	memset((void *)ZERO_PGE, 0, PAGE_SIZE);
> +	memset(absolute_pointer(ZERO_PGE), 0, PAGE_SIZE);
>  }
>  
>  #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_SRM)
> -- 
> 2.30.2
> 
