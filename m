Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA6951898E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiECQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiECQXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:23:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D714B2CE3F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:19:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so31166417lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JG3HzoSawUya4Ff5hOskiwsDPqB8IOURZiJ3WxkT7I=;
        b=XyTHbO/T17RhX6KeTaQRsyWHKfUZUjRIcfF2dxzjhwrNQCTLyaHdRtlVu0D3ZMfUOr
         yLARl+3w/sPGEBVgTRp4sRNYGbtxaOSoBGfOkj0VKZT+OwDCqmOkbOxZ5/UxuREnKMBZ
         5rlI886BqT1O89jxNYWRi10yebcu9Avcp57aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JG3HzoSawUya4Ff5hOskiwsDPqB8IOURZiJ3WxkT7I=;
        b=wUzT7loSnEY/RLipltB7wASy8GF/Gazs8SdPVpTimiZS+eDrhJBUifg5Ke7W0qYAYt
         UDG30o1gmS9rnGDioU4PUHgH4UgarVv7qBUBDb0cgUn7klAwX3eLPBwDNTfSHSb3wKlz
         dt3JcAhbIk62B3abMHAsSptAnuMq7cVHfUcwKtqHpZMpk9gv67mBDt9RS4RXP513hLHC
         wGYTmrNzUOsYw3MomIzpPtuhieF42L+NvruCpqVGVtpkWVmG/Tkmju6D6b3/z5O8JNny
         LTpwWm2Tg+ngIHTIV3MeYfbwGsw/uZVRgxEPJOLGS5HLF7j+ARDfaeD0gEllt/I4m9w/
         d2hw==
X-Gm-Message-State: AOAM531d0w3UJT5FrYtrCXW3WaSqqqeTdJ83yTOO2k594iufuJK0Ly1M
        X/F+cxCpE5LyRkt1xUoY4+E6gR2QGjwgmOPG
X-Google-Smtp-Source: ABdhPJzk0b3QFAyhFMow4te3Pl8C2/a+mMrZgvOfpWRXqyR0qI9RH2HMm5YxItPpMtqbM2NK8ZzxSw==
X-Received: by 2002:a05:6512:3191:b0:472:5e00:1bee with SMTP id i17-20020a056512319100b004725e001beemr9500683lfe.129.1651594782450;
        Tue, 03 May 2022 09:19:42 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id f12-20020a2eb5ac000000b0024f3d1daea1sm1385006ljn.41.2022.05.03.09.19.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:19:41 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id q14so22619401ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:19:41 -0700 (PDT)
X-Received: by 2002:a2e:934b:0:b0:24f:cce:5501 with SMTP id
 m11-20020a2e934b000000b0024f0cce5501mr10518058ljh.443.1651594781101; Tue, 03
 May 2022 09:19:41 -0700 (PDT)
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
 <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com> <CAHc6FU77KGn76B4ieu9Tn895deK-1yV4y=8ou4gTfUf=7C-4XQ@mail.gmail.com>
In-Reply-To: <CAHc6FU77KGn76B4ieu9Tn895deK-1yV4y=8ou4gTfUf=7C-4XQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 May 2022 09:19:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfP+m6--NtUeOm5XTuhBGHkyoqd00ypW6v3RkzMFLU8g@mail.gmail.com>
Message-ID: <CAHk-=whfP+m6--NtUeOm5XTuhBGHkyoqd00ypW6v3RkzMFLU8g@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, May 3, 2022 at 1:56 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> We still get data corruption with the patch applied. The
> WARN_ON_ONCE(!bytes) doesn't trigger.

Oh well. I was so sure that I'd finally found something.. That partial
write case has had bugs before.

> As an additional experiment, I've added code to check the iterator
> position that iomap_file_buffered_write() returns, and it's all
> looking good as well: an iov_iter_advance(orig_from, written) from the
> original position always gets us to the same iterator.

Yeah, I've looked at the iterator parts (and iov_iter_revert() in
particular) multiple times, because that too is an area where we've
had bugs before.

That too may be easy to get wrong, but I couldn't for the life of me
see any issues there.

> This points at gfs2 getting things wrong after a short write, for
> example, marking a page / folio uptodate that isn't. But the uptodate
> handling happens at the iomap layer, so this doesn't leave me with an
> immediate suspect.

Yeah, the uptodate setting looked safe, particularly with that "if we
copied less than we thought we would, and it wasn't uptodate, just
claim we didn't do anything at all".

That said, I now have a *new* suspect: the 'iter->pos' handling in
iomap_write_iter().

In particular, let's look at iomap_file_buffered_write(), which does:

        while ((ret = iomap_iter(&iter, ops)) > 0)
                iter.processed = iomap_write_iter(&iter, i);

and then look at what happens to iter.pos here.

iomap_write_iter() does this:

        loff_t pos = iter->pos;
        ...
                pos += status;

but it never seems to write the updated position back to the iterator.

So what happens next time iomap_write_iter() gets called?

This looks like such a huge bug that I'm probably missing something,
but I wonder if this is normally hidden by the fact that usually
iomap_write_iter() consumes the whole 'iter', so despite the 'while()'
loop, it's actually effectively only called once.

Except if it gets a short write due to an unhandled page fault..

Am I entirely blind, and that 'iter.pos' is updated somewhere and I
just missed it?

Or is this maybe the reason for it all?

                Linus
