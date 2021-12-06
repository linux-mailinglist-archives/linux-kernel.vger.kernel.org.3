Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9214F46A0BB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359086AbhLFQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389316AbhLFQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:09:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB49C0A891A;
        Mon,  6 Dec 2021 07:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FBC0B810C3;
        Mon,  6 Dec 2021 15:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D9CC34901;
        Mon,  6 Dec 2021 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638805604;
        bh=SvLC2Iy302oq1vi6bndP0HPPCYQNXQZPoUVtePvfZtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrRlyOInIKDtL00bUWMq51WSFFkGpCPSLOfpd1QTxPmKajT4ktJFzW2bksV9mA+lb
         c9NNhBtXBW9U9Qmf/jzL7xTBsJWS+zzQk8k6/Z1URKNmO7xFUZx4bIndk9M6ssNPg5
         fYpsiARJ04JIB1xw0kZaL939ziyczNvquavzTAKc=
Date:   Mon, 6 Dec 2021 16:02:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH 11/19] vsprintf: add new `%pA` format specifier
Message-ID: <Ya4mAqoOa8zIeZGZ@kroah.com>
References: <20211206140313.5653-1-ojeda@kernel.org>
 <20211206140313.5653-12-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206140313.5653-12-ojeda@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:03:05PM +0100, Miguel Ojeda wrote:
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
> ---
>  lib/vsprintf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 58d5e567f836..bc9c05427d9a 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2233,6 +2233,10 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +#ifdef CONFIG_RUST
> +char *rust_fmt_argument(char* buf, char* end, void *ptr);
> +#endif

That should be in a .h file somewhere.  Remember, don't put #ifdef in .c
files please.

> +
>  /* Disable pointer hashing if requested */
>  bool no_hash_pointers __ro_after_init;
>  EXPORT_SYMBOL_GPL(no_hash_pointers);
> @@ -2388,6 +2392,10 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
>   *
>   * Note: The default behaviour (unadorned %p) is to hash the address,
>   * rendering it useful as a unique identifier.
> + *
> + * There is also a '%pA' format specifier, but it is only intended to be used
> + * from Rust code to format core::fmt::Arguments. Do *not* use it from C.
> + * See rust/kernel/print.rs for details.
>   */
>  static noinline_for_stack
>  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> @@ -2460,6 +2468,10 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		return device_node_string(buf, end, ptr, spec, fmt + 1);
>  	case 'f':
>  		return fwnode_string(buf, end, ptr, spec, fmt + 1);
> +#ifdef CONFIG_RUST
> +	case 'A':
> +		return rust_fmt_argument(buf, end, ptr);
> +#endif

Same here, this should not be needed if you put it in a .h file
correctly.

thanks,

greg k-h
