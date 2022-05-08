Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A783751EF86
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiEHTGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344561AbiEHSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:04:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA1FE3
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:00:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ba17so13905980edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 11:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcaHO+HqpMQv3+DLpIAhYp2C5r7z6Gel9BfrGJWEBrQ=;
        b=IlM4lhJlJ2d07BNY1D8txDkP1oAW3YcNeZ93q2oLYgogCvo5k208E0ZRRp7wmn5zzn
         uzTzmLz4eArNamcc6FiQQahescDgwY/UeBnXOlNABtKk6MEX/oddgfacXW29CPBwl2Nd
         RKZah5ByfhTGR6tJynRj1ekttHDm8vScstcIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcaHO+HqpMQv3+DLpIAhYp2C5r7z6Gel9BfrGJWEBrQ=;
        b=Fa416WCZVyHMkod1r4QAKp6bNupdn5tcQPR/NI+gp0uJgkBe0SdWp7t2DhYT1oi2Ps
         KzOFo5bu3LA1OqCMSQmWQraV4boz0Y//QGfQPST7ob8CNT04CehN4mx2a3ka0j+vevuq
         2hZrUlVqF8UW8WS4ihSQQFSDV2BRtz8SKRFxlrYub+jrnCW7jedHQbMhmhVnjBju+S8j
         RJgaWDoShpOflYK02/20qPtwOebXvYY/bwFaHg6v5m4uTJBYz3wR+sfh3KsM0Mk7wyB8
         n5+mLe3aJ2jAzFqHQRVK+A2bXAltt0KnP5QcUfcN0FTEqOUGTW/0YURbvZXKKSymvDc3
         2NHA==
X-Gm-Message-State: AOAM531hKCycw/O9z+yH+yrfGUpLtGRtcpcBroUCa0mEgK5FuJM33POH
        iYr1Wgqpmd2GzClPw32SnJ0avI6ID2SySGiT
X-Google-Smtp-Source: ABdhPJxkwIFcMkQNm1jDtlp7H1rE4Cgj+6rMHnymX0Qc780ZJ+rNiW/R8AfiQhbVSgAMWQEN/phW1Q==
X-Received: by 2002:a05:6402:17c7:b0:425:d52c:8907 with SMTP id s7-20020a05640217c700b00425d52c8907mr13532553edy.15.1652032835650;
        Sun, 08 May 2022 11:00:35 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090729c600b006f3ef214df6sm4224202ejc.92.2022.05.08.11.00.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 11:00:34 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e24so16599195wrc.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 11:00:34 -0700 (PDT)
X-Received: by 2002:adf:dfc8:0:b0:20a:d256:5b5c with SMTP id
 q8-20020adfdfc8000000b0020ad2565b5cmr10724888wrn.97.1652032834122; Sun, 08
 May 2022 11:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <165201148069.536527.1960632033331546251.tglx@xen13>
In-Reply-To: <165201148069.536527.1960632033331546251.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 May 2022 11:00:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
Message-ID: <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
Subject: Re: [GIT pull] core/urgent for v5.18-rc6
To:     Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Sun, May 8, 2022 at 5:05 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single bugfix for the PASID management code, which freed the PASID too
> early. The PASID needs to be tied to the mm lifetime, not to the address
> space lifetime.

So I have to once more complain about the -tip tree "Link:" usage.

Again, the commit has a link to the patch *submission*, which is
almost entirely useless. There's no link to the actual problem the
patch fixes.

It does have a "Fixes:" link, and it has an "explanation", but the
explanation doesn't actually make much sense to me.

The *sensible* thing for an iommu driver to do is to just do a
mmget/mmput, and then the whole "drop PASIX on last mmput() (ie in
__mmput)" makes lots of sense.

The commit claims that's not what the iommu drivers do, but it's
really hard to tell *what* it is that does a mmgrab. It just says

  "the IOMMU driver holds a reference on the mm itself, not the address space"

but then I tried to see where such references are held, and I couldn't find it.

*Must* users do mmget/mmput, and the commit even says that's the
logical thing to do. Apparently something that the iommu code relies
on does the mmgrab/mmdrop thing, but I really would have liked to know
what that is.

Yes, "mmgab" is the right thing to do if all you want is the "struct
mm_struct", and don't actually care about the page tables themselves,
and don't want to have the refcount keep page tables alive. But you'd
think the iommu code really does want the page tables.

So it would have been really nice to have an explanation for what it
was that did the mmgrab, especially since the commit itself makes it
clear that the logical thing to do seems to be just mmget/put. No?

I _really_ wish the -tip tree had more links to the actual problem
reports and explanations, rather than links to the patch submission.

One has the actual issue. The other just has the information that is
already in the commit, and the "Link:" adds almost no actual value
(yes, yes, you can see late "Acked-by" etc, but that really isn't
worth it).

I've pulled this, because I definitely believe the issue is real. I
just wish I could see _what_ the issue was.

Put another way: I can see that

    Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>

in the commit, but I don't have a clue what the actual report was, and
there really isn't enough information in the commit itself, except for
a fairly handwavy "Device drivers might, for instance, still need to
flush operations.."

I don't want to know what device drivers _might_ do. I would want to
have an actual pointer to what they do and where.

I suspect it's related to mmu_notifiers or something, but I really
would have liked a more exact "this is where things go wrong".

I also *suspect* that this is all about that _loong_ thread (picking
one email almost at random) here:

   https://lore.kernel.org/all/a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com/

but if so, the confusion I see in that thread is even more reason to
have more background for what is going on.

Anyway, this is merged in my tree, but I'm having trouble following
the logic, which is why I'm writing this long email to complain about
lack of context.

               Linus
