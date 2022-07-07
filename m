Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDAF56A90E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiGGREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiGGRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:03:56 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE333357;
        Thu,  7 Jul 2022 10:03:56 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-f2a4c51c45so26070208fac.9;
        Thu, 07 Jul 2022 10:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hxrD6nwo8sdSbU5ymYc4KD711eUSR6K/JYrSuwLGXA=;
        b=ehq+sWSvFQjQVYqRgRB5AOG0IGWxkRCD88ovi2mVhH1FZb2eNyPwM/DXiSKn6A8uPr
         Hiz4bvlG9ziATSNL4Zl1yvweX4TZBpKzTa6hEuZrHgXwipDe5iKj7tpxkjzaXX/jxc5f
         32t5roHE4VjlgV+mQRUAKLaHxVuYDaRWx6lhHkzmjKQyaBYKNYUv8WWfYKjiPEzjKOS7
         YWD20kW/5UW5mEb0EiDNHDHLs8S4glQE0RuN93fm4wkuhmPexc3r+i5PKSRItK4KQQSU
         w49dZvLzdKaLkfFU2TOXHGyPiUMJipFqLrEwAT4B/mu1rzXiUUVh9nEc0tCZQqwuBzWl
         0MQg==
X-Gm-Message-State: AJIora8Hk/ZdMn8ty0Mf7RELz2/W2wLbwaYEc96TydUTTgLjbox6fByy
        b1gAB5Cq4Y5eeUUY2foWuG5iMCG2y51ZaqRMtLQ=
X-Google-Smtp-Source: AGRyM1sM66sh3ZxBBJ6OYd2N8rrRLQvdjQwa0Ridtj8zpp+kk2gPDF/rdTnq2xd6D6mWhoF3wkaKo4eE0JOwHCZtOiY=
X-Received: by 2002:a05:6870:a182:b0:10b:efbe:e65d with SMTP id
 a2-20020a056870a18200b0010befbee65dmr3615412oaf.5.1657213435353; Thu, 07 Jul
 2022 10:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220615163222.1275500-1-namhyung@kernel.org> <CAM9d7cjD=at=AtKmvMLogjN6mieWVR2kk-HigxO01cvPPRGFBg@mail.gmail.com>
 <YrYJq8UQ04FFN12/@kernel.org> <CAM9d7cjSPB+YfUBKHC_b3ux8z5r0QOr_B=nbPX62vygOogiVYQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjSPB+YfUBKHC_b3ux8z5r0QOr_B=nbPX62vygOogiVYQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 7 Jul 2022 10:03:44 -0700
Message-ID: <CAM9d7ci9Zzqdhv3eKgxWhJjEgUttwjmz5XACr0gTa9RH5JtMww@mail.gmail.com>
Subject: Re: [PATCHSET 0/7] perf lock: New lock contention tracepoints support (v4)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Genple ping!

On Fri, Jun 24, 2022 at 2:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Arnaldo,
>
> On Fri, Jun 24, 2022 at 11:59 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Jun 24, 2022 at 09:40:05AM -0700, Namhyung Kim escreveu:
> > >> Ping!  Any comments?
> >
> >
> > I'll take a look and test it soon.
>
> Thanks for doing that!
> Namhyung
