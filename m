Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C152D10A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiESLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiESLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:01:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B525CD
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:01:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l13so1799112lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gS9JeUMKm9gLH6I0YioZSKZRpDTxg6jGf/FW7Dub0V8=;
        b=HeZ4SGYOa+2JHEfI08Yn/5kzSBr64/rwPIJu2FmEX4E1rjIoJLOOFID5KiiSbR2+Nn
         +8yE3t89kPEm3aXfx9O7JeuBHM9uh584pY5M2vIS3SK+oKNAiHfRaJPos5xNt0hpjwkE
         /Xtypl54qoYJMXYc+OJGCxDvFa36dNB8OqhkVcsRICX3Ue/gi3kTvB3leaITh2rbETSW
         lOx81NBdXrXwI1aYDCTILOgN2JUSICoEsujF0JiHKt24V1jsy8sczyQY0Ato4JRcBkrc
         y0sWuklE48qtX7GDOqya0p2rHIr3bIJJ4q4iGhcFcfL+SZOqQoLyaIVQgfVWqSbMfd8r
         2SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gS9JeUMKm9gLH6I0YioZSKZRpDTxg6jGf/FW7Dub0V8=;
        b=fbKSaFfH7xNMqDCqPjIffeK45vSkOgESuW44d0KxKfRGoSVyfoOcqmc07nM8iYB3+/
         74nz6/jNz6keCiq1Aib+Iavr67VXaLdvRWcMvLXafAcNoXTBE8wZbdUYgLLvXCfZvFuL
         bdkSQucdYqIFO4lUjcNrwE0+mMhDncyI1YAHTxB4APWQOyj6HgNeK1fWJLAGHgWjqltt
         1biPRwgvvigcKHA3X9w846kLIUnl6klpzBRvAjXHM1V3g09Mz24O/toBaZJzY2Myemxr
         LOHOETRymDPaXvstWy9/KEt545lX9sMuTRhYx45OpyMp9Ag1d6M7MpoTI7zTRf4EkejO
         2duA==
X-Gm-Message-State: AOAM533So8qzsALjBNK9YuQeqIoZhBJy8qIGWPcZwp51HRxsUolt/B9r
        Bl7IcmWFHdcqGu2u+Xp4yUBI27v5m+/Un7ZLf296Mnnb3khB5g==
X-Google-Smtp-Source: ABdhPJxp8IViIL6xXR+pTEzCb+U74CV/8uAvUHeuJWMavYf3SxovFQU9CPG4eZyJ+vjM/8r42vxxNE6yx4MHYAa05TQ=
X-Received: by 2002:a05:6512:3f13:b0:464:f55f:7806 with SMTP id
 y19-20020a0565123f1300b00464f55f7806mr2934429lfa.598.1652958097345; Thu, 19
 May 2022 04:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000029572505de968021@google.com> <a72282ef-650c-143b-4b88-5185009c3ec2@kernel.dk>
 <YnmuRuO4yplt8p/p@T590> <20220510055039.GA10576@lst.de> <0e1b3d10-ae79-f987-187e-58109441ccee@kernel.dk>
In-Reply-To: <0e1b3d10-ae79-f987-187e-58109441ccee@kernel.dk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 May 2022 13:01:25 +0200
Message-ID: <CACT4Y+Z9GUz7xK8YKuVewTEopCUWX9tCRhWZq3O84Lw-ZRXd+w@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in bio_poll
To:     syzbot <syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc:     linux-kernel@vger.kernel.org
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

On Tue, 10 May 2022 at 14:45, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/9/22 11:50 PM, Christoph Hellwig wrote:
> > On Tue, May 10, 2022 at 08:13:58AM +0800, Ming Lei wrote:
> >>> Guys, should we just queue:
> >>>
> >>> ommit 9650b453a3d4b1b8ed4ea8bcb9b40109608d1faf
> >>> Author: Ming Lei <ming.lei@redhat.com>
> >>> Date:   Wed Apr 20 22:31:10 2022 +0800
> >>>
> >>>     block: ignore RWF_HIPRI hint for sync dio
> >>>
> >>> up for 5.18 and stable?
> >>
> >> I am fine with merging to 5.18 & stable.
> >
> > I'm fine, too.  But are we sure this actually is one and the same
> > issue?  Otherwise I'll try to find some time to feed it to syzbot
> > first.
>
> I re-wrote the reproducer a bit and can reproduce it, so I can certainly
> test a backport. But yes, I was skeptical on this being the same issue
> too. My initial reaction was that this is likely due to the bio being
> "downgraded" from polled to IRQ driven, and hence completes without an
> extra reference before the bio_poll() is done on it. Which is not the
> issue described in the referenced commit.

#syz fix: block: ignore RWF_HIPRI hint for sync dio
