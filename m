Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5D5ABA55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiIBVrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBVrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:47:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08667E9260;
        Fri,  2 Sep 2022 14:47:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v4so3010005pgi.10;
        Fri, 02 Sep 2022 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=8qrkjZATNcKs7ClCMRnzoadlGyVSZuIBOgyRx8UlO2k=;
        b=M8ldlNGA2VFaNUIyEcgrOBDyNwIzmzSljb7q8CyGnXgSZ+0yt0T08a47GRH6CvKwSw
         /BQwWahTc1Q7k1Qa5CUNRfrYW+hlh57Y70fu/1YQRIvRSc9S3KL1mS4+v74xB2E0n3uV
         sHcFxhVr21O1uYY6gYd6WP6X3jdKcEVDX6iD9vjlqP9CTYDnR6eZHQybUUp5QYOm/Shc
         iY7OnFu4gZXOXizatNHdzWwLBq677FbctHtmA25x82SYEwNTAzHCZVM51oQqxDXic9Du
         QUeVqoeq7YXtHhjfaOPSY0oDmN3PKX8B/xhifjPSz9yhiUD/Uj2BLbAJeUtTY3TLRrxP
         MLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8qrkjZATNcKs7ClCMRnzoadlGyVSZuIBOgyRx8UlO2k=;
        b=L6D9XoQEhknwKER3e/OoVYzBeBefxqxIqx5prlPUVmQPS/HYQnCXoc7IXg60b7ZkIi
         MaQHCXDbXsvVhihMnwIkoil0AysidW9J/AU+JXIIPqtVRMr6ixC4UGXMgjx4LGB+Z98S
         DaV2rfcGac8hJzDr15rTVenKU8TGVJcrCjPS2kojIPGD8Uqdr3ZUOTyIYsPzjTtUaX0R
         JNW0MlnkJp5owI71xOASIZPA88PT/d3SGZndGaqBNlJdwA0KjPavSRiERBFvX1mDvrQa
         FQSm4kHZyd7lXGxJf5JXMwENnignMMKBcQva5HrHf+O6S9xt0hqKMDGSvo/FbBvujhno
         SLWA==
X-Gm-Message-State: ACgBeo03/TQkrEinZTHxNefXWMyWHpATG2IVwSNj4//Fy7U61BKw3Lxt
        fBbZ+8IaNBV6ceahoTrug7M=
X-Google-Smtp-Source: AA6agR4x6jWRA9NlMcwdHJ4Kz/VQFMg4a/qOXmq33qEXCk9jhl147fyprECYpjzFYX42X6O1OUCedQ==
X-Received: by 2002:a05:6a00:1586:b0:537:f5f:11d0 with SMTP id u6-20020a056a00158600b005370f5f11d0mr39031903pfk.64.1662155228453;
        Fri, 02 Sep 2022 14:47:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902c78b00b00172973d3cd9sm2086040pla.55.2022.09.02.14.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:47:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Sep 2022 14:47:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] string: Introduce strtomem() and strtomem_pad()
Message-ID: <20220902214704.GA4094673@roeck-us.net>
References: <20220901190952.2229696-1-keescook@chromium.org>
 <ba161718-bc61-57b8-dfbe-dee666fd06e8@roeck-us.net>
 <202209021351.13203B669@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209021351.13203B669@keescook>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 01:52:35PM -0700, Kees Cook wrote:
> On Thu, Sep 01, 2022 at 12:34:34PM -0700, Guenter Roeck wrote:
> > On 9/1/22 12:09, Kees Cook wrote:
> > > [...]
> > > -If a caller is using non-NUL-terminated strings, strncpy() can
> > > -still be used, but destinations should be marked with the `__nonstring
> > > +If a caller is using non-NUL-terminated strings, strtomem() should be
> > > +be used, and the destinations should be marked with the `__nonstring
> > 
> > s/be //
> 
> Thanks!
> 
> > > [...]
> > > +++ b/include/linux/fortify-string.h
> > > @@ -77,6 +77,36 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
> > >   #define POS	__pass_object_size(1)
> > >   #define POS0	__pass_object_size(0)
> > > +/** strncpy - Copy a string to memory with non-guaranteed NUL padding
> > 
> > Does that need a newline before strncpy() ?
> 
> What do you mean here? I think this is valid kerndoc, but I'll
> double-check. (And will continue in the neighboring htmldoc build thread.)
> 

Just asking. "/** strncpy - Copy a string ..." seemed unusual without
newline between "/**" and the function name.

Guenter
