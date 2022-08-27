Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC895A32FD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbiH0AOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiH0AOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:14:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A7AE97C7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:13:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w10so3911537edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8MsyfPvlxXKEg0Jtycdt6Gg2UJ2p22jXnG/vc+XzCe0=;
        b=dvDc7RyUENalgJYmQDzoJ3qfWWZSzJELcl5kwFmvtTunSI6kDlFmY1f5hw2CJWC81D
         7HCxkzu0/6Qzh8zreFKnsB0/ETpPGjAYo/2bJGMS+agIeTjoSNtVgSP+hwzS+XXujjLH
         nlmSUQPC4V9XNtBgZ7KCbIXh09Fy/D4DnwoqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8MsyfPvlxXKEg0Jtycdt6Gg2UJ2p22jXnG/vc+XzCe0=;
        b=a/VS5Baqa70yBS1dlCzcROgw75Knpg8gTWmK05eG0SloKOBl5mn/XAYqRT4U0RLA6t
         Q3xkr6zTubl6GGchM45H84pe4A7oY7fGbIF9X1UXX5PDpKUEBPw6vc88Fe3HGEnN/S1+
         tKoMXRYhVwzzEHBHgbXbJo41jElnN0svz1VSZYoD6wBtm2azN7wEOqRimps+JAyPsYuB
         OaLhxxpJ9G/OjoVh3fccZj9PHSxDMLZ/Y4o+sit4R0AcRmGNE9WF1AhpOk+Pc2b7yaIX
         aOKKzZxX+b8Bs+2WICRUGv+ukw/y/spq3MSsEC733V/cOLVC3R2CQq4CEy+Awl2j9JTG
         +GTw==
X-Gm-Message-State: ACgBeo3T3EljjI7L7oX6dS8QRcZlXtPxsjSMRFlg/Upc/ePJChSmO3sq
        5xnjHDgGeqplIG6TFg6bVWYM0zb7cxN7aj6hTg0=
X-Google-Smtp-Source: AA6agR4RUMwXfngME2BLPqfj3BG469ptMacCCme3X7LDACAKemV5EB3f6yUXRdmbLr07UOCkYaW7pA==
X-Received: by 2002:a05:6402:26cf:b0:447:e004:ea40 with SMTP id x15-20020a05640226cf00b00447e004ea40mr4633043edd.385.1661559236198;
        Fri, 26 Aug 2022 17:13:56 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7d489000000b0043d7b19abd0sm2012430edr.39.2022.08.26.17.13.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 17:13:55 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1583128wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:13:54 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr937717wme.8.1661559234478; Fri, 26 Aug
 2022 17:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
 <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com> <166155521174.27490.456427475820966571@noble.neil.brown.name>
In-Reply-To: <166155521174.27490.456427475820966571@noble.neil.brown.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 17:13:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whz69y=98udgGB5ujH6bapYuapwfHS2esWaFrKEoi9-Ow@mail.gmail.com>
Message-ID: <CAHk-=whz69y=98udgGB5ujH6bapYuapwfHS2esWaFrKEoi9-Ow@mail.gmail.com>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
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

On Fri, Aug 26, 2022 at 4:07 PM NeilBrown <neilb@suse.de> wrote:
>
> As you note, by the end of the series "create" is not more different
> from "rename" than it already is.  I only broke up the patches to make
> review more manageable.

Yes, I understand. But I'm saying that maybe a filesystem actually
might want to treat them differently.

That said, the really nasty part was that 'wq' thing that meant that
different paths had different directory locking not because of
low-level filesystem issues, but because of caller issues.

So that's the one I _really_ disliked, and that I don't think should
exist even as a partial first step.

The "tie every operation together with one flag" I can live with, in
case it turns out that yes, that one flag is all anybody ever really
wants.

> Alternate option is to never pass in a wq for create operation, and use
> var_waitqueue() (or something similar) to provide a global shared wait
> queue (which is essentially what I am using to wait for
> DCACHE_PAR_UPDATE to clear).

I _think_ this is what I would prefer.

I say that I _think_ I prefer that, because maybe there are issues
with it. But since you basically do that DCACHE_PAR_UPDATE thing
anyway, and it's one of the main users of this var_waitqueue, it feels
right to me.

But then if it just end sup not working well for some practical
reason, at that point maybe I'd just say "I was wrong, I thought it
would work, but it's better to spread it out to be a per-thread
wait-queue on the stack".

IOW, my preference would be to simply just try it, knowing that you
*can* do the "pass explicit wait-queue down" thing if we need to.

Hmm?

> > Instead of it being up to the filesystem to say "I can do parallel
> > creates, but I need to serialize renames", this whole thing has been
> > set up to be about the caller making that decision.
>
> I think that is a misunderstanding.  The caller isn't making a decision
> - except the IS_PAR_UPDATE() test which is simply acting on the fs
> request.  What you are seeing is a misguided attempt to leave in place
> some existing interfaces which assumed exclusive locking and didn't
> provide wqs.

Ok. I still would prefer to have unified locking, not that "do this
for one filesystem, do that for another" conditional one.

> >  (b) aim for the inode lock being taken *after* the _lookup_hash(),
> > since the VFS layer side has to be able to handle the concurrency on
> > the dcache side anyway
>
> I think you are suggesting that we change ->lookup call to NOT
> require i_rwsem be held.

Yes and no.

One issue for me is that with your change as-is, then 99% of all
people who don't happen to use NFS, the inode lock gives all that VFS
code mutual exclusion.

Take that lookup_hash_update() function as a practical case: all the
*common* filesystems will be running with that function basically 100%
serialized per directory, because they'll be doing that

        inode_lock_nested(dir);
        ...
        inode_unlock(dir);

around it all.

At the same time, all that code is supposed to work even *without* the
lock, because once it's a IS_PAR_UPDATE() filesystem, there's
effectively no locking at all. What exclusive directory locks even
remain at that point?

IOW, to me it feels like you are trying to make the code go towards a
future with basically no locking at all as far as the VFS layer is
concerned (because once all the directory modifications take the inode
lock as shared, *all* the inode locking is shared, and is basically a
no-op).

BUT you are doing so while not having most people even *test* that situation.

See what I'm trying to say (but possibly expressing very badly)?

So I feel like if the VFS code cannot rely on locking *anyway* in the
general case, and should work without it, then we really shouldn't
have any locking around any of the VFS operations.

The logical conclusion of that would be to push it all down into the
filesystem (possibly with the help of a coccinelle script).

Now it doesn't have to go that far - at least not initially - but I do
think we should at least make sure that as much as possible of the
actual VFS code sees that "new world order" of no directory locking,
so that that situation gets *tested* as widely as possible.

> That is not a small change.

Now, that I agree with. I guss we won't get there soon (or ever). But
see above what I dislike about the directory locking model change.

> It might be nice to take a shared lock in VFS, and let the FS upgrade it
> to exclusive if needed, but we don't have upgrade_read() ...  maybe it
> would be deadlock-prone.

Yes, upgrading a read lock is fundamentally impossible and will
deadlock trivially (think just two readers that both want to do the
upgrade - they'll block each other from doing so).

So it's not actually a possible operation.

                    Linus
