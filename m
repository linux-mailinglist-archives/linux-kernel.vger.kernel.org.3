Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0E4D3AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiCIURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiCIURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:17:48 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0178BA94FD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:16:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id f8so3243152pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6BaluqbU/Z25J2R97A+4bgdc+ob1O3EWcsEpPLgF3pk=;
        b=ISdtbAOwnBbYGM4PCvpKrrw5HmGmfUq3wg3g9OLspUaLc+zFWwDqcVsYfOgzslDf9L
         8ZVKnke21o94g0bfC8pnuFzNLInuTyhowTRNulQ+CAFOHtaG0pSBOXjDS2XuX6b8YzvF
         ilTdwW3UUTtdTskFFMnGU9GNP34o5UgoK+vm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6BaluqbU/Z25J2R97A+4bgdc+ob1O3EWcsEpPLgF3pk=;
        b=XY7NFhcwyu8stEY+6R9t0P8UHCGA/0/9k31JVJDc4lGx8SP94mEWd7TcVORsik4+qq
         ISvjvGjV8moU9Q6OlfUYv+kBzjyY9UjRo4nkbks3hOyCjVYEPZ+Y0pomzA6ieiFVEw7x
         s7hsgdhnYsG+Bz+kwhDAyIdErlD23j2U1CPdc2tx46namx4bJELIMeYdwLqYZ2bffQHS
         v3OwVFFJmZJhg0KN7uybaq9ZdXeXAsiS7Kugi9HKAYX6FU5eQOz7+UmUXRywE9Kybg1/
         8kEKYX0toQuIjVKtSmTysn/9O1HPY6jw75Njk0KuPhVlXn8L+nSn40m2fZcHxUwv2x0D
         7suQ==
X-Gm-Message-State: AOAM531bX8rQt72F3Sxou9D369bjAQN+oE3wHk6sXNhw9TLLEo6acfW4
        XWhBnIRM1AH6yJvmqVeyX0YUmQ==
X-Google-Smtp-Source: ABdhPJwlFCfuaoDPFowRrKqu5kBpvMkL/ybtBrvNihxj3zKsFGRIqd0H9DrqrIK7H2SCt/BiTczTZA==
X-Received: by 2002:a05:6a00:2168:b0:4f6:eb64:71dd with SMTP id r8-20020a056a00216800b004f6eb6471ddmr1450854pff.40.1646857008474;
        Wed, 09 Mar 2022 12:16:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6-20020a63aa06000000b00380c8bed5a6sm1650747pgf.46.2022.03.09.12.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 12:16:48 -0800 (PST)
Date:   Wed, 9 Mar 2022 12:16:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, linux@roeck-us.net,
        luc.vanoostenryck@gmail.com, elver@google.com,
        mark.rutland@arm.com, masahiroy@kernel.org, ojeda@kernel.org,
        nathan@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        samitolvanen@google.com, shuah@kernel.org, tglx@linutronix.de,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] lkdtm: Add Shadow Call Stack tests
Message-ID: <202203091211.4F00F560@keescook>
References: <20220303073340.86008-1-ashimida@linux.alibaba.com>
 <20220303074339.86337-1-ashimida@linux.alibaba.com>
 <202203031010.0A492D114@keescook>
 <202203031105.A1B4CAE6@keescook>
 <92a767c4-09e1-8783-2581-9848bb72890d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a767c4-09e1-8783-2581-9848bb72890d@linux.alibaba.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 07:16:36AM -0800, Dan Li wrote:
> The following code seems to work fine under clang/gcc, x86_64/aarch64
> (also tested in lkdtm_CFI_BACKWARD_SHADOW):
> 
> #include <stdio.h>
> 
> static __attribute__((noinline))
> void set_return_addr(unsigned long *expected, unsigned long *addr)
> {
>     /* Use of volatile is to make sure final write isn't seen as a dead store. */
>     unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> 
>     /* Make sure we've found the right place on the stack before writing it. */
>     if(*ret_addr == expected)
>         *ret_addr = (addr);
> }
> 
> static volatile int force_label;
> 
> int main(void)
> {
>     void *array[] = {0, &&normal, &&redirected};
> 
>     if (force_label) {
>         /* Call it with a NULL to avoid parameters being treated as constants in -02. */
>         set_return_addr(NULL, NULL);
>         goto * array[force_label];
>     }

Hah! I like that. :) I had a weird switch statement that was working for
me; this is cleaner.

> 
>     do {
> 
>         set_return_addr(&&normal, &&redirected);
> 
> normal:
>         printf("I should be skipped\n");
>         break;
> 
> redirected:
>         printf("Redirected\n");
> 
>     } while (0);
> 
>     return 0;
> }
> 
> But currently it still crashes when I try to enable
> "-mbranch-protection=pac-ret+leaf+bti".
> 
> Because the address of "&&redirected" is not encrypted under pac,
> the autiasp check will fail when set_return_addr returns, and
> eventually cause the function to crash when it returns to "&&redirected"
> ("&&redirected" as a reserved label always seems to start with a bti j
> insn).

Strictly speaking, this is entirely correct. :)

> For lkdtm, if we're going to handle both cases in one function, maybe
> it would be better to turn off the -mbranch-protection=pac-ret+leaf+bti
> and maybe also turn off -O2 options for the function :)

If we can apply a function attribute to turn off pac for the "does this
work without protections", that should be sufficient.

-- 
Kees Cook
