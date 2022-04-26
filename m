Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A8E510B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355515AbiDZVfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355466AbiDZVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:35:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95942A0A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:32:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh6so14584270ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTyKSDm8OUEDphbP/fy4/ucOerWUVhiZWBgtnRYZdZw=;
        b=hrSd0P29IeYe6JLT8G7WLSBdSI48pYOP7RhBuJIBtv4ClnQVYjjErhR34j0o200+qB
         ZmfPY98iMRNovl+NLZxfdhxJ3/MvNXFHB9ii9TPtVwPFc2KOg2+t3+AWecp78bb59SEs
         k3gJZOBTeyKxuzsujMgaNfukSda0/QDU6ee1ATJySsYy756ykIh1JNgCMhQSoJ7YcWWt
         HWPhI/N31gng2lgoFCDipErbgkUNhhm/+YP2rVyQEZ2EWRJ4dWojw4VULFeC+PxD9Ea9
         plVLdr1s5D3D0Lvs+uEbKotSgi+iVq5gk3V/rOO7Ay5N2JH0Bv9lyryuC7Tr0dznWNXf
         IQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTyKSDm8OUEDphbP/fy4/ucOerWUVhiZWBgtnRYZdZw=;
        b=DxMEJUu3AmmjKXzi6GkewVrtFBGrqJwG5bQGjrksUO0ov/jtzjuwSVjukqDdZ7NmbK
         kVsrNzKdgblB0eDgTIDG9vptUA8sy9UOkqGd5LOnln7RsZyezDgpBWzPeThIR6G03k+s
         jqs8WH0/pcZ9RIePJRlHNkwVfHPwiTVcmwAJImOr5UefwVGmrCWjzixA6Xt6cCfayT4J
         jH0A8PwQ+5cvUwzNy7NjkybPaJ/lDPXBP7FTGma1ooTkY4PmdwVHknwBfhrrp1piynoS
         vkBxnvL1Q2ZBmj+3o8Cln8cXw5y/eOry/r/WF4yGEsKEadyyNf7Vw3w+ejPiFdAtGd23
         D7oQ==
X-Gm-Message-State: AOAM530EGmtWSSsWOrVu2FEGBmnbuwCxdj8LBFQlyXWcWbQRxpQnTuvd
        wPsjvtP7EEluwi6myM4yhV8cgNXYb8JOdzr/72mdsw==
X-Google-Smtp-Source: ABdhPJzOjBqpk5z5nirWqeoop1JfQFBvXl7jX0YyAMqDGlb2b78LJN0qWVUBzbGca1ofOWWZotLWJ7fP4Y1aIixJzhE=
X-Received: by 2002:a17:907:eab:b0:6da:8ec5:d386 with SMTP id
 ho43-20020a1709070eab00b006da8ec5d386mr23479103ejc.668.1651008729111; Tue, 26
 Apr 2022 14:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220402043530.923747-1-davidgow@google.com> <20220402043530.923747-2-davidgow@google.com>
In-Reply-To: <20220402043530.923747-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 26 Apr 2022 17:31:57 -0400
Message-ID: <CAFd5g46UfmrE-D9PKfGJsgZBnCUi9-Z82tu1=4ZQzCCj0VcQCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: Rework kunit_resource allocation policy
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 12:35 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> KUnit's test-managed resources can be created in two ways:
> - Using the kunit_add_resource() family of functions, which accept a
>   struct kunit_resource pointer, typically allocated statically or on
>   the stack during the test.
> - Using the kunit_alloc_resource() family of functions, which allocate a
>   struct kunit_resource using kzalloc() behind the scenes.
>
> Both of these families of functions accept a 'free' function to be
> called when the resource is finally disposed of.
>
> At present, KUnit will kfree() the resource if this 'free' function is
> specified, and will not if it is NULL. However, this can lead
> kunit_alloc_resource() to leak memory (if no 'free' function is passed
> in), or kunit_add_resource() to incorrectly kfree() memory which was
> allocated by some other means (on the stack, as part of a larger
> allocation, etc), if a 'free' function is provided.
>
> Instead, always kfree() if the resource was allocated with
> kunit_alloc_resource(), and never kfree() if it was passed into
> kunit_add_resource() by the user. (If the user of kunit_add_resource()
> wishes the resource be kfree()ed, they can call kfree() on the resource
> from within the 'free' function.
>
> This is implemented by adding a 'should_free' member to
> struct kunit_resource and setting it appropriately. To facilitate this,
> the various resource add/alloc functions have been refactored somewhat,
> making them all call a __kunit_add_resource() helper after setting the
> 'should_free' member appropriately. In the process, all other functions
> have been made static inline functions.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Tested-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
