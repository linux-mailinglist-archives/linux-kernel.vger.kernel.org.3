Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28A85976BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbiHQTkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbiHQTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:39:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0797A4B08
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:39:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo2743379pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=r68vuNb5uh5ONaquxzxTqZ7ONll565ksnKh3ylI2Qso=;
        b=fMHE08mTNGtgJz5Oy07EEtIpqqdqolGc17nEd8gVvKUw5CdSjv/rRzxqaLb78IHB67
         dldRsPtd4wwFvOhdDwQV4bqau/Eu1sfiQ9hhO6/lGkKw/IpZWigxnU2oPUBD+pZqQKEO
         7bul/7sfTougSEqU7vjXZAS4IeQZPRusWPFiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=r68vuNb5uh5ONaquxzxTqZ7ONll565ksnKh3ylI2Qso=;
        b=x9iUMe6HSK2nK2+QfHmiREQSdsu7l/+pz5eQ8eHcqA70IPbE7p231rnX0WYyo8gEDN
         Vpe+sWyuQDwTam/csa/fubGZNzTkpLwOSyVI/nJpQHJHx/tJ2Okv0GoSV4T946h75Xgi
         UyJmMlEy0oBCnY7GxaN+Hnb4NsojnOjfWUOKJjtKQYoIByqEH0mQUWgASNatHKP6MA6N
         15zV+H2RinYQQXQUks8e/9NlvnzhUW3W+wjeLHBsByndE31ZXfFhOJRHFtKKBdSywZaW
         +X//kwdh5kC+jnYFQsoYTyqdFv4EEd76+TFoNgfzY5nuiOpbup7xpWfVae3eBPgjlHeM
         fbqg==
X-Gm-Message-State: ACgBeo3oRdyZaFfuTyR2wJ0ZKCXasEiRGO9UzM4y0QCZrUJBhSI7LkPS
        lSNZwJQLOAd8Ktkco0YCwUe3DQ==
X-Google-Smtp-Source: AA6agR4QLUE1Ptr9L6/5prtoBq9XWGwAqLKFX6+0rTRLhg6Qq0It1iuQEECu3eQaVfLVc7g9ixBe/A==
X-Received: by 2002:a17:902:ccd1:b0:172:5c49:34be with SMTP id z17-20020a170902ccd100b001725c4934bemr21344292ple.23.1660765189710;
        Wed, 17 Aug 2022 12:39:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q7-20020aa79607000000b0052d0a93f6d5sm10845922pfg.116.2022.08.17.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 12:39:49 -0700 (PDT)
Date:   Wed, 17 Aug 2022 12:39:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v9 03/27] kallsyms: add static relationship between
 `KSYM_NAME_LEN{,_BUFFER}`
Message-ID: <202208171238.80053F8C@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-4-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-4-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:41:48PM +0200, Miguel Ojeda wrote:
> This adds a static assert to ensure `KSYM_NAME_LEN_BUFFER`
> gets updated when `KSYM_NAME_LEN` changes.
> 
> The relationship used is one that keeps the new size (512+1)
> close to the original buffer size (500).
> 
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/kallsyms.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index f3c5a2623f71..f543b1c4f99f 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -33,7 +33,11 @@
>  #define KSYM_NAME_LEN		128
>  
>  /* A substantially bigger size than the current maximum. */
> -#define KSYM_NAME_LEN_BUFFER	499
> +#define KSYM_NAME_LEN_BUFFER	512
> +_Static_assert(
> +	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
> +	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
> +);

Why not just make this define:

#define KSYM_NAME_LEN_BUFFER (KSYM_NAME_LEN * 4)

? If there's a good reason not it, please put it in the commit log.

-Kees

-- 
Kees Cook
