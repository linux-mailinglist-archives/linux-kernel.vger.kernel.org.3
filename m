Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813544D8777
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiCNOyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiCNOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:54:25 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982E2255BA;
        Mon, 14 Mar 2022 07:53:14 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nTm4O-0006nG-01; Mon, 14 Mar 2022 15:53:12 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C5EC0C2E31; Mon, 14 Mar 2022 15:52:15 +0100 (CET)
Date:   Mon, 14 Mar 2022 15:52:15 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Yanteng Si <siyanteng01@gmail.com>, linux-mips@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Only use current_stack_pointer on GCC
Message-ID: <20220314145215.GD13438@alpha.franken.de>
References: <20220309220939.392227-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309220939.392227-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:09:39PM -0800, Kees Cook wrote:
> Unfortunately, Clang did not have support for "sp" as a global register
> definition, and was crashing after the addition of current_stack_pointer.
> This has been fixed in Clang 15, but earlier Clang versions need to
> avoid this code, so add a versioned test and revert back to the
> open-coded asm instances. Fixes Clang build error:
> 
> fatal error: error in backend: Invalid register name global variable
> 
> Fixes: 200ed341b864 ("mips: Implement "current_stack_pointer"")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/lkml/YikTQRql+il3HbrK@dev-arch.thelio-3990X
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Yanteng Si <siyanteng01@gmail.com>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220309204537.390428-1-keescook@chromium.org
> v2: - adjust Clang version (Nathan)
> ---
>  arch/mips/Kconfig                   | 2 +-
>  arch/mips/include/asm/thread_info.h | 2 ++
>  arch/mips/kernel/irq.c              | 3 ++-
>  arch/mips/lib/uncached.c            | 4 +++-
>  4 files changed, 8 insertions(+), 3 deletions(-)

applied to mips-next with the Clang version in the decscription fixed.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
