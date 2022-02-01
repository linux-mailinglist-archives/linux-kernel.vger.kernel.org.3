Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCCB4A5BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiBAMBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:01:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:25834 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237302AbiBAMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643716894; x=1675252894;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xK2CPhJ2c7fDqeNTYNEdi9CV6bv+gk4dlygHqA4TWpQ=;
  b=X5kHoSuj6Qpy4XZHj2DMOyq6w4z0kARlL+xHFenNpIDX3tj2aQMYbMdg
   ntveatj1gXdxlGuMm1iS2RC7mheX8riX6QcCBpgI7I/1Orz4hSBuZKmBF
   kMukqZHvqnKdivxWtj/bayuntZqoN9/STPYwecl43ih5rN+v/R1M7h9Lh
   0H0Z2MrSM7WiIfbH7zj4aYmCxfI7LHfCSIjRMN0xDluFgzK1TyJ7qltKq
   DpRtn+z5UWTe1vU3jOq0IwD9pAbqIs7/8I28y1pzH/5oQMqkohd0QEzsy
   NHT8PI7ACU7Ka2aREGW/G+TZlx/7nY7X1hEdGieZfNz9mUZ9PeU4Cs202
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247446257"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="247446257"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 04:01:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="523030836"
Received: from ehanosko-mobl.ger.corp.intel.com (HELO localhost) ([10.252.6.3])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 04:01:26 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
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
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
In-Reply-To: <20220131204357.1133674-1-keescook@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220131204357.1133674-1-keescook@chromium.org>
Date:   Tue, 01 Feb 2022 14:01:24 +0200
Message-ID: <871r0mvlrf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022, Kees Cook <keescook@chromium.org> wrote:
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

I thought the first literal 8 was just for looks, and it mattered only
for the last literal 8.

It's been a while when I looked all of this up, but this pretty much
matches what I remember. LGTM.

BR,
Jani.


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

-- 
Jani Nikula, Intel Open Source Graphics Center
