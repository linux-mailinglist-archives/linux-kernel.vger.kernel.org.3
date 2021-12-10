Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4B470374
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbhLJPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhLJPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:06:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33EC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:03:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35748B8206B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BA9C00446;
        Fri, 10 Dec 2021 15:03:02 +0000 (UTC)
Date:   Fri, 10 Dec 2021 15:02:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, bp@alien8.de,
        broonie@kernel.org, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        mingo@redhat.com, peterz@infradead.org, tabba@google.com,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [RFC PATCH 4/6] arm64: clean up symbol aliasing
Message-ID: <YbNsI31st3oXleWq@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
 <20211206124715.4101571-5-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206124715.4101571-5-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:47:13PM +0000, Mark Rutland wrote:
> Now that we have SYM_FUNC_ALIAS() and SYM_FUNC_ALIAS_WEAK(), use those
> to simplify and more consistently define function aliases across
> arch/arm64.
> 
> Aliases are now defined in terms of a canonical function name. For
> position-independent functions I've made the __pi_<func> name the
> canonical name, and defined other alises in terms of this.
> 
> The SYM_FUNC_{START,END}_PI(func) macros obscure the __pi_<func> name,
> and make this hard to seatch for. The SYM_FUNC_START_WEAK_PI() macro
> also obscures the fact that the __pi_<func> fymbol is global and the
> <func> symbol is weak. For clarity, I have removed these macros and used
> SYM_FUNC_{START,END}() directly with the __pi_<func> name.
> 
> For example:
> 
>     SYM_FUNC_START_WEAK_PI(func)
>         ... asm insns ...
>     SYM_FUNC_END_PI(func)
>     EXPORT_SYMBOL(func)
> 
> ... becomes:
> 
>     SYM_FUNC_START(__pi_func)
>         ... asm insns ...
>     SYM_FUNC_END(__pi_func)
> 
>     SYM_FUNC_ALIAS_WEAK(func, __pi_func)
>     EXPORT_SYMBOL(func)
> 
> For clarity, where there are multiple annotations such as
> EXPORT_SYMBOL(), I've tried to keep annotations grouped by symbol. For
> example, where a function has a name and an alias which are both
> exported, this is organised as:
> 
>     SYM_FUNC_START(func)
> 	... asm insns ...
>     SYM_FUNC_END(func)
>     EXPORT_SYMBOL(func)
> 
>     SYM_FUNC_ALAIAS(alias, func)
>     EXPORT_SYMBOL(alias)
> 
> For consistency with the other string functions, I've defined strrchr as
> a position-independent function, as it can safely be used as such even
> though we have no users today.
> 
> As we no longer use SYM_FUNC_{START,END}_ALIAS(), our local copies are
> removed. The common versions will be removed by a subsequent patch.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
