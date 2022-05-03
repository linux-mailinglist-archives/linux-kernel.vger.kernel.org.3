Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C596E518A35
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiECQpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiECQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E5DF1A07B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651596092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pahes7C/tmc6/DL1WldFW1GN6sPT/c4aOjyuB4GyOjo=;
        b=dIXyraVRoTPf01vJm5a1/gQ32dATrVAeJ1E/KDvwq1DRYaFWa38mN4CdrxW6feIIK8L+ZS
        Dxe5gEiwthNwlSLLntHo4keLDKaAAsVt1KPOJZkBsRqD+LvYiJ7O7r2MWVWB6Cv0896wxQ
        ilGKtv2iUx/tL70GuCaiGmlM+k+qMeg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-WQkx191tM5KaVMuB7t7ogw-1; Tue, 03 May 2022 12:41:30 -0400
X-MC-Unique: WQkx191tM5KaVMuB7t7ogw-1
Received: by mail-wm1-f72.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso6077795wma.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pahes7C/tmc6/DL1WldFW1GN6sPT/c4aOjyuB4GyOjo=;
        b=IU8ENrQbHRrsc/Jfb3b8tVwZQpx7aGNqxpMSaBBMtwFrzfA3Dx9iXSfDn4atKVGOxT
         jiSPuTcCnhh8+toKfKXfLDduGvbCkkv/GN/xFAQanJNGoWwojySrNNbgQHAbqAYSQzS7
         Veab3nBdC01f07vCtKsNvjJ4yeXoUAmIh8dNibpb9s0/WiHVZPyei0PTAUynAUZWXizH
         ClIN+Fc+6X5vFCWZFmg942heAdn29Au12vMDAko4e0FUhgU/g5E58WR/e2szUpRIZt2C
         hSGAP31/upnm3/aaFdIlk+QzEff95Tb5Kk/Td74sbbpyutUHeoUXixFvsxH8cVvTfXKH
         gCLQ==
X-Gm-Message-State: AOAM531FHz/dY0z0rNM/LQX6R75dSs2R0MwpRXnxeGNclB+Ro10qZPAJ
        O7FFVKRvICAI/o5fB9yVFNx/p4TbXsIhYWywXH4/lZQvatzhV0BUzUwItFZcbSsBpxHWQmr80PQ
        b0ZLrTI3epHm+dJaBP2/YdY0xJRXWcVNiEeuzLYSU
X-Received: by 2002:a05:6000:1848:b0:20c:713b:8e1e with SMTP id c8-20020a056000184800b0020c713b8e1emr4687686wri.640.1651596088858;
        Tue, 03 May 2022 09:41:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxlxZdFgCAiHMVbSw5lczeYImaUCvF2aHBlyYw8A/WTq0Zy6Np8DioP/9GtXIjN4YifBEpw2oAXSUJWziXL2w=
X-Received: by 2002:a05:6000:1848:b0:20c:713b:8e1e with SMTP id
 c8-20020a056000184800b0020c713b8e1emr4687668wri.640.1651596088626; Tue, 03
 May 2022 09:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
 <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
 <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
 <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
 <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
 <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com>
 <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
 <CAHc6FU6VgQDO7HT5f4S_4f=9hczKGRDQ6SbQ5kNHMi4i-6rxVA@mail.gmail.com>
 <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
 <CAHc6FU77KGn76B4ieu9Tn895deK-1yV4y=8ou4gTfUf=7C-4XQ@mail.gmail.com> <CAHk-=whfP+m6--NtUeOm5XTuhBGHkyoqd00ypW6v3RkzMFLU8g@mail.gmail.com>
In-Reply-To: <CAHk-=whfP+m6--NtUeOm5XTuhBGHkyoqd00ypW6v3RkzMFLU8g@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 3 May 2022 18:41:17 +0200
Message-ID: <CAHc6FU4JeMHUrJbbTwEsMiPPyinQpX9fW-hz21GdjgVsvYRZkw@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 6:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, May 3, 2022 at 1:56 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > We still get data corruption with the patch applied. The
> > WARN_ON_ONCE(!bytes) doesn't trigger.
>
> Oh well. I was so sure that I'd finally found something.. That partial
> write case has had bugs before.
>
> > As an additional experiment, I've added code to check the iterator
> > position that iomap_file_buffered_write() returns, and it's all
> > looking good as well: an iov_iter_advance(orig_from, written) from the
> > original position always gets us to the same iterator.
>
> Yeah, I've looked at the iterator parts (and iov_iter_revert() in
> particular) multiple times, because that too is an area where we've
> had bugs before.
>
> That too may be easy to get wrong, but I couldn't for the life of me
> see any issues there.
>
> > This points at gfs2 getting things wrong after a short write, for
> > example, marking a page / folio uptodate that isn't. But the uptodate
> > handling happens at the iomap layer, so this doesn't leave me with an
> > immediate suspect.
>
> Yeah, the uptodate setting looked safe, particularly with that "if we
> copied less than we thought we would, and it wasn't uptodate, just
> claim we didn't do anything at all".
>
> That said, I now have a *new* suspect: the 'iter->pos' handling in
> iomap_write_iter().
>
> In particular, let's look at iomap_file_buffered_write(), which does:
>
>         while ((ret = iomap_iter(&iter, ops)) > 0)
>                 iter.processed = iomap_write_iter(&iter, i);
>
> and then look at what happens to iter.pos here.
>
> iomap_write_iter() does this:
>
>         loff_t pos = iter->pos;
>         ...
>                 pos += status;
>
> but it never seems to write the updated position back to the iterator.
>
> So what happens next time iomap_write_iter() gets called?
>
> This looks like such a huge bug that I'm probably missing something,
> but I wonder if this is normally hidden by the fact that usually
> iomap_write_iter() consumes the whole 'iter', so despite the 'while()'
> loop, it's actually effectively only called once.
>
> Except if it gets a short write due to an unhandled page fault..
>
> Am I entirely blind, and that 'iter.pos' is updated somewhere and I
> just missed it?

That's happening in iomap_file_buffered_write() and iomap_iter():

        while ((ret = iomap_iter(&iter, ops)) > 0)
                iter.processed = iomap_write_iter(&iter, i);

Here, iomap_write_iter() returns how much progress it has made, which
is stored in iter.processed, and iomap_iter() -> iomap_iter_advance()
then updates iter.pos and iter.len based on iter.processed.

Andreas

