Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E146F552CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347657AbiFUIOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiFUIOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:14:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804AE237F2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:14:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g4so8692765lfv.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0qbX+HZcIdI4yeZAAxEQa15Bz902lFD5WKfEE9fTfjU=;
        b=VHglxW5+rgr1w513Qfypb0rHsKD+qePqFA2997oV3AXqcYfySQLbZBrNYgW5VUJ5IV
         ePLX3lhtM44wnAItTgSDtAxzPC3KO4M+88PIJA9hm4JWaljuM5GTAqCglwh/42XIfr6m
         yU2pV6kk8yX/wJiPOydMjXhOK0/XtVwl7CTFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0qbX+HZcIdI4yeZAAxEQa15Bz902lFD5WKfEE9fTfjU=;
        b=4X8kJT80mEJ5d56r2yzgrDqpZCp7a/S85DnhucHMhkP4S3aPJ+tSSPUgkck5yR/a4h
         YbGhs92G2nwg1veXX3Bba86eLK8dNK3ijAdAKGJeXV99glH6KssMXM2yugagnEKkhjBM
         Zs/c1u0XBt/fFoni2KEmkAty9kStwbYCWwI4LOEDyAYvLVeOpC7Ht6SLD4cJR5l6c9Vn
         PfvyJ/qqb3v5rhYwJ24il4FgkpR6oEpAnuPjYFGg4+1S1EZSpnTKmrbQ1YnuoM0Fd7sz
         bvLMUL/TvrdAscN6kjMyb1erJteRddSFUWiIQ8XVGwFqtAOtAiSwGzhHjNk4eYZ3M85S
         bGEg==
X-Gm-Message-State: AJIora9pYesssxwDqykU0egypNxEQ1u3X2MXsdcufKxEAs67AiZn2agY
        ZLk6DyVtwEWElTJTU405fqwXIA==
X-Google-Smtp-Source: AGRyM1u+zUhfCCGCZCym7AJJEi4Df5fDdiy1vGPqBJfNs6HvSYHsUiVAKy7oYac1oliTxywrw+k6kg==
X-Received: by 2002:a05:6512:11d2:b0:47f:7ca3:c533 with SMTP id h18-20020a05651211d200b0047f7ca3c533mr1432629lfr.388.1655799251768;
        Tue, 21 Jun 2022 01:14:11 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p5-20020a2eb7c5000000b0025a7b36d222sm74100ljo.135.2022.06.21.01.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 01:14:11 -0700 (PDT)
Message-ID: <aadf33cb-e0ef-c0b4-8e38-76f38c910a2a@rasmusvillemoes.dk>
Date:   Tue, 21 Jun 2022 10:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 08/34] lib/printbuf: Tabstops, indenting
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-9-kent.overstreet@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220620004233.3805-9-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 02.42, Kent Overstreet wrote:
> This patch adds two new features to printbuf for structured formatting:
> 
>  - Indent level: the indent level, as a number of spaces, may be
>    increased with pr_indent_add() and decreased with pr_indent_sub().
> 
>    Subsequent lines, when started with pr_newline() (not "\n", although
>    that may change) will then be intended according to the current
>    indent level. This helps with pretty-printers that structure a large
>    amonut of data across multiple lines and multiple functions.
> 
>  - Tabstops: Tabstops may be set by assigning to the printbuf->tabstops
>    array.
> 
>    Then, pr_tab() may be used to advance to the next tabstop, printing
>    as many spaces as required - leaving previous output left justified
>    to the previous tabstop. pr_tab_rjust() advances to the next tabstop
>    but inserts the spaces just after the previous tabstop - right
>    justifying the previously-outputted text to the next tabstop.

I am really, really, really not convinced that we want or need this. But
as long as this doesn't add overhead to those not using it (in
particular, as long as it doesn't grow a "scan whatever contents was
just added for maybe a \n so ->last_newline can be updated"), meh.

> + *
> + * Make sure you use prt_newline() instead of \n in the format string for indent
> + * level and tabstops to work corretly.
>   */
>  
>  #include <linux/kernel.h>
> @@ -45,18 +62,29 @@ struct printbuf {
>  	char			*buf;
>  	unsigned		size;
>  	unsigned		pos;
> +	unsigned		last_newline;
> +	unsigned		last_field;
> +	unsigned		indent;
>  	/*
>  	 * If nonzero, allocations will be done with GFP_ATOMIC:
>  	 */
>  	u8			atomic;
>  	bool			allocation_failure:1;
>  	bool			heap_allocated:1;
> +	u8			tabstop;
> +	u8			tabstops[4];
>  };
>  
>  int printbuf_make_room(struct printbuf *, unsigned);
>  const char *printbuf_str(const struct printbuf *);
>  void printbuf_exit(struct printbuf *);
>  
> +void prt_newline(struct printbuf *);
> +void printbuf_indent_add(struct printbuf *, unsigned);
> +void printbuf_indent_sub(struct printbuf *, unsigned);
> +void prt_tab(struct printbuf *);
> +void prt_tab_rjust(struct printbuf *);
> +
>  /* Initializer for a heap allocated printbuf: */
>  #define PRINTBUF ((struct printbuf) { .heap_allocated = true })
>  
> @@ -187,6 +215,8 @@ static inline void printbuf_reset(struct printbuf *buf)
>  {
>  	buf->pos		= 0;
>  	buf->allocation_failure	= 0;
> +	buf->indent		= 0;
> +	buf->tabstop		= 0;
>  }
>  
>  /**
> diff --git a/lib/printbuf.c b/lib/printbuf.c
> index 8c70128e31..a7f80f63ca 100644
> --- a/lib/printbuf.c
> +++ b/lib/printbuf.c
> @@ -12,6 +12,11 @@
>  #include <linux/slab.h>
>  #include <linux/printbuf.h>
>  
> +static inline size_t printbuf_linelen(struct printbuf *buf)
> +{
> +	return buf->pos - buf->last_newline;
> +}
> +
>  int printbuf_make_room(struct printbuf *out, unsigned extra)
>  {
>  	unsigned new_size;
> @@ -69,3 +74,123 @@ void printbuf_exit(struct printbuf *buf)
>  	}
>  }
>  EXPORT_SYMBOL(printbuf_exit);
> +
> +void prt_newline(struct printbuf *buf)
> +{
> +	unsigned i;
> +
> +	printbuf_make_room(buf, 1 + buf->indent);
> +
> +	__prt_char(buf, '\n');
> +
> +	buf->last_newline	= buf->pos;
> +
> +	for (i = 0; i < buf->indent; i++)
> +		__prt_char(buf, ' ');

Why the loop? Don't you have a _chars variant?

> +void printbuf_indent_add(struct printbuf *buf, unsigned spaces)
> +{
> +	if (WARN_ON_ONCE(buf->indent + spaces < buf->indent))
> +		spaces = 0;
> +
> +	buf->indent += spaces;
> +	while (spaces--)
> +		prt_char(buf, ' ');
> +}
> +EXPORT_SYMBOL(printbuf_indent_add);
> +
> +/**
> + * printbuf_indent_sub - subtract from the current indent level
> + *
> + * @buf: printbuf to control
> + * @spaces: number of spaces to subtract from the current indent level
> + *
> + * Subsequent lines, and the current line if the output position is at the start
> + * of the current line, will be indented by @spaces less spaces.
> + */
> +void printbuf_indent_sub(struct printbuf *buf, unsigned spaces)
> +{
> +	if (WARN_ON_ONCE(spaces > buf->indent))
> +		spaces = buf->indent;
> +
> +	if (buf->last_newline + buf->indent == buf->pos) {
> +		buf->pos -= spaces;
> +		printbuf_nul_terminate(buf);
> +	}
> +	buf->indent -= spaces;
> +}
> +EXPORT_SYMBOL(printbuf_indent_sub);
> +
> +/**
> + * prt_tab - Advance printbuf to the next tabstop
> + *
> + * @buf: printbuf to control
> + *
> + * Advance output to the next tabstop by printing spaces.
> + */
> +void prt_tab(struct printbuf *out)
> +{
> +	int spaces = max_t(int, 0, out->tabstops[out->tabstop] - printbuf_linelen(out));
> +
> +	BUG_ON(out->tabstop > ARRAY_SIZE(out->tabstops));

So this accesses out->tabstops first, then does a (buggy) bounds check.
And kills the machine if somebody managed to corrupt ->tabstop. Instead
of limping along and living with less-pretty-printed output.

I don't think you'll get this code accepted by the Great Penguin.

Rasmus
