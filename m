Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE846512481
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbiD0V34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbiD0V3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3434FCEB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651094799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AB2AzJJ8IjGoSjnbfQx30F7f0GbMWPGLsvloPQDw8ac=;
        b=NQSd0+SDNmQE/1N2lSW1vR+reMMGAGZY7NI/7KCCypRP76ORZtqzHOs5tgno4c/JWpEcFl
        YjBJnKg6a6ykxQ0CKWvRA1lTip3WvRO1AMu+AYWFQRP7GAVKbQbIx82qf8oydeFK5buxT0
        xE3ZCGO4aZLQWJwowxG9/Zhul9obMdo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-SNMw0_TlOXqW5QQJ3VzNcg-1; Wed, 27 Apr 2022 17:26:37 -0400
X-MC-Unique: SNMw0_TlOXqW5QQJ3VzNcg-1
Received: by mail-wm1-f70.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so889367wmi.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AB2AzJJ8IjGoSjnbfQx30F7f0GbMWPGLsvloPQDw8ac=;
        b=RuobRbmCwIg52sirHU0+Loonx5igk4MHdzGY5A/BKY7etdn7/4c8Wtv1rBIoVUbJtL
         iYvHMlZP/NLu8ih1oHAO2I56mGtaaSaCH+U2FJaYpHopNI8puEpHkLKwuHpY6QoFUew/
         HtxyQZGbXo1rh34rU6hl3vebMLPszsaTeutgPwut4KF94j9sqSVWwkFralU2ysAaMdO6
         wA4WumvlvcN11/yD2KhbiGxLWiJCA7SEF3ZKN6oCxCDfIwZibkcsx9RODWiud2CWhQni
         ee2upK+qvynpLndTZM9LlT8QQHtyiWEB6DX+TYqGHPcWIJtrwi1tI1ZAI2b0KDA1egwP
         JgpA==
X-Gm-Message-State: AOAM531ToMUxaRsDyxJLFOkNW2pWFmye4A+0vwYj/V55JZjSrmqvPZ0B
        iw8Qhq6gCeOayCXqG9NIs8rP9sP2a5raExGlmjBIxcKfOmW3Q8fKqgLOo/PJ4c7tibh01pPHiiX
        NKKEquFBk/kg7yMeG/9WIu5zClxcma/1pQQ4HjTjk
X-Received: by 2002:a5d:4b0d:0:b0:20a:f3d9:336e with SMTP id v13-20020a5d4b0d000000b0020af3d9336emr1727602wrq.467.1651094796139;
        Wed, 27 Apr 2022 14:26:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfF0F/O5mtxoKKsietIrkPmZm5qUDbCRczQudsCfphucBocKFEsXyrVgqBJN5m4mn3cJF1U0v52FtCk2cx/QY=
X-Received: by 2002:a5d:4b0d:0:b0:20a:f3d9:336e with SMTP id
 v13-20020a5d4b0d000000b0020af3d9336emr1727590wrq.467.1651094795879; Wed, 27
 Apr 2022 14:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com> <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
In-Reply-To: <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 27 Apr 2022 23:26:24 +0200
Message-ID: <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:26 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 27, 2022 at 12:41 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > I wonder if this could be documented in the read and write manual
> > pages. Or would that be asking too much?
>
> I don't think it would be asking too much, since it's basically just
> describing what Linux has always done in all the major filesystems.
>
> Eg look at filemap_read(), which is basically the canonical read
> function, and note how it doesn't take a single lock at that level.
>
> We *do* have synchronization at a page level, though, ie we've always
> had that page-level "uptodate" bit, of course (ok, so "always" isn't
> true - back in the distant past it was the 'struct buffer_head' that
> was the synchronization point).
>
> That said, even that is not synchronizing against "new writes", but
> only against "new creations" (which may, of course, be writers, but is
> equally likely to be just reading the contents from disk).
>
> That said:
>
>  (a) different filesystems can and will do different things.
>
> Not all filesystems use filemap_read() at all, and even the ones that
> do often have their own wrappers. Such wrappers *can* do extra
> serialization, and have their own rules. But ext4 does not, for
> example (see ext4_file_read_iter()).
>
> And as mentioned, I *think* XFS honors that old POSIX rule for
> historical reasons.
>
>  (b) we do have *different* locking
>
> for example, we these days do actually serialize properly on the
> file->f_pos, which means that a certain *class* of read/write things
> are atomic wrt each other, because we actually hold that f_pos lock
> over the whole operation and so if you do file reads and writes using
> the same file descriptor, they'll be disjoint.
>
> That, btw, hasn't always been true. If you had multiple threads using
> the same file pointer, I think we used to get basically random
> results. So we have actually strengthened our locking in this area,
> and made it much better.
>
> But note how even if you have the same file descriptor open, and then
> do pread/pwrite, those can and will happen concurrently.
>
> And mmap accesses and modifications are obviously *always* concurrent,
> even if the fault itself - but not the accesses - might end up being
> serialized due to some filesystem locking implementation detail.
>
> End result: the exact serialization is complex, depends on the
> filesystem, and is just not really something that should be described
> or even relied on (eg that f_pos serialization is something we do
> properly now, but didn't necessarily do in the past, so ..)
>
> Is it then worth pointing out one odd POSIX rule that basically nobody
> but some very low-level filesystem people have ever heard about, and
> that no version of Linux has ever conformed to in the main default
> filesystems, and that no user has ever cared about?

Well, POSIX explicitly mentions those atomicity expectations, e.g.,
for read [1]:

  "I/O is intended to be atomic to ordinary files and pipes and FIFOs. Atomic
  means that all the bytes from a single operation that started out together
  end up together, without interleaving from other I/O operations."

Users who hear about it from POSIX are led to assume that this atomic
behavior is "real", and the Linux man pages do nothing to rob them of
that illusion. They do document that the file offset aspect has been
fixed though, which only makes things more confusing.

So from that point of view, I think it would be worthwhile to mention
that most if not all filesystems ignore the "non-interleaving" aspect.

[1] https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/functions/read.html
[2] https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/functions/write.html
[3] https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/functions/V2_chap02.html#tag_15_09_07

Thanks,
Andreas

