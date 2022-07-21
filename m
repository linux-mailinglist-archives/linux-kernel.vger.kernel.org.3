Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD67457D232
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiGURFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGURFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:05:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F3A7AB0A;
        Thu, 21 Jul 2022 10:05:43 -0700 (PDT)
Received: from localhost (dynamic-089-204-139-174.89.204.139.pool.telefonica.de [89.204.139.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 429A96601ABB;
        Thu, 21 Jul 2022 18:05:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658423142;
        bh=FoeOIMjJ3nvLwW8C/6cVGGWNd/VWco4Un0vi/mWNUjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDsLd+3hm6DpoMQwa1Z4koJcjzZqb/0zdLycCEYzZvEZoJEVKRTIz9MszbqPHm5P3
         P1EUkPVJeBtpZ0YpdYeeIWZm7yrMhPUo8Xk/YK/xhmSc1Ay9mXg+Pjzb4t4myxAKWv
         /RL2FdZvsIaa8C2QezBYPZ/mahvozCnUNv0NE5c0RoWW8wmZORd+XWNvayrZv6G0By
         4/HScJ/R4Aw/a/2VJPmW0z83p0ZDxGpGJyiJZCYvNfXrT/dYKaM1ZxXCYuSR/Z8Q1z
         2pRQHJSSHjb6BsFU2aMuPeMHcpPDgXbvD8tvhRGfflk/VqH0RxgucT75XQFb4sf4FS
         sKnICVoH+L0SA==
Date:   Thu, 21 Jul 2022 19:05:39 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>, knaerzche@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>,
        bob.beckett@collabora.com,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-staging@lists.linux.dev, nicolas.dufresne@collabora.com,
        andrzej.p@collabora.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/6] bitops: bitmap helper to set variable length values
Message-ID: <20220721170539.57z5kcxtgxuh3qma@basti-XPS-13-9310>
References: <20220713163201.136202-1-sebastian.fricke@collabora.com>
 <Ys8Txuq9/u/EL6sj@yury-laptop>
 <CAHp75VeOLfKw4-+Dpn54yy6j=tdiBNA_2Kvhj7mUUjTD-M_vYA@mail.gmail.com>
 <Ys8gpl3m+vvEM7Sy@yury-laptop>
 <CAHp75VeGSWoq-a10nA9NLKBEX7L_eiL0zPMJHUbX=c64wG8hkg@mail.gmail.com>
 <Ys8uKUKErpoWL873@yury-laptop>
 <Ys/835VdAYRVYdXW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Ys/835VdAYRVYdXW@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yury and Andy,

thanks for you review and discussion, after some further communication
with Nicolas Dufresne and Andrzej Pietrasiewicz, we came to the
conclusion that I will prepare a more general bit-writer API, which fits
better to the use-case we have on a lot of multimedia hardware.

I'll probably reuse the bitmap API as the backbone of that
implementation and use the `*_set8` to write the content back to memory,
but as we have a few more potential users for such an API, I'll strive
towards creating a new kernel API instead of extending an existing API
that isn't designed for our use-case.

Thanks a lot for your input and ideas.

Greetings,
Sebastian

On 14.07.2022 14:24, Andy Shevchenko wrote:
>On Wed, Jul 13, 2022 at 01:42:17PM -0700, Yury Norov wrote:
>> On Wed, Jul 13, 2022 at 10:14:24PM +0200, Andy Shevchenko wrote:
>> > On Wed, Jul 13, 2022 at 9:44 PM Yury Norov <yury.norov@gmail.com> wrote:
>> > > On Wed, Jul 13, 2022 at 09:10:33PM +0200, Andy Shevchenko wrote:
>> > > > On Wed, Jul 13, 2022 at 8:56 PM Yury Norov <yury.norov@gmail.com> wrote:
>> > > > > On Wed, Jul 13, 2022 at 06:31:59PM +0200, Sebastian Fricke wrote:
>
>...
>
>> > > > > I'd suggest you to try implementing
>> > > > >         bitmap_copy_from(dst, src, dst_off, len)
>> > > > > or even
>> > > > >         bitmap_copy_from(dst, dst_off, src, src_off, len)
>> > > > > if you expect that you'll need more flexibility in the future.
>> > > >
>> > > > Do you think it would be useful?
>> > > >
>> > > > We have bitmap_replace() & bitmap_remap(). Wouldn't that be enough?
>> > >
>> > > bitmap_replace and bitmap_remap have no an 'offset' parameter.
>> >
>> > True.
>> >
>> > But then it's a bit too generic to have this src_off, no?
>>
>> That's why I said:
>>
>> > > > > if you expect that you'll need more flexibility in the future.
>>
>> My preferred option is bitmap_copy_from(dst, src, dst_off, len).
>>
>> > I would rather expect for asymmetrical bitmaps that the other side
>> > will be either one of the fixed width types (it makes sense to have
>> > for 32- or 64-bit arguments.
>>
>> Look at patch #6 - it copies 1,4,5,9,10,32,37... - pretty much a random
>> number number of bits.
>
>It's too poor randomness, as u64 covers all what in patch 6.
>
>> > When you have a source bitmap of x bits and  you would like to copy it
>> > into a y-bit one, I would think that either you have a small amount of
>> > bits in x anyway, or x is a full-sized bitmap (same order as y).
>>
>> It sounds like a speculation to me. Why shouldn't we let people to
>> copy with an offset any number of bits?
>
>Because it's a common case. You have a value in the register / variable, which
>naturally is one of the POD types. Now you want to inject this into bitmap at
>the arbitrary offset. Value itself also needs to be variadic size in bits.
>
>Basically what he is trying to achieve is something like bitfield.h API over
>bitmaps. Dunno, if actually bitfield.h in the certain driver wouldn't be
>enough.
>
>> > Also
>> > keep in mind that granularity is long, so less than long it makes no
>> > sense.
>> >
>> >   bitmap_copy_from_T(unsigned long *map, start, len, T src),
>> >
>> > where T is type, start is the offset in map, len is the amount of bits
>> > from src starting from 0. That's what is required in most of the cases
>> > I believe.
>>
>> But not in Sebastian's case, according to patch #6.
>
>I think it's a case, see above.
>
>-- 
>With Best Regards,
>Andy Shevchenko
>
>
