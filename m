Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C1549C24
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbiFMSts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbiFMSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:49:28 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B4E86C4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:47:34 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id v7so4545573ilo.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3y6nQUpREDLkWe7yKa0UAwuMqX3hq5w915YYWK2imJA=;
        b=dfO6y+K+eEEw+nHowr64bloavX1KPc8PRVoqFmcf+aWlEilrashyB632gGEfGmOFM9
         0Njo5NPQAdGI+1e5XMn/E5nBtdPPM/qly7ovhx5ErL+dbsJzsDFyxvy+fEpPJ76/XBGc
         b2lqU9w7djr5BM+e32FltdjMLXCOi/ORouMImp327Cv13MIbMaTq2UV3+cXHKQWJkyZo
         xgIVLQwWEzDwTIvKlR4H8e1Wr5Wjnuzqopjykh6Yzh0TsCY2ZIGeOtEjstO9A7mENRnd
         4OuDRZBLbOCOomiXN2LhWoWm3LdGF+nAVQX9ZWmfil2DR5tnPU+p8qzfPW0SOCPfQKg1
         ySXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3y6nQUpREDLkWe7yKa0UAwuMqX3hq5w915YYWK2imJA=;
        b=4zLfLC6E13ES1Imedi1We+lomTfJj+wGvOB3//pwnqJ7wYtkMkcgRe9qGqHYe+JTuK
         UFy0wo212+NwKamlNRFLyFOGOdpEy3fPgf6TbREKbsEPkbQUsk6d3ccXDP8ESPjREJNH
         N6WCQG6ctVbajzA0ewwK08WhWjcjy/KZUQW77KdXe76ZfUA7hyhMElxBPi9DZmnxMEef
         lxUMneA0RQcrn6aPLJIVxARV5j/xnzoQY1bYlaR/CSOLshWtr9iAjdD5grxrSiXjU25h
         myZM3St7AoCPkOOlPpTmHec8IeTMh94nm16RBWX5ab14rJTGFU3+y/l5WsqUBW5p1+YP
         4oGA==
X-Gm-Message-State: AJIora/8MvBtDH56yhKJm/bOtYPr4oJJB1OFf8jhy7bIFx7eQZfeVGzr
        4NmUkRteGJZlnf9VLWYAIjn/uygN2arM2ObraAdkmg==
X-Google-Smtp-Source: AGRyM1utYZtUJPmmO0YH5rQY1H+QkoLxHbX0qkfAdMz/XCRVb0XG2N2qMO4MC8xySY77TbTFJmHmuYWkYpRBCT9nKZ4=
X-Received: by 2002:a92:ca0e:0:b0:2d3:dc52:35e9 with SMTP id
 j14-20020a92ca0e000000b002d3dc5235e9mr272117ils.44.1655135253763; Mon, 13 Jun
 2022 08:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <Yp59WCODvEDbpxOY@sol.localdomain> <CANp29Y7yEocOnLMhE_hc37L8wAzpvON9hwpjvuBLoMdQzhw+xA@mail.gmail.com>
 <Yp/wGYVsKR8M9eXI@sol.localdomain>
In-Reply-To: <Yp/wGYVsKR8M9eXI@sol.localdomain>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 13 Jun 2022 17:47:22 +0200
Message-ID: <CANp29Y7Y-5KY8D8=tFQfYF_aHwNOh8pz3sumLuKM930EHW7msg@mail.gmail.com>
Subject: Re: Auto-invalidating old syzbot reports?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 2:41 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jun 07, 2022 at 04:37:42PM +0200, 'Aleksandr Nogikh' via syzkaller wrote:
> > Hi Eric,
> >
> > Thanks for contacting us!
> > These are very interesting points.
> >
> > Syzbot indeed only closes old bugs without a reproducer, because if we
> > have a repro, then we can periodically do a fix bisection. And yes,
> > this mechanism unfortunately does not always work perfectly.
> >
> > I think we could split the problem you described into two parts.
> > 1) Some bugs that are "open" on the dashboard are actually no longer
> > relevant and should be closed.
> >
> > If you know some old opened bugs with repro, which are actually
> > already fixed, could you please share them? It would be helpful to
> > figure out the exact reason why they are still open.
> > There are some cases when we can close bugs with a repro without
> > losing too much -- e.g. for bugs from -next there was a discussion in
> > https://github.com/google/syzkaller/issues/1957.
> > Also, if the fix bisection fails, but the repro no longer triggers the
> > crash on the HEAD, then we could probably "cancel" the repro and let
> > the bug be auto-closed (actually, auto-invalidated) later?
> >
>
> Just to give the first definitive example I could find,
> https://syzkaller.appspot.com/bug?id=06c43cd0a71aec08de8ea55ca5cda816c45ab4e0
> ("KMSAN: uninit-value in _mix_pool_bytes") is a 3-year old bug that is still
> open even though it was fixed by commit f45a4248ea4c ("net: usb: rtl8150: set
> random MAC address when set_ethernet_addr() fails").

Thanks for providing the example!
Yes, KMSAN bugs are unfortunately a bit special at the moment - we
cannot do a proper fix bisection because the KMSAN repo is regularly
rebased. Correct Reported-by tag and manual fix reporting (#syz fix)
are right now the only ways to get KMSAN bugs closed.

For this particular bug the problem was that the fixing commit
referenced (Reported-by:
syzbot+abbc768b560c84d92fd3@syzkaller.appspotmail.com) another bug
(https://syzkaller.appspot.com/bug?extid=abbc768b560c84d92fd3).

>
> From working on syzbot reports in the past, I can say that the "already fixed"
> case for old reports is very common.  It is hard and time-consuming to actually
> identify them as such though, since it requires root-causing the bug.  If it was
> quick and easy to do so, there wouldn't be hundreds of such open reports...
>
> > 2) Some bugs were reported to the mailing lists, but became forgotten.
> >
> > We could periodically take maintainers as per the latest commit and
> > send a reminder email to them. What do you think, would people go mad
> > if we did that for each bug e.g. every 6 months? :) Only if the bug
> > still happens on syzbot, of course.
>
> That is greatly needed, but to get there we first need to get past the
> assumption that every syzbot report will get properly handled by humans and thus
> should never be automatically closed.  That assumption has been tried for the
> last 5 years, and unfortunately it isn't working.  (If responding to syzbot
> reports was being properly funded, it would be possible, but it's not.)  It
> looks like you agree, as per your suggestion that only crashes that still happen
> in syzbot should be reminded about.  I think syzbot actually needs to go further
> and close the old bug reports, not merely suppress reminders about them...

I've filed an issue about making syzbot periodically re-test the
reproducers. If the repro doesn't trigger a bug anymore, syzkaller
will pretend there's no repro and close the bug once crashes are not
happening anymore. This should hopefully resolve the problem with old
irrelevant bugs.
https://github.com/google/syzkaller/issues/3193

>
> In any case, reminders *must* include the latest crash details in a way that
> clearly shows that the bug is still relevant.

That's a good point, thanks!

>
> > At some point we were also considering sending aggregated reminders
> > (e.g. sth like "we still have X open bugs for the subsystem you
> > maintain/have actively contributed to, here they are:"), but to do
> > that, we first need to learn how to more or less reliably classify the
> > bugs into the subsystems.
>
> Well syzbot already identifies subsystems via the stack trace; it's just not as
> good as a human expert, and probably never will be since the correct subsystem
> can be very non-obvious.  For a short time, I was actually manually classifying
> the subsystems for syzbot reports and sending out reminders --- see
> https://lore.kernel.org/linux-kernel/?q=%22open+syzbot+bugs%22 --- but I gave up
> due to lack of support from my job for doing that work, combined with receiving
> somewhat less engagement than I had hoped.

Hmm, yes, maybe we can indeed give even the existing subsystem
detection mechanism a try.
And it looks like it's better to only send grouped reminders -- given
how much negative reaction one can see under your link(s), I wonder
what would there be if we send per-bug reminders :)

Hopefully I'll be able to get to the implementation in some foreseeable future.

>
> Perhaps the best solution would be to crowdsource by providing a self-service
> "#syz subsystem $FOO" command.
>
> - Eric
