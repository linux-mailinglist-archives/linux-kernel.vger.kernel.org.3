Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F6052DF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbiESVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiESVUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:20:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957076344;
        Thu, 19 May 2022 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8vvPLkGWP3ifaJKEhqGdE/tJr4G8u2UkA/bB8o3Xs4c=; b=a/t1D1HqFnYaibHeG7izMDFqmz
        6G6dEhrvZMFWvgNj9hd4x783hx2LvXPK6FA7zGWH3KT7pUQGnnSRpBt0ylVXlND/yspdZgk/LoLgY
        D8/A8VuVkatFLfXwIVn3s8FkLqPkmsA1V0I+qEKNa2VZXZ0nLBDwlQSrNPK9e9EWWud4YH8IkJpfX
        SINO1Ys1SjzBsLHHg4ftQBq4Wtc8w+3EdgaNhzPIlJAzjQQxQweXFF/oQLIlnziYvTe4Eh1Y281Rg
        idDPi/luA6Ot7y0tGHA9JAz5mUKBSTr7d80CzFmd4d/bXPvjHcIx3QXoZbhJR2vYtiQ5XdwIvU7wI
        D1XjSTBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrnZd-00D6is-0o; Thu, 19 May 2022 21:20:45 +0000
Date:   Thu, 19 May 2022 22:20:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <Yoa0rBRY/wwplw0h@casper.infradead.org>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-4-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:23:56PM -0400, Kent Overstreet wrote:
> +			while (1) {
> +				if (WARN_ON_ONCE(nr_args == ARRAY_SIZE(fn_args)))
> +					goto out;
> +				if (*fmt++ != '%')
> +					goto out;
> +				if (*fmt++ != 'p')
> +					goto out;
> +				fn_args[nr_args++] = va_arg(args, void *);
> +				if (*fmt == ')')
> +					break;
> +				if (*fmt++ != ',')
> +					goto out;
> +			}
> +
> +			call_pr_fn(out, fn, fn_args, nr_args);
> +			fmt++; /* past trailing ) */

It's not a big thing, but why not make the loop do:

				c = *fmt++;
				if (c == ')')
					break;
				if (c != ',')
					goto out;

and then you can drop the fmt++ line outside the loop.

(it's obviosuly awkward; it needed a comment)
