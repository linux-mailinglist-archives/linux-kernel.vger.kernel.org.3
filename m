Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5CE57F76A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiGXWsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 18:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXWsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 18:48:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16ACE30
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0534611FB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 22:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0ACC341C0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 22:48:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qAFp1JIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658702882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzuSl3dxwIYIDZF4lZFJvzhnSJM1/WXSFLmwNOT9hlg=;
        b=qAFp1JIM3bp4ZJkRcPUc1I6MXyLO5U1Gv9D6VbfkESug8oc+KDEMA27wRiFlnRBDQSNxs/
        azjK9yP5Lv8sI+y3vcBU80QDDUgIMfhvQTzrH1VJNUJXSRGzc0rSsG5d6LBrrzkHClEn1w
        KactQS76DeFVyIxbJId4zp7JWXzATxk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 219336fc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 24 Jul 2022 22:48:02 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31e7ca45091so93192547b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:48:02 -0700 (PDT)
X-Gm-Message-State: AJIora+zmgvGOxF/rnRqbSoBg8zxepsmWisoV/rcGgwnIUqm6i6+MwPZ
        8R1PCqOYq48vmEyCUIjY4XjkkooQRoB+0WyVd/0=
X-Google-Smtp-Source: AGRyM1uBMjFY1+oZ0uGP/skNRN1JUeazAmEPygDqL4fRgAqZIS2VP+LTcFy+qvQmEzIgotp6FwKOvCHwhE+IX7ritXs=
X-Received: by 2002:a0d:cc05:0:b0:31e:6ee8:2fdd with SMTP id
 o5-20020a0dcc05000000b0031e6ee82fddmr7833707ywd.414.1658702880868; Sun, 24
 Jul 2022 15:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qTA90=GEr6h1GZh0CjS+6tpe5uuqkYoJVv79h0zd0w1w@mail.gmail.com>
 <20220719130207.147536-1-Jason@zx2c4.com>
In-Reply-To: <20220719130207.147536-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 25 Jul 2022 00:47:50 +0200
X-Gmail-Original-Message-ID: <CAHmME9o7cNRPxy+WuM6-13ak9RNo1UH8-4qMArSACLs8LYAt8g@mail.gmail.com>
Message-ID: <CAHmME9o7cNRPxy+WuM6-13ak9RNo1UH8-4qMArSACLs8LYAt8g@mail.gmail.com>
Subject: Re: [PATCH v3] random: handle archrandom with multiple longs
To:     Borislav Petkov <bp@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Borislav (or other x86ers),

On Tue, Jul 19, 2022 at 3:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The archrandom interface was originally designed for x86, which supplies
> RDRAND/RDSEED for receiving random words into registers, resulting in
> one function to generate an int and another to generate a long. However,
> other architectures don't follow this.
>
> On arm64, the SMCCC TRNG interface can return between 1 and 3 longs. On
> s390, the CPACF TRNG interface can return arbitrary amounts, with 32
> longs having the same cost as one. On UML, the os_getrandom() interface
> can return arbitrary amounts.
>
> So change the api signature to take a "max_longs" parameter designating
> the maximum number of longs requested, and then return the number of
> longs generated.
>
> Since callers need to check this return value and loop anyway, each arch
> implementation does not bother implementing its own loop to try again to
> fill the maximum number of longs. Additionally, all existing callers
> pass in a constant max_longs parameter. Taken together, these two things
> mean that the codegen doesn't really change much for one-word-at-a-time
> platforms, while performance is greatly improved on platforms such as
> s390.

This patch now has acks from Heiko, Catalin, Mark, and Michael,
covering the arm, ppc, and s390 changes. The changes to s390 and arm
were non-trivial so those acks were quite meaningful. On x86 and ppc,
the code compiles down to basically the same assembly and the change
really doesn't matter at all. Nonetheless, I thought I should give you
a final poke in case you want to ack or nack this, lest I step on the
tip.git of your shoes.

Jason
