Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E672A467D46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359515AbhLCSaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382714AbhLCSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:30:05 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836AC061751;
        Fri,  3 Dec 2021 10:26:41 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j9so3555762qvm.10;
        Fri, 03 Dec 2021 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwdyKi75KKswk2QfbKpEYyGLv09EUR9IJeToSYVhRWQ=;
        b=W38ot1tcCSbjmyqud55X3YgaLmd6fRFcb9mHmPbNLCYs6QDzxLTEVRBjRM2wrlRxiQ
         3Zogxk9fhR+hzw5HEljJ/i9beF3BMuos0+Q9UBxru3ovqzqdKAS2rMuwN/I7Hy7Rs8Fw
         jOLLla0Gws/MGv7LN7WMMvTDQUimICe4FafYZTkwrb4QU4uy1ZWnDUO8KIstLQdz5JTK
         FZXRXecY3qnV59brlqxZsuH4qDoWiOXEOW2ChJyIZ6gwQ6BCGVgHWCcos228Xu3yzBsI
         Vx5/IA9YqhqVlKKmnfq3SBshMgonRHFr1Owf5oFAosafUwXAvS3JSpj3Rx79EB62RJQx
         z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwdyKi75KKswk2QfbKpEYyGLv09EUR9IJeToSYVhRWQ=;
        b=mboyJuhle/shyOcrDjHcKu7gTJcstv1KrH8NM9PrizXN0yNTUGIoVeIqHuvaZ05yoI
         k9Xo6rVli5MDaMWPl+OINgqVymGnp4hTk9uEN5e3jwtPG+sUIxYyth3dHk5VhWVdl7Hp
         N/qrWh5IMXdNfjaYoByMUryMcxeOP+HSUssrhP6OJLehfw9LXzZu7eyTLslZhFDFdgrP
         OqbL5UEevvneU0WoD2ASA6zx5TRkQ3EwcwQ95F5ta5Pt58Pg0iIjkCc4vrC+xVylnLwq
         m48FJN6yzc96j56uTngqHZsn4pw6UVaYJrrfQGS6RpAfNkOmlSXjenUxl/MhyQG2tEdd
         drXg==
X-Gm-Message-State: AOAM533X28TslaPzExle9FgOFGpC1PX+5rHKY7IgHY9EpL0Sr2NtDddr
        lYvoBqo998s1g1VK9qi9pWs6I67szv8=
X-Google-Smtp-Source: ABdhPJyIY9Lf45PQeVA46yUfwcfIBMhyOpfHzmidYGdQ1zcW9Atz1ekGaXN3nZoVLdoMrKIJHxLSaA==
X-Received: by 2002:ad4:596f:: with SMTP id eq15mr20521055qvb.89.1638556000572;
        Fri, 03 Dec 2021 10:26:40 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id c8sm2571116qkp.8.2021.12.03.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 10:26:40 -0800 (PST)
Date:   Fri, 3 Dec 2021 10:26:38 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <20211203182638.GA450223@lapt>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaoN6wnNezMvyyd5@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 02:30:35PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> > It's common practice to cast small variable arguments to the find_*_bit()

Not that common - I found 19 examples of this cast, and most of them
are in drivers. The only non-driver case is kernel/trace/pid_list.c:

        static inline bool upper_empty(union upper_chunk *chunk)
        {
                /*
                 * If chunk->data has no lower chunks, it will be the same
                 * as a zeroed bitmask. Use find_first_bit() to test it
                 * and if it doesn't find any bits set, then the array
                 * is empty.
                 */
                int bit = find_first_bit((unsigned long *)chunk->data,
                                         sizeof(chunk->data) * 8);
                return bit >= sizeof(chunk->data) * 8;
        }

And it's OK wrt type conversion because chunk->data is:

        union lower_chunk {
                union lower_chunk               *next;
                unsigned long                   data[LOWER_SIZE]; // 2K in size
        };

Although, this function should use bitmap_empty(), probably like this:

        static inline bool upper_empty(union upper_chunk *chunk)
        {
                return bitmap_empty(chunk->data->data[0], BITS_PER_LONG);
        }

Steven, can you comment on this?

> It's a bad practice and should be fixed accordingly, no?

Yes.

> > helpers to unsigned long and then use a size argument smaller than
> > sizeof(unsigned long):
> > 
> > 	unsigned int bits;
> > 	...
> > 	out = find_first_bit((unsigned long *)&bits, 32);
> > 
> > This leads to the find helper dereferencing a full unsigned long,
> > regardless of the size of the actual variable. The unwanted bits
> > get masked away, but strictly speaking, a read beyond the end of
> > the target variable happens. Builds under -Warray-bounds complain
> > about this situation, for example:
> > 
> > In file included from ./include/linux/bitmap.h:9,
> >                  from drivers/iommu/intel/iommu.c:17:
> > drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> > ./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
> >   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> >       |                                     ^~~~~
> > drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
> >  2115 |         int pds, max_pde;
> >       |                  ^~~~~~~

The driver should be fixed. I would suggest using one of ffs/fls/ffz from
include/asm/bitops.h

Thanks,
Yury

> > Instead, just carefully read the correct variable size, all of which
> > happens at compile time since small_const_nbits(size) has already
> > determined that arguments are constant expressions.
> 
> What is the performance impact?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
