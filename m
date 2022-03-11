Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD4D4D5852
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbiCKCqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbiCKCqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:46:17 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835821A616E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:45:15 -0800 (PST)
Date:   Fri, 11 Mar 2022 02:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646966713;
        bh=75n7D8GkYY40Smy0jggoA4SN2YbNoOfxMs7WJaVH1BQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=smcqxfpP0eydrrymPUTUQKgUeY4UV3ULEfkQvq3VNj3sGW8i0CVEovFvDjUHAu+aD
         Bh2zEDb8F2EBGyMXGPEd2DHSWG2tzLj3w5w08uHBCzNZBR1dAibNILjDcqUILci+Qe
         GNDYMx2iem/kBGXyRuFAHhw8nYt1I/N3q8rtuJ3jW6KEyphkntPgt7GbV8tTM2/ZwQ
         iEHBdEoXhKPe1qthkJMnp4hcq0GgQ3VlLGbSo1CD+biVwOlF/K2/Yd7MC90+/RMClZ
         bfIq5TtmlZqiBx61UileYOxq0xQ3fAAmjEjR2+GI/+LiKvq75HzYGuwpE4S59Fl5EH
         gdMCSzBzuRc/Q==
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
Message-ID: <L-1HXgKDMuTPMcgA_RH5BHU4bFb1U8UcqcmeZyV08uR7oBO2XsgCg3yeQNk3nK2SOtb3VDLMtbMLTjmQmFMju1weR47JOEh5DHzGFVdpHNE=@protonmail.com>
In-Reply-To: <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
References: <20220311013238.3387227-1-pobrn@protonmail.com> <20220311013238.3387227-2-pobrn@protonmail.com> <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
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


2022. m=C3=A1rcius 11., p=C3=A9ntek 2:42 keltez=C3=A9ssel, Linus Torvalds =
=C3=ADrta:
> On Thu, Mar 10, 2022 at 5:33 PM Barnab=C3=A1s P=C5=91cze <pobrn@protonmai=
l.com> wrote:
> >
> > The underlying idea is to define each list head using an anonymous stru=
ct:
>
> Why struct? Union is much better, and doesn't pointlessly waste memory
> for members that are only used for their type.

As far as I can tell, zero-sized arrays won't take up any space. It's true
that if the type has excessive alignment requirements, then it may indeed
waste space. Changing it to a pointer+union is a simple change, nonetheless=
.


>
> Anyway, as far as I can tell, your model is unworkable as-is, since it
> only works for a list that is external to the types in question.
>
> Which is not even remotely the interesting case. All serious list uses
> are inside other types, and refer to each other.
>
> So this seems to be fundamentally broken, in that it only works for
> trivial things, and is not even as good as
>
>    https://lore.kernel.org/all/CAHk-=3DwiacQM76xec=3DHr7cLchVZ8Mo9VDHmXRJ=
zJ_EX4sOsApEA@mail.gmail.com/
>
> that actually converted a real case.
>
> That one didn't do the automatic offset thing, but see
>
>    https://lore.kernel.org/all/CAADWXX-Pr-D3wSr5wsqTEOBSJzB9k7bSH+7hnCAj0=
AeL0=3DU4mg@mail.gmail.com/
>
> on the problems that has.
>
> Again, you avoided those problems by making the use-case a narrow and
> uninteresting one.

Yes, I have mentioned at the end that there are limitations of this approac=
h
(to keep it easy to use and sane) and that it won't work everywhere,
namely where the value type is incomplete. E.g.
  * you cannot have a list of T inside a T;
  * you cannot have a list of B inside A plus a list of A inside B.

Nonetheless, I still think there are legitimate use cases for this, where
the simple, limited interface works fine. And I am by no means suggesting
not going forward with the other ideas that came up. I mostly imagined this
tlist as an "addition" for the simple, trivial cases.

For example, there are currently more than 1000 occurrences of

  static LIST_HEAD(

in the source tree. I did not check, but I think it's very likely that most=
 of
them would satisfy the constraints of the proposed interface. And while I c=
annot
provide any numbers, I would not be surprised if most list uses in the kern=
el were
"boring" and "trivial", where this interface would work.

But I understand if you don't want something that doesn't work for every ca=
se.


Best regards,
Barnab=C3=A1s P=C5=91cze
