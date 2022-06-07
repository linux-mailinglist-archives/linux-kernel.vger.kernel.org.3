Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54725540191
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbiFGOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245640AbiFGOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:37:57 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94F39BB9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:37:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y12so15689632ior.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdHJWud4Esb486ECVTxXzI6Kb+rZg4dxyJx1aHp+WQ0=;
        b=p1yrjVTX25GJuJWQxXO4slQsUE3V2ksOOmrTfHbAiEIx4YmFPIWQa+Uvvkx5Px+e/w
         hD2DTYGcSlRCngVekdCTc8vZZnmVa9c+bpVJF1dzXGArV3uwhPlrkMVBbC3hUl3FhK0l
         3sfkIAMa3zzyErynhAax4a2EjY/mHXUCwlhDwIMpqZ4mZXJLueR54TAwM8ZzJJehxlna
         QW2YPCJL4AcMOeLKeMXenItoNSNzFUBbbVwW69m1XqWBMMP1J429aJDmo6zAAdkqIs80
         n3EfKAQj2925UrzvDt1DGoMT1KTFIHN/qUDxgGBMh8KnGZ9jBvD5H7h0Gi9YjBVGDLXe
         IkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdHJWud4Esb486ECVTxXzI6Kb+rZg4dxyJx1aHp+WQ0=;
        b=hsgpv/purB8trHtaHD9BnTZ+Es7NkTnQnqP3xqm7jBdA6XvjVxlvfN5S6bzc+s2Not
         u4ZBXnPy+bUF09AabYKvzqmkpxp2jx5V5S0XSmRQKbedWxZlZPwLOVuRSXtCUiMyHGMP
         hfjqORbG91jP2lblmldeto95eHTXKNACJj0NDtBvpx6bmaX/AeJOYIWB7ZZ+OY3mFLxw
         Txh9LP0d8+jZnJRu4JTMVi9jVoP1l4xGKiB5Inl2daEyE9qbjBbbEb6IxtG5zA7cgdGm
         to87JRKEBCc7rT/GxzQrJv1Ogl27hRABkQyd9C4bqWnSSBsuJteXbyUSD3glqkd7GSt9
         EI9Q==
X-Gm-Message-State: AOAM530K1FR+yV/5MD0Iv9SkDZZLFrOOIFUVtwHVVn38D2fIx5PgZBQ/
        jTFHbuqsxAAwKGA/35Q/6Em+gjkI0zDjAPMCYy0W8w==
X-Google-Smtp-Source: ABdhPJzVVT8+GTP9Xb3A4HcsJ3LH8PbvMlQ/UZvnDv/iX6AT50XdZSKBoasNx0AWMpGF6muwHI3IP1pzl9EqRFHvKTY=
X-Received: by 2002:a05:6638:14cf:b0:330:f947:2ab7 with SMTP id
 l15-20020a05663814cf00b00330f9472ab7mr15874956jak.309.1654612673055; Tue, 07
 Jun 2022 07:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <Yp59WCODvEDbpxOY@sol.localdomain>
In-Reply-To: <Yp59WCODvEDbpxOY@sol.localdomain>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 7 Jun 2022 16:37:42 +0200
Message-ID: <CANp29Y7yEocOnLMhE_hc37L8wAzpvON9hwpjvuBLoMdQzhw+xA@mail.gmail.com>
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

Hi Eric,

Thanks for contacting us!
These are very interesting points.

Syzbot indeed only closes old bugs without a reproducer, because if we
have a repro, then we can periodically do a fix bisection. And yes,
this mechanism unfortunately does not always work perfectly.

I think we could split the problem you described into two parts.
1) Some bugs that are "open" on the dashboard are actually no longer
relevant and should be closed.

If you know some old opened bugs with repro, which are actually
already fixed, could you please share them? It would be helpful to
figure out the exact reason why they are still open.
There are some cases when we can close bugs with a repro without
losing too much -- e.g. for bugs from -next there was a discussion in
https://github.com/google/syzkaller/issues/1957.
Also, if the fix bisection fails, but the repro no longer triggers the
crash on the HEAD, then we could probably "cancel" the repro and let
the bug be auto-closed (actually, auto-invalidated) later?

2) Some bugs were reported to the mailing lists, but became forgotten.

We could periodically take maintainers as per the latest commit and
send a reminder email to them. What do you think, would people go mad
if we did that for each bug e.g. every 6 months? :) Only if the bug
still happens on syzbot, of course.

At some point we were also considering sending aggregated reminders
(e.g. sth like "we still have X open bugs for the subsystem you
maintain/have actively contributed to, here they are:"), but to do
that, we first need to learn how to more or less reliably classify the
bugs into the subsystems.

--
Best Regards,
Aleksandr

On Tue, Jun 7, 2022 at 12:19 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Currently the upstream Linux kernel has 888 open syzbot reports
> (https://syzkaller.appspot.com/upstream).  However, nearly two-thirds of them
> (577) were reported more than 1 year ago.  Old reports are often for bugs that
> were already fixed.  They can also be reports that got overlooked, forgotten
> about, not sent to the right place, etc.  Kernel maintainers also change over
> time, so the current maintainer(s) might never have received the original report
> even if syzbot sent the original report to the correct maintainer(s).
>
> Having these old reports open is preventing syzbot from re-reporting any bugs
> with the same crash signature (where a crash signature is something like
> "KASAN: null-ptr-deref Read in percpu_ref_exit") if it is still being seen.
>
> syzbot does auto-invalidate some old bugs, but only ones without a reproducer.
>
> Given that humans aren't keeping up with these reports, has it been considered
> to auto-invalidate all old syzbot reports -- not just ones without a reproducer?
>
> - Eric
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/Yp59WCODvEDbpxOY%40sol.localdomain.
