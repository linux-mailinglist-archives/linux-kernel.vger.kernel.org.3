Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1AC50D54D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 23:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiDXVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239656AbiDXVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 17:41:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4815248B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:38:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h3so18395873lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Lj+8I0FO8qrcoAXKsUQ/7bkIYJ5OSyWim41oZ7eGAE=;
        b=KHxV1EGyudGee9WRj/AK3mRuuSFGQaU2WbRpDeBjO+4p17nGhVHLE1H5WV46pDemIT
         kLR9CVjz0o6OcYGCl94opQlwarAN2+atjKFY0JzJkSkvtYVU+MmJFCJyMLkyvsRUjJ3L
         e2bakbwMP3wwR5Bf3TNbjHY/rMlRuB+LJzpWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Lj+8I0FO8qrcoAXKsUQ/7bkIYJ5OSyWim41oZ7eGAE=;
        b=4HDiefD6p721Mp+cceYToNC9EosBwiF0alial5YfRw7y1dbGeoJloMNkkw287pl3zS
         dJnHlHv7bDJA1KhkE1/4SGMhTZKHzI2zLcN2kGijRl/jn1bkLGXfRYfi2Q6QVL4cz4Rd
         HKsjzMh08OX9Kx1EAyIXUQSLae/ivX3TmQaDCnR2CLsuu+5v5gUGMpE5Iz22X6nVZAVy
         6Hry9MC5Q1HP80O2v7WbnUOBQrX4SijALdxer9aPeI5NLtvNyU/pLKKXJY3wDM/vZKw3
         BgG4aL2b7B1O+wx1JjTvhHpmlfFQDOQr4lCZAuHNOxiAHL5GsRXGeEDxgBxmmAqNj/5H
         Bhbw==
X-Gm-Message-State: AOAM5300VOkidALj362yKkxEKfSHjAllA6o438UvPcPsNJibwFsFBFn0
        rfuptPLEKklpH9x6dQ1Jc4ugwp/xYBuu5u18P10=
X-Google-Smtp-Source: ABdhPJzW2IGc+IL90UxKiHHM6MAd4aUlFbBies2zIbsUkVimb9UQuHS70OIVWBUdY2bcHbRkw+V12Q==
X-Received: by 2002:a05:6512:25a4:b0:471:fbe9:8893 with SMTP id bf36-20020a05651225a400b00471fbe98893mr4836858lfb.147.1650836297382;
        Sun, 24 Apr 2022 14:38:17 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm1153439lfb.302.2022.04.24.14.38.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 14:38:15 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id g19so23138092lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:38:15 -0700 (PDT)
X-Received: by 2002:ac2:5084:0:b0:471:ccb3:8c99 with SMTP id
 f4-20020ac25084000000b00471ccb38c99mr10965514lfm.435.1650836294999; Sun, 24
 Apr 2022 14:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Apr 2022 14:37:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
Message-ID: <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
Subject: Re: [PATCH] hex2bin: make the function hex_to_bin constant-time
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 1:54 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> + *
> + * Explanation of the logic:
> + * (ch - '9' - 1) is negative if ch <= '9'
> + * ('0' - 1 - ch) is negative if ch >= '0'

True, but...

Please, just to make me happier, make the sign of 'ch' be something
very explicit. Right now that code uses 'char ch', which could be
signed or unsigned.

It doesn't really matter in this case, since the arithmetic will be
done in 'int', and as long as 'int' is larger than 'char' as a type
(to be really nit-picky), it all ends up working ok regardless.

But just to make me happier, and to make the algorithm actually do the
_same_ thing on every architecture, please use an explicit signedness
for that 'ch' type.

Because then that 'ch >= X' is well-defined.

Again - your code _works_. That's not what I worry about. But when
playing these kinds of tricks, please make it have the same behavior
across architectures, not just "the end result will be the same
regardless".

Yes, a 'ch' with the high bit set will always be either >= '0' or <=
'9', but note how *which* one it is depends on the exact type, and
'char' is simply not well-defined.

Finally, for the same reason - please don't use ">> 8".  Because I do
not believe that bit 8 is well-defined in your arithmetic. The *sign*
bit will be, but I'm not convinced bit 8 is.

So use ">> 31" or similar.

Also, I do worry that this is *exactly* the kind of trick that a
compiler could easily turn back into a conditional. Usually compilers
tend to go the other way (ie turn conditionals into arithmetic if
possible), but..

                    Linus
