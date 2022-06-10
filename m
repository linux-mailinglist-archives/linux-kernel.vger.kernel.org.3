Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA92E545980
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiFJBSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiFJBSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:18:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC282A716
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:18:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id me5so50156264ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 18:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ef7tk7wNIsYPCOZrPmVbjZG8x2iQKEtwi1Ey0SbKXGA=;
        b=EFUiKhh5CA9hmmuqakb4HXAGXMunTa/FbrwjNrG/DVQIXKmAjwv5p2Z3DaV8xEBSwF
         sot+1ivxF0lBTUfXLfzRb2X9xDJ0JvFX2lQ9XjM3GRuLWnDCAlXwlcG+s0qC0qBURvEo
         Kp6sCp9lcT1HznxgjtiQk2hBCKdmoF9kwO1+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ef7tk7wNIsYPCOZrPmVbjZG8x2iQKEtwi1Ey0SbKXGA=;
        b=ohBSA/18T3HiffJZcHN4W7O/gtXqUonSsm5cM4Z5Lee5eamzR1cHqUS4vxthJYoDhv
         cBBCoKDJtTgABqEujZN8ZvXUR5ZhJRcSD/jDbhjf2nESAAKaqmS+gBhqGwb1RJmOGpdo
         2VxrhNw3jLzIHv6WoDVXF+M27FkEX44NyuYCYMHNn/gPYppqiYk0gHZu2ANf+b22FJbU
         XXkDtm960WTkb7ji0EH3qdB9PDoulLt64CiARSmM7BTRPSrJLoBI5h96jYrf7Y0Ki+Dw
         EtPJocRckVZou/fGIrKLnEcwMHKhSCQmkDax43eut9dQAlX3Au7sHiSlrTQJsICAzRzt
         AEPg==
X-Gm-Message-State: AOAM532+iO95jAu053esY9IwCNjGBZT6ggI4f/fqVhg+EFVrUJSHNtXD
        +axMmFV5NVmm6xs7WRM/owKzEyYU6nUQs2KLf3M=
X-Google-Smtp-Source: ABdhPJw+uih+F/sQSFz3axt1fXcqj68fWePLwL1n+13k9yKRE2e7Uos5LPjX0Z0rzFwUyL6Ny5TzTg==
X-Received: by 2002:a17:906:74cc:b0:712:381:9c5a with SMTP id z12-20020a17090674cc00b0071203819c5amr5906907ejl.466.1654823926379;
        Thu, 09 Jun 2022 18:18:46 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id s23-20020aa7d797000000b0042bc54296a1sm15085706edq.91.2022.06.09.18.18.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 18:18:45 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id p10so34555587wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 18:18:45 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr41289192wrf.193.1654823924692; Thu, 09
 Jun 2022 18:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook>
 <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
 <202206081404.F98F5FC53E@keescook> <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
 <AEEBCF5D-8402-441D-940B-105AA718C71F@chromium.org> <CAHk-=wh6+KUi+T8Ncn6BWTHDTJCzrJxgT47SWbq-ZWs1_vbvHA@mail.gmail.com>
 <4147483.1654784079@warthog.procyon.org.uk> <CAHk-=wj5hoE19YNniN+cquGT6H2z1BefbBo7UwE4-oySW86BxA@mail.gmail.com>
 <YqKJXf6dif2emugf@rh>
In-Reply-To: <YqKJXf6dif2emugf@rh>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 18:18:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdVzniqKj160Gn5ngPLwMhvvPSEg8VE4mndbq4uj-kog@mail.gmail.com>
Message-ID: <CAHk-=whdVzniqKj160Gn5ngPLwMhvvPSEg8VE4mndbq4uj-kog@mail.gmail.com>
Subject: Re: [PATCH] s390: disable -Warray-bounds
To:     Dave Chinner <dchinner@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 4:59 PM Dave Chinner <dchinner@redhat.com> wrote:
>
> I saw a heap of different implementations of the same thing with no
> consistency across them (i.e. inode container definitions) and a
> mess of a patch to convert them without solving the problem that
> there's no consistent convention for doing filesystem inode -> VFS
> inode container conversion

Sure. But the thing is, they aren't actually all the same.

We do have a pattern - embed the generic vfs inode inside the
filesystem-specific one - but the exact details of how you do it isn't
fixed in stone.

And this netfs thing is actually an example of why it *shouldn't* be
fixed in stone, exactly because a netfs user doesn't want to just
"embed the vfs inode" - it wants to embed something *else* that in
turn embeds the vfs inode.

So yes, most filesystems do similar things, but they aren't exactly
the same. And they *could* be more different than they actually are
(there's nothing that says you *have* to embed the generic VFS inode
in the filesystem-specific one, it's just that we make it easy and
it's a pattern that has been copied because it works really well)

And yes, we could just enforce naming, and force everybody do use

   #define VFS_I(myino) (&(myino)->vfs_inode)

but then we really would have been in trouble with this whole netfs
embedded struct.

And no, it wouldn't be some kind of insurmountable issue, using an
unnamed union (so that "vfs_inode" would be the inode, and
"netfs_inode" would be the bigger netfs inode+context) would have made
it all work out.

But I really don't see the point of trying to just force everybody to
use the same name, and force people to use a common macro that doesn't
really *buy* you anything.

I think just writing 'inode->vfs_inode.i_mode' is very clear, and is
particularly obvious in that there's no costly translation.
'VFS_I(inode)->i_mode' might be shorter to write, but that's mainly
because of the ugly shortened macro name. If you want ugly short
names, you could have called the inode member just 'vfs_i' in the
first place.

And yes, we could go even further, and just make the rule be that
everybody should actually put the generic VFS inode struct at the
beginning of the filesystem inode. I think people do that already in
practice.

Then we could maybe use some language tricks to make the filesystems
get their own inode pointer directly as arguments, instead of getting
a 'struct inode *" and having to do that

        struct ext4_inode_info *ei = EXT4_I(inode);

at all.

I suspect we'd have to use a macro with a cast at the op assignment
time, which would be really ugly, though, but maybe there's some gcc
language extension that allows that kind of thing.

Anyway, my point is that yes, we could enforce tighter rules here, and
make everybody match some particular pattern.

But I don't think we'd actually benefit from it, and I think it would
have just caused more pain in this situation, for example.

                 Linus
