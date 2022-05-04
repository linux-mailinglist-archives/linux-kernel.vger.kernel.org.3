Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03C351AE3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377718AbiEDTrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377626AbiEDTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:46:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C288C4D9E0;
        Wed,  4 May 2022 12:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5793161BE2;
        Wed,  4 May 2022 19:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A48FC385AE;
        Wed,  4 May 2022 19:43:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gOI+pPvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651693386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eh5hrFL6SoGsF2luvmj8kgX+XfJv5UAB+hp+Z2Gh8l8=;
        b=gOI+pPvWytZbiHHfM24+WPgjRKejf38DstYmHsH5ZBXsDe5gZP1iedq1tfHUGmqfQJedbh
        f8uHzOLiGsCtmX2chVLt9QM25p0gz4405G8O2vWOCq8v/k68FrsW063wbzth0A1LZsfGRH
        nSdu3/EYkJ8n+f/8yQHPpEs0PVc6jmw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c2082e74 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 19:43:06 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7d621d1caso27108307b3.11;
        Wed, 04 May 2022 12:43:05 -0700 (PDT)
X-Gm-Message-State: AOAM533OICeQnfc44NfeVL81aAHB3SnOB26Rjeuf+gx5//q3ECTuu4ja
        zrttoPHLOPq8yoXAV2T8w5SxCm5I/qkmsaRcO1o=
X-Google-Smtp-Source: ABdhPJx/LLlf9uU3BgMKrDlesdbIqJ0CMZ2ujuXNSd91VO0CROyM9dP7lS+9effRUl7IhGh/0TkAsL77MotuiIOKYfI=
X-Received: by 2002:a0d:ef03:0:b0:2fa:245:adf3 with SMTP id
 y3-20020a0def03000000b002fa0245adf3mr11176034ywe.100.1651693384800; Wed, 04
 May 2022 12:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec> <YnJI4Ru0AlUgrr9C@zx2c4.com> <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com> <YnJSQ3jJyvhmIstD@zx2c4.com> <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
In-Reply-To: <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 4 May 2022 21:42:54 +0200
X-Gmail-Original-Message-ID: <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
Message-ID: <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Stafford Horne <shorne@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, May 4, 2022 at 8:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 4, 2022 at 3:15 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote=
:
> >
> > > Alignment? Compiler bug? HW issue?
> >
> > Probably one of those, yea. Removing the instruction addresses, the onl=
y
> > difference between the two compiles is: https://xn--4db.cc/Rrn8usaX/dif=
f#line-440
>
> Well, that address doesn't work for me at all. It turns into =D7=90.cc.
>
> I'd love to see the compiler problem, since I find those fascinating
> (mainly because they scare the hell out of me), but those web
> addresses you use are not working for me.

=D7=90.cc is correct. If you can't load it, your browser or something in
your stack is broken. Choosing a non-ASCII domain like that clearly a
bad decision because people with broken stacks can't load it? Yea,
maybe. But maybe it's like the arch/alpha/ reordering of dependent
loads applied to the web... A bit of stretch.

> It most definitely looks like an OpenRISC compiler bug - that code
> doesn't look like it does anything remotely undefined (and with the
> "unsigned char", nothing implementation-defined either).

I'm not so certain it's in the compiler anymore, actually. The bug
exhibits itself even when that code isn't actually called. Adding nops
to unrelated code also makes the problem go away. And removing these
nops [1] makes the problem go away too. So maybe it's looking more
like a linker bug (or linker script bug) related to alignment. Or
whatever is jumping between contexts in the preemption code and
restoring registers and such is assuming certain things about code
layout that doesn't always hold. More fiddling is necessary still.

Jason

[1] https://lore.kernel.org/lkml/20220504110911.283525-1-Jason@zx2c4.com/
