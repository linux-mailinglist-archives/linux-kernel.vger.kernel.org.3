Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16A4B93FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiBPWsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:48:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiBPWsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:48:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07BA134DEB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:47:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m14so6610416lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eQzUlBBbN3LIoyK9nl/nS8qXfRu/+keDWNHs9SzLBE=;
        b=g9doDMJjI1xslX56Y6WS/yYmKio6ItRFaGZv+X4uBUWvSLqPjRG55zm9KqzcLdvfes
         SD577cJ+p7QmIMM4gFrcL6m26/ljjceK/VP4cJTdtfZJcT6QExtosH38yW2+m+Dryq+R
         p8wBfVVB8tcEQpZoIDeh354XEK2cK8iUxZp/G/hyutnnAReJHFFecYqTCbSEZ2dt0+Q4
         LvLfqQEpypggjDStspmJQCwl44uFgZKwhm97qqiGpLM8KWEx7Bag0B+jl+c6Du5R2dTq
         ayjSLl/X58B7nFoBoZdD1o2rf8B3msWlO2jFe9Iyy+QdFIHX/HRd2M3gCvVW3WKLFLOq
         p/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eQzUlBBbN3LIoyK9nl/nS8qXfRu/+keDWNHs9SzLBE=;
        b=sHuXsVDEBJ5u/Y6FerIVSXRLH7Bfr/pJYlmVxAN36KZ8k9A4aP8KQP79xGPqdd1wBO
         bda7LHcgHo3Vgo6lOiXA1oxSRi9c/ira4/9K4mAS+TrThRZMjmacpKbHUaW4yg+rXFcK
         uvXaGcmg8KOj0mIx0pK+BLceQxof/tx+9KxGpA5ky/9RbjHvbEXFIvNjnhwF3fd8u4RK
         6VdF26Q4/PuyyJ9sH84EneddDtITk0op6P+V6XpIUrjvuM2Wc4oauR4yvtqnWfA4sEVu
         nYvXpBJrQ7BHEJVAdHQUBqRYz+U9OC9+xIEvZWi9qakzZf8kGY78V1wpT298LFlaEFI9
         a/9w==
X-Gm-Message-State: AOAM530OabvzRf5W1YolT7LQgcqLqwSVvemVfezGWDw4JIi+dfIW2GpG
        vwb843rzu6V4m3hXbdJ153j6wlEn+X4KWfmQvaGKqg==
X-Google-Smtp-Source: ABdhPJwXgiCBqMwy6i/HD2uHx0cjX4YslKBZy0bAbLJHM2GmXJ3FdSpGpa8ZrEEvi/P1eI0Z6oalbN9Q6+Mn3ao5sGc=
X-Received: by 2002:a05:6512:208d:b0:443:1833:7473 with SMTP id
 t13-20020a056512208d00b0044318337473mr133778lfr.651.1645051666773; Wed, 16
 Feb 2022 14:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20220216224153.2242451-1-keescook@chromium.org>
In-Reply-To: <20220216224153.2242451-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Feb 2022 14:47:35 -0800
Message-ID: <CAKwvOdm62iA1dNiC6Q11UJ-MnTqtc4kXkm-ubPaFMK824_k0nw@mail.gmail.com>
Subject: Re: [PATCH] lib: overflow: Convert to Kunit
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 2:41 PM Kees Cook <keescook@chromium.org> wrote:
>
> Convert overflow unit tests to KUnit, for better integration into the
> kernel self test framework. Includes a rename of test_overflow.c to
> overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
>
> Cc: David Gow <davidgow@google.com>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Assuming no one objects, I'll carry this in my for-next/overflow tree. :)

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
