Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113EF4A514F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380249AbiAaVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241083AbiAaVTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:19:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98201C061714;
        Mon, 31 Jan 2022 13:19:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54E37B82CA1;
        Mon, 31 Jan 2022 21:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0E4C340E8;
        Mon, 31 Jan 2022 21:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643663977;
        bh=bydv7gfSFyvaJwR+P/7cGzOvsDym3JsAo7rfZrr7r/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6Vk68zSyrlVBRQoLyQEefza0TDiislHx/Z7lsiaTafTymNdJ+L+Ga3ysGKXae/t2
         7W60y03whPQ/BK4ZI7BNUVOSfjBWiELrkLhDxpjf5GB+gT0knZxcYgvelw/luAevQa
         ztcsrr9ihLE04UKepEZUAPn1VWb8biP7WB8f98x2Nna8ghkt1s22BtPrsBSiCrOFzt
         YU24oZWvkilw7M5xw3ZyEeSRSwMEj8dflJvYpoMp2jZFtPoBWZsdSPiyplwDLfS9KO
         MgKBlhw/6VM38ikvQ+sBUIa1qXnNJ73ZIwC/32M21qs3A7gXh6br+hb1gVYciPX0SM
         UEKuQ2rbXPQjQ==
Date:   Mon, 31 Jan 2022 15:26:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
Message-ID: <20220131212637.GA198787@embeddedor>
References: <20220131204357.1133674-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131204357.1133674-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:43:57PM -0800, Kees Cook wrote:
> The __is_constexpr() macro is dark magic. Shed some light on it with
> a comment to explain how and why it works.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
> Jon, since this is pure comment, do you want to take it through the docs tree?
> ---
>  include/linux/const.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/const.h b/include/linux/const.h
> index 435ddd72d2c4..7122d6a1f8ce 100644
> --- a/include/linux/const.h
> +++ b/include/linux/const.h
> @@ -7,6 +7,30 @@
>   * This returns a constant expression while determining if an argument is
>   * a constant expression, most importantly without evaluating the argument.
>   * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> + *
> + * Details:
> + * - sizeof() is an integer constant expression, and does not evaluate the
> + *   value of its operand; it only examines the type of its operand.
> + * - The results of comparing two integer constant expressions is also
> + *   an integer constant expression.
> + * - The use of literal "8" is to avoid warnings about unaligned pointers;
> + *   these could otherwise just be "1"s.
> + * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
> + *   architectures.
> + * - The C standard defines an "integer constant expression" as different
> + *   from a "null pointer constant" (an integer constant 0 pointer).
> + * - The conditional operator ("... ? ... : ...") returns the type of the
> + *   operand that isn't a null pointer constant. This behavior is the
> + *   central mechanism of the macro.
> + * - If (x) is an integer constant expression, then the "* 0l" resolves it
> + *   into a null pointer constant, which forces the conditional operator
> + *   to return the type of the last operand: "(int *)".
> + * - If (x) is not an integer constant expression, then the type of the
> + *   conditional operator is from the first operand: "(void *)".
> + * - sizeof(int) == 4 and sizeof(void) == 1.
> + * - The ultimate comparison to "sizeof(int)" chooses between either:
> + *     sizeof(*((int *) (8)) == sizeof(int)   (x was a constant expression)
> + *     sizeof(*((void *)(8)) == sizeof(void)  (x was not a constant expression)
>   */
>  #define __is_constexpr(x) \
>  	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> -- 
> 2.30.2
> 
