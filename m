Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184234F210D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiDEDJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiDEDJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:09:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A639119EC43
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:53:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g15-20020a17090adb0f00b001caa9a230c7so1168934pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 19:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RzCNHATVinMYtEKVMMIDubor35Dt80OzooLQrltUApM=;
        b=N9TdufpWDVKbp38k8iCOC/2EFCcd30wxtzwCUb1TTzlkaZsDEt8KaHMZszH4iOb2jD
         OR2cD1+XafBXpJ5pq6VC+wNGWQKqqHRjkN+XPqOXB/RLxr+DW7Yv/M06mMn8R/O7wVO3
         kFjNq2hpO9C8vosv9I9ffSM+ZDtvuR+bVaKYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzCNHATVinMYtEKVMMIDubor35Dt80OzooLQrltUApM=;
        b=2FmqDsjvIqUWms8m0hiB2PcY6dQWTxHEHe9jw6lnkVEqT2+KoMFcrjhbZ62mOg3R13
         79NmxaffGQZyq/KBAGTjckJ9WpnhRLvCei5gfofIE3kGKXbYvcHnbNplsJz6wjuNSUUW
         /57pLlrFmGAuzz1gvfHL3Ppvq0sTbCFv8eLEZNYH/HrtQxoF7U0XkoZra348YigmuvUf
         aa4XElz3t8C33Y8RNteXIgGx/h5Hcw/C8dBdqoQZ50MNwLzznksTvCE+BhKvGbtnEZch
         zHKAO6ZhTBlq0YYTR8GNLk+rDb2FklrZOx7Cnb5BFio2tx8s0K3SrA5ERktdGGm+KaAL
         OZpQ==
X-Gm-Message-State: AOAM533mW5L9nKhXAzIC0XVdDpqvuRPzAvPmZKunHUCiWkvy2/5d2huL
        PCKw3arq8FGYIaut5vzUaCiv+A==
X-Google-Smtp-Source: ABdhPJzgJ3PcpqePx7yJkUjQ9w+yt6GA1CifHPfNbfQ5uDiUQz3+GZgm4m/QE146hFtdAY3/em/zoA==
X-Received: by 2002:a17:902:c401:b0:154:3b8a:5e6e with SMTP id k1-20020a170902c40100b001543b8a5e6emr1238570plk.18.1649127186112;
        Mon, 04 Apr 2022 19:53:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w129-20020a628287000000b004fdc453b49asm13683585pfd.39.2022.04.04.19.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 19:53:05 -0700 (PDT)
Date:   Mon, 4 Apr 2022 19:53:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/3] kbuild: Change CFI_CLANG to depend on
 __builtin_function_start
Message-ID: <202204041950.B13AD5CB@keescook>
References: <20220401201916.1487500-1-samitolvanen@google.com>
 <20220401201916.1487500-2-samitolvanen@google.com>
 <CAK7LNAQoJWUscyxXVnOQ9924MYZwaZGgfBYSzmjJxKH_UC0Pkw@mail.gmail.com>
 <CABCJKudaQJ0_e290gD+rG8SwEembd33ua1MG-w2OKRq3es8Kjw@mail.gmail.com>
 <Ykt2mz3gBTAyu9pL@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykt2mz3gBTAyu9pL@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 03:52:11PM -0700, Nathan Chancellor wrote:
> On Mon, Apr 04, 2022 at 12:40:46PM -0700, Sami Tolvanen wrote:
> > On Sat, Apr 2, 2022 at 6:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Sat, Apr 2, 2022 at 5:19 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >
> > > > Clang 14 added support for the __builtin_function_start()
> > > > built-in function, which allows us to implement function_nocfi()
> > > > without architecture-specific inline assembly. This patch changes
> > > > CONFIG_CFI_CLANG to depend on the built-in and effectively upgrades
> > > > the minimum supported compiler version for CFI to Clang 14.
> > >
> > > From this description, I think the straight-forward change would be:
> > >
> > >     depends on CLANG_VERSION >= 120000
> > > -->
> > >     depends on CLANG_VERSION >= 140000
> > >
> > > Any reason to avoid this?
> > 
> > I thought testing for the compiler feature was preferred, but I can
> > certainly just increase the minimum version number here too.
> 
> I think we have been somewhat inconsistent with feature versus version
> checking. It might be nice to hash out when a feature check should be
> done instead of a version one.
> 
> Generally, I think we tend to prefer version checks, as they are
> "cheaper" since we do not have to call the compiler again because we
> already cached the version code. When adding version checks, our policy
> has always been use the upstream version of LLVM that the feature in
> question shipped in, even if it is a top of tree version, as people who
> are using prereleased versions of LLVM should be frequently updating
> them.
> 
> Unfortunately, that does not always match reality. For example,
> Android's LLVM tracks the main branch but they are almost always behind
> by a few months. For example, the latest release is 14.0.4, based on a
> version of LLVM from January 28th:
> 
> https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/ab73cd180863dbd17fdb8f20e39b33ab38030cf9/clang-r450784b/clang_source_info.md
> https://github.com/llvm/llvm-project/commits/282c83c32384cb2f37030c28650fef4150a8b67c
> 
> Normally, I would say "who cares?" but Android's LLVM is used by the
> Android kernel team both downstream and upstream, so I would argue it is
> important to take that into account when deciding to do a feature check
> versus a version check. In other words, by moving to a version check,
> will we knowingly break a version of clang that is relatively widely
> used?
> 
> In this case, 14.0.4 has __builtin_function_start(), so I think it is
> okay to use a version check instead of a feature one.

Thanks for checking the details on that. Yeah, I think it's fine to go
with a version check here.

Sami, can you send a v2, and I can take it via the hardening for
-next? (Unless the ARM folks _really_ want it for -rc2 -- this is kind
of a fix, but it's also kind of not.)

-- 
Kees Cook
