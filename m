Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087804A757F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbiBBQJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBBQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:09:06 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B08C061714;
        Wed,  2 Feb 2022 08:09:06 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so19875317otr.11;
        Wed, 02 Feb 2022 08:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v6kuMWAWRh6UNWKt1To15PX+Alnw0cwwwqkktpikgvU=;
        b=lQg/DOsL9qtQzb83BcwHQB57seYU+r6Wb6Tn+EsFeSafq5cg0JB8z8wGhb8pKi/e/B
         x08nwRT8WIQdSzde8afN7+G8vSgEcj+un4DDDjOsKw0l3rzFhaW2ShFs9YQBiFfxt7ZT
         aZBRjlPhbEQ+w/OZUQfec2B5m5Jo+/OB5ByWasga8tKs+bSM2niKgCHQRE8YT+xrZBRx
         vey3z/Ot7SnDSQQErJ/7J23bOIeKafbiGJ8I0iUDpvWu8U+ZtnTIu6nomw+H6VcC73wM
         PSgRYH3KYoNqlTuwiHu+7f+vdD+Xj0DAS2cmal5FoT7l6raGVZAOCsTs4Wy05oubFx5j
         VGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=v6kuMWAWRh6UNWKt1To15PX+Alnw0cwwwqkktpikgvU=;
        b=L9pl0y89FQm0tln4OIoFUcqOZzsQ/N33jbxSFDJ390rs9IYGiD071qzkTGGKpjSH79
         BAhJeZmjcsLnGX0S+GyMNAvzFkHWg1qeFvPQVxncQ61c/vtOzOb3OIN18B6NqCHt6XGh
         A5ziQcBgq5H5jZIZGSQledXzCoj7Hp4pjHm18eIYOKYXSsMg12/skq4zXUDco5y3+XnU
         MZYj7nwwYTbUyFV5kep+wmcSy9gdnQVAspvDvdSVTvmx6XsE2Pqzw+PevFcGArWLlSKJ
         COZbmZS2aN60S6LnTFKc4UbQm4maIcBKZ3sXV50+uy/xCtrSZqk/hDCCpDH/4Px2lgNJ
         mVWw==
X-Gm-Message-State: AOAM532Ak+j5XR6ghuI1AsMb18SQe0zSymHv0Dc8ELUffgY5hbgLJqNz
        7mGz6/HnzJzkixemYns0qTM=
X-Google-Smtp-Source: ABdhPJwzIPq7/SXvESsrrYxg24FI7X7Ew67gS5YI1WpQh9CGadlW5Tn8no8geA9iu9N2MExRT9mPEw==
X-Received: by 2002:a9d:73d8:: with SMTP id m24mr17206726otk.52.1643818145370;
        Wed, 02 Feb 2022 08:09:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t22sm6044586oiw.2.2022.02.02.08.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:09:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Feb 2022 08:09:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/5] Makefile: Enable -Warray-bounds
Message-ID: <20220202160903.GA2337834@roeck-us.net>
References: <20210818081118.1667663-1-keescook@chromium.org>
 <20210818081118.1667663-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818081118.1667663-5-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 01:11:17AM -0700, Kees Cook wrote:
> With the recent fixes for flexible arrays and expanded FORTIFY_SOURCE
> coverage, it is now possible to enable -Warray-bounds. Since both
> GCC and Clang include -Warray-bounds in -Wall, we just need to stop
> disabling it.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index a4aca01a4835..af22b83cede7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1072,7 +1072,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
>  
>  # We'll want to enable this eventually, but it's not going away for 5.7 at least
>  KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
> -KBUILD_CFLAGS += -Wno-array-bounds
>  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
>  
>  # Another good warning that we'll want to enable eventually

alpha:defconfig:

In function '__memset',
    inlined from '__bad_pagetable' at arch/alpha/mm/init.c:79:2:
./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
   37 |                         return __builtin_memset(s, c, n);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
In function '__memset',
    inlined from '__bad_page' at arch/alpha/mm/init.c:86:2:
./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
   37 |                         return __builtin_memset(s, c, n);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
In function '__memset',
    inlined from 'paging_init' at arch/alpha/mm/init.c:256:2:
./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
   37 |                         return __builtin_memset(s, c, n);


xtensa:allmodconfig:
--------------
Error log:
In file included from include/linux/uaccess.h:11,
                 from include/linux/sched/task.h:11,
                 from arch/xtensa/kernel/process.c:21:
arch/xtensa/kernel/process.c: In function 'copy_thread':
arch/xtensa/kernel/process.c:262:52: error: array subscript 53 is above array bounds of 'long unsigned int[16]'

