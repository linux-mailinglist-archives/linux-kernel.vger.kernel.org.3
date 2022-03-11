Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FBF4D56EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbiCKArt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbiCKArs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:47:48 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B087F1A2734
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:46:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gb39so15769406ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MWpPevTXD3OVyRVT3kR8OEKqC1/aCzhwDb8lPZGqgeU=;
        b=CDZNJsuOi788FY8gAuDZGmuG80aZHvreAMuZ2/qjypwYCvKbhskHBt81S8aJWPM1tr
         hjtcuXwJ4nOsvWb+oryDzTMfn95fyqZB6BBoKlpNGFr0dtAg2Fgg/OYjjxStPVhsQT+H
         qKo6KFJIMe0zUgg+i5yc+Ratje7eCBQ+C9VR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MWpPevTXD3OVyRVT3kR8OEKqC1/aCzhwDb8lPZGqgeU=;
        b=sstbjnf6ONftzGJZq8AJrMK3LR+nibi3UwNT2StaP8E3DH2YwgKMIfieJPhJ6SzBtX
         D/5cDsUfpIw7Z9gyyvWnSB3sMRFi8nALaHjX7h+lD4IUUCMw/NjfVz5n2f2sZmD+e+ck
         VGCMQXQZB6r5eFlGsdHmV+rINDfTudgZefi7aNyS+L5Y2CP1qeNPUMmMY/bmBdvLHvYx
         063fLzZ+HrO0WZ9VsVy7awz6za6GX8D3mGkrtf+BYrEzop/hSH95qKj4cbVVxPEZlr0y
         oGyW7CHIuok9agjH1ZzrGwK0zqrvnwGAQjTgnnsmnevp/E0zizouvV5CMfvyRWgrMvax
         L+qw==
X-Gm-Message-State: AOAM530fIfSIimpgbuFmtT3XA9may5/Vv6OzX1nHOF9eutpr89oYrxd2
        6UoAcavtBrMzRnZz7gPCOlRPvBV8cdM+JHZ2WlW50A==
X-Google-Smtp-Source: ABdhPJwIBFoifixGR/mxfVGqBIPW9Qoe/+D8Bt3okVLQx4CODl8cRqLb5n7nORyLXZ+SFzDpEKbCzCxuXrLHr7ocLoQ=
X-Received: by 2002:a17:906:7316:b0:6d7:16be:b584 with SMTP id
 di22-20020a170906731600b006d716beb584mr6468336ejc.759.1646959604231; Thu, 10
 Mar 2022 16:46:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiacQM76xec=Hr7cLchVZ8Mo9VDHmXRJzJ_EX4sOsApEA@mail.gmail.com>
 <YiqPmIdZ/RGiaOei@qmqm.qmqm.pl>
In-Reply-To: <YiqPmIdZ/RGiaOei@qmqm.qmqm.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 16:46:33 -0800
Message-ID: <CAADWXX-Pr-D3wSr5wsqTEOBSJzB9k7bSH+7hnCAj0AeL0=U4mg@mail.gmail.com>
Subject: Re: [PATCH 2/6] list: add new MACROs to make iterator invisiable
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 3:54 PM Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.=
qmqm.pl> wrote:
>
> If the macro implementation doesn't have to be pretty, maybe it could go
> a step further and remember the list_head's offset? That would look
> something like following (expanding on your patch; not compile tested):

Oh, I thought of it.

It gets complicated.

For example, a type that refers to a list of itself (and 'struct
task_struct' is one such example) cannot actually refer to that other
member name while declaring the head entry.

That's true even if the target member was declared before the head
that points to it - because the type just hasn't been fully
instantiated yet, so you can't refer to it AT ALL.

And even if that wasn't the case - and we could refer to previous
members during the initialization of subsequent ones - you'd still end
up with circular issues when one type has a list of another type,
which has a list of the first type.

Which I'm also fairly certain does happen.

With regular "circular pointers", the trick is to just pre-declare the type=
, ie

   struct second;

  struct first {
     .. define here, can use 'struct second *'
  };

  struct second {
    .. define here, can use 'struct first *'
  };

but that only works as long as you only use a pointer to that type.
You can't actually use 'offsetof()' of the members that haven't been
described yet.

Now, you can combine that "pre-declare the type" model with the "do
the offsetof later", but it gets nasty.

So I actually think it *can* be made to work, but not using your
"pointer to an array of the right size". I think you have to

 - pre-declare another type (the name needs to be a mix of both the
base type and the target type) with one macro

 - use a pointer to that as-yet undefined but declared type it in that
union defined by list_traversal_head() type

 - then, later on, when that target type has been fully defined, have
a *different* macro that then creates the actual type, which can now
have the right size, because the target has been declared

But that means that you can't really describe that thing inside just
the list_traversal_head() thing, you need *another* place that firsat
declares that type, and then a *third* place that defines that final
the type once all the pieces are in hand.

So it gets a lot uglier. But yes, I do believe it it's doable with
those extra steps.

The extra steps can at least be sanity-checked by that name, so
there's some "cross-verification" that you get all the pieces right,
but it ends up being pretty nasty.

It's extra nasty because that type-name ends up having to contain both
the source and destination types, and the member name. We could avoid
that before, because the 'name##_traversal_type' thing was entirely
internal to the source structure that contains the head, so we didn't
need to name that source structure - it was all very naturally
encapsulated.

So you'd have to do something like

  #define list_traversal_declare(src, head, dst, member) \
        struct src##_##head##_##dst##_##member##_offset_type

  #define list_traversal_defile(src, head, dst, member) \
        list_traversal_declare(src,head,dst,member) { \
                char[offsetof(struct dst, member); \
        }

   #define list_traversal_head(src, name, dst, member) \
    union {
        struct list_head name; \
        struct dst *name##_traversal_type; \
        list_traversal_declare(src,head,dst,member) *name##_target_type_off=
set;
    }

and then you'd have to do

    list_traversal_declare(task_struct, children, task_struct, sibling);

    struct task_struct {
        ...
        list_traversal_entry(task_struct, children, task_struct, sibling);
        ..
    };

    list_traversal_define(task_struct, children, task_struct, sibling);

and now list_traversal() itself can use
'sizeof(*name##_target_type_offset)' to get that offset.

NOTE! All of the above was written in my MUA with absolutely no
testing, just "I think something like this will work". And note how
really ugly it gets.

So. Doable? Yes. But at a pretty horrid cost - not just inside the
"list_traverse()" macro, but in that now the places declaring how the
list works get much much nastier.

                 Linus
