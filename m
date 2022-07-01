Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2D3563075
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiGAJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiGAJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:42:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD130F67
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:42:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v185so3065729ybe.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7WkaE4UplPR9g6PXITQSoGxqocYmDuMj7V8IXNG4nHE=;
        b=o/icSX7EYaDr5CQtcNGx2zhumstPfDHcBFWg+on1+8CGEhnmQUB86cqAxXNMAFUUYP
         MkiPmIY82JD9hW60FTI9nyiZl/taPYZGVyMbgAX5mmoCiokjtSiB3EUiP6ncWaFXQasV
         f5DXC87Sp7HMHIM5Db5Bu0pIIb2wdZWrq5p9F2JccFYjppf3+lg5PSzjCgCHCV1PO4uf
         sfj1PId5y4l1HNhL+6rlz04kTFQtat0PnjxGgfqZ9jjwJmS1TGXuosAb3QWfuctC4off
         p+975vNhN2+WZkNwfZFN1n9dHsM7dklac1kBCIRt6DBgI6A0PzWOyP7XHUlkntzsDamH
         sSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7WkaE4UplPR9g6PXITQSoGxqocYmDuMj7V8IXNG4nHE=;
        b=EtOwed5mwP4gs73aR/14Rc7R1LVZG2ECt4Cf9kT1/2Z1u/uiBZtvbPWDcppz93CNIP
         jpB9hx2Ti5F2R1mbO+kVCEW4WZrW0mMObYSYiKZ7CFWgcFU1UCZ5ka9VoAnQ3GJlKPiR
         62l4aeZ3FrC4MVu92skEJbN72TuGsx7nxyrCzGVWuag4F/VAuwrGzL7mcdF2v4r2QlDy
         GGOVpSdUe6CdN5RUZLTogCneebZuLtc+BsJVc75AQY4ersF8lXsZ7TqIuL/MMdAJaYOv
         xCvtQbKtNZn27LTi4QYj0etkCZd8e/4Wn5NK6r1bSahpWvcgNRc+i+lPpQmWJfRDZlCa
         SkmQ==
X-Gm-Message-State: AJIora97tfjrjeS4maT1r7GulvSw0Jq8K27aap0Qu3gXgxxsjObg6mYs
        Kc4RK2tE6q7L5jHRB2yKTwH7yMu91aN+XpjBV0VpgA==
X-Google-Smtp-Source: AGRyM1vGyRnUQaQ2a9Cl91wMlrhSEkd/ZeG5HlS8zoLj0GJa+tXHl0U3awLZiSPBVgIXdFQYboQuB7lYervCr/HAOs0=
X-Received: by 2002:a25:94a:0:b0:668:df94:fdf4 with SMTP id
 u10-20020a25094a000000b00668df94fdf4mr13606867ybm.425.1656668521567; Fri, 01
 Jul 2022 02:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-9-elver@google.com>
 <045a825c-cd7d-5878-d655-3d55fffb9ac2@csgroup.eu>
In-Reply-To: <045a825c-cd7d-5878-d655-3d55fffb9ac2@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Fri, 1 Jul 2022 11:41:25 +0200
Message-ID: <CANpmjNOeyZ0MZ_esOnR7TUE1R5Vf+_Ejt5JRQ1AoAmhkCrVrBA@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] powerpc/hw_breakpoint: Avoid relying on caller synchronization
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 1 Jul 2022 at 10:54, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi Marco,
>
> Le 28/06/2022 =C3=A0 11:58, Marco Elver a =C3=A9crit :
> > Internal data structures (cpu_bps, task_bps) of powerpc's hw_breakpoint
> > implementation have relied on nr_bp_mutex serializing access to them.
> >
> > Before overhauling synchronization of kernel/events/hw_breakpoint.c,
> > introduce 2 spinlocks to synchronize cpu_bps and task_bps respectively,
> > thus avoiding reliance on callers synchronizing powerpc's hw_breakpoint=
.
>
> We have an still opened old issue in our database related to
> hw_breakpoint, I was wondering if it could have any link with the
> changes you are doing and whether you could handle it at the same time.
>
> https://github.com/linuxppc/issues/issues/38
>
> Maybe it is completely unrelated, but as your series modifies only
> powerpc and as the issue says that powerpc is the only one to do that, I
> thought it might be worth a hand up.

I see the powerpc issue unrelated to the optimizations in this series;
perhaps by fixing the powerpc issue, it would also become more
optimal. But all I saw is that it just so happens that powerpc relied
on the nr_bp_mutex which is going away.

This series will become even more complex if I decided to add a
powerpc rework on top (notwithstanding the fact I don't have any ppc
hardware at my disposal either). A separate series/patch seems much
more appropriate.

Thanks,
-- Marco
