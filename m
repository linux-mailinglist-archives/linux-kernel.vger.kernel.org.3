Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7241C4D5A42
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbiCKFI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241284AbiCKFIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:08:21 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5181AC28D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:07:18 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id bn33so10621145ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wcU6MX9LLUloTsS3asCkIkFhbxnmE8bY6OPlHU+tAvY=;
        b=ejnJ42B3adgmAYauyTHn/0Z7UvY8C0yjl+tE+vuPgUhoRLJU2nD6R04n+IuSDfAEwY
         kxNkVRiyagwIwxm7Kfmokp13X8lRRNvFsMpKMWF+lWkXWTu356RFh6aYhxldXi00V2ZW
         kwJXO7kXGoc9gDiDQUN9k2Ki5TCG3CXuiBeLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcU6MX9LLUloTsS3asCkIkFhbxnmE8bY6OPlHU+tAvY=;
        b=ItM1NaYW3neSTAdthCydDMuII6pMchsZm0BXd2PmWonGVWB1hK7g1/8Wu2bxOmUPTQ
         /hPo7gHQ4FtAElgD6nFMdv49HHqewTzxaaf4bVvsdLHzJNMzkoqlnwU3z19q5jXImMEj
         wwGl8zSvwszeEL0EkVAAEOIJ3aF0hzUuecapPaWEFdnscB1QVjzzmSA1CMcJFGRSgcvS
         h+jFMSg2l712V2sqqWVfmd/etQK/V5geP640JgToQK0vg+ae85S6VMrhJ49My97Rd5dZ
         BNFMNEERsTW2plD1PImwb8nuGpAwJ82gOfJLCCVnPYceHrN19NIhknkRLhRbEbyEj3mO
         zl4A==
X-Gm-Message-State: AOAM530PlbM7ZyqJWghfyko0ljSgNgTuSJolqxWFgFq/Q8Rjlaxb5ilS
        cyCyMWIMFE4zWD2aE3x5f4t/7De69mz0aAzXZ68=
X-Google-Smtp-Source: ABdhPJxIOS5saXo7m7LmaMj6ZZms2ksuadpxhfIYBa4ANaGRNaG+JyF98zgysmc9IGeuYa+poiLMZA==
X-Received: by 2002:a2e:88d6:0:b0:245:f22e:5125 with SMTP id a22-20020a2e88d6000000b00245f22e5125mr4875691ljk.529.1646975236595;
        Thu, 10 Mar 2022 21:07:16 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512388d00b00443d9064160sm1373841lft.125.2022.03.10.21.07.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 21:07:16 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id r22so10626294ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:07:15 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr4951405lja.443.1646975235613; Thu, 10
 Mar 2022 21:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20220311013238.3387227-1-pobrn@protonmail.com>
 <20220311013238.3387227-2-pobrn@protonmail.com> <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
 <CAHk-=wjF4d_v5t=ht_vCOHxNDoPvsBuK-2jiEBus-__oPZuPFQ@mail.gmail.com> <wKlkWvCGvBrBjshT6gHT23JY9kWImhFPmTKfZWtN5Bkv_OtIFHTy7thr5SAEL6sYDthMDth-rvFETX-gCZPPCb9t2bO1zilj0Q-OTTSbe00=@protonmail.com>
In-Reply-To: <wKlkWvCGvBrBjshT6gHT23JY9kWImhFPmTKfZWtN5Bkv_OtIFHTy7thr5SAEL6sYDthMDth-rvFETX-gCZPPCb9t2bO1zilj0Q-OTTSbe00=@protonmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 21:06:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6PtRx9nBHVnrQkQkczGjXjO0E-oHXPPgPK_H+Nm=Czg@mail.gmail.com>
Message-ID: <CAHk-=wg6PtRx9nBHVnrQkQkczGjXjO0E-oHXPPgPK_H+Nm=Czg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] list: add type-safer list_head wrapper
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
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

On Thu, Mar 10, 2022 at 6:49 PM Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.=
com> wrote:
>
> That is indeed a simpler thing to do, and doesn't need `offsetof()` at th=
e
> declaration, but there are places - not many -  where the `list_head` mem=
ber
> is inside a subobject, for example, so `member` now contains a period.

Ahh, very true. And very annoying. So close, yet so far, and no way I
can see to really deal with that.

And it's not even really all that rare. It may not be the _common_
case, but it's still fairly wide-spread and not some "one or two odd
places" thing.

This grep catches at least a subset of cases:

    git grep '\<list_for_each_entry(.*\.[a-z_0-9]*)'

and it's clearly all over.

As mentioned, I don't think that we have had huge problems with
getting the member name wrong. We do get a fair amount of checking in
that it obviously has to be part of the type we iterate over, and even
if you were to pick the wrong one, the result is a very simple "that
doesn't work".

But it would still undeniably be very nice to have some automatic
build-time checking for it.

Now, some checking could be done by just doing the "reverse" of what
that patch in

  https://lore.kernel.org/all/CAHk-=3DwiacQM76xec=3DHr7cLchVZ8Mo9VDHmXRJzJ_=
EX4sOsApEA@mail.gmail.com/

does with 'list_traversal_head()', and have a

  #define list_traversal_entry()

that has a similar union with a type that also specifies the list
entry type (with that same "append marker to member name" model, which
still works fine with dots in the middle).

Then at least cross-checking that the type of the iterator matches
with the target list member is trivial, but _if_ a type has multiple
list entries, they often end up referring to the same type.

That very patch with 'struct task_struct' converted is actually an
example of exactly that: the <children,sibling> and <ptraced,
ptrace_entry> pairings have the exact same type tuple (all being
'struct task_struct', of course).

So it would strengthen the typechecking a bit in some cases, but
probably not all that noticeably.

            Linus
