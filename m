Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693F4520FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiEJImg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbiEJIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:42:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC391238861;
        Tue, 10 May 2022 01:38:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5309A21B9E;
        Tue, 10 May 2022 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652171916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBHPkY7leVke4Ab1YZuG3Eh0I871w0YjHYv2ZTtbS6c=;
        b=DsYTFv2022XRh8F2WnKcoEl+nKZY/3KpwlPjMI4FKvwyHh0rrcFNMQQmRsq0I711GwI0Ep
        SAZ+vVa2BPCJhwhrtLBU/mVDb5Oqi01suAxUtLsAchCovotcblyR2nPoXWwTsaoxMyNr58
        PJcrw4n3sS7HX+mJ6hcxDLzaFUSpjaA=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9AC522C141;
        Tue, 10 May 2022 08:38:35 +0000 (UTC)
Date:   Tue, 10 May 2022 10:38:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v6 14/23] vsprintf: add new `%pA` format specifier
Message-ID: <Ynoki5rA2ivmFwkS@alley>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-15-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507052451.12890-15-ojeda@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-05-07 07:24:12, Miguel Ojeda wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> This patch adds a format specifier `%pA` to `vsprintf` which formats
> a pointer as `core::fmt::Arguments`. Doing so allows us to directly
> format to the internal buffer of `printf`, so we do not have to use
> a temporary buffer on the stack to pre-assemble the message on
> the Rust side.
> 
> This specifier is intended only to be used from Rust and not for C, so
> `checkpatch.pl` is intentionally unchanged to catch any misuse.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>

See a comment below.

> ---
>  lib/vsprintf.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 40d26a07a133..00f71f91d991 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2270,6 +2270,9 @@ int __init no_hash_pointers_enable(char *str)
>  }
>  early_param("no_hash_pointers", no_hash_pointers_enable);
>  
> +/* Used for Rust formatting ('%pA'). */
> +char *rust_fmt_argument(char *buf, char *end, void *ptr);
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -2396,6 +2399,10 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
>   *
>   * Note: The default behaviour (unadorned %p) is to hash the address,
>   * rendering it useful as a unique identifier.
> + *
> + * There is also a '%pA' format specifier, but it is only intended to be used
> + * from Rust code to format core::fmt::Arguments. Do *not* use it from C.
> + * See rust/kernel/print.rs for details.
>   */

It would be great to document it also in
Documentation/core-api/printk-formats.rst
I am sorry that I did not mentioned it earlier.

Also the check in checkpatch.pl, mentioned in another reply, sounds
like a good idea.

Best Regards,
Petr
