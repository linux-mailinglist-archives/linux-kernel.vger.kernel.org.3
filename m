Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B8D4AC7DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbiBGRq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383727AbiBGRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:40:34 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C5A1C0401D9;
        Mon,  7 Feb 2022 09:40:34 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nH7yl-0006Gx-01; Mon, 07 Feb 2022 18:39:07 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 66847C2116; Mon,  7 Feb 2022 18:35:50 +0100 (CET)
Date:   Mon, 7 Feb 2022 18:35:50 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] MIPS: Loongson64: Clean up use of cc-ifversion
Message-ID: <20220207173550.GB16822@alpha.franken.de>
References: <20220125221925.3547683-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125221925.3547683-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:19:24PM -0700, Nathan Chancellor wrote:
> This Makefile checks that GCC is 4.9 or newer, which is redundant after
> commit 76ae847497bc ("Documentation: raise minimum supported version of
> GCC to 5.1"), so cc-option can be removed.
> 
> Clang does not support -march=loongson3a so it needs to continue to use
> -march=mips64r2, which no longer needs cc-option because all supported
> clang versions recognize this flag.
> 
> -march=loonson3a can be used unconditionally with GCC because the
> minimum supported GCC version has been bumped past 4.9.0, which won't
> have the bug mentioned in the comment. The _MIPS_ISA macro redefinition
> can be removed at the same time for the same reason.
> 
> Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v1 -> v2: https://lore.kernel.org/r/20220120214001.1879469-1-nathan@kernel.org/
> 
> * Eliminate ld-option call (Jiaxun).
> * Eliminate _MIPS_ISA macro redefinitions (Nick).
> 
>  arch/mips/loongson64/Platform | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
