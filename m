Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65756544EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbiFIOZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243030AbiFIOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:25:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF32E4C80
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:25:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F1BDF1FDB8;
        Thu,  9 Jun 2022 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654784737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=foyHxtvOVYiFqUh/38xC4MXVzb6kZxMjubnQ2EP+XC8=;
        b=M7OAt6TF1mc95qHuzApN77ZZkItbbIdgln3oCGu+kbqlQU2czhudi69INI1sKakhvrdf+5
        AgzzJJN0fs5lGeWp+MlNMDj4as14grpX7kXXqwUJAU5KrmSo581loTInMJNpdqCjpx/QW8
        9bVF6y7FQpwh4vbFmAvASovStF0Nf7I=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A33452C141;
        Thu,  9 Jun 2022 14:25:36 +0000 (UTC)
Date:   Thu, 9 Jun 2022 16:25:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 02/33] lib/string_helpers: Convert string_escape_mem()
 to printbuf
Message-ID: <YqIC4AWW0bF7nOGu@alley>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
 <20220604193042.1674951-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604193042.1674951-3-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-06-04 15:30:11, Kent Overstreet wrote:
> Like the upcoming vsprintf.c conversion, this converts string_escape_mem
> to prt_escaped_string(), which uses and outputs to a printbuf, and makes
> string_escape_mem() a smaller wrapper to support existing users.
> 
> The new printbuf helpers greatly simplify the code.
> 
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -15,6 +15,7 @@
>  #include <linux/fs.h>
>  #include <linux/limits.h>
>  #include <linux/mm.h>
> +#include <linux/printbuf.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/string_helpers.h>
> @@ -301,19 +302,14 @@ int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
>  }
>  EXPORT_SYMBOL(string_unescape);
>  
> -static bool escape_passthrough(unsigned char c, char **dst, char *end)
> +static bool escape_passthrough(struct printbuf *out, unsigned char c)
>  {
> -	char *out = *dst;
> -
> -	if (out < end)
> -		*out = c;
> -	*dst = out + 1;
> +	prt_char(out, c);

This modifies the behavior. The original code did not add
the trailing '\0'.

I agree that the original behavior is ugly but it is documented
see the comment:

 * Return:
 * The total size of the escaped output that would be generated for
 * the given input and flags. To check whether the output was
 * truncated, compare the return value to osz. There is room left in
 * dst for a '\0' terminator if and only if ret < osz.
                             ^^^^^^^^^^^^^^


I am all for changing the behavior but it would require checking
all callers.

Anyway, adding the trailing '\0' all is not much effective.
I suggest to use __prt_char() and add the trailing '\0' when
the string is complete.

We must make sure that __prt_char() is able to add the last
character even when there will not longer be space for
the trailing '\0'.


>  	return true;
>  }
>  

[...]

>  
>  /**
> - * string_escape_mem - quote characters in the given memory buffer
> + * prt_escaped_string - quote characters in the given memory buffer
> + * @out:	printbuf to output to (escaped)
>   * @src:	source buffer (unescaped)
>   * @isz:	source buffer size
> - * @dst:	destination buffer (escaped)
> - * @osz:	destination buffer size
>   * @flags:	combination of the flags
>   * @only:	NULL-terminated string containing characters used to limit
>   *		the selected escape class. If characters are included in @only
> @@ -517,11 +466,10 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>   * truncated, compare the return value to osz. There is room left in
>   * dst for a '\0' terminator if and only if ret < osz.
>   */
> -int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
> -		      unsigned int flags, const char *only)
> +void prt_escaped_string(struct printbuf *out,
> +			const char *src, size_t isz,
> +			unsigned int flags, const char *only)
>  {
> -	char *p = dst;
> -	char *end = p + osz;
>  	bool is_dict = only && *only;
>  	bool is_append = flags & ESCAPE_APPEND;
>  
> @@ -549,41 +497,49 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  		 * %ESCAPE_NA cases.
>  		 */
>  		if (!(is_append || in_dict) && is_dict &&
> -					  escape_passthrough(c, &p, end))
> +		    escape_passthrough(out, c))
>  			continue;
>  
>  		if (!(is_append && in_dict) && isascii(c) && isprint(c) &&
> -		    flags & ESCAPE_NAP && escape_passthrough(c, &p, end))
> +		    flags & ESCAPE_NAP && escape_passthrough(out, c))
>  			continue;
>  
>  		if (!(is_append && in_dict) && isprint(c) &&
> -		    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
> +		    flags & ESCAPE_NP && escape_passthrough(out, c))
>  			continue;
>  
>  		if (!(is_append && in_dict) && isascii(c) &&
> -		    flags & ESCAPE_NA && escape_passthrough(c, &p, end))
> +		    flags & ESCAPE_NA && escape_passthrough(out, c))
>  			continue;
>  
> -		if (flags & ESCAPE_SPACE && escape_space(c, &p, end))
> +		if (flags & ESCAPE_SPACE && escape_space(out, c))
>  			continue;
>  
> -		if (flags & ESCAPE_SPECIAL && escape_special(c, &p, end))
> +		if (flags & ESCAPE_SPECIAL && escape_special(out, c))
>  			continue;
>  
> -		if (flags & ESCAPE_NULL && escape_null(c, &p, end))
> +		if (flags & ESCAPE_NULL && escape_null(out, c))
>  			continue;
>  
>  		/* ESCAPE_OCTAL and ESCAPE_HEX always go last */
> -		if (flags & ESCAPE_OCTAL && escape_octal(c, &p, end))
> +		if (flags & ESCAPE_OCTAL && escape_octal(out, c))
>  			continue;
>  
> -		if (flags & ESCAPE_HEX && escape_hex(c, &p, end))
> +		if (flags & ESCAPE_HEX && escape_hex(out, c))
>  			continue;
>  
> -		escape_passthrough(c, &p, end);
> +		escape_passthrough(out, c);
>  	}
> +}
> +EXPORT_SYMBOL(prt_escaped_string);
> +
> +int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
> +		      unsigned int flags, const char *only)

We need keep the comment above this API as long as it is public.

Note that it uses the docbook comment format, starging with /** ...
And the symbol is exported.

It is even more important because of the crazy behavior where
it does not add the trailing '\0'.

> +{
> +	struct printbuf out = PRINTBUF_EXTERN(dst, osz);
>  
> -	return p - dst;
> +	prt_escaped_string(&out, src, isz, flags, only);
> +	return out.pos;
>  }
>  EXPORT_SYMBOL(string_escape_mem);

Note: If you decided to change/fix the behavior then please do so
      in a separate patch(set). I was able to catch the problem
      because the patch was straightforward and "easy" to review.

Best Regards,
Petr
