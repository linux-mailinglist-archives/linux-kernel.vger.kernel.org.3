Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4962D4AC7D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiBGRq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381104AbiBGRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:40:29 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 037F4C0401D9;
        Mon,  7 Feb 2022 09:40:28 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nH7yl-0006Gx-02; Mon, 07 Feb 2022 18:39:07 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 45700C2116; Mon,  7 Feb 2022 18:36:09 +0100 (CET)
Date:   Mon, 7 Feb 2022 18:36:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] MIPS: Loongson{2ef,64}: Wrap -mno-branch-likely
 with cc-option
Message-ID: <20220207173609.GC16822@alpha.franken.de>
References: <20220125221925.3547683-1-nathan@kernel.org>
 <20220125221925.3547683-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125221925.3547683-2-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:19:25PM -0700, Nathan Chancellor wrote:
> This flag is not supported by clang, which results in a warning:
> 
>   clang-14: warning: argument unused during compilation: '-mno-branch-likely' [-Wunused-command-line-argument]
> 
> This breaks cc-option, which adds -Werror to make this warning fatal and
> catch flags that are not supported.
> 
> Wrap this flag in cc-option so that it does not cause cc-option to fail,
> which can cause randconfigs to be really noisy, due to warnings not
> getting disabled that should be.
> 
> Additionally, move the cc-option check to Kconfig so that the check is
> done at configuration time, rather than build time, as builds with no
> configuration change will be quicker because the cc-option call will not
> need to happen in those instances.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v1 -> v2: https://lore.kernel.org/r/20220120214001.1879469-2-nathan@kernel.org/
> 
> * Move cc-option call to Kconfig (Nick).
> * Also apply to loongson2ef, even though this will not currently build
>   with clang.
> 
>  arch/mips/Kconfig              | 4 ++++
>  arch/mips/loongson2ef/Platform | 3 ++-
>  arch/mips/loongson64/Platform  | 3 ++-
>  3 files changed, 8 insertions(+), 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
