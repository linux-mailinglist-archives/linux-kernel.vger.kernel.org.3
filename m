Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C324D585B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345690AbiCKCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiCKCur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:50:47 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A91A274F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:49:45 -0800 (PST)
Date:   Fri, 11 Mar 2022 02:49:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646966983;
        bh=580k28RZJWmruhyNLJaUIw7q1yifrWd4WqcSy+ybKWo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ZF8FYbbFpCzxGnaB7xZpON8TRl6aEG9ZJXzgjVQdF/0AaUKypfyo2r6NOf41G4VPX
         chPLti/RlDcF1XukztOtMmYbSMzy2dM2xXq38Iw3rFe55l1RTmuXP6it83vOPb5MOH
         qJajJIRq0AK+ZgZ+PaTlV17YnB5UTh7oYgF04Ru733MZqiTbAK4q4dDtWDCaV0xy6a
         urzqvoUKEuOmAW97BV0uRrETdfOnY1jZf2HJOej5uu6/v8kLzs0rtTIFJwNtarMZGj
         Dbkgrn4ScnkWOWLDdu9aM1S+eC4v5ossq5QL/ensZaLjBXuMelyytpe7kva6H3dqwr
         dsDmBshLVTHMw==
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
Message-ID: <wKlkWvCGvBrBjshT6gHT23JY9kWImhFPmTKfZWtN5Bkv_OtIFHTy7thr5SAEL6sYDthMDth-rvFETX-gCZPPCb9t2bO1zilj0Q-OTTSbe00=@protonmail.com>
In-Reply-To: <CAHk-=wjF4d_v5t=ht_vCOHxNDoPvsBuK-2jiEBus-__oPZuPFQ@mail.gmail.com>
References: <20220311013238.3387227-1-pobrn@protonmail.com> <20220311013238.3387227-2-pobrn@protonmail.com> <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com> <CAHk-=wjF4d_v5t=ht_vCOHxNDoPvsBuK-2jiEBus-__oPZuPFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2022. m=C3=A1rcius 11., p=C3=A9ntek 3:01 keltez=C3=A9ssel, Linus Torvalds =
=C3=ADrta:
> On Thu, Mar 10, 2022 at 5:42 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That one didn't do the automatic offset thing, but see
> >
> >    https://lore.kernel.org/all/CAADWXX-Pr-D3wSr5wsqTEOBSJzB9k7bSH+7hnCA=
j0AeL0=3DU4mg@mail.gmail.com/
> >
> > on the problems that has.
>
> Note: I think the problems are serious enough that it almost certainly
> isn't worth doing - it makes the code uglier for very little upside.
>
> So I tried to explain how it _could_ be done, but that doesn't mean
> that it _should_ be done.
>
> Having the member name as part of the list traversal macro isn't
> actually generally a real problem.
>
> I added it to the list_traversal_head() macro in that original patch
> because I think we can easily use the member head name to _verify_
> that the declaration and the use match.
>
> Yes, squirrelling  off the offset and not needing the member head name
> at all at when traversing the list is obviously simpler syntax, but
> that part has never been the real problem with list traversal. And
> verifying that the member name that is passed in is the same as in the
> list_traversal_head() would be trivial.
>
> To verify it, we could simply change that type name from:
>
>      type *name##_traversal_type;
>
> to be
>
>      type *name##_traversal_type_##member;
>
> instead, and suddenly the member name in 'list_traverse()' has to
> match that thing that list_traversal_head() created.
>
> So yes, you'd have that third argument in list_traverse(), but it
> would be trivially checked at compile-time.

That is indeed a simpler thing to do, and doesn't need `offsetof()` at the
declaration, but there are places - not many -  where the `list_head` membe=
r
is inside a subobject, for example, so `member` now contains a period.


>
> And you'd avoid all the ugly complexities (described above) with lists
> that are embedded inside data structures that refer to each other)


Regards,
Barnab=C3=A1s P=C5=91cze
