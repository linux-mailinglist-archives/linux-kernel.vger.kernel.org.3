Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E482052C5E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiERWE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiERWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:04:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C452170645
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 14:58:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so3391073pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O6yf2UWZ8UN4B5Ub+KLJ0wguRQoH13rthoX40EwQxbo=;
        b=XS2ixMtUp73NCca0e0habAj613bG4zp1rmlTrH+gl7A85yjlbIUOiH0wfYvbvnFtIw
         /L3msYZXEtynOWif0uAYutzY8ZgueMLHd1QLZCVyAM6m2oFjrR1YgNbh38bNELyslbSO
         SOXD3DC1BzIC0c2NzOyabSxBDXE6chM3pyoqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O6yf2UWZ8UN4B5Ub+KLJ0wguRQoH13rthoX40EwQxbo=;
        b=WHV/b8CzAKcRCuwRoFZc7F1gJc0CWN/9lMBw8fLoTpKQVPep44FWhy0+GSOkvhyuJo
         Kntz9CNdBl348ajQTfVh5/KRQlvtic27ieMB1GEETAiubSJNVbUMD9bi4OhSl8cWrJ4f
         P0YWvgSDlwbD44GzZWCsLPip46ZfdRV5rKUOG9BvL5Od6zCk/XGXxO295Ne5Gq66Vlxl
         ZGoIecEAwjqu53TSxnEoxktaAquK8/99hfgeAJ3NtxuKqCCP+3M2sIU6o0dNIQCH4Q58
         wQoliPbDo5CkISsJDus4lbtQmHidKPSXvtHG8qsqwqM9V0DXGR/5dxrcuQZyFltAN2QX
         lz3w==
X-Gm-Message-State: AOAM532AtP/euJ2CIDHwYZKE6JcSXQZJ68zcq9sA0yB3qGbKIXv+T6Z9
        UOjSSZhLowtkwWe8khjMEN6qsg==
X-Google-Smtp-Source: ABdhPJykCL7NHtfW0xHLWbjA+irKGLbxQ0C+OMsnrlCtOZB9EkfXmI8s27QTLCiH6juOQOkBpqRK9Q==
X-Received: by 2002:a17:902:c947:b0:15e:b73a:63d1 with SMTP id i7-20020a170902c94700b0015eb73a63d1mr1625210pla.67.1652911087178;
        Wed, 18 May 2022 14:58:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n21-20020a63f815000000b003c14af50628sm2026326pgh.64.2022.05.18.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 14:58:06 -0700 (PDT)
Date:   Wed, 18 May 2022 14:58:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] sign-file: Convert API usage to support OpenSSL v3
Message-ID: <202205181457.01A586D25E@keescook>
References: <20220518215129.264872-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518215129.264872-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:51:29PM -0700, Kees Cook wrote:
> OpenSSL's ENGINE API is deprecated in OpenSSL v3.0, along with some
> other functions. Remove the ENGINE use and a macro work-around for
> ERR_get_error_line().
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Salvatore Bonaccorso <carnil@debian.org>
> Cc: keyrings@vger.kernel.org
> Suggested-by: Adam Langley <agl@google.com>
> Co-developed-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20211005161833.1522737-1-lee.jones@linaro.org/
> v2: https://lore.kernel.org/lkml/Yicwb+Ceiu8JjVIS@google.com/
> v3:
>  - Eliminate all the build warnings with OpenSSL 3
>  - Fully remove ENGINE usage, if it can be optional, just drop it.
> ---
>  scripts/sign-file.c | 49 ++++++++++-----------------------------------
>  1 file changed, 11 insertions(+), 38 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c

Eh, this only fixes sign-file.c. Fixes are still needed for
extract-cert.c...

-- 
Kees Cook
