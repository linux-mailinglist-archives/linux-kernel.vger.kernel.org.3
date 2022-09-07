Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC665AFDB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIGHlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIGHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:41:30 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A86A9C2F1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:41:23 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-333a4a5d495so118420807b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E9pidXGct5S8ms/KlIXlwMVVLVf0nTiLM3OKPd0GOQQ=;
        b=LvMU6mMR4G7KAw4ms+Dn8YY0BzPYr2ExRSYSvnMAgFXp31eKl0gSX0c53Rl/omK57F
         qf3BYWYtcgfo5w4nLUWiMesc+YLh40LiueVANSnVv0645gEojyH3KSDdGlOiBpGkz3Hx
         COxgkQssBWSG0K8ON6B7odRQ7k5PrG2kXqbN7z4P7e3p5KAE7r+a+wy85K/9DIRGYnYl
         ZWFNQFsC6p4qyPv5n+KbsVV9Eaf+kh6AOiZkF+gb3wQAWChOykNIdVCdH1KJbzHSSb8L
         Yh/iGvX1n0PwrO2gic1Qy1jGetWHDp/43VJck32Sy5gKH4Vli06x8/gm6euTLcVt47W8
         H7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E9pidXGct5S8ms/KlIXlwMVVLVf0nTiLM3OKPd0GOQQ=;
        b=wwMG2bQ5f940ym0TcgoSWURwj05Fcjd7rowrGsL89yMc/XVVICXiltcAjXudIz3H7K
         jFU6MAtZLJldKjVuHsT1HqHrG95OMClIRzfbory9tsD2N2wQu8BZk1q6AT/F7zbEcp+y
         Xp6YSV3Bhm/h+SFCN0M70Lka1vhFWRN3sB4hRaxnyDCn+A4fIFHsjgKuwG+qXnHOYV3r
         JKocM/lNkJIj89kyCnuAKLCHoM0BADqmgLm5ipxWi9H8Ag4+jCj+x6Gn5f4msjH+7zBI
         LvIkgvKzqESKxflRWYJI/uO22y+bJA91KED520UXdCNivdIbyy4XgXG2Nw4xNhjSr9BC
         DgZw==
X-Gm-Message-State: ACgBeo1lX1twOjm02Ii/Q5sZAFQl6mtEekR6IHmxJl3DSy+uL+lH1/Ub
        LiwpWz/SLCLb6NjrzlfVwXqxNv4Z3p8f9zuLMSchkw==
X-Google-Smtp-Source: AA6agR6YMuwY5s6C8iTQ95EECnOpLYDpT6Nj0MkZt/pB0xQx20WoNw9/Y4h4FRxmPnOsYiSme5PDUg1jTnWVoxW6d+8=
X-Received: by 2002:a81:a16:0:b0:345:afa:5961 with SMTP id 22-20020a810a16000000b003450afa5961mr1953865ywk.11.1662536482427;
 Wed, 07 Sep 2022 00:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220902100057.404817-1-elver@google.com> <YxevqB2OpJ9BLE+s@hirez.programming.kicks-ass.net>
In-Reply-To: <YxevqB2OpJ9BLE+s@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 7 Sep 2022 09:40:46 +0200
Message-ID: <CANpmjNMbnG2KcSoqmCkPTcSkdsgHcfTSaXDSKti3uHGz6A=bsQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Allow restricted kernel breakpoints on user addresses
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Tue, 6 Sept 2022 at 22:38, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 02, 2022 at 12:00:57PM +0200, Marco Elver wrote:
> > Allow the creation of restricted breakpoint perf events that also fire
> > in the kernel (!exclude_kernel), if:
> >
> >   1. No sample information is requested; samples may contain IPs,
> >      registers, or other information that may disclose kernel addresses.
> >
> >   2. The breakpoint (viz. data watchpoint) is on a user address.
> >
> > The rules constrain the allowable perf events such that no sensitive
> > kernel information can be disclosed.
> >
> > Despite no explicit kernel information disclosure, the following
> > questions may need answers:
> >
> >  1. Is obtaining information that the kernel accessed a particular
> >     user's known memory location revealing new information?
> >     Given the kernel's user space ABI, there should be no "surprise
> >     accesses" to user space memory in the first place.
> >
> >  2. Does causing breakpoints on user memory accesses by the kernel
> >     potentially impact timing in a sensitive way?
> >     Since hardware breakpoints trigger regardless of the state of
> >     perf_event_attr::exclude_kernel, but are filtered in the perf
> >     subsystem, this possibility already exists independent of the
> >     proposed change.
> >
>
> Changelog forgot to tell us why you want this :-)

Oops.

> I don't see any immediate concerns, but it's late so who knows..

Similar to motivation as
https://lore.kernel.org/all/20210408103605.1676875-1-elver@google.com/:
Low-overhead error detectors that rely on detecting memory access via
breakpoints/watchpoints. For example for race detection, but also
things like data flow tracking.

By allowing in-kernel breakpoints on user addresses, we can detect
bugs that involve kernel accesses (e.g. for race detector, racy
read/write vs. syscall somewhere; or tracking data flow through
kernel).

Shall I go and send v2 with some motivation?

Thanks,
-- Marco
