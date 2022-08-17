Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8259718E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiHQOmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiHQOlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:41:44 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7A9C22E;
        Wed, 17 Aug 2022 07:41:43 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id y18so10501983qtv.5;
        Wed, 17 Aug 2022 07:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nRYmskuhaxAVoDteJGSexBwd8XT1zGLZhU2AlsjADdk=;
        b=7CM4colDEice2FwBrWn4p9qXWxYLaVaprxt04uS6SzJKeHazzYyAMyeLT5yOIRal71
         YFgj9boSRRwlcgm43E34eCW0sjSanC62HFqhvstKihbeOTWvR4hwWeRLwbO6nsliyeYj
         ZClPbcAHYQcTyRJ09jAE0JxUIwBWX0iSH4Ve/hics6uf6t8mqUrenIxRPtupV73FC62t
         c5UcWVVHgae22exYbNuPKQnLryKtpF0oAmEi5314w8kY+CBiqSxZTN7c6ioyf4gkzSTq
         dtg8gMkaWgIj00jaVHlPHMbmr4WktnYEIa/KqE4CarmSv5ZSlgaVY69ZLtBT50ZbOSEQ
         YKSQ==
X-Gm-Message-State: ACgBeo0dNklqpbtOIAbXP5iX5T66pf5OUUcty1TrYiYuw5frJLDZQrb7
        l1AgZRclVOyM7wmTfY4nwBbzXCrpu/t7aA==
X-Google-Smtp-Source: AA6agR5Pkg/OwGpCZWH7SYscNGtKX0Z/4e2NYcRmt0J/XZL+nwmACLc40bsX8DEV3zTXcDwdbi2EHA==
X-Received: by 2002:ac8:5755:0:b0:343:560d:f4e1 with SMTP id 21-20020ac85755000000b00343560df4e1mr22270223qtx.630.1660747302446;
        Wed, 17 Aug 2022 07:41:42 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id bw11-20020a05622a098b00b0034306f519ddsm12642744qtb.65.2022.08.17.07.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:41:42 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-332fc508d88so167101287b3.3;
        Wed, 17 Aug 2022 07:41:42 -0700 (PDT)
X-Received: by 2002:a81:b812:0:b0:328:68e4:c886 with SMTP id
 v18-20020a81b812000000b0032868e4c886mr20747531ywe.502.1660747290248; Wed, 17
 Aug 2022 07:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
 <20220815125019.4a307a44@canb.auug.org.au>
In-Reply-To: <20220815125019.4a307a44@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 16:41:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXoVzcVERZQXDYxDZZc2_=huaAF8dC8o4iksV07w8ZU7Q@mail.gmail.com>
Message-ID: <CAMuHMdXoVzcVERZQXDYxDZZc2_=huaAF8dC8o4iksV07w8ZU7Q@mail.gmail.com>
Subject: Re: linux-next: stats (Was: Linux 6.0-rc1)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Aug 15, 2022 at 4:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> There are also 320 commits in next-20220802 that didn't make it into
> v6.0-rc1.

> Top ten commiters:

>      13 geert+renesas@glider.be

How did that happen? Turns out these are false positives.

Whenever I update any of the renesas-*-for-vX.Y branches, I merge
them into renesas-next, which is pulled into linux-next.
When a commit in a renesas-*-for-vX.Y branch turns out to be bad,
and the branch hasn't been pulled by soc yet, I just fix that by
rebasing the renesas-*-for-vX.Y branch, and resolving any conflicts
during the next merge into renesas-next.
So the bad commits are gone from the renesas-*-for-vX.Y branches,
and thus will never go upstream, but technically, they are still part
of linux-next.  Hence  they show up in the statistics you do not
want to be part of...

Perhaps I should just recreate renesas-next every time any of the
renesas-*-for-vX.Y branches needs to be rebased? I already recreate
renesas-next after each rc1 release.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
