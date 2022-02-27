Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD94C5AB5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiB0Lod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiB0Loa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:44:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783FCE0FC;
        Sun, 27 Feb 2022 03:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 351B7B800A0;
        Sun, 27 Feb 2022 11:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE240C340F3;
        Sun, 27 Feb 2022 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645962230;
        bh=83ynuK5GTbf/JTBo6qMbtfOA3WOxBaL3FE64VfSTbwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CeckwioaHTRlYaJqDt9Zj6M+x2ZBQaGvgZnfWtRq3T1Bw1ADFGVSeOeFY2vHOuwAw
         QHkcw5yoYCOuCpW+xarFRkts/WVYUFeJZwgpGdllqtnOjegvs1+9ocDnEciaRlljbU
         DtboQpfW8MgBtepvFcIzz6ybLVWx1BVbWvyCRwmKkBqJKxjDyjqI6NNF3H9zRjHiHt
         s8VYIUcj+tSqQiGVDLMwyqSgHz9/Hp5kb9E28QL0Xthh1UKqK6hmkq1nX1OrJ7S0QD
         v8mysIUB1y8ujUvAXsvuIhOxRLi+lT/NbmrotIefF+INw6ls8e8RYJqmM2Vgs5qIVE
         Eu9A9SN5Z4APw==
Received: by mail-yb1-f177.google.com with SMTP id b35so14935039ybi.13;
        Sun, 27 Feb 2022 03:43:50 -0800 (PST)
X-Gm-Message-State: AOAM530ojzLa9wwbrkAj6UQlMEEpqg0pooaCzfM/nSfz8HTjTNDy/Yi2
        iUU8Esq1zYgx7SGDwVun1rXBf82o2w8jdrw7Y+Y=
X-Google-Smtp-Source: ABdhPJxaXhhC4f43aQCA949j8FB7vygtq3FTQ0iDTd3LkCgfQEi6WCsFklRxTq/cLEa22HjecrJdFhS9I9QJXTGrCUc=
X-Received: by 2002:a25:4214:0:b0:624:6215:4823 with SMTP id
 p20-20020a254214000000b0062462154823mr14630993yba.432.1645962229999; Sun, 27
 Feb 2022 03:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
 <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
 <CAHmME9rPd8Nu8Q0+R6B4Bz-caKpq5SSvLaiKdwXcyNHY8Ebfqg@mail.gmail.com>
 <CAMj1kXEwsyPcoTvK6PZyA5L3q9u_dd_wXUiyHw7TtPM5LecP7g@mail.gmail.com>
 <CAMj1kXHAeqrPjMZi_VD6fYWXatV5UUy5N3ZbtZf=SaDpN3GPVQ@mail.gmail.com> <b023481d-7a25-2343-63d9-0a34874f2ba8@amazon.com>
In-Reply-To: <b023481d-7a25-2343-63d9-0a34874f2ba8@amazon.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 27 Feb 2022 12:43:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEcM1Q=utgfj1b+NGGH=+dcjdC6OhDhCqJhR8ZNXbUM2A@mail.gmail.com>
Message-ID: <CAMj1kXEcM1Q=utgfj1b+NGGH=+dcjdC6OhDhCqJhR8ZNXbUM2A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     Alexander Graf <graf@amazon.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 at 12:39, Alexander Graf <graf@amazon.com> wrote:
>
>
> On 27.02.22 11:47, Ard Biesheuvel wrote:
> > On Sun, 27 Feb 2022 at 11:30, Ard Biesheuvel <ardb@kernel.org> wrote:
> >> On Sun, 27 Feb 2022 at 11:03, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>> On 2/27/22, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>> On Sat, 26 Feb 2022 at 23:07, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>>>> From: Alexander Graf <graf@amazon.com>
> >>>>>
> >>>> Please don't invent patch authors like that. Alex's patch that started
> >>>> this discussion was completely different.
> >>> Considering the investigative side ("why won't the _CID match?") and
> >>> most the commit message were Alex's, and that those things comprise
> >>> 95% of what this patch is, and that the code change itself isn't even
> >>> part of anything Turing complete, I most certainly did not feel
> >>> comfortable stripping Alex's authorship. Instead I added myself as a
> >>> co-author at the bottom. When in doubt, err on the side of crediting
> >>> others. Alex also took a look at this patch, I am under the impression
> >>> of at least, before it went out. Let's minimize the paperwork
> >>> policing, okay? I think it'd make for a much more pleasant space here.
> > ...
> >> Please stop with the ad hominems in response to criticism on factual
> >> aspects of your code. Putting someone else's authorship on code they
> >> did not write is not cool, and pointing that out is *not* what is
> >> making this space unpleasant.
> >> And 'paperwork policing' is sadly an important aspect of a high
> >> profile open source project such as Linux.
> >>
> > I typed this before reading your message on IRC, which reads:
> >
> > "Alex looked at that patch before i sent it out and did not object to
> > me keeping his authorship. I wouldn't have sent it out otherwise."
> >
> > and so I stand corrected if this is true. But please, next time,
> > please be more clear about these things.
>
>
> Yes, he did reach out to me on a separate channel and I told him to go
> for it :). Sorry if I created some confusion with that.
>

No, my bad. But in my defence, everyone on the original thread knows
that this single oneline change was suggested by Jason, not you, and
so seeing him posting it as your patch did confuse me a little.
