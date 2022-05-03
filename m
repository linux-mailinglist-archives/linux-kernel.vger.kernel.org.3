Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F8518A79
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiECQzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiECQzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:55:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B479B2A260
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:51:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m23so22730447ljb.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQQ4M4gauRgvjGonaZz8I2LViquH62bNFXTFnYfFmTQ=;
        b=ZZ79PTvSiDix/BT4/4BoV+H6PAAni2xSl2bjFp4DgWFtS9ryzY8pV9lWjf47cE1vt/
         zhSi0WFHtNS22XehNn4RxeoPYQY4DuLZ5cNGUb+2JAlUhk1DPffdt31zGBUpHubSHe0L
         lXMbpa2lOnhtnfKl8xwne8VDfa23amnXkKbh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQQ4M4gauRgvjGonaZz8I2LViquH62bNFXTFnYfFmTQ=;
        b=ipLP8o+f+PvWOsL6ED+eD5dkPBCL29masgndF5Xa+iwkMNxBoNECmWfHJ8QQwaHcug
         jiaZaOnbtNUkIGjpArut6d89cXpGGGRdUeWcoTyD6wY/I9oUYjvs9ZSI5k2Bodj4D5sQ
         TmWDVZd4EkqKxfQVIfUijmHnVqdWimAG8l2d6aQFuIYLTXQzQpxjL4mrhdVOX8QIsQ1X
         fji+kzqXmdH4fEU7BaLyzA/ndDw/IRMZukGnI2frKHOtaXgSnV0GJyExBPGHXo8Ops46
         YgKIUF6bEXDC0Qsk3DoRDICEBO0Vh71r2s7/jGloouFSu+k/rjvl+F1n1KcXWX7p8JSB
         0RIg==
X-Gm-Message-State: AOAM531RWavb9YM/4cK+Gk6u+7ZgbgfYo1PJofQFz0Vw2z25CvCl2VyR
        sl2WpP2RpMvml7XXgUwlIrpfJR33PSIwO4iy
X-Google-Smtp-Source: ABdhPJx/2zHwYD40X2zQgd5C5TWEdPGYtY9kQg+izTqgW1Ly60QEh0DkeJcbuA8+pLMp34iqfWlyvg==
X-Received: by 2002:a05:651c:b0d:b0:24f:4ff1:6b23 with SMTP id b13-20020a05651c0b0d00b0024f4ff16b23mr8489193ljr.420.1651596703112;
        Tue, 03 May 2022 09:51:43 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c26-20020ac244ba000000b0047255d210eesm985375lfm.29.2022.05.03.09.50.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:51:09 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x17so31284327lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:50:45 -0700 (PDT)
X-Received: by 2002:a05:6512:6cb:b0:472:5e24:de05 with SMTP id
 u11-20020a05651206cb00b004725e24de05mr9332378lff.542.1651596636487; Tue, 03
 May 2022 09:50:36 -0700 (PDT)
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
 <CAHc6FU77KGn76B4ieu9Tn895deK-1yV4y=8ou4gTfUf=7C-4XQ@mail.gmail.com>
 <CAHk-=whfP+m6--NtUeOm5XTuhBGHkyoqd00ypW6v3RkzMFLU8g@mail.gmail.com> <CAHc6FU4JeMHUrJbbTwEsMiPPyinQpX9fW-hz21GdjgVsvYRZkw@mail.gmail.com>
In-Reply-To: <CAHc6FU4JeMHUrJbbTwEsMiPPyinQpX9fW-hz21GdjgVsvYRZkw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 May 2022 09:50:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipNXcy2qRF5d+oqO-LN+bR7Bmz+Vtvcapo_WigOzLirA@mail.gmail.com>
Message-ID: <CAHk-=wipNXcy2qRF5d+oqO-LN+bR7Bmz+Vtvcapo_WigOzLirA@mail.gmail.com>
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

On Tue, May 3, 2022 at 9:41 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> That's happening in iomap_file_buffered_write() and iomap_iter():
>
>         while ((ret = iomap_iter(&iter, ops)) > 0)
>                 iter.processed = iomap_write_iter(&iter, i);
>
> Here, iomap_write_iter() returns how much progress it has made, which
> is stored in iter.processed, and iomap_iter() -> iomap_iter_advance()
> then updates iter.pos and iter.len based on iter.processed.

Ahh. I even had that file open in my editor in another window, but missed it.

So much for that theory.

              Linus
