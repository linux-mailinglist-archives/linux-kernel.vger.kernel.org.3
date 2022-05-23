Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCFC5319DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiEWUcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiEWUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:32:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C89771A11;
        Mon, 23 May 2022 13:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B0E5B815BA;
        Mon, 23 May 2022 20:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E891C34115;
        Mon, 23 May 2022 20:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653337921;
        bh=POIdHLZCL8JWg7SSzx3poIK2a1cQmFod9S3oQWwvGKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kjv+/DsiS8pvW8eeG3mSkfBuQ98mB6Ks8R8DjGvJBHGGCx+IwONrywQV5H8QVt3B6
         ZQa5klLnbzzAA19PKGzholfvuEaKhsztF7cCn9dO+9z51O4G7ZEOZiYt8foJeWqp+6
         miQ7kZ71TB8PbJKDsqoNc8o0wY3/6bTi54dLRg4V+k3dhIGztk+qxl8Yp2wRE/2sk9
         etOOriEZQJV9ohfKu/HNW1Y5KhoEvVsH8gd7p3jcON0A/sZB2s3cAO8gcst1F7RgE3
         oK1rWJnc2YAff3nGxaQj8frnysgcCLeJPx25evjQlceTxch+UfVemVzX7KBwt34L+y
         OWGwkQjhF8+vw==
Date:   Mon, 23 May 2022 23:30:20 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 02/25] kallsyms: support "big" kernel symbols
Message-ID: <Yovu3As0kmk/l6bX@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
 <20220523020209.11810-3-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523020209.11810-3-ojeda@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 04:01:15AM +0200, Miguel Ojeda wrote:
> Rust symbols can become quite long due to namespacing introduced
> by modules, types, traits, generics, etc.
> 
> Increasing to 255 is not enough in some cases, and therefore
> we need to introduce longer lengths to the symbol table.

s/we need to//

> 
> In order to avoid increasing all lengths to 2 bytes (since most
> of them are small, including many Rust ones), we use ULEB128 to

s/we//

> keep smaller symbols in 1 byte, with the rest in 2 bytes.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> This is a prerequisite patch, independently submitted at:
> 
>     https://lore.kernel.org/lkml/20220506203443.24721-3-ojeda@kernel.org/
> 
>  kernel/kallsyms.c  | 26 ++++++++++++++++++++++----
>  scripts/kallsyms.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 79f2eb617a62..e8d2262ef2d2 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -69,12 +69,20 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
>  	data = &kallsyms_names[off];
>  	len = *data;
>  	data++;
> +	off++;
> +
> +	/* If MSB is 1, it is a "big" symbol, so needs an additional byte. */
> +	if ((len & 0x80) != 0) {
> +		len = (len & 0x7F) | (*data << 7);
> +		data++;
> +		off++;
> +	}
>  
>  	/*
>  	 * Update the offset to return the offset for the next symbol on
>  	 * the compressed stream.
>  	 */
> -	off += len + 1;
> +	off += len;
>  
>  	/*
>  	 * For every byte on the compressed symbol data, copy the table
> @@ -127,7 +135,7 @@ static char kallsyms_get_symbol_type(unsigned int off)
>  static unsigned int get_symbol_offset(unsigned long pos)
>  {
>  	const u8 *name;
> -	int i;
> +	int i, len;
>  
>  	/*
>  	 * Use the closest marker we have. We have markers every 256 positions,
> @@ -141,8 +149,18 @@ static unsigned int get_symbol_offset(unsigned long pos)
>  	 * so we just need to add the len to the current pointer for every
>  	 * symbol we wish to skip.
>  	 */
> -	for (i = 0; i < (pos & 0xFF); i++)
> -		name = name + (*name) + 1;
> +	for (i = 0; i < (pos & 0xFF); i++) {
> +		len = *name;
> +
> +		/*
> +		 * If MSB is 1, it is a "big" symbol, so we need to look into
> +		 * the next byte (and skip it, too).
> +		 */
> +		if ((len & 0x80) != 0)
> +			len = ((len & 0x7F) | (name[1] << 7)) + 1;
> +
> +		name = name + len + 1;
> +	}
>  
>  	return name - kallsyms_names;
>  }
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 82d6508bdf29..7e99799aa7b9 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -480,12 +480,35 @@ static void write_src(void)
>  		if ((i & 0xFF) == 0)
>  			markers[i >> 8] = off;
>  
> -		printf("\t.byte 0x%02x", table[i]->len);
> +		/* There cannot be any symbol of length zero. */
> +		if (table[i]->len == 0) {
> +			fprintf(stderr, "kallsyms failure: "
> +				"unexpected zero symbol length\n");
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		/* Only lengths that fit in up-to-two-byte ULEB128 are supported. */
> +		if (table[i]->len > 0x3FFF) {
> +			fprintf(stderr, "kallsyms failure: "
> +				"unexpected huge symbol length\n");
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		/* Encode length with ULEB128. */
> +		if (table[i]->len <= 0x7F) {
> +			/* Most symbols use a single byte for the length. */
> +			printf("\t.byte 0x%02x", table[i]->len);
> +			off += table[i]->len + 1;
> +		} else {
> +			/* "Big" symbols use two bytes. */
> +			printf("\t.byte 0x%02x, 0x%02x",
> +				(table[i]->len & 0x7F) | 0x80,
> +				(table[i]->len >> 7) & 0x7F);
> +			off += table[i]->len + 2;
> +		}
>  		for (k = 0; k < table[i]->len; k++)
>  			printf(", 0x%02x", table[i]->sym[k]);
>  		printf("\n");
> -
> -		off += table[i]->len + 1;
>  	}
>  	printf("\n");
>  
> -- 
> 2.36.1
> 

BR, Jarkko
