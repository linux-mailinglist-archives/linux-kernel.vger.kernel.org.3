Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA94E89BE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiC0Tdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiC0Tdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:33:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD774FC5E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:32:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c10so6216696ejs.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81R8ObTvU5bcOjgPkhjrVdYMQgLpHwwmsUh10DuWTXw=;
        b=QVswRSXvuEFhZlnuaBAnMB1TOMg78uyn8mRLwSOZtWi/86mVxTdWeJmg8H09RYWcp4
         O6lvIOKP0C2OxXUCyV3ffNy61gxSdcLR6Kl9jGUx2xgYt16l8oVTj7BEMInCe8aUUdRF
         U28WrmitywInVLFpJqv3NSZNOfcB3kKShK/cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81R8ObTvU5bcOjgPkhjrVdYMQgLpHwwmsUh10DuWTXw=;
        b=dJAv8xZuJAwK9JrgCGQoZGRbur6R3/xUa04mhk4IQBd0XfYIud0bI6/YX68/8X2+L4
         uQF0eCrEicSd0pswNHYXNoDTfHgdY/0zXIoMTP6nwmOeUpRK2YusCpMlTFaZoDSvw5pW
         YkVeJBwEc/44lZLKBOmNDzJ0ffpVx7t0NBUlffdvPr0+baUPEE7fzztcDrrUJl6pEBla
         JOE6is/+awZkhmKUi3uTr+9V7UgFWOwBe73xZu/kzIhI/iRtk9+84Ll3r97GGW/LTUVX
         KJVn9ZqlsuyYOM+drMviyBPwEiQLd8/HDF8H3jqu835xCNsqxO/AOt1BkZGfL641x3Et
         E1FQ==
X-Gm-Message-State: AOAM533Kz3/ts+lVbpox8yh2c4llnmE+N7PQCbyLo2mJ4ZczZoTlW+2E
        ltQtX+tYYl3AIlLPfmoNSPEAJ18tika+oRxsA4w=
X-Google-Smtp-Source: ABdhPJzJ1VZKFu5q9TOHNABHbsaDFZuBYFMcQRd8KEWo2+lJnQYSxpJrSnEhrTBAAV4Gsxx2K5io/g==
X-Received: by 2002:a17:906:2a0c:b0:6df:ec76:af8c with SMTP id j12-20020a1709062a0c00b006dfec76af8cmr23080538eje.269.1648409520068;
        Sun, 27 Mar 2022 12:32:00 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709060cc200b006d3d91e88c7sm4961559ejh.214.2022.03.27.12.31.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:31:59 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id w4so17409746wrg.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:31:59 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr17499555lja.443.1648409031649; Sun, 27
 Mar 2022 12:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <20220327054848.1a545b12.pasic@linux.ibm.com> <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
 <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com> <0745b44456d44d1e9fc364e5a3780d9a@AcuMS.aculab.com>
In-Reply-To: <0745b44456d44d1e9fc364e5a3780d9a@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 12:23:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLyqNJx=bb8=o0Nk5U8gMnf0-=qx53ShLEb3V=Yrt8fw@mail.gmail.com>
Message-ID: <CAHk-=wgLyqNJx=bb8=o0Nk5U8gMnf0-=qx53ShLEb3V=Yrt8fw@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     David Laight <David.Laight@aculab.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Maxime Bizon <mbizon@freebox.fr>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Olha Cherevyk <olha.cherevyk@gmail.com>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
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

On Sun, Mar 27, 2022 at 8:24 AM David Laight <David.Laight@aculab.com> wrote:
>
> Aren't bounce buffers just a more extreme case on non-coherent
> memory accesses?

No.

In fact, this whoe change came about exactly because bounce buffers
are different.

The difference is that bounce buffers have that (wait for it) bounce
buffer, which can have stale contents.

> They just need explicit memory copies rather than just cache
> writeback and invalidate operations.

That's the thing - the memory copies introduce entirely new issues.

I really think that instead of making up abstract rules ("ownership"
or "bounce buffers are just extreme cases of non-coherency") we should
make the rules very much practical and down to earth, and write out
exactly what they *do*.

The whole "sync DMA" is odd and abstract enough as a concept on its
own, we shouldn't then make the rules for it odd and abstract. We
should make them very very practical.

So I will propose that we really make it very much about practical
concerns, and we document things as

 (a) the "sync" operation has by definition a "whose _future_ access
do we sync for" notion.

     So "dma_sync_single_for_cpu()" says that the future accesses to
this dma area is for the CPU.

     Note how it does *NOT* say that the "CPU owns the are". That's
bullsh*t, and we now know it's BS.

 (b) but the sync operation also has a "who wrote the data we're syncing"

     Note that this is *not* "who accessed or owned it last", because
that's nonsensical: if we're syncing for the CPU, then the only reason
to do so is because we expect that the last access was by the device,
so specifying that separately would just be redundant and stupid.

     But specifying who *wrote* to the area is meaningful and matters.
It matters for the non-coherent cache case (because of writeback
issues), but it also matters for the bounce buffer case (becasue it
determines which way we should copy).

Note how this makes sense: a "sync" operation is clearly about taking
some past state, and making it palatable for a future use. The past
state is pretty much defined by who wrote the data, and then we can
use that and the "the next thing to access it" to determine what we
need to do about the sync.

It is *NOT* about "ownership".

So let's go through the cases, and I'm going to ignore the "CPU caches
are coherent with device DMA" case because that's always going to be a
no-op wrt data movement (but it will still generally need a memory
barrier, which I will mention here and then ignore going forward).

Syncing for *CPU* accesses (ie dma_sync_single_for_cpu()) has four
choices I can see:

 - nobody wrote the data at all (aka DMA_NONE).

   This is nonsensical and should warn. If nobody wrote to it, why
would the CPU ever validly access it?

   Maybe you should have written "memset(buffer, 0, size)" instead?

 - the CPU wrote the data in the first place (aka DMA_TO_DEVICE)

   This is a no-op (possibly a memory barrier), because even stale CPU
caches are fine, and even if it was in a bounce buffer, the original
CPU-side data is fine.

 - the device wrote the data (aka DMA_FROM_DEVICE)

   This is just the regular case of a device having written something,
and the CPU wants to see it.

   It obviously needs real work, but it's simple and straightforward.

   For non-coherent caches, it needs a cache invalidate. For a bounce
buffer, it needs a copy from the bounce buffer to the "real" buffer.

 - it's not clear who write the data (aka DMA_BIDIRECTIONAL)

   This is not really doable for a bounce buffer - we just don't know
which buffer contents are valid.

   I think it's very very questionable for non-coherent caches too,
but "writeback and invalidate" probably can't hurt.

   So probably warn about it, and do whatever we used to do historically.

Syncing for device accesses (ie dma_sync_single_for_device()) also has
the same four choices I can see, but obviously does different things:

 - nobody wrote the data at all (aka DMA_NONE)

   This sounds as nonsensical as the CPU case, but maybe isn't.

   We may not have any previous explicit writes, but we *do* have that
"insecure and possibly stale buffer contents" bounce buffer thing on
the device side.

   So with a bounce buffer, it's actually somewhat sane to say
"initialize the bounce buffer to a known state".

   Because bounce buffers *are* special. Unlike even the "noncoherent
caches" issue, they have that entirely *other* hidden state in the
form of the bounce buffer itself.

   Discuss.

 - the CPU wrote the data in the first place (aka DMA_TO_DEVICE).

   This is the regular and common case of "we have data on the CPU
side that is written to the device".

   Again, needs work, but is simple and straightforward.

   For non-coherent caches, we need a writeback on the CPU. For a
bounce buffer, we need to copy from the regular buffer to the bounce
buffer.

 - the device wrote the data in the first place (aka DMA_FROM_DEVICE)

   This is the case that we hit on ath9k. It's *not* obvious, but when
we write this out this way, I really think the semantics are pretty
clear.

   For non-coherent caches, we may need an "invalidate". For a bounce
buffer, it's a no-op (because the bounce buffer already contains the
data)

 - it's not clear who write the data (aka DMA_BIDIRECTIONAL)

   This is again not really doable for a bounce buffer. We don't know
which buffer contains the right data, we should warn about it and do
whatever we used to do historically.

   Again, it's very questionable for non-coherent caches too, but
"writeback and invalidate" probably at least can't hurt.

So hey, that's my thinking. The whole "ownership"  model is, I think,
obviously untenable.

But just going through and listing the different cases and making them
explicit I think explains exactly what the different situations are,
and that then makes it fairly clear what the different combinations
should do.

No?

           Linus
