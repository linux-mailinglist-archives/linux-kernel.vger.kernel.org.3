Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB3523E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347540AbiEKUEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347496AbiEKUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:04:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4626F2317D5;
        Wed, 11 May 2022 13:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE0B2B8261E;
        Wed, 11 May 2022 20:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E272C340EE;
        Wed, 11 May 2022 20:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652299443;
        bh=QECFIEHeP/akX/1+3OaCSi9J5B/pyZpp7SXlX0Z6nz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3Fj/G3MKPzS6rMAsbssX2HaIxxOk+A5/lQ0DznlPwU6NTQUz+Xq7IKOPR2iyOko5
         Hv1B1q7FeZV2nPk0CSQ4PJi8oY9TDOxSEuNXuCs5U6OMKlV9JwnDpPn53VcafyLyex
         21tSGxJ2MNcCSD0W3vDSdQylmuHWqhxujIy8noIFI+yWr0bxj4v6s/ek/TxpELzymB
         4OafBMH1wxK67FmKKfv78D0lmdSD9bEhyBMGgovIFRnlBbVreX94uj5ICcNs9cfW37
         ieRpRbWgy1sc1xk8qGARVWPv0LZM8qXp1/hNvCWOosNTiRntZh+FgLyXI0NiuBCMyB
         Doh9lNyrtUtRA==
Date:   Wed, 11 May 2022 13:04:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v5 00/12] kbuild: yet another series of cleanups
 (modpost, LTO, MODULE_REL_CRCS, export.h)
Message-ID: <YnwWsYdL2khCikSY@dev-arch.thelio-3990X>
References: <20220511164514.2741934-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511164514.2741934-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Thu, May 12, 2022 at 01:45:02AM +0900, Masahiro Yamada wrote:
> 
> This is the third batch of cleanups in this development cycle.
> 
> Major changes in v5:
>  - Fix build errors
>  - More cleanups
> 
> Major changes in v4:
>  - Move static EXPORT_SYMBOL check to a script
>  - Some refactoring
> 
> Major changes in v3:
> 
>  - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.
> 
> Major changes in v2:
> 
>  - V1 did not work with CONFIG_MODULE_REL_CRCS.
>    I fixed this for v2.
> 
>  - Reflect some review comments in v1
> 
>  - Refactor the code more
> 
>  - Avoid too long argument error
> 
> 
> 
> Masahiro Yamada (12):
>   modpost: split the section mismatch checks into section-check.c
>   modpost: add sym_find_with_module() helper
>   modpost: extract symbol versions from *.cmd files
>   kbuild: link symbol CRCs at final link, removing
>     CONFIG_MODULE_REL_CRCS
>   kbuild: stop merging *.symversions
>   genksyms: adjust the output format to modpost
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
>   kbuild: check static EXPORT_SYMBOL* by script instead of modpost
>   kbuild: make built-in.a rule robust against too long argument error
>   kbuild: make *.mod rule robust against too long argument error
>   kbuild: add cmd_and_savecmd macro
>   kbuild: rebuild multi-object modules when objtool is updated

I applied this series to your latest kbuild branch, built an Arch
Linux x86_64 config and Fedora aarch64 config with
CONFIG_LTO_CLANG_FULL=y then CONFIG_LTO_CLANG_THIN=y, and boot tested
each kernel in QEMU with a full userspace. I did not notice any new
warnings/errors and everything appears to work fine.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan
