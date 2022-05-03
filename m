Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58045191A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiECWp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiECWp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:45:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA982DA89
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:41:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p10so32645735lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJ6LSQS2hZp/i3Er1PZcJDTlIm5WitovxDQeaGU9cAY=;
        b=WTLzW2HJFi/Z1y+N4gAHgVKK1VuC87VXq9k0nNYsUTnMvX9bd+jxioIwGpNC9V+CSI
         KELuVjTwGzBhxLqNqagoquMhsrEJefNChCLonIzL0jpLz3Yq97uKmCn83uHtsaxrcB19
         tgu7+VGYMG4ZeZ5/Ml6eBX4/cTUM1LBycamnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJ6LSQS2hZp/i3Er1PZcJDTlIm5WitovxDQeaGU9cAY=;
        b=sfrLbh/dF9XnsSBT+djeOAmtY0k92IBeWlC0jhtm5Cbcw7xFK8f3A+pQmIdpfVkCXz
         hGm9Lruf1abmUZ/6OBnNkKYeAfinx/ubZZccmuag+t8w2OJJ8SgNCwjGJFKCm2sHaD0b
         iqTXzLUuIh87QJ0DMAQQvuUEAej1Ch5hp6Bv2TIhZeuPfSofycX8m77Mf6uFFZR/BJd4
         mVo4E9hlFPOYJP53isTGzC549Gz4sNGDb1PRcsNZLgjVOn/tekIaCl5uulY5xhAwNrbu
         LirpMNMvEin3WdwsAIl2FyA86uO6OmJ7zTQdLBhdzD1KGdAx1LwQEBtGC+vxGIyoG/Qm
         +T+g==
X-Gm-Message-State: AOAM531/cWefpqnll0mSDue1N69+JQ/REkKZ0XmZdqL2sf6t7D5eWNJ/
        0CHX69AlY8zKCvENPmej5kTPr1aan0DTyBpM
X-Google-Smtp-Source: ABdhPJyjHx1ZXHtfbTeCgKDij1keG9l9NuQNH5uSez+k6iyPgcXvXmhiFMZgdrMK6fOpjhdWf5C/sg==
X-Received: by 2002:a05:6512:1398:b0:445:bcef:e4fd with SMTP id p24-20020a056512139800b00445bcefe4fdmr12350269lfa.398.1651617711757;
        Tue, 03 May 2022 15:41:51 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p10-20020a05651238ca00b0047255d21138sm1049306lft.103.2022.05.03.15.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 15:41:50 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id i10so4651863lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 15:41:49 -0700 (PDT)
X-Received: by 2002:a05:6512:a8f:b0:473:a826:bfd0 with SMTP id
 m15-20020a0565120a8f00b00473a826bfd0mr3724913lfu.435.1651617709017; Tue, 03
 May 2022 15:41:49 -0700 (PDT)
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
 <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
 <CAHc6FU77KGn76B4ieu9Tn895deK-1yV4y=8ou4gTfUf=7C-4XQ@mail.gmail.com>
 <CAHc6FU7i4GJaSodNX+o44VgWyo1LTPdYkBnypYS3GYa1atYAZA@mail.gmail.com> <20220503213524.3273690-1-agruenba@redhat.com>
In-Reply-To: <20220503213524.3273690-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 May 2022 15:41:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQwqW+FJ_dsq8M58=5joQdV+8Q51bmyjvrBV6Z68VF0Q@mail.gmail.com>
Message-ID: <CAHk-=wjQwqW+FJ_dsq8M58=5joQdV+8Q51bmyjvrBV6Z68VF0Q@mail.gmail.com>
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

On Tue, May 3, 2022 at 2:35 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> More testing still ongoing, but the following patch seems to fix the
> data corruption.

Fingers crossed.

> +               truncate_pagecache_range(inode, hstart, hend - 1);
> +               if (hstart < hend)
> +                       punch_hole(ip, hstart, hend - hstart);

Why doesn't that "hstart < hend" condition cover both the truncate and
the hole punch?

             Linus
