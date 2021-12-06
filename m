Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD146987D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbhLFOWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244558AbhLFOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:22:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9C6C061746;
        Mon,  6 Dec 2021 06:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U62ZcSPWhWgjkAasz/W1SPJ0TKrJujh2fnjbz+MxAoM=; b=iHirtUCCzQZTUjaCuIKdBFIo0N
        SpYk42ie9tcAtRHyapcdPNV5Fx5jAGO0RaXPJgvZCk4AgzWJOp+SdL70ucoco8QXOVrzwo3OZEs4L
        X49XO1GLEMAxC29lbNH/O31Vx3X2I8N1qe9l9A9D1PMH3HvjRcTrP3yTnYpokTApqfVfkn0aSw7t8
        UzPkXZmjBzEkQ0MOXbViIUIyGyKItBLg7t/NMPL4z1VCrHka1Ng8dmGY/JRN/WGeCNWC9adqEkS2x
        ZK0N685y74M3YIiWrvR1/+QCEZDO3VA2BEWh0w1L7ALG43STkHYvH7FI+OTbQ7eaBzHFNUIERwbue
        X8a+00AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muEp7-004omM-3h; Mon, 06 Dec 2021 14:18:33 +0000
Date:   Mon, 6 Dec 2021 14:18:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 01/19] kallsyms: support "big" kernel symbols
Message-ID: <Ya4bucmvLBJRWhvn@casper.infradead.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
 <20211206140313.5653-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206140313.5653-2-ojeda@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:02:55PM +0100, Miguel Ojeda wrote:
> Rust symbols can become quite long due to namespacing introduced
> by modules, types, traits, generics, etc.
> 
> Increasing to 255 is not enough in some cases, and therefore
> we need to introduce longer lengths to the symbol table.
> 
> In order to avoid increasing all lengths to 2 bytes (since most
> of them are small, including many Rust ones), we use ULEB128 to
> keep smaller symbols in 1 byte, with the rest in 2 bytes.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Who are all these people, who didn't actually do any of this
implementation, and where am I who did?

> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  kernel/kallsyms.c  | 26 ++++++++++++++++++++++----
>  scripts/kallsyms.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 3011bc33a5ba..80702273494a 100644
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
> index 54ad86d13784..79b11bb7f07d 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -470,12 +470,35 @@ static void write_src(void)
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
> 2.34.0
> 
