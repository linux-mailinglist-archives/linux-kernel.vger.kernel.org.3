Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6D509088
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381806AbiDTTgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353156AbiDTTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:36:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02723EAA2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:33:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g19so4812838lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQf/c6SFLeLbkhwhXbufAJYZwI77Oi3QbNygfxlLBy4=;
        b=Nkom6JPjm5rIdy+ECNM+jePflCglXSUYJ7CZDmOzRAMIROG4MFMgW70DQmc0n29WOZ
         RiM7dK0nWYcPuGZJVSQSfzH17vt8dW+R8FBVhg60w9CfD7gJqmK93xV5KSRu9ZpjGaHL
         eeumdg/5zwYLL8Du6jUBRtqtAU29zaZ4nSbtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQf/c6SFLeLbkhwhXbufAJYZwI77Oi3QbNygfxlLBy4=;
        b=nKYei1P2c6AXB2HrJdgcTt9j7OwPwA9rGcmswRRVH5s0n9BP2+l+rI7gjcV4nm0S5P
         Le6fbblkWCoTXeYWschPbfOoeOV6viNo2CStgaSNWDRB8WcR7cjX7CXOz5tJPjtKKMtM
         P+TE7TQY6QdPwxeaLr8dFDREKsAFA2FuycoDEewxl0aj6Gyp3gbmS6UYkIqMIBcGYtC5
         Gv7rN6BQaaHmKMXyT/7TXj677qT28yy1Ok4I3rNuH3+fmeDpMzEmwkdLRVI8Wc4SBQug
         fSmSN4WNmB6+7p1z8avv7e5C2sK6Jqt0QIXcwqYGBeoc6Lms3UORpNlp/XKN3Mx7ZbT9
         W2hw==
X-Gm-Message-State: AOAM530o/YCNRInHJ0owhYjqGTkuMiHFT2q2oZjYBEgTZTRzJY3X21s4
        c6VeGqjEqz7DIM7eVOJ5BK9b4byNRgZel6Ucqeo=
X-Google-Smtp-Source: ABdhPJzXFRZ0VtlqVK0fMtISBCEA48rm+X4zED9mvZ8iQedY1cOfGj/Lrr5VjZreRK948evxynjy0A==
X-Received: by 2002:a05:6512:228e:b0:471:9022:c4d3 with SMTP id f14-20020a056512228e00b004719022c4d3mr11352430lfu.513.1650483236967;
        Wed, 20 Apr 2022 12:33:56 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d28-20020a056512321c00b00470d2987b50sm1368270lfe.137.2022.04.20.12.33.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 12:33:56 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x17so4766390lfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:33:55 -0700 (PDT)
X-Received: by 2002:a05:6512:108b:b0:470:90b9:fb51 with SMTP id
 j11-20020a056512108b00b0047090b9fb51mr14612420lfg.52.1650483235692; Wed, 20
 Apr 2022 12:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <Ylh61CCMkESmurIp@arm.com> <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
 <YmBaA5O8cnBuoGuG@arm.com>
In-Reply-To: <YmBaA5O8cnBuoGuG@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Apr 2022 12:33:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=widM2Zt2BK3dwpUG8SzPG7_oG7t7ZvDoQmvDWDWwkB7TA@mail.gmail.com>
Message-ID: <CAHk-=widM2Zt2BK3dwpUG8SzPG7_oG7t7ZvDoQmvDWDWwkB7TA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:08 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> With kstrdup() modified to pass __GFP_PACKED (as per the last hunk in
> the diff below), I get just after boot:
>
> kmalloc-128         8966   9056    128   32
> kmalloc-96             0      0     96   42
> kmalloc-64           192    192     64   64
> kmalloc-32           768    768     32  128
> kmalloc-16          2048   2048     16  256
> kmalloc-8           2560   2560      8  512
>
> So that's probably the simplest approach and using the ftrace histogram
> we can add the flag to more places.

I agree that this seems to be the safest thing to do, and maybe
__GFP_PACKED is a better flag name than __GFP_NODMA.

That said, It worries me a bit in that to me "PACKED" implies "no
alignment at all". And I could _easily_ see people still wanting to do
8-byte allocations that have 8-byte alignment because it's some kind
of private pointer thing or whatever.

For "kstrdup()", a flag like __GFP_PACKED makes 100% sense, since it
literally wants byte alignment.

But what about those "random small structures" cases?

Anyway, I'm perfectly happy calling it __GFP_PACKED, but at a minimum
document that "packed" in this case still means "__alignof__(unsigned
long long)" or something like that?

                      Linus
