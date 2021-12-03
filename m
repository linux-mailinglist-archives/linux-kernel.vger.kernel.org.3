Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654E1467EF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383128AbhLCUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:52:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47886 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhLCUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:52:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B71CFB82920;
        Fri,  3 Dec 2021 20:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908B4C53FCD;
        Fri,  3 Dec 2021 20:48:57 +0000 (UTC)
Date:   Fri, 3 Dec 2021 15:48:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <20211203154855.43d4f0e6@gandalf.local.home>
In-Reply-To: <20211203182638.GA450223@lapt>
References: <20211203100846.3977195-1-keescook@chromium.org>
        <YaoN6wnNezMvyyd5@smile.fi.intel.com>
        <20211203182638.GA450223@lapt>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 10:26:38 -0800
Yury Norov <yury.norov@gmail.com> wrote:

> On Fri, Dec 03, 2021 at 02:30:35PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:  
> > > It's common practice to cast small variable arguments to the find_*_bit()  
> 
> Not that common - I found 19 examples of this cast, and most of them
> are in drivers. The only non-driver case is kernel/trace/pid_list.c:
> 
>         static inline bool upper_empty(union upper_chunk *chunk)
>         {
>                 /*
>                  * If chunk->data has no lower chunks, it will be the same
>                  * as a zeroed bitmask. Use find_first_bit() to test it
>                  * and if it doesn't find any bits set, then the array
>                  * is empty.
>                  */
>                 int bit = find_first_bit((unsigned long *)chunk->data,
>                                          sizeof(chunk->data) * 8);
>                 return bit >= sizeof(chunk->data) * 8;
>         }
> 
> And it's OK wrt type conversion because chunk->data is:
> 
>         union lower_chunk {
>                 union lower_chunk               *next;
>                 unsigned long                   data[LOWER_SIZE]; // 2K in size
>         };
> 
> Although, this function should use bitmap_empty(), probably like this:
> 
>         static inline bool upper_empty(union upper_chunk *chunk)
>         {
>                 return bitmap_empty(chunk->data->data[0], BITS_PER_LONG);
>         }
> 
> Steven, can you comment on this?
> 
> > It's a bad practice and should be fixed accordingly, no?  
> 
> Yes.

You are probably right and that should be bitmap_empty(), but the above is
incorrect.

This is emulating a sparse bitmask in a tree.

trace_pid_list {
	union upper_chunk	upper[256];
};

union upper_chunk {
	union upper_chunk	*next; // when freed used as free list pointer
	union lower_chunk	data[256];
};

union lower_chunk {
	union lower_chunk	*next; // for free list
	unsigned long		data[512]; // for 64 bit
//				data[1024]; for 32 bit
};

The code is initialized where we allocate some structures to fill the above
tree, but when the sparse bitmask is empty, the upper pointers are null.
That is, the pointers are only assigned *if and only if* there's a bit set
in the lower structure. That way, we can quickly skip over large sections
without having to look deeper into the tree if there's nothing set.

Because the upper_chunk has an array of pointers, and the pointers are
only allocated if the lower chunk they point to has a bit set, and are NULL
otherwise. In order to find the first chunk to look at, or know if a chunk
is empty, we scan the pointers as if they were long words, and if nothing
is set, we know it is empty.

The above is an abuse of find_first_bit() to scan the pointers.

The equivalence of:

                 int bit = find_first_bit((unsigned long *)chunk->data,
                                          sizeof(chunk->data) * 8);
                 return bit >= sizeof(chunk->data) * 8;

would then actually be:

		return bitmap_empty((unsigned long *)chunk->data,
			sizeof(chunk->data) * 8);

Not what you wrote.

-- Steve


