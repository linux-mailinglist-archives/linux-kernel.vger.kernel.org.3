Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857C595550
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiHPIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiHPIaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:30:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A3135AFE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:53:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id tl27so17036307ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WBv3h3wgQyY1EiVeiutsnqi3DPEWUTFH2e+SxIIu+SI=;
        b=HMgDCIXlUYJ6kJuRhk+eXtuR9vuZC+EQUek1ea7s4szj5UjzZ0duIpqooXHBusQSn3
         2C1m8fobBSmp7OoimIVuJSe5viRJfsH3IXM7JVm4shRAKMJvp9GtGyRvl5HJ4S4/A7CS
         8yKVcomowZtnMK4E6sYXaCaspJq0LI7wL44x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WBv3h3wgQyY1EiVeiutsnqi3DPEWUTFH2e+SxIIu+SI=;
        b=JvOLX0Yp6I/UmD6wNB1JDH34JjP3cToY7dGJscb7jgNjMsnKu1xCMyp+E54d/jPIDr
         TkL5mF8x2WZjMPysymlWNXN6s3tyP/IM8ac6YDCvhv0oXIClIssVZ2bTAjAgdexU/jnp
         C5/FbmQYpYeKCIu12PZkOLYf2nHNdQMLVA48Me9qwkCVTvbsD5rW7t5h2epnKSjkM+qS
         NPaXqoSQ7DHCpU0xscwgohLNBMqZEBRhLXTY43N5CsdseAvmcErXRk2cKlFWeWOdNNeY
         AgfdM89B1Luyh8CEv+jJgkpeXn3A5o1WlSci2R922eaMfciezYHUw0M+Kg2oXTPDlrJy
         hcKQ==
X-Gm-Message-State: ACgBeo2ViWhaw80xC0m2jstJCqbJMPpdVF3cq8Ez7loC9FHdn4ZPUcOY
        /fUTJ/6GFv/J/GL3Ym2cDUO27w4vDZqG3Y9v/FI=
X-Google-Smtp-Source: AA6agR6ycOgTWzvkxxc8ZJAHtOyNYp2mAAm4rM+pZ9mFqRiJHWGsS0iFFZn95x+HCDuHDunSfbYMSQ==
X-Received: by 2002:a17:907:2722:b0:731:23a3:be78 with SMTP id d2-20020a170907272200b0073123a3be78mr12607950ejl.330.1660629186550;
        Mon, 15 Aug 2022 22:53:06 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906844800b0072af102e65csm4893180ejy.152.2022.08.15.22.53.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 22:53:05 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id j1so11345407wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:53:05 -0700 (PDT)
X-Received: by 2002:adf:b343:0:b0:225:1a75:2a9a with SMTP id
 k3-20020adfb343000000b002251a752a9amr270998wrd.281.1660629185303; Mon, 15 Aug
 2022 22:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <YvqaK3hxix9AaQBO@slm.duckdns.org> <YvsZ6vObgLaDeSZk@gondor.apana.org.au>
 <CAHk-=wgSNiT5qJX53RHtWECsUiFq6d6VWYNAvu71ViOEan07yw@mail.gmail.com> <cd51b422-89f3-1856-5d3b-d6e5b0029085@marcan.st>
In-Reply-To: <cd51b422-89f3-1856-5d3b-d6e5b0029085@marcan.st>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Aug 2022 22:52:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfLT7nL8pV8RWATpjgm0zDtUwT8UMtroqnGcXRjN8tgw@mail.gmail.com>
Message-ID: <CAHk-=wjfLT7nL8pV8RWATpjgm0zDtUwT8UMtroqnGcXRjN8tgw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix memory ordering race in queue_work*()
To:     Hector Martin <marcan@marcan.st>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        peterz@infradead.org, jirislaby@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, oneukum@suse.com,
        roman.penyaev@profitbricks.com, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:36 PM Hector Martin <marcan@marcan.st> wrote:
>
> These ops are documented in Documentation/atomic_bitops.txt as being
> unordered in the failure ("bit was already set" case), and that matches
> the generic implementation (which arm64 uses).

Yeah, that documentation is pure garbage. We need to fix it.

I think that "unordered on failure" was added at the same time that
the generic implementation was rewritten.

IOW, the documentation was changed to match that broken
implementation, but it's clearly completely broken.

I think I understand *why* it's broken - it looks like a "harmless"
optimization. After all, if the bitop doesn't do anything, there's
nothing to order it with.

It makes a certain amount of sense - as long as you don't think about
it too hard.

The reason it is completely and utterly broken is that it's not
actually just "the bitop doesn't do anything". Even when it doesn't
change the bit value, just the ordering of the read of the old bit
value can be meaningful, exactly for that case of "I added more work
to the queue, I need to set the bit to tell the consumers, and if I'm
the first person to set the bit I may need to wake the consumer up".


> On the other hand, Twitter just pointed out that contradicting
> documentation exists (I believe this was the source of the third party
> doc I found that claimed it's always a barrier):

It's not just that other documentation exists - it's literally that
the unordered semantics don't even make sense, and don't match reality
and history.

And nobody thought about it or caught it at the time.

The Xen people seem to have noticed at some point, and tried to
introduce a "sync_set_set()"

> So either one doc and the implementation are wrong, or the other doc is
> wrong.

That doc and the generic implementation is clearly wrong.

              Linus
