Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125734DA0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350414AbiCOREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350393AbiCOREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90F7F7655
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647363792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmxYI6ts0ifPqvBUGqySYDpgc0rBSTfKUOaCBQr9r+M=;
        b=LprTYFP7uPGFn+xjzs0uz8dgxJIg7HNYyTR5mw47jMUCLnKg6GqLkOFYKTn8RJpU6OsN73
        Z7ujcqAP44kNNSEOfIrJZBgdLazFRz4DvlPE0vLW2kpG9HlpYLNlYEjgTu/wxf9AJ2Auj4
        mJBD3RL5+NicXDUy+L9M0AfW/ot7Yd8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-k2mQQShZNuKgp7tqoTu5Fw-1; Tue, 15 Mar 2022 13:03:11 -0400
X-MC-Unique: k2mQQShZNuKgp7tqoTu5Fw-1
Received: by mail-wr1-f71.google.com with SMTP id a5-20020adfc445000000b00203dcb13954so110564wrg.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OmxYI6ts0ifPqvBUGqySYDpgc0rBSTfKUOaCBQr9r+M=;
        b=a/6mUpsfzgkDk2scBohg25tIs3YY9u1dR6/EsdHr4RaQI39uhQBtG+AE3ocmmNawD7
         Lq6ZXQxG8TfC9VC2YcTicNtrg09NsiYFQ6jXUjltvVwULZu9vKf2Ke26xKwTN3YZ77Jj
         QHTbXKICoUC98Dv9nhq26KhPUcyiCuCqIbcOre4aHuLzOVhwqezdGiQ4tA2ZZX6WENDP
         V8OB3Q0B6CNKSqayviQJWlXgDs4eT+VKUIbJ1G52VJoFHXUFIR8siELojchIV6kWaPcp
         nApj8TY0zJgu7zAkLYjA1WulSbDVrVHTKhiHoV3Xh0/k7HYUICV3yjFqs0Se6vBPDs1P
         5YFA==
X-Gm-Message-State: AOAM533HyKx+ZsDx8DiEi46NRSRqbAjcfgF5vmRrdCsoDcTpEZ8EhAwT
        8m5GSaq3UG5xsRWBh65S3ZyxTmYED3L34NnZKwypsR6Vii6qU8ZndmKW9iNhETgq4XAY8Ab/HIS
        uYIRPhNnMb730JynP2Ra4uExl
X-Received: by 2002:a05:6000:2c6:b0:203:871d:aaa4 with SMTP id o6-20020a05600002c600b00203871daaa4mr20082228wry.47.1647363790163;
        Tue, 15 Mar 2022 10:03:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0VnXioS5GPLkgJGEECy6qRxXD0f5fqDGsdTj5oM5pW6HFay89xxxO5qnSXYIleqPeTR4uQw==
X-Received: by 2002:a05:6000:2c6:b0:203:871d:aaa4 with SMTP id o6-20020a05600002c600b00203871daaa4mr20082206wry.47.1647363789931;
        Tue, 15 Mar 2022 10:03:09 -0700 (PDT)
Received: from redhat.com ([2.53.2.35])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d5647000000b0020372c969d9sm15998430wrw.29.2022.03.15.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 10:03:09 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:03:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] linux/types.h: Remove unnecessary __bitwise__
Message-ID: <20220315130258-mutt-send-email-mst@kernel.org>
References: <20220315153048.621328-1-helgaas@kernel.org>
 <20220315153048.621328-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315153048.621328-2-helgaas@kernel.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:30:47AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no users of "__bitwise__" except the definition of "__bitwise".
> Remove __bitwise__ and define __bitwise directly.
> 
> This is a follow-up to 05de97003c77 ("linux/types.h: enable endian checks
> for all sparse builds").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/uapi/linux/types.h  | 5 ++---
>  tools/include/linux/types.h | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
> index f6d2f83cbe29..71696f424ac8 100644
> --- a/include/uapi/linux/types.h
> +++ b/include/uapi/linux/types.h
> @@ -20,11 +20,10 @@
>   */
>  
>  #ifdef __CHECKER__
> -#define __bitwise__ __attribute__((bitwise))
> +#define __bitwise	__attribute__((bitwise))
>  #else
> -#define __bitwise__
> +#define __bitwise
>  #endif
> -#define __bitwise __bitwise__
>  
>  typedef __u16 __bitwise __le16;
>  typedef __u16 __bitwise __be16;
> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> index 6e14a533ab4e..6c18c54e7d7f 100644
> --- a/tools/include/linux/types.h
> +++ b/tools/include/linux/types.h
> @@ -43,11 +43,10 @@ typedef __u8  u8;
>  typedef __s8  s8;
>  
>  #ifdef __CHECKER__
> -#define __bitwise__ __attribute__((bitwise))
> +#define __bitwise	__attribute__((bitwise))
>  #else
> -#define __bitwise__
> +#define __bitwise
>  #endif
> -#define __bitwise __bitwise__
>  
>  #define __force
>  #define __user
> -- 
> 2.25.1

