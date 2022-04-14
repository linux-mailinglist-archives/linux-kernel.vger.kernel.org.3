Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED09501E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbiDNW2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiDNW2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:28:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF85CC31D5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:26:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w19so11403210lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grIrFiDIYej8A2nEyShR/f/AA0BjSrqUafhM5e+bJC8=;
        b=PDOMyhu4Ot0RITPmSamRezvWlV9rWJSil6/c4p4BGDd0iBOTga7RB6uavJaMpTmOXV
         5jwUTMm/+Dz9yaqMjzZq8YxJ8+ff2e0+Be5W/cj0EWXwFsBB0vRDLZihMAtRe/vKVQQW
         GkKv2Ydf1Q2D3rndpsIMIBShWkf0ZsFxSqc0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grIrFiDIYej8A2nEyShR/f/AA0BjSrqUafhM5e+bJC8=;
        b=NK2KZwVEtki6CIE6gK9YGzIYAuBQTIc3rpA0ogJ2EapMdcAIIQWVi0kp8BOhrqOg5I
         8Gi/QrM8X6mj1eaogQ87Rs0g3QnVaVAyn7gNxK6bRkJdWGzPSnTgov3qPFDPMc/GYVRr
         piwBiXem6yanp3wE4Zp1dskrd1/mjWgzx2v83FEXzzJQalvdlxAhGZPsrXfamJmk0UmA
         xfLQUyOnpAaWAhlDwhgB+bwpKu07/Y39SyzQf0M+zU+QqiKIN3ShUknWWdJ+PZM9G6/e
         6wMrwUEoRtyXAmbr4bJm+m0cTsZNW4uSJfID0PaxWSHK5nYYcHu2xg3bGXliNbxIaWbw
         qf+g==
X-Gm-Message-State: AOAM532uimKpxCRZrKE4mHkD2jwzwvfOi29FRUuV9pbBBFtN3AkO/3cV
        xty2yfaZz+hRhgVRjXg0yHJ1Jybl2ihU2PR0
X-Google-Smtp-Source: ABdhPJzbaOMKNDhepiJ0yDDhmpOUSjMgGUoIqRIR7oarG6biKo+ZnUpeHPJBuWTh8EY7yDm/3g1XCw==
X-Received: by 2002:a05:6512:2312:b0:44a:7699:a2b with SMTP id o18-20020a056512231200b0044a76990a2bmr3252547lfu.285.1649975179683;
        Thu, 14 Apr 2022 15:26:19 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a19-20020a19ca13000000b0046d1684db04sm126195lfg.232.2022.04.14.15.26.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 15:26:16 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w19so11403037lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:26:16 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr3273417lfb.435.1649975175853; Thu, 14
 Apr 2022 15:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <Yk/6ts5sVDMDpKj3@arm.com> <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <Ylh61CCMkESmurIp@arm.com>
In-Reply-To: <Ylh61CCMkESmurIp@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Apr 2022 15:25:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
Message-ID: <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
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

On Thu, Apr 14, 2022 at 12:49 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> It's a lot worse, ARCH_KMALLOC_MINALIGN is currently 128 bytes on arm64.
> I want to at least get it down to 64 with this series while preserving
> the current kmalloc() semantics.

So here's a thought - maybe we could do the reverse of GFP_DMA, and
add a flag to the places that want small allocations and know they
don't need DMA?

Because even 64 bytes is _huge_ for those small allocations. And 128
bytes is just insane.

Maybe we don't have a ton of them, but I just checked my desktop, and
if my laptop had 17k 8-byte allocation, on my desktop it's currently
sitting at 43k of them. And I've got a lot of 16- and 32-byte ones
too:

  kmalloc-32         51529  51712     32  128    1 :
  kmalloc-16         45056  45056     16  256    1 :
  kmalloc-8          43008  43008      8  512    1 :

Don't ask me what they are. It's probably fairly easy to find out, and
it's probably something silly like sysfs private pointer data or
whatever.

If I did my math right, with a 128-byte minimum allocation, that is
16MB of wasted memory.

Yeah, yeah, I've got 64GB or RAM in this thing, and there are things
that take a lot more memory than the above (mem_map etc), and 64MB is
peanuts at just 0.1% of RAM.

Maybe nobody cares. But I really feel bad about that kind of egregious
waste. The mem_map[] array may be big, it may use 1.5% of the memory I
have, but at least it *does* something.

And it could be that if I have 150k of those smallish allocations, a
server with lots of active users might have millions. Not having
looked at where they come from, maybe that isn't the case, but it
*might* be.

Maybe adding something like a

        static int warn_every_1k = 0;
        WARN_ON(size < 32 && (1023 & ++warn_every_1k));

to kmalloc() would give us a statistical view of "lots of these small
allocations" thing, and we could add GFP_NODMA to them. There probably
aren't that many places that have those small allocations, and it's
certainly safer to annotate "this is not for DMA" than have the
requirement that all DMA allocations must be marked.

Then just teach kmalloc() something like

        align = (gfp_flags & __GFP_NODMA) ? 8 : 128;

on arm.

Hmm?

              Linus
