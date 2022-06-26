Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1153F55B3E3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiFZTxj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Jun 2022 15:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiFZTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:53:37 -0400
Received: from relay3.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0178A2728
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:53:36 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 4978A20F7F;
        Sun, 26 Jun 2022 19:53:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id BF0E720025;
        Sun, 26 Jun 2022 19:53:27 +0000 (UTC)
Message-ID: <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
Subject: [RFC[ Alloc in vsprintf
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Date:   Sun, 26 Jun 2022 12:53:26 -0700
In-Reply-To: <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
         <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
         <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
         <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
         <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
         <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
         <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: BF0E720025
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: zohyamfpbqbpm5xnigdzra7x6gg67d57
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/C8USxNfy8/EPSKDDRnnUZLXfj+xRFuUo=
X-HE-Tag: 1656273207-146809
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a reply to the printbufs thread, I wrote a proposal to use an
alloc to reduce stack in vsprintf when CONFIG_KALLSYMS is enabled.

No one has replied to this but I think it's somewhat sensible.

Thoughts?

On Mon, 2022-06-20 at 19:10 -0700, Joe Perches wrote:

> In a brief looking around at stack uses in vsprintf, I believe
> this is the largest stack declaration there.
> 
> Especially since KSYM_NAME_LEN was increased to 512 by 
> commit 394dffa6680c ("kallsyms: increase maximum kernel symbol length to 512")
> 
> Perhaps this stack declaration should instead be an alloc/free
> as it can be quite large.
> 
> I suppose one could quibble about the kzalloc vs kmalloc or the nominally
> unnecessary initialization of sym.
> 
> I think this makes sense though and it reduces the #ifdef uses too.
> ---
>  lib/vsprintf.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index c414a8d9f1ea9..30113a30fd88a 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -980,30 +980,37 @@ char *symbol_string(char *buf, char *end, void *ptr,
>  		    struct printf_spec spec, const char *fmt)
>  {
>  	unsigned long value;
> -#ifdef CONFIG_KALLSYMS
> -	char sym[KSYM_SYMBOL_LEN];
> -#endif
> +	char *sym = NULL;
>  
>  	if (fmt[1] == 'R')
>  		ptr = __builtin_extract_return_addr(ptr);
>  	value = (unsigned long)ptr;
>  
> -#ifdef CONFIG_KALLSYMS
> -	if (*fmt == 'B' && fmt[1] == 'b')
> -		sprint_backtrace_build_id(sym, value);
> -	else if (*fmt == 'B')
> -		sprint_backtrace(sym, value);
> -	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
> -		sprint_symbol_build_id(sym, value);
> -	else if (*fmt != 's')
> -		sprint_symbol(sym, value);
> -	else
> -		sprint_symbol_no_offset(sym, value);
> +	if (IS_ENABLED(CONFIG_KALLSYMS) &&
> +	    (sym = kzalloc(KSYM_SYMBOL_LEN, GFP_NOWAIT | __GFP_NOWARN))) {
> +		char *rtn;
> +
> +		if (*fmt == 'B' && fmt[1] == 'b')
> +			sprint_backtrace_build_id(sym, value);
> +		else if (*fmt == 'B')
> +			sprint_backtrace(sym, value);
> +		else if (*fmt == 'S' &&
> +			 (fmt[1] == 'b' ||
> +			  (fmt[1] == 'R' && fmt[2] == 'b')))
> +			sprint_symbol_build_id(sym, value);
> +		else if (*fmt != 's')
> +			sprint_symbol(sym, value);
> +		else
> +			sprint_symbol_no_offset(sym, value);
> +
> +		rtn = string_nocheck(buf, end, sym, spec);
> +
> +		kfree(sym);
> +
> +		return rtn;
> +	}
>  
> -	return string_nocheck(buf, end, sym, spec);
> -#else
>  	return special_hex_number(buf, end, value, sizeof(void *));
> -#endif
>  }
>  
>  static const struct printf_spec default_str_spec = {
> 

