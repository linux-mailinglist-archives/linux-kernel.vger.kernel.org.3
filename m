Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3705B535135
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347843AbiEZPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEZPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:06:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734513E2E;
        Thu, 26 May 2022 08:06:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A074F21A41;
        Thu, 26 May 2022 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653577576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9LKdruTdJBcqubf9vomsTehcbvJ/DJyjpYz62KRzlKg=;
        b=Kaw7sEjXPl5+sS7E6uyLS6gKAYfAFuNiV0NQrwdaVzwbqGRUfel70QBIJbMWZ3h/Hj/B4g
        IRROZjCR/OpF/8vPsha445oWLLPseeLyoJuUgetxdEuXob/UkQOX48d06VXTrvFGlGNWrq
        Az11Mwz3/whu/eC/uJ8hZV7pxteGE0Y=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1152D2C141;
        Thu, 26 May 2022 15:06:16 +0000 (UTC)
Date:   Thu, 26 May 2022 17:06:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 01/28] lib/printbuf: New data structure for printing
 strings
Message-ID: <Yo+XZ4YtU9fN/sGE@alley>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-2-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-05-19 13:23:54, Kent Overstreet wrote:
> This adds printbufs: a printbuf points to a char * buffer and knows the
> size of the output buffer as well as the current output position.
> 
> Future patches will be adding more features to printbuf, but initially
> printbufs are targeted at refactoring and improving our existing code in
> lib/vsprintf.c - so this initial printbuf patch has the features
> required for that.

> diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
> new file mode 100644
> index 0000000000..40dc07040d
> --- /dev/null
> +++ b/include/linux/printbuf.h
> +static inline void pr_chars(struct printbuf *out, char c, unsigned n)
> +{
> +	memset(out->buf + out->pos,
> +	       c,
> +	       min(n, printbuf_remaining(out)));
> +	out->pos += n;
> +	printbuf_nul_terminate(out);
> +}

This function is not later used. Please, do not add API
that will not have users in the same patchset.

There are several other cases. I am not going to comment
all of them.


> +static inline void __pr_char(struct printbuf *out, char c)
> +{
> +	if (printbuf_remaining(out))
> +		out->buf[out->pos] = c;
> +	out->pos++;
> +}
> +
> +static inline void pr_char(struct printbuf *out, char c)
> +{
> +	__pr_char(out, c);
> +	printbuf_nul_terminate(out);
> +}

The "pr_" prefix is a nightmare for me because the same prefix
is used also for printk() API ;-)

Could we please use "pb_" instead?

Note that "prb_" prefix is already used by the lockless printk
ringbuffer, see kernel/printk/printk_ringbuffer.h.

Best Regards,
Petr
