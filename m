Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC23E562F89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiGAJIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiGAJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:08:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4BF1F607
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:08:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k7so2211905wrc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWHIzp+3WUp4C4qcj3J1sqQ4NecfP0gvWEDQIXDxCZA=;
        b=S7EU9K2ESnYjIFfr8D2s7DQ495eaV/IlS9h8WATLYLoNYo50IyYLAJU77fCyKyxgFo
         r0KDAbPEhNHeor2q1TMGyfSpWZ2Xxb93kkcUSQNtv4LnMdVjwDsMPFqyprNo+7orPeos
         T0YMlpbiEu9KMkXpHwTYZRZ1Y+yOT+MT66d40sXDqZnr16PwtKmfq+sd+jMta2ngPbgN
         fVvUhJWAS69cTCEiqxO4u/LGSZ87g0Sphj3Wx8AHvX56kO0zRHBrUR228J7O2UMoHrxK
         +4FofEGOpB8u3gWOVTYWFGApS6jm4fYLBdnHAn4sjdmNbgtkmA4HQDHJH5h66wvKNAYe
         MjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWHIzp+3WUp4C4qcj3J1sqQ4NecfP0gvWEDQIXDxCZA=;
        b=CbObj1iA9NsAyhP56oL5uUTgH2spf/y8GwZY6208p0cQjneW+hnFRdpJF/3OnnaJm8
         byVuKfDHrkzV5HsiIFzucHZRsNlbXJkmOoeqH0JCeDiOPqBO+V8BkKMHPlK8O1SC1kja
         Axng0HZMjoCcNpspKDx2cpvBxqpH0TmNu7x4YCKQ83WoIJCKt7Rhc0VFPS7OSG6rrMyb
         xs0VolDlKlVcQ7VcM+BMYN0L/AV3I/ITtqQiWKBfVF1vGioia0J65EI6hE5mpbJyXzCs
         zSiRHwNtB24C/qkQHXZe0Gc8nFTphdbj3Jz2q2L3W15iipqKNzPjGTloQMpol6Ln49YK
         OuYQ==
X-Gm-Message-State: AJIora8CEAFr1H0qjmqQMOFlU9V/1HqIlTzkgcnYgXiIGo6dh9EpWgzg
        lhbynzBtSBtHLT+8zatEiMGBqS98afR0gcV+qJFuTA==
X-Google-Smtp-Source: AGRyM1u+9Bbxm/xIsmtaWRza6eo9Ztg1heI3SslGLOs+WuiqNjm1FFsmCbirvS9ni9p6WO6KNx9lUCeXZf/76Kvleik=
X-Received: by 2002:a05:6000:144d:b0:21b:b3cc:162e with SMTP id
 v13-20020a056000144d00b0021bb3cc162emr12777663wrx.433.1656666518482; Fri, 01
 Jul 2022 02:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220630080834.2742777-1-davidgow@google.com> <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
 <20220630125434.GA20153@axis.com> <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
In-Reply-To: <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Jul 2022 17:08:27 +0800
Message-ID: <CABVgOSmxnTc31C-gbmbns+8YOkpppK77sdXLzASZ-hspFYDwfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] UML: add support for KASAN under x86_64
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>
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

On Thu, Jun 30, 2022 at 9:29 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 2:54 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > On Thu, Jun 30, 2022 at 11:41:04AM +0200, Dmitry Vyukov wrote:
> > > On Thu, 30 Jun 2022 at 10:08, David Gow <davidgow@google.com> wrote:
> > > > diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> > > > index 1c2d4b29a3d4..a089217e2f0e 100644
> > > > --- a/arch/um/kernel/Makefile
> > > > +++ b/arch/um/kernel/Makefile
> > > > @@ -27,6 +27,9 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
> > > >  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> > > >  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> > > >
> > > > +KASAN_SANITIZE_stacktrace.o := n
> > > > +KASAN_SANITIZE_sysrq.o := n
> > >
> > > Why are these needed?
> > > It's helpful to leave some comments for any of *_SANITIZE:=n.
> > > Otherwise later it's unclear if it's due to some latent bugs, some
> > > inherent incompatibility, something that can be fixed, etc.
> >
> > I believe I saw the stacktrace code itself triggering KASAN splats and
> > causing recursion when sanitization was not disabled on it.  I noticed
> > that other architectures disabled sanitization of their stacktrace code,
> > eg. ARM in commit 4d576cab16f57e1f87978f ("ARM: 9028/1: disable KASAN in
> > call stack capturing routines"), so I did not investigate it further.
> >
> > (Note that despite the name, sysrq.c is also just stacktrace code.)
>
> Stack trace collection code might trigger KASAN splats when walking
> stack frames, but this can be resolved by using unchecked accesses.
> The main reason to disable instrumentation here is for performance
> reasons, see the upcoming patch for arm64 [1] for some details.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=802b91118d11

Ah -- that does it! Using READ_ONCE_NOCHECK() in dump_trace() gets rid
of the nasty recursive KASAN failures we were getting in the tests.

I'll send out v5 with those files instrumented again.

Thanks!
-- David
