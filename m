Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEFF4ADA67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376773AbiBHNvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiBHNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:51:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4DFC03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:51:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DEE1A1F387;
        Tue,  8 Feb 2022 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644328299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KdBmHlpiWVoOGJrAAEL9T6nI45p+Xd30noXSDXWqouo=;
        b=XfWeGKbvKx6pedZHAsn1NdiA7AYox4E41PKEamA/hgEiAcW3xIwQlj5qrchfieR/gW4T01
        X2M138V1wLSeEPCyzgWBhpDuR7RzOUTOmuKKW+/uRhgunNC2IoB2OSqcSEHe4FQTtIYBMo
        OQs3lKNKVuJ6YPdpmyLaB4ysNKau11o=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59DA2A3B84;
        Tue,  8 Feb 2022 13:51:39 +0000 (UTC)
Date:   Tue, 8 Feb 2022 14:51:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vsprintf: Fix %pK with kptr_restrict == 0
Message-ID: <YgJ1a0Mi0wEbr88C@alley>
References: <d7cd39abc28f5e0e08faa8958f35cd929165084e.1643281806.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cd39abc28f5e0e08faa8958f35cd929165084e.1643281806.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Kees and Linus in Cc because it modifies %pK behavior.

On Thu 2022-01-27 11:11:02, Christophe Leroy wrote:
> Although kptr_restrict is set to 0 and the kernel is booted with
> no_hash_pointers parameter, the content of /proc/vmallocinfo is
> lacking the real addresses.
> 
>   / # cat /proc/vmallocinfo
>   0x(ptrval)-0x(ptrval)    8192 load_module+0xc0c/0x2c0c pages=1 vmalloc
>   0x(ptrval)-0x(ptrval)   12288 start_kernel+0x4e0/0x690 pages=2 vmalloc
>   0x(ptrval)-0x(ptrval)   12288 start_kernel+0x4e0/0x690 pages=2 vmalloc
>   0x(ptrval)-0x(ptrval)    8192 _mpic_map_mmio.constprop.0+0x20/0x44 phys=0x80041000 ioremap
>   0x(ptrval)-0x(ptrval)   12288 _mpic_map_mmio.constprop.0+0x20/0x44 phys=0x80041000 ioremap
>     ...
> 
> According to the documentation for /proc/sys/kernel/, %pK is
> equivalent to %p when kptr_restrict is set to 0.

Good catch!

BTW: The behavior is strange also when kptr_restrict == 1. It allways
prints non-hashed pointers for user space adresses. It means that
it is less restrictive than kptr_restrict == 0 by default when
no_hash_pointers == 0. It is probably not a big deal but...


> ---
>  lib/vsprintf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b8129dd374c..9c60d6e1a0d6 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -857,6 +861,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
>  	switch (kptr_restrict) {
>  	case 0:
>  		/* Handle as %p, hash and do _not_ leak addresses. */
> +		if (unlikely(no_hash_pointers))
> +			break;
>  		return ptr_to_id(buf, end, ptr, spec);

This is a twisted duplication of the following code from pointer():

static noinline_for_stack
char *pointer(const char *fmt, char *buf, char *end, void *ptr,
	      struct printf_spec spec)
{
[...]
	/*
	 * default is to _not_ leak addresses, so hash before printing,
	 * unless no_hash_pointers is specified on the command line.
	 */
	if (unlikely(no_hash_pointers))
		return pointer_string(buf, end, ptr, spec);
	else
		return ptr_to_id(buf, end, ptr, spec);
}

Instead, I would create:

/*
 * default is to _not_ leak addresses, so hash before printing,
 * unless no_hash_pointers is specified on the command line.
 */
static noinline_for_stack
char *default_pointer(const char *fmt, char *buf, char *end, void *ptr,
		      struct printf_spec spec) 
{
	if (unlikely(no_hash_pointers))
		return pointer_string(buf, end, ptr, spec);

	return ptr_to_id(buf, end, ptr, spec);
}

and use it in both hash_pointer() and pointer().

And I would use is also for kptr_restrict == 1. But it probably
should be done in a separate patch and should be acked by Kees.


>  	case 1: {
>  		const struct cred *cred;

Best Regards,
Petr
