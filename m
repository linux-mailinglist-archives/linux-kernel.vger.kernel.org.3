Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4915158A7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381654AbiD2Wt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381613AbiD2Wty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:49:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD13DA48
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:46:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id y76so16922047ybe.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zEA5WukbY7s3aZ0MsN0+Mtea1tRCsvoCyLF2Tq3H8o=;
        b=c5jY+A/DdA9edep65f+MbfoAWEohpvHWaaKQE2j6lzeRrx/wD6Gka10BawpudtgGiR
         +ACeiOzB+5qEwH/f23Bc07gKFyLegSobuHaSnD19nAVQNuATeRghFcHhhwqtOJLrh1rp
         1XHUO3KNtB3UY7MkhrJDjZa9Fp1XhGIVytnDxVlhm/RrOeTMh9LENAgpwrtUfEm71bwh
         AG8V0yvvqK1U7Kpaj3aN2gAvErCljEJUgVeMDV5dFEhhzy7wbtbVzEb4ZMFsNFjBjHqW
         yirl/GC1kV+F+dmzOiZrw5Dh6NYJe6RznW5PQEavAWwcLYLfZRSzIZ1xpgVBuW2epyEC
         Jzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zEA5WukbY7s3aZ0MsN0+Mtea1tRCsvoCyLF2Tq3H8o=;
        b=K2F42FA0xxsXJvQJunviC2ACBDDt2KiPvqFl8O/TE5vSZ+oHjB9MP7UkmdeOp3BRk8
         f7WQA4nhnG6LadpPDgH4jD0V3lgfTphhcPTKUmWUcC6IBiIkj26TDXpAoPBgg4mbkeZ/
         76AFmP+k73s13jBTGmztoHqwSOSiKP3I+J8T81sGB67q2Q/i9wmHjg8pSMtzsq3CRYrF
         YPAus9f2hFS5sNy2DEfQWvZUghKYXkDHDJwuIADdRO+XtOOTIoa1iyLAhIuErhQu8kaz
         qJyB5K0bkZnQL7glsrFU4ZbUAwCSeeJnAtAOnB2f1KG7dg35cnSYqPbMpg696JGH2wnF
         qbrQ==
X-Gm-Message-State: AOAM532ABymgQ/UkFjkl6LaiQyu9nkaEp8Ky1UUh4M8JY6+5PDrnM7vO
        Fo2CjZhtKsRycxFmhDt9VgcnOSdlW/CjrXh/y5Qjqg==
X-Google-Smtp-Source: ABdhPJxQDYj5S8Gom/Rw7HQOjs4g7oDNnQ/BJKrJtrEA8LCqLNYkIYADTxfMZSGVvtL3DxgcG6h33eEFVgYUOmaL4v8=
X-Received: by 2002:a25:6157:0:b0:645:8d0e:f782 with SMTP id
 v84-20020a256157000000b006458d0ef782mr1840588ybb.36.1651272392698; Fri, 29
 Apr 2022 15:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9r_DbZWe4FsfebHSSf_iPctSe5S-w9bU3o8BN43raeURg@mail.gmail.com>
 <20151116203709.GA27178@oracle.com> <CAHmME9pNCqbcoqbOnx6p8poehAntyyy1jQhy=0_HjkJ8nvMQdw@mail.gmail.com>
 <1447712932.22599.77.camel@edumazet-glaptop2.roam.corp.google.com>
 <CAHmME9oTU7HwP5=qo=aFWe0YXv5EPGoREpF2k-QY7qTmkDeXEA@mail.gmail.com>
 <YmszSXueTxYOC41G@zx2c4.com> <04f72c85-557f-d67c-c751-85be65cb015a@gmail.com>
 <YmxTo2hVwcwhdvjO@zx2c4.com> <d9854c74-c209-9ea5-6c76-8390e867521b@gmail.com>
 <CAHmME9qXC-4OPc5xRbC6CQJcpzb96EXzNWAist5A8momYxvVUA@mail.gmail.com>
 <CANn89iLyNoCRrp6YYdy6kGhM7X2JQ9J4-LfEJCBvhYAv4N+FPA@mail.gmail.com> <CAHmME9rt_fGfgQSL12Q8CnNdh0Fc-8Z9CBEM9iSNjGCQ_En6Ow@mail.gmail.com>
In-Reply-To: <CAHmME9rt_fGfgQSL12Q8CnNdh0Fc-8Z9CBEM9iSNjGCQ_En6Ow@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 29 Apr 2022 15:46:21 -0700
Message-ID: <CANn89iLLmTQ6XZG3BsP29E2r0Qix0SBVff0RNz=EUULOAQK88A@mail.gmail.com>
Subject: Re: Routing loops & TTL tracking with tunnel devices
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 3:09 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Eric,
>
> On Sat, Apr 30, 2022 at 12:05 AM Eric Dumazet <edumazet@google.com> wrote:
> > I assume you add encap headers to the skb ?
>
> Yes; it's encapsulated in UDP, and under that some short header.
> However, everything under that is encrypted. So,
>
> > You could check if the wireguard header is there already, or if the
> > amount of headers is crazy.
>
> so it's not quite possible to peer down further to see.
>
> > You also can take a look at CONFIG_SKB_EXTENSIONS infrastructure.
>
> Blech, this involves some kind of per-packet allocation, right? I was
> hoping there might be some 6 or 7 or 8 bit field in sk_buff that's not
> used anywhere on the TX path that maybe I could overload for this
> purpose...
>

Maybe reuse redirected / tc_skip_classify (used in drivers/net/ifb.c)
