Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC35642BE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiGBUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 16:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 16:44:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE74AA44F;
        Sat,  2 Jul 2022 13:44:14 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id k14so4551755qtm.3;
        Sat, 02 Jul 2022 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DlqK/gCHCDGy5OSRXAYFxnfYX+I9GxfO75TGVC+FALo=;
        b=KYrBXP9UYV5NoeyAbdVeawzPP055oU/YPCp4PhRf6nnOZT6ArrIVdgKYCoo6iGYIf+
         OkpT7KUF7/gAJJpj8Gndr1tT5ooKoE1Njt/nQZMg5AT/yUvpXboiZ/7YVG5kVzxZiDmN
         33edQoG2f8REKt8wyYDVZqC17/vWVi1BSJtXaVZotBUjJeo0oi9t0rl723v/YXS0e8I4
         Lm/8Y766tSv3y1tW0SDfNL66UCtAPbt4apAJhXJR5LagbgW6dah2u1jztPJUP5qjESHt
         gNofLDhtzb34Mw6JCaEQvGQ09YGrqkszp6Jaz3T6qgV/3A+xlFIDrZsvk+nZJb6LBdbT
         uyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DlqK/gCHCDGy5OSRXAYFxnfYX+I9GxfO75TGVC+FALo=;
        b=jDAFI4ZcvMW6Fa52etnglszLBuQP/gcC47FU58fxtQxjpwcrQlhPZKYKHu3bUrH0lC
         c+0/K0KqK+8vcUTkTbf6f0L/5+0tGtHgBqUZuyi2vQp6jtTChZ0Jhq2acovHcII1pcEo
         W2np89DE63CD/nnuGwg/EADgAjyRbpufgZRmxH1YAxqJ8ilGowpkAV102X8lUXhQmPhd
         EalFAYagwKT21pdWexQk5VLl9BdGMPp+uFgz9ntLWlqiEmNYFNAfiA06a9s83J9+1XFe
         AWHIqZJwgv8VhBCQ+EG5CzXisrotUA9jaM5sMkWROKu0HC4kZLZP3hxWyqNWA5u3gTXm
         VLqA==
X-Gm-Message-State: AJIora8Vcg/Vr4Tovkd9zQk3tGiZ5cmoE6lZh/nKo6KpBY598/eAol+s
        +gLptBE/ic+lIeQdSnkRlwc=
X-Google-Smtp-Source: AGRyM1v9Om7l6fke9TMJ9NBQOtPQriWNRvL7GNoiNXCdxK+C+aPoOgahYt70QVZO5kMXfNiYT220JQ==
X-Received: by 2002:a05:6214:e83:b0:470:54c3:e18e with SMTP id hf3-20020a0562140e8300b0047054c3e18emr22253839qvb.3.1656794653736;
        Sat, 02 Jul 2022 13:44:13 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:e838:b1c2:b125:986a])
        by smtp.gmail.com with ESMTPSA id c19-20020a05622a059300b00304edcfa109sm18513614qtb.33.2022.07.02.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 13:44:13 -0700 (PDT)
Date:   Sat, 2 Jul 2022 13:44:12 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] Introduce bitmap_size()
Message-ID: <YsCuHLTsKGCO/jsL@yury-laptop>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 08:28:53PM +0200, Christophe JAILLET wrote:
> This serie introduces bitmap_size() which returns the size, in bytes, of a
> bitmap. Such a function is useful to simplify some drivers that use vmalloc() or
> other functions to allocate some butmaps.

This generally looks like a step in a wrong direction. Bitmap is by
definition an array of bits. If someone has a reason to handle bitmap
on a per-byte basis, the guy is probably doing something wrong.

We already have quite comprehensive list of functions that help to
allocate, fill, clear, copy etc bitmap without considering it as an
array of bytes or words.

> ... some drivers that use vmalloc() ...

If a driver needs vmalloc() for a bitmap, we should introduce
bitmap_vmalloc(), not bitmap_size().

> It also hides some implementation details about how bitmaps are stored (array of
> longs)

Sorry, I don't understand that. How bitmap_size() helps to hide a fact that
bitmap is an array of unsigned longs? (Except that it makes an impression
that it's an array of bytes.)

> Before introducing this function in patch 3, patch 1 and 2 rename some functions
> with the same name but with different meaning.
> 
> Finaly, patch 4 makes use of the new function in bitmap.h.

You mentioned, you need bitmap_size() to use with vmalloc(), but in
patch 4, there's no such code. 
 
> Other follow-up patches to simplify some drivers will be proposed later if/when
> this serie is merged.

This series doesn't show an example of how you're going to use new
API, and therefore it's hard to judge, do we really need bitmap_size(),
or we just need more helpers around.

As I already said, bitmaps are evolving in 2nd direction, which is the
right approach, I think.

Thanks,
Yury

> Christophe JAILLET (4):
>   s390/cio: Rename bitmap_size() as idset_bitmap_size()
>   fs/ntfs3: Rename bitmap_size() as ntfs3_bitmap_size()
>   bitmap: Introduce bitmap_size()
>   bitmap: Use bitmap_size()
> 
>  drivers/md/dm-clone-metadata.c |  5 -----
>  drivers/s390/cio/idset.c       |  8 ++++----
>  fs/ntfs3/bitmap.c              |  4 ++--
>  fs/ntfs3/fsntfs.c              |  2 +-
>  fs/ntfs3/index.c               |  6 +++---
>  fs/ntfs3/ntfs_fs.h             |  2 +-
>  fs/ntfs3/super.c               |  2 +-
>  include/linux/bitmap.h         | 15 +++++++++------
>  lib/math/prime_numbers.c       |  2 --
>  9 files changed, 21 insertions(+), 25 deletions(-)
> 
> -- 
> 2.34.1
