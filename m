Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD23F517812
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387365AbiEBU2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiEBU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BF61247
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651523092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UdZt71erzInkdQWP9nE3aPOYbCeSzdBMVJZpOjnab6U=;
        b=f0FGb3lj/+SxscQXxi5URGJs3S+8k6WGyTU5okwJhzpQmMVXCG3K6ZlkH4Lg3MRQs1Hw0I
        UN6+vkU2kGGGBlvv2pGK51lsnq0lfiO7g9auqzkDQh1NYM1UcTZtWBQbgRjK/BmTGvautd
        LtgGcNvKw6RtngdDTiEtk+8fkWPTKKA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-zQqkl90DPemgT1JHvT1TBA-1; Mon, 02 May 2022 16:24:43 -0400
X-MC-Unique: zQqkl90DPemgT1JHvT1TBA-1
Received: by mail-wr1-f72.google.com with SMTP id b10-20020adfc74a000000b0020ab029d5edso5627810wrh.18
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdZt71erzInkdQWP9nE3aPOYbCeSzdBMVJZpOjnab6U=;
        b=LrPW1EZMMeobTnliYx5P8n3yCvxhVs3hSYrInWNjR8gI5UGu/1SIGDRWrMeKYhR5Ky
         /Cb30bmj9MOjga2vFec2uwFP528zyJizXwUyCKoB3Xoeg+a3JWnryebXI7EjPcl997IH
         z3JjpfIM8tlDweo7KIlphnmCWQPYIXGm+HDTfRZcpTop3zJ+MUyiRrP4Bvoes6dx//ol
         RtIRlyKbH8g0YMviUUS4kVELjmlgFho708RO4qFIDfol0S9aVkvL2LFWD+POURmN0clp
         SSmOTyZ0W8sA5y2Elbp1pVPznjvLjjVr8EkKkltAG7g9kj2et4iFzlOhHTbzjn9JJEfO
         27jA==
X-Gm-Message-State: AOAM533vZIxK/xUDiF0kuf2hp9r0+QkteWMAft///O1uGjdQbTIJcTWY
        m9BE+2wv8YVOLm79qG6SSmh+qw9At9jW8oR4vBQEbVlkFjtbJ1hpy+k2orw076S0pPK6NrDxA0h
        t2NfhARoP7IpHD+fdzB4wUfJH9JJvt4l/a80PjRVa
X-Received: by 2002:a1c:2942:0:b0:392:3aff:4fcd with SMTP id p63-20020a1c2942000000b003923aff4fcdmr620246wmp.0.1651523082222;
        Mon, 02 May 2022 13:24:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcEsBewr8W5eVg62nkR1Wb4KVlY1M0XsuVK3vz1ojcr4Vc7wcJuVZJYI+tEdl0Qe0q+ayeeD8mjC8Nl1rx4+U=
X-Received: by 2002:a1c:2942:0:b0:392:3aff:4fcd with SMTP id
 p63-20020a1c2942000000b003923aff4fcdmr620231wmp.0.1651523081803; Mon, 02 May
 2022 13:24:41 -0700 (PDT)
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
 <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com> <CAHk-=whrt9ofcyonPEbgPOaCG+15mDdz+O9bb0RKrJVTt7vR4w@mail.gmail.com>
In-Reply-To: <CAHk-=whrt9ofcyonPEbgPOaCG+15mDdz+O9bb0RKrJVTt7vR4w@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 2 May 2022 22:24:30 +0200
Message-ID: <CAHc6FU7TRD_2H6H4ucoqQ-8Q1d0xtoT68uopbZGQPwO9Z1k0kw@mail.gmail.com>
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

On Mon, May 2, 2022 at 8:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, May 2, 2022 at 11:31 AM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > NOTE! This patch is entirely untested. I also didn't actually yet go
> > look at what gfs2 does when 'bytes' and 'copied' are different.
>
> Oh, it's a lot of generic iomap_write_end() code, so I guess it's just
> as well that I brought in the iomap people.
>
> And the iomap code has many different cases. Some of them do
>
>         if (unlikely(copied < len && !folio_test_uptodate(folio)))
>                 return 0;
>
> to force the whole IO to be re-done (looks sane - that's the "the
> underlying folio wasn't uptodate, because we expected the write to
> make it so").
>
> And that might not have happened before, but it looks like gfs2 does
> actually try to deal with that case.
>
> But since Andreas said originally that the IO wasn't aligned, I don't
> think that "not uptodate" case is what is going on, and it's more
> about some "partial write in the middle of a buffer succeeded"
>
> And the code also has things like
>
>         if (ret < len)
>                 iomap_write_failed(iter->inode, pos, len);
>
> which looks very wrong - it's not that the write failed, it's just
> incomplete because it was done with page faults disabled. It seems to
> try to do some page cache truncation based on the original 'len', but
> not taking the successful part into account. Which all sounds
> horrifically wrong.
>
> But I don't know the code well enough to really judge. It just makes
> me uncomfortable, and I do suspect this code may be quite buggy if the
> copy of the full 'len' doesn't succeed.

This has thrown me off in the past as well; it should be changed to
iomap_write_failed(iter->inode, pos + ret, len - ret) for legibility.
However, iomap_write_failed() only truncates past EOF and is preceded
by i_size_write(iter->inode, pos + ret) here, so it's not strictly a
bug.

> Again, the patch I sent only _hides_ any issues and makes them
> practically impossible to see. It doesn't really _fix_ anything, since
> - as mentioned - regardless of fault_in_iov_iter_readable()
> succeeding, racing with page-out could then cause the later
> copy_page_from_iter_atomic() to have a partial copy anyway.

Indeed. Let's see what we'll get with it.

In the meantime, we've reproduced with 5.18-rc4 + commit 296abc0d91d8
("gfs2: No short reads or writes upon glock contention"), and it still
has the data corruption.

> And hey, maybe there's something entirely different going on, and my
> "Heureka! It might be explained by that partial write_end that
> generally didn't happen before" is only my shouting at windmills.
>
>              Linus
>

