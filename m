Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160504756FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbhLOKzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbhLOKzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:55:22 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D4C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:55:22 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id j2so53922000ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/b9fHHE4hjZyZA5CBpGA3qQ8yRtdTTyk2I+Jk0XPiCQ=;
        b=qXyfFh4C89lG8vSP7FGnlEmJU90OvmObfhMRpUzRMEF8EuM0QAmcghIHzbokP0in6K
         2mEc2/xCnMIzwy0ZMwG37XO6VPzlFLePQ1urgGciaenz75x1et+d0/b2rQDaAL66xn7D
         JFiNodSkj0K1wlcrYsS6yV8dvUE7NckHYRGk+bXeV9FiaRbbIkKHQlIx2EkpqG31NMLi
         vIMUehexePpeyXlN8Lza3+LJ/ZD+FHFIrqub4Tfsr2anWZlhew3UU9gyXJ675BLYH/b7
         R7oeik7h6jXgGnd72j6Z7kJD57jr1m9jilVA9dPVHVwjKiWkXlXNaljLCtRldraQySjn
         HB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/b9fHHE4hjZyZA5CBpGA3qQ8yRtdTTyk2I+Jk0XPiCQ=;
        b=2neMeJpOwLPP6DvLs013CknpFFUjDQHo5b7FdcoXfQ5Y/BB83NW340vYYmh/aAy55s
         MtlIbc1cNbjX8SkY0KGcRJsrUIjh/56ahmnLQDFFw9FWoPZChBcFmIoexoY2lDEDD5TQ
         tQ1kWbBjan2ExNh/A5mqGRJyyB02fj28JcJM4Nr2PucyuDTDx+bxKFV6au0Q6roiEm0+
         39BEfOdPyEClOIbE7UaCdm5Sf25bDniQMQ4i2O5TlYNk94CkabgBZ9oESrghfK9+fAIT
         vC4xm0T3XscLIK+fmnEVJOyogMyiyXU2xZ7vaoFQaS7GWfY6xEsb5r4kYRq9gaH60/ku
         Nc1Q==
X-Gm-Message-State: AOAM530FVPwhxbdTKUmSq1jU0ID0wrcG5yg1hwJhgcHd0kSwdCrOP3bZ
        jgSyij96BMn158f5I+Z6UYfFwIp7QS7uyXedlcRGPw==
X-Google-Smtp-Source: ABdhPJxPOyHN09MApCmnwhVcELlYjc3FN9cuMYirbncLALLjo5QPK5J0qqlPrzxaP3FDcVXUsi/iifKxtsgGZcQptaI=
X-Received: by 2002:a25:df4f:: with SMTP id w76mr5726625ybg.711.1639565720958;
 Wed, 15 Dec 2021 02:55:20 -0800 (PST)
MIME-Version: 1.0
References: <0b6c06487234b0fb52b7a2fbd2237af42f9d11a6.1639560869.git.geert+renesas@glider.be>
 <CANn89iKdorp0Ki0KFf6LAdjtKOm2np=vYY_YtkmJCoGfet1q-g@mail.gmail.com>
 <CAMuHMdWQZA_fS-pr+4wVYtZ6h9Bx4PJ_92qpDNZ2kdjpzj+DHQ@mail.gmail.com>
 <CANn89iJ-uGzpbAhNjT=fGfDYTjpxo335yhKbqUKwSUPOwPZqWw@mail.gmail.com> <CAMuHMdUepDEgf9xD6+6qLqKtQH-ptvUf-fP1M=gt5nemitQBsw@mail.gmail.com>
In-Reply-To: <CAMuHMdUepDEgf9xD6+6qLqKtQH-ptvUf-fP1M=gt5nemitQBsw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 Dec 2021 02:55:09 -0800
Message-ID: <CANn89iJ2HjNqOM=yF0yCi5K8id7XY=nG-yoo-sJsv=ykaSNDnw@mail.gmail.com>
Subject: Re: [PATCH -next] lib: TEST_REF_TRACKER should depend on REF_TRACKER
 instead of selecting it
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 2:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Eric,
>
> On Wed, Dec 15, 2021 at 11:24 AM Eric Dumazet <edumazet@google.com> wrote:
> > On Wed, Dec 15, 2021 at 2:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Dec 15, 2021 at 10:51 AM Eric Dumazet <edumazet@google.com> wrote:
> > > > On Wed, Dec 15, 2021 at 1:36 AM Geert Uytterhoeven
> > > > <geert+renesas@glider.be> wrote:
> > > > > TEST_REF_TRACKER selects REF_TRACKER, thus enabling an optional feature
> > > > > the user may not want to have enabled.  Fix this by making the test
> > > > > depend on REF_TRACKER instead.
> > > >
> > > > I do not understand this.
> > >
> > > The issue is that merely enabling tests should not enable optional
> > > features, to prevent unwanted features sneaking into a product.
> >
> > if you do not want the feature, just say no ?
> >
> > # CONFIG_TEST_REF_TRACKER is not set
> > # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> > # CONFIG_NET_NS_REFCNT_TRACKER is not set
> >
> > > If tests depend on features, all tests for features that are enabled can
> > > still be enabled (e.g. made modular, so they can be loaded when needed).
> > >
> > > > How can I test this infra alone, without any ref_tracker being selected ?
> > > >
> > > > I have in my configs
> > > >
> > > > CONFIG_TEST_REF_TRACKER=m
> > > > # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> > > > # CONFIG_NET_NS_REFCNT_TRACKER is not set
> > > >
> > > > This should work.
> > >
> > > So you want to test the reference tracker, without having any actual
> > > users of the reference tracker enabled?
> >
> > Yes, I fail to see the problem you have with this.
> >
> > lib/ref_tracker.c is not adding intrusive features like KASAN.
>
> How can I be sure of that? ;-)
>
> > > Perhaps REF_TRACKER should become visible, cfr. CRC32 and
> > > the related CRC32_SELFTEST?
> >
> > I can not speak for CRC32.
> >
> > My point is that I sent a series, I wanted this series to be bisectable.
> >
> > When the test was added, I wanted to be able to use it right away.
> > (like compile it, and run it)
>
> Then you indeed need a way to force-enable the feature. For other
> library-like features, that is done by making the feature visible,
> cfr. CRC32.
>
> My point is that a user should be able to easily enable all available
> tests for all features he has wilfully enabled in his kernel config,
> without running into the risk of accidentally enabling more features.
> Hence a test should depend on the feature under test, not blindly
> enable the feature.

So you say that STACKDEPOT should be user selectable,
even if no layer is using it ?

I based my work on STACKDEPOT, not on EXT4
