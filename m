Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C69E5AB9BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIBVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiIBVB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:01:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9AAAF4A6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:01:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 202so2932392pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ivy4hiovuVJGCoZ9n9tHFNF9hyXGxf5/YOiVDQAlelE=;
        b=LSZY3QzN15LWiVUx+9nH4/6jq2W7D45/mFqZrLbJ3s8vbhDHb41yCx/rL04saqTKIU
         4UVXLa4vHLHHQRrlqqc9iNw7u4HWQTEDqdrnPCu8/usduuInMqxIZw7M39AQpCI9WNUd
         /+YXw1y77xS6Jg1b3JShys/Brl4G8Z+JjwY6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ivy4hiovuVJGCoZ9n9tHFNF9hyXGxf5/YOiVDQAlelE=;
        b=zqOVF/XvJr5USGz5VXZtLy5izrr0jYuSbPfyB/guFJCjgp/PziPt1K5DtIhp7mJH0O
         rsVqF2Nnvb+ny6St6+Ma54L8wNPtNM2QxjgfoQSYx7nZc8G/xrdi/7kLUmTuYw2+8FPs
         Prhv/EvHUeguWsyGTrZlXfxexlBr30Xln5f9EGYaImXecGVBkC5GNc3SMBWTu6JHEcuN
         gj6blyTWHiET/bIP3p9zbtS7bWkJm/3NbsGep2amf0hK0cjyy5OOv7gp3o3Ypek873ih
         M18+pub3oq851QUM+UNA1yhV6ETXGOouMvYiQDbxuEglI1b7wd2X6Wd+OowUMTvd0s78
         7ZTg==
X-Gm-Message-State: ACgBeo3cjaUlULfSoJm3dDuwUZXP9fMfu4zSo7fKRYoSsf7y5bmBNS8T
        0q82x1wkaCFiHBrkKBE7V9aO5Q==
X-Google-Smtp-Source: AA6agR7R6I90fwYhZLbuY+//piml7wvhclLEZ8mv7jpEEvGSPk/vFriOSm5/LHNqlUdJJAOOUri5AQ==
X-Received: by 2002:a65:4644:0:b0:42a:dfb6:4e80 with SMTP id k4-20020a654644000000b0042adfb64e80mr31797046pgr.262.1662152517174;
        Fri, 02 Sep 2022 14:01:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w24-20020aa79558000000b0053725e331a1sm2233759pfq.82.2022.09.02.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:01:56 -0700 (PDT)
Date:   Fri, 2 Sep 2022 14:01:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] string: Introduce strtomem() and strtomem_pad()
Message-ID: <202209021401.674DEF1936@keescook>
References: <20220901190952.2229696-1-keescook@chromium.org>
 <YxGEwdc69waEXhnV@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxGEwdc69waEXhnV@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:21:21AM +0700, Bagas Sanjaya wrote:
> On Thu, Sep 01, 2022 at 12:09:52PM -0700, Kees Cook wrote:
> > + * Do not use this function. While FORTIFY_SOURCE tries to avoid
> > + * over-reads of @q, it cannot defend against writing unterminated
> > + * results to @p. Using strncpy() remains ambiguous and fragile.
> > + * Instead, please choose an alternative, so that the expectation
> > + * of @p's contents is unambiguous:
> > + *
> > + * @p needs to be:     | padded to @size | not padded
> > + * --------------------+-----------------+------------+
> > + *      NUL-terminated | strscpy_pad()   | strscpy()  |
> > + * --------------------+-----------------+------------+
> > + *  not NUL-terminated | strtomem_pad()  | strtomem() |
> > + * --------------------+-----------------+------------+
> > + *
> 
> My htmldocs build doesn't catch any new warnings, but I think the table
> above can be fixed up:
> 
> ---- >8 ----
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index eed2119b23c523..3413a8e561fc62 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -95,12 +95,13 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
>   * Instead, please choose an alternative, so that the expectation
>   * of @p's contents is unambiguous:
>   *
> - * @p needs to be:     | padded to @size | not padded
> - * --------------------+-----------------+------------+
> - *      NUL-terminated | strscpy_pad()   | strscpy()  |
> - * --------------------+-----------------+------------+
> - *  not NUL-terminated | strtomem_pad()  | strtomem() |
> - * --------------------+-----------------+------------+
> + * +--------------------+-----------------+------------+
> + * |@p needs to be:     | padded to @size | not padded |
> + * +====================+=================+============+
> + * |     NUL-terminated | strscpy_pad()   | strscpy()  |
> + * +--------------------+-----------------+------------+
> + * | not NUL-terminated | strtomem_pad()  | strtomem() |
> + * +--------------------+-----------------+------------+

Ah thank you!

> Regardless, I don't see these new table above in the output (am I missing
> something?).

Oh, yes, you're right. I will add an kern-doc directive to pull in the
file.

-- 
Kees Cook
