Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459854E1C87
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbiCTQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245457AbiCTQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:18:20 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1B7E506DA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 09:16:54 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22KGGiDY026852;
        Sun, 20 Mar 2022 17:16:44 +0100
Date:   Sun, 20 Mar 2022 17:16:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 5/6] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
Message-ID: <20220320161644.GF8067@1wt.eu>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-6-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320093750.159991-6-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ammar,

a few points below:

On Sun, Mar 20, 2022 at 04:37:49PM +0700, Ammar Faizi wrote:
> +struct nolibc_heap {
> +	size_t	len;
> +	char	user_p[] __attribute__((__aligned__));
> +};

Note that many programs assume that malloc() returns a field aligned
to 2*sizeof(pointer) and unless I'm mistaken, above the user pointer
will only be aligned by one pointer. This may have an impact when the
compiler decides to use SIMD instructions.

> +#ifndef offsetof
> +#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
> +#endif
> +
> +#ifndef container_of
> +#define container_of(PTR, TYPE, FIELD) ({			\
> +	__typeof__(((TYPE *)0)->FIELD) *__FIELD_PTR = (PTR);	\
> +	(TYPE *)((char *) __FIELD_PTR - offsetof(TYPE, FIELD));	\
> +})
> +#endif

These ones are independent on the malloc code and should move to a
different patch and likely to a different file. I'm seeing we already
have a few macros in types.h and since it's shared by almost everything
it might be more suitable there.

Thanks!
Willy
