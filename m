Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E614DA2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351181AbiCOS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiCOS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:57:40 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D714E393;
        Tue, 15 Mar 2022 11:56:27 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id 11so2931qtt.9;
        Tue, 15 Mar 2022 11:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1R6MexnAYDRxJBUb0QgsDJ7MygsbxDZQB18nTdrN9k=;
        b=zsKLQZVmMlABXEa4cZ2YMoJAGJVQ673L6ghBnwPWKtAL+GwsEts0zqp9R164LRxKcx
         KydyC9yZfvnhbaPgstS1tHeyX9cWM0Z5ZDDKup6sDEYdFxZP6cpO/5SQF/0x94qSY81a
         WPE60yp2S2uLwqKiOMYSNXKtZUq8alqlYgzeLKuMRU55WW7RZpivZ47GJTwt+ib8+FII
         zE1VoHAZ0dhv0ArCxiWkjx1LywikG4tg9c7sgKbZN339oLow9aeyxUvp2ArTdASEeTpC
         5gyseyGCZF7EddIsjzLhJycIMGDyyLiOXmtDUZnXHzgCVXqDtDmsEbtU4QZgc/lLz3tG
         5Y7A==
X-Gm-Message-State: AOAM532ulcFFpic5uaZRguyjwSq8yRfvOzXUJTqlMF0kH+dcHrrXTFoS
        NjGAHE11z7yVpkxpMIfyCVkIPak5oT5+HQ==
X-Google-Smtp-Source: ABdhPJzm94DKiM/MVYEHZOrTxKXpLow5k0BvpABrrV9RCaueeaHtasWKDreg/aRQIjvHq0YXKEqfHg==
X-Received: by 2002:ac8:5c90:0:b0:2de:37cd:8af6 with SMTP id r16-20020ac85c90000000b002de37cd8af6mr23372119qta.437.1647370586013;
        Tue, 15 Mar 2022 11:56:26 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id a13-20020a05622a064d00b002e1b8d9d6cfsm10246974qtb.32.2022.03.15.11.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 11:56:25 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id y142so275695ybe.11;
        Tue, 15 Mar 2022 11:56:25 -0700 (PDT)
X-Received: by 2002:a25:aa0e:0:b0:633:7c3b:94a0 with SMTP id
 s14-20020a25aa0e000000b006337c3b94a0mr3416103ybi.546.1647370585424; Tue, 15
 Mar 2022 11:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220310121327.63C6FC340E8@smtp.kernel.org> <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
 <YinzW413m6p0H/i1@sirena.org.uk> <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
 <CAHk-=wiZnS6n1ROQg3FHd=bcVTHi-sKutKT+toiViQEH47ZACg@mail.gmail.com>
In-Reply-To: <CAHk-=wiZnS6n1ROQg3FHd=bcVTHi-sKutKT+toiViQEH47ZACg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 19:56:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWd_eAGjXRAODXvufoXT_QqqOpuLJTAj9ZG7d-EQyRKBw@mail.gmail.com>
Message-ID: <CAMuHMdWd_eAGjXRAODXvufoXT_QqqOpuLJTAj9ZG7d-EQyRKBw@mail.gmail.com>
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Mar 15, 2022 at 5:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 15, 2022 at 2:08 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I had noticed while reviewing the patch, but changing to size_t wouldn't
> > help much, as other related code paths treat the value as unsigned int
> > anyway.
>
> .. but it really would.
>
> Note that the paths *after* this code don't matter. Because the result
> is guaranteed to fit in 'unsigned int' anyway.
>
> Put another way:
>
>     min_t(unsigned int,x,y)
>
> is buggy if one of x/y is 'size_t'. Why? Because if that one gets
> truncated, you're doing 'min()' with a value that may be artificially
> much too small (that was exactly the problem commit 1a4e53d2fc4f:
> "spi: Fix invalid sgs value")fixed).
>
> But the situation is _not_ true in the reverse. Look:
>
>     min(size_t,x,y)
>
> is guaranteed to fit in 'unsigned int' as long as _one_ of x,y fits in
> 'unsigned int' - even if the other doesn't. Because then 'min()' will
> just pick the one that already had the right size.
>
> To make it really concrete, compare
>
>     min_t(unsigned int, 5, 0x100000001);
>     min_t(size_t, 5, 0x100000001);
>
> on a 64-bit machine (ie size_t is 64-bits, and unsigned int is 32-bit).
>
> One returns 1. The other returns 5. Both fit the result in 'unsigned
> int', but one of them is wrong.

You're absolutely right. So the code should be changed to:

        if (vmalloced_buf || kmap_buf) {
-                desc_len = min_t(unsigned int, max_seg_size, PAGE_SIZE);
+               desc_len = min_t(unsigned long, max_seg_size, PAGE_SIZE);
                sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
        } else if (virt_addr_valid(buf)) {
-               desc_len = min_t(unsigned int, max_seg_size, ctlr->max_dma_len);
+               desc_len = min_t(size_t, max_seg_size, ctlr->max_dma_len);
                sgs = DIV_ROUND_UP(len, desc_len);
        } else {
                return -EINVAL;
        }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
