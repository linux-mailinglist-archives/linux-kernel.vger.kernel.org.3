Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D58544E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbiFINzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiFINzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:55:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30563C4B8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:55:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C8D981FE11;
        Thu,  9 Jun 2022 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654782942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7ReEg/+KycGfvZvsF4eM6xltIFNVKmJ3ikfiONV6AI=;
        b=mMkZORa4LmkL90Nulr/tyP/y+roVDdHPLSbWA3Oce9MBPZhcxiPGnCZ+iMCRjkD4UvsfVX
        zpZnyqzSxKXRYYehS/IQe1Jp5bynnq6mRbrILpgJzC54pc2DXECKkHPnAH5TdzHeinCZIO
        V0if76H9rJonJx3I+TEqIHMoparqkMc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 80DDB2C141;
        Thu,  9 Jun 2022 13:55:42 +0000 (UTC)
Date:   Thu, 9 Jun 2022 15:55:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 01/33] lib/printbuf: New data structure for printing
 strings
Message-ID: <YqH72gJpajLCLCUc@alley>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
 <20220604193042.1674951-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604193042.1674951-2-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-06-04 15:30:10, Kent Overstreet wrote:
> This adds printbufs: a printbuf points to a char * buffer and knows the
> size of the output buffer as well as the current output position.
> 
> Future patches will be adding more features to printbuf, but initially
> printbufs are targeted at refactoring and improving our existing code in
> lib/vsprintf.c - so this initial printbuf patch has the features
> required for that.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/printbuf.h | 118 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 include/linux/printbuf.h
> 
> diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
> new file mode 100644
> index 0000000000..8b3797dc4b
> --- /dev/null
> +++ b/include/linux/printbuf.h
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: LGPL-2.1+ */
> +/* Copyright (C) 2022 Kent Overstreet */
> +
> +#ifndef _LINUX_PRINTBUF_H
> +#define _LINUX_PRINTBUF_H
> +
> +#include <linux/string.h>
> +
> +/*
> + * Printbufs: String buffer for outputting (printing) to, for vsnprintf

It might be worth to mention:

  @pos is the position that would be used to write into the buffer.
  The string is truncated when @pos is greater or equal to
  the buffer @size.

  @buf might be NULL and @size zero when the buffer is used just
  to count the needed buffer size.

It is visible in the code. But it would be nice to explicitly
mention it because it is one important feature of this buffer.

> + */
> +
> +struct printbuf {
> +	char			*buf;
> +	unsigned		size;
> +	unsigned		pos;
> +};
> +
> +static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
> +{
> +	memset(out->buf + out->pos,
> +	       c,
> +	       min(n, printbuf_remaining(out)));
> +	out->pos += n;
> +}

Thanks for using "prt_" prefix. It is better than "pr_", definitely.

Though, I wonder if you considered using:

    pb_   aka "Print to Buffer"
    ppb_  aka "Print to PrintBuffer"
    bpr_  aka "Buffer Print"

to make it more obvious that it is printing into some buffer.

I promise that this is my last try to bikeshed about the prefix.
I just want to get it "right" before you extend the patchset even
more.

Otherwise, the code looks good to me.

Best Regards,
Petr
