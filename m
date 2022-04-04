Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF644F1C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381162AbiDDVWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380353AbiDDTnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:43:19 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90582DD48
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:41:22 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2eb543fe73eso52807697b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAwv7CFZ3JOlEcNj8j8D2/v921PTmZNLQHl33SWwbZQ=;
        b=pMdBBCRgdJWrkxOB7Vi/srVNde9bJufkX4hVHEeS+pFF8yy6ccmz7kB+1UwHKEIDFa
         JDg37ysNC2VzPqSfgLQnu7iYkS3/sbzzt9U66P4qidAB+SU4mTF1PntYeWGtGxMrXI94
         c7VlnLx3YhtB0XEymV2HzG/wPESttE7jFSEYKhmWuLId0C4CdBpHGprn+S1rZ+skseYr
         R5O2AESDpF9Nha3NUhigFuCto1zYZ+Q5FUlSL9jPB/joOa9jbDMtEx1Y2YhBi+lkRwGp
         DyTmqM/Fr5UV5yGB2tMELqq9tO6uUup/Raugo78JKi2NLR+3NMDswAsxgK2+Xfgbv0HL
         ywZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAwv7CFZ3JOlEcNj8j8D2/v921PTmZNLQHl33SWwbZQ=;
        b=owQrgGe4kGwCB8KJk9PRL4LHyawLTf51O75kvAwuYCBoiVuewVfUBCtKgv/doG+ArJ
         jOi6330RW4lQmRZWv+6Tnt4vBMlShO9Cjr1M1SX+Poom6yjHZQlCeQXxd87D9091kvFK
         c/15dLVy7vY55RnwLHOlhHPOee/7jlHxABmltzuMQC+NBc82FElKfdXnzo2n4D2PB0l9
         xw3CM6Zkiu2QoZZncBM5zCc/Y4Nkj0ZJOrg/qsb3wPaioeJrgzPaYeq+MDP6onZ1C5Nf
         l+eNNWzWpAmSRAEeiLwMEid1K71hE8YQ6UtnEBmHokoDn5nx/2PjxtIiz8qAqhftVZeG
         PrwA==
X-Gm-Message-State: AOAM530RaeyBH7DU65TZTqAeGldjzsUe24b2Shx0vcSGx2Zb3BjTaj3+
        oG5nztnHc0gRzESJp/mhzYsiMH+kWF0Oj3lSb2X6nw==
X-Google-Smtp-Source: ABdhPJx7D6TDafv3kiS/i/Qp7m7WK4qbRCfugunFo5wbxlDRV34SM1qNDg9LlBTyO66YQQqmXk6cb/7CTestETLhn4E=
X-Received: by 2002:a81:3a4a:0:b0:2e5:a9e9:f43c with SMTP id
 h71-20020a813a4a000000b002e5a9e9f43cmr1490010ywa.243.1649101281897; Mon, 04
 Apr 2022 12:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220401201916.1487500-1-samitolvanen@google.com>
 <20220401201916.1487500-2-samitolvanen@google.com> <CAK7LNAQoJWUscyxXVnOQ9924MYZwaZGgfBYSzmjJxKH_UC0Pkw@mail.gmail.com>
In-Reply-To: <CAK7LNAQoJWUscyxXVnOQ9924MYZwaZGgfBYSzmjJxKH_UC0Pkw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Apr 2022 12:40:46 -0700
Message-ID: <CABCJKudaQJ0_e290gD+rG8SwEembd33ua1MG-w2OKRq3es8Kjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: Change CFI_CLANG to depend on __builtin_function_start
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
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

On Sat, Apr 2, 2022 at 6:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Apr 2, 2022 at 5:19 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Clang 14 added support for the __builtin_function_start()
> > built-in function, which allows us to implement function_nocfi()
> > without architecture-specific inline assembly. This patch changes
> > CONFIG_CFI_CLANG to depend on the built-in and effectively upgrades
> > the minimum supported compiler version for CFI to Clang 14.
>
> From this description, I think the straight-forward change would be:
>
>     depends on CLANG_VERSION >= 120000
> -->
>     depends on CLANG_VERSION >= 140000
>
> Any reason to avoid this?

I thought testing for the compiler feature was preferred, but I can
certainly just increase the minimum version number here too.

Sami
