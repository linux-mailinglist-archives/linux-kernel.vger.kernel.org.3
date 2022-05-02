Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566B517703
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386993AbiEBTCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiEBTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:02:21 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89A064E1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:58:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l19so19485091ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CECE6TSK8MHjSmTIWBnzhHFpumjz5uVxh+Sa8svO4Ik=;
        b=X4E70v2iXVM3ihjmV7BjytsYyEz9ntDrfu5Z5lmWsyUIDVc/hoV+kgQtmfpHjq+QaG
         RZHX0XUVq9LLxTj4kMxCrvbvC12tOFZ/wIMtSilIKFTBrXxenui/UU9vAD5EqqeSCzW+
         NtJP10C4GHavyC+ks7adueMhrSbuNivJEsS8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CECE6TSK8MHjSmTIWBnzhHFpumjz5uVxh+Sa8svO4Ik=;
        b=ydde1/TSdYMFcI2DPy0fPGG4BD357kkQL2XHmQIiSlovSo8ky/9yPI36CsIyADFZCm
         pC/44LS/bwP818Fh9n3gXWtes+kdzKc9/ZMaCTS8nRT4hnL6QsTEJZGNxDx2aRuDII33
         n0p5TkTt3O9NeYM3gfBFLxXhQHf/jGjMZ+OAlE3ZBNU3KJYztumIoGTjcf6GvwfSt0JD
         mfL6XDof4bta/1VLIStXV6Vaw1EzGwuMgjbXonEImmI3Ne6k+k1ScCbwXcPjZ4903ew+
         fkr3fMsR51JXo+njEPoPskqpGz++FY+r6ftqj8WHF86dayJOKtFHEHKZzb8QSA7/SvU7
         FYOw==
X-Gm-Message-State: AOAM5332UteZOUVeMmRMG91exvc4TFc2+9SsCF+rda147JlyYbtZrYcG
        xYxmqOKeIE3p1feWh5736zH29gcvO+J472lE
X-Google-Smtp-Source: ABdhPJzaETJwCr7RvPip+vAsdk7E6WJgziRhIIi7w2BF3irbr03jHX6ZBZ/kdQj6nq4Q9ptQLDdIfA==
X-Received: by 2002:a05:651c:992:b0:250:664c:9058 with SMTP id b18-20020a05651c099200b00250664c9058mr917313ljq.26.1651517929864;
        Mon, 02 May 2022 11:58:49 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 16-20020a05651c00d000b0024f3d1daeebsm1119594ljr.115.2022.05.02.11.58.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 11:58:48 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 17so19507644lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:58:48 -0700 (PDT)
X-Received: by 2002:a2e:8789:0:b0:24f:124c:864a with SMTP id
 n9-20020a2e8789000000b0024f124c864amr8342835lji.164.1651517927914; Mon, 02
 May 2022 11:58:47 -0700 (PDT)
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
 <CAHc6FU6VgQDO7HT5f4S_4f=9hczKGRDQ6SbQ5kNHMi4i-6rxVA@mail.gmail.com> <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
In-Reply-To: <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 May 2022 11:58:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrt9ofcyonPEbgPOaCG+15mDdz+O9bb0RKrJVTt7vR4w@mail.gmail.com>
Message-ID: <CAHk-=whrt9ofcyonPEbgPOaCG+15mDdz+O9bb0RKrJVTt7vR4w@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
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

On Mon, May 2, 2022 at 11:31 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> NOTE! This patch is entirely untested. I also didn't actually yet go
> look at what gfs2 does when 'bytes' and 'copied' are different.

Oh, it's a lot of generic iomap_write_end() code, so I guess it's just
as well that I brought in the iomap people.

And the iomap code has many different cases. Some of them do

        if (unlikely(copied < len && !folio_test_uptodate(folio)))
                return 0;

to force the whole IO to be re-done (looks sane - that's the "the
underlying folio wasn't uptodate, because we expected the write to
make it so").

And that might not have happened before, but it looks like gfs2 does
actually try to deal with that case.

But since Andreas said originally that the IO wasn't aligned, I don't
think that "not uptodate" case is what is going on, and it's more
about some "partial write in the middle of a buffer succeeded"

And the code also has things like

        if (ret < len)
                iomap_write_failed(iter->inode, pos, len);

which looks very wrong - it's not that the write failed, it's just
incomplete because it was done with page faults disabled. It seems to
try to do some page cache truncation based on the original 'len', but
not taking the successful part into account. Which all sounds
horrifically wrong.

But I don't know the code well enough to really judge. It just makes
me uncomfortable, and I do suspect this code may be quite buggy if the
copy of the full 'len' doesn't succeed.

Again, the patch I sent only _hides_ any issues and makes them
practically impossible to see. It doesn't really _fix_ anything, since
- as mentioned - regardless of fault_in_iov_iter_readable()
succeeding, racing with page-out could then cause the later
copy_page_from_iter_atomic() to have a partial copy anyway.

And hey, maybe there's something entirely different going on, and my
"Heureka! It might be explained by that partial write_end that
generally didn't happen before" is only my shouting at windmills.

             Linus
