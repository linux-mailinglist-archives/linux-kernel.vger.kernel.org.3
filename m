Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C1E4D6A26
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiCKWtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiCKWt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:49:28 -0500
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA612270F35
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:23:33 -0800 (PST)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4KFgJC1Bh3z4xCgB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 22:16:27 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ia3xAS/M"
Date:   Fri, 11 Mar 2022 22:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1647036926;
        bh=l1bduWvt/CdjWmQkkyuVKI1SoQtj7OXve0HQvrvs5/I=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ia3xAS/MfhjG1g4DtW5kietXkDif1bYn6Fj5JolIS+zh4xESPcxMEwY/51H0a+qlM
         oRm8++EThWrl6Vc3pFP6aqX2pOUY42Zp9Vqmln3KzGvv8gafBfXI32+dBUKiy5RAFB
         MyaopiD41Zc1yKB/Buk9LdFJXljwkrh1JoVHAEABX6yq6Ms/OWL5J1WAx5pFzZt6WX
         5yxVU4xsBrF/j+1ykUQXys7AdMtpHh9D7LVSnQXadLIBofAtM2FYqUnk4CV5t4KoEI
         bwEtuj6o2BtLiCpEX8xrcmXaX3APS8O7lcOwpdEq5RVhUzudXkeYNEthMX3Sv8ILXm
         pqrvM46WvX2hA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [RFC PATCH v1 1/2] list: add type-safer list_head wrapper
Message-ID: <1D4riYxukWActDG6uXJOjvSq0GvTWaO4KZGVfqmX5RG_HGGjzgBb3srCUNRZqyPOzzNzVIrKRw0ktupkVs0DWQGTiZ1cSuWEcu5z3O1Pk4Y=@protonmail.com>
In-Reply-To: <CAHk-=wg6PtRx9nBHVnrQkQkczGjXjO0E-oHXPPgPK_H+Nm=Czg@mail.gmail.com>
References: <20220311013238.3387227-1-pobrn@protonmail.com> <20220311013238.3387227-2-pobrn@protonmail.com> <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com> <CAHk-=wjF4d_v5t=ht_vCOHxNDoPvsBuK-2jiEBus-__oPZuPFQ@mail.gmail.com> <wKlkWvCGvBrBjshT6gHT23JY9kWImhFPmTKfZWtN5Bkv_OtIFHTy7thr5SAEL6sYDthMDth-rvFETX-gCZPPCb9t2bO1zilj0Q-OTTSbe00=@protonmail.com> <CAHk-=wg6PtRx9nBHVnrQkQkczGjXjO0E-oHXPPgPK_H+Nm=Czg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2022. m=C3=A1rcius 11., p=C3=A9ntek 6:06 keltez=C3=A9ssel, Linus Torvalds =
=C3=ADrta:
> On Thu, Mar 10, 2022 at 6:49 PM Barnab=C3=A1s P=C5=91cze <pobrn@protonmai=
l.com> wrote:
> >
> > That is indeed a simpler thing to do, and doesn't need `offsetof()` at =
the
> > declaration, but there are places - not many -  where the `list_head` m=
ember
> > is inside a subobject, for example, so `member` now contains a period.
>
> Ahh, very true. And very annoying. So close, yet so far, and no way I
> can see to really deal with that.
>
> And it's not even really all that rare. It may not be the _common_
> case, but it's still fairly wide-spread and not some "one or two odd
> places" thing.
>
> This grep catches at least a subset of cases:
>
>     git grep '\<list_for_each_entry(.*\.[a-z_0-9]*)'
>
> and it's clearly all over.
>
> As mentioned, I don't think that we have had huge problems with
> getting the member name wrong. We do get a fair amount of checking in
> that it obviously has to be part of the type we iterate over, and even
> if you were to pick the wrong one, the result is a very simple "that
> doesn't work".
>
> But it would still undeniably be very nice to have some automatic
> build-time checking for it.
>

Yes, I think compile-time errors are significantly better than whatever you=
 get
at runtime. So, sorry to be this obtuse, but I gather the proposed interfac=
e
is a no-go in all ways, shapes, and forms in your eyes? I am fully aware th=
at it
does not magically solve everything and it does not work in the "interestin=
g"
and "convoluted" cases, but as mentioned in a previous email, I think there=
 are
still a lot of "boring" places where it can be used. But of course I don't =
want
to bother anyone if it's a definitive no.


> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
