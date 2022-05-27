Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6045364B8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353626AbiE0PcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiE0PcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:32:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DE27157;
        Fri, 27 May 2022 08:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68B4EB8258A;
        Fri, 27 May 2022 15:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A3BC385A9;
        Fri, 27 May 2022 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653665517;
        bh=lDacCcW5oBQ/nFAD4l5L8yV6/DrYAxo5jI0xrrZLIUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otNuxF4tGMSeaMha2xXHnHV5OIS3F3SZzm4iyeVBirWWS4lloMSYuJCB4Ggkhg5N5
         XjthG4zVxpbfHSE3zapxjG2J8XAf0xjt39HDVxpGBozFr9LhWmnAof47DnYBC4sfQu
         a6VMJqVey0NrS102dTQKfTCZdWAwRJZZdAAmiucP4mxrG8wObPT0UgYvpDUYT181H/
         L/SkGGfeFYUN4B4qGd6tX8ri7FcnLh6fpt/QPv9ejo+SLJPgVPqxu4b6SH6+7eP34u
         QfvJnEGY/QF7WERzBIi4qxx+bQLWbzCG6u3E0d5ics0Kv4dDyy4vHvW0/EDBN1UNWH
         U5qpK0EH3X50A==
Date:   Fri, 27 May 2022 08:31:54 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, llvm@lists.linux.dev,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v7 2/8] kbuild: do not create *.prelink.o for Clang LTO
 or IBT
Message-ID: <20220527153154.hivyahzjz3txouoi@treble>
References: <20220527100155.1996314-1-masahiroy@kernel.org>
 <20220527100155.1996314-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220527100155.1996314-3-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 07:01:49PM +0900, Masahiro Yamada wrote:
> New build flow
> ==============
> 
>  [1] single-object module
> 
>   Since there is only one object, there is no need to keep the LLVM IR.
>   Use $(CC)+$(LD) to generate an ELF object in one build rule. When LTO
>   is disabled, $(LD) is unneeded because $(CC) produces an ELF object.
> 
>                $(CC)+$(LD)+objtool              $(LD)
>     foo.c ----------------------------> foo.o ---------> foo.ko
>                                         (ELF)     |
>                                                   |
>                                       foo.mod.o --/
> 
>  [2] multi-object module
> 
>   Previously, $(AR) was used to combine LLVM bitcode into an archive,
>   but there was no technical reason to do so. Use $(LD) to merge them
>   into a single ELF object.
> 
>                                $(LD)
>              $(CC)            +objtool          $(LD)
>     foo1.c ---------> foo1.o ---------> foo.o ---------> foo.ko
>                                  |      (ELF)     |
>     foo2.c ---------> foo2.o ----/                |
>                      (LLVM IR)        foo.mod.o --/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
