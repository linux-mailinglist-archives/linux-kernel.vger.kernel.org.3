Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11C352403E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiEKW2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbiEKW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:28:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883CB1C12E1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:28:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b32so4369841ljf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyMWC5Ce+DbHvHrRZbNzybIooKs941ovMuRT8zwal6o=;
        b=ODldyIJbQoAyYDC5pjX9b20HROQqklkQThQUFGX3eTahhXsBHBH4CJlIDCBgttiogS
         MmA3Oo84KlyqrtjbK76zj9ibCUeLYihWEyQSxtQhG2lX8Far/bwtzC0hVK668HMlqWfe
         ia5ZuUTYVcKzSzX1Fa0FUl/4sh4+GA+p4bgK9NIL1dBZh1A2NpMc0sBPArJlyLn+Bi07
         pNjdkORNwQcm1WoWkJEtRjnibWydx+fLZclqKH+O93fNK+BclfQPzuJmqUALA0f9wzvn
         7tZI+ql9/KioXlR48gTW8io/0g5EQV67uS6bfAZu2AJa2jTe+8daQMNT+xmEpiX22eeF
         wv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyMWC5Ce+DbHvHrRZbNzybIooKs941ovMuRT8zwal6o=;
        b=Wkx47t/XMkMh8Fqn32ihN9sZEZfhRyAk7VzjaFkk6rpb+cyADG4hou/Oa0ZMduCpmB
         NllnRRYsXcN7G2gas/y1SI4rCU1ZyyF4L7bJ82SB1CfMiBZecF8q6aS+AEviZ2p4RP5c
         FdibhIzZBNVv+NivrZn+P8+naQmOujCtRMIztIC3ord9u+KzRjbprhjK/kbasICpbDGe
         f+rXqK6m6uZelM8iIhXPVYzLp8in9lRag7u+EwGAQfeyxOPII5ME7l/dzGyPjNk3DpaK
         3H9ivBZBel93TghTfXJThOA8NZEOLkYtSfHtA0Karpv+heuDKB5r6U89ZWWFmCbr7fiA
         B7eA==
X-Gm-Message-State: AOAM533J5gsQF35AbqxvnTlJwHrEAp996Ta3hMOn4aQcUTlB4w1iTbNJ
        RvCZADWLeEvmERN/KRfkc4ZMMKU10puwG1KK3mWNVg==
X-Google-Smtp-Source: ABdhPJyv+O/HArEJ1Z0AyIFHlWgXlGM/PbFI2as6NgGfHYb60UnmpCiC8VUkn1r037kAgnW3UIkA20t6ZlFJ8Xt5iqs=
X-Received: by 2002:a05:651c:552:b0:250:5c23:d0f2 with SMTP id
 q18-20020a05651c055200b002505c23d0f2mr18636863ljp.239.1652308099695; Wed, 11
 May 2022 15:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511164514.2741934-1-masahiroy@kernel.org> <20220511164514.2741934-2-masahiroy@kernel.org>
In-Reply-To: <20220511164514.2741934-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 15:28:07 -0700
Message-ID: <CAKwvOd=SZYO0344rrJWP+JvmuZmQ9N6VM9UgMwrb9fH3MaNLMQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] modpost: split the section mismatch checks into section-check.c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
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

On Wed, May 11, 2022 at 9:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> modpost.c is too big, and the half of the code is for section checks.
> Split it.
>
> Also, move some related typedefs and macros from modpost.h to
> section-check.c
>
> Copy Sam's Copyright there. Commit b39927cf4cc5 ("kbuild: check for
> section mismatch during modpost stage") is the initial work for the
> section checks.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Sorry again for my "brain fart" in reviewing the global var in v4. :(
I think my blood sugar was getting low or something...

> ---
>
> Changes in v5:
>    - Fix the build error  (spotted by Nathan)
>    - Do not do codying style changes  (Suggested by Nick)

I'm surprised the style changes didn't show up in v5 as a later patch
in the series. I wasn't against them in general, just thought it would
be easier to review if they were distinct commits.
-- 
Thanks,
~Nick Desaulniers
