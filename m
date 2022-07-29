Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4C585195
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiG2O2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiG2O2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:28:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6399642ACA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:28:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so4056955wrd.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSCRUzqHEeshRCXk0c46IYD/2B5v+syWELOAjW4JLl8=;
        b=ht+dLOTBjToDS/+UkuMYt6260/Cg9KmnKO7XPvOPdsrk7keccvGCS2sa0dK4ivOoda
         WwP87v/UcnAi+HpCgtaUMVc321imz5QObRqhFHnDQwbG/SarxZvLE2U24YsozI1hcGVF
         D5G2cgoJ8cnB8lSQZQfC1ZH9nUoyrwai/sTsLWHvxT+QO6fM/ZE/J2doHTnFtNVuKZZk
         hZwerSx//XqShJnS6yeyzO11muejbNczCrFsDKTl0qh9zMA40Yq+5ZGFSQkQhVKXL0Az
         WXfDRBZyxHtz26kzz+tFSegtY4SOBB46T8TYmk8v86bY/rqQq1/a8bhi6NXBCQOahz2z
         Rz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSCRUzqHEeshRCXk0c46IYD/2B5v+syWELOAjW4JLl8=;
        b=6UhxvmhudMNjeDMNeDnbitNHq0qxH+UIvEMKtuMCDAR9RwveYEVxTWuf9fT179WJw3
         uttwXI8F1cyTC3DxX6uPHAossCXXyDvMpCyCxzuCBCic9trykqyMYEvlGHrxOG2zRfF7
         gVVG1ML9xzIdDfx1ZWv3Zy3W/Qz+7nTHjcIQMtFQJk9Xhehu4GDgIkBlyFg9ZfFyBhJO
         FrylvSvDPqI4fIIqKA8rkhlIkk4h48sutG527ihYpz20QDyPtFP49fZCSVv/KvX0jDtl
         TSRONNWJqJkMpB1GzdcHf+0S98J9NLuGr9KJ/lJQz3tbxXxZSOw/FlYT4E0k5mPqp+np
         Vhng==
X-Gm-Message-State: ACgBeo08jYbufzAqoY2tJrS1asjtVqd3pXibZZKQgkClAG8IF7b6ne7A
        C5yZK3BC4RMgPcq2UpTjpnTCjC1pCtGAewumqCJxdw==
X-Google-Smtp-Source: AA6agR7SF8L2zGkGQ8Oi2s4j6CMeJzn0PTlELJABR3Z3tcIstQ9HpPnm0kwIyZFk86W12xyZOV981Bp6rSI3Bx96yA0=
X-Received: by 2002:a5d:6481:0:b0:21e:6c01:95a2 with SMTP id
 o1-20020a5d6481000000b0021e6c0195a2mr2592575wri.40.1659104928546; Fri, 29 Jul
 2022 07:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
 <CAP-5=fVyyj4nwam3grTAw94w8Ad+qZP6LDxYZv17vP2ph6pXwA@mail.gmail.com> <YuPGFNZNF+hAGWOa@krava>
In-Reply-To: <YuPGFNZNF+hAGWOa@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 07:28:36 -0700
Message-ID: <CAP-5=fUTX37VS949zKKkXA+a8rtWY_fSjZG+J2gRcqd6uhCw8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Corrections to cpu map event encoding
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 4:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Jul 28, 2022 at 07:01:09PM -0700, Ian Rogers wrote:
> > On Fri, Jul 15, 2022 at 10:01 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Tue, Jun 14, 2022 at 7:33 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > A mask encoding of a cpu map is laid out as:
> > > >   u16 nr
> > > >   u16 long_size
> > > >   unsigned long mask[];
> > > > However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> > > > after long_size. This means 32-bit and 64-bit builds see the mask as
> > > > being at different offsets. On top of this the structure is in the byte
> > > > data[] encoded as:
> > > >   u16 type
> > > >   char data[]
> > > > This means the mask's struct isn't the required 4 or 8 byte aligned, but
> > > > is offset by 2. Consequently the long reads and writes are causing
> > > > undefined behavior as the alignment is broken.
> > > >
> > > > These changes do minor clean up with const, visibility of functions
> > > > and using the constant time max function. It then adds 32 and 64-bit
> > > > mask encoding variants, packed to match current alignment. Taking the
> > > > address of a packed struct leads to unaligned data, so function
> > > > arguments are altered to be passed the packed struct. To compact the
> > > > mask encoding further and drop the padding, the 4-byte variant is
> > > > preferred. Finally a new range encoding is added, that reduces the
> > > > size of the common case of a range of CPUs to a single u64.
> > > >
> > > > On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> > > > 0x9a98 [0x28]: event: 74
> > > > .
> > > > . ... raw event: size 40 bytes
> > > > .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
> > > > .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
> > > > .  0020:  00 00 00 00 00 00 00 00                          ........
> > > >
> > > > 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
> > > >
> > > > Using the 4-byte encoding it is:
> > > > 0x9a98@pipe [0x20]: event: 74
> > > > .
> > > > . ... raw event: size 32 bytes
> > > > .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
> > > > .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................
> > > >
> > > > 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
> > > >
> > > > Finally, with the range encoding it is:
> > > > 0x9ab8@pipe [0x10]: event: 74
> > > > .
> > > > . ... raw event: size 16 bytes
> > > > .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.
> > > >
> > > > 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
> > > >
> > > > v2. Fixes a bug in the size computation of the update header
> > > >     introduced by the last patch (Add range data encoding) and caught
> > > >     by address sanitizer.
> > > >
> > > > Ian Rogers (6):
> > > >   perf cpumap: Const map for max
> > > >   perf cpumap: Synthetic events and const/static
> > > >   perf cpumap: Compute mask size in constant time
> > > >   perf cpumap: Fix alignment for masks in event encoding
> > > >   perf events: Prefer union over variable length array
> > > >   perf cpumap: Add range data encoding
> > >
> > > Ping. There was some feedback on this change but nothing to create a
> > > v3. Feedback/acked-by/reviewed-by appreciated.
> >
> > Ping. Feedback appreciated.
>
> hi,
> there's some unanswered feedback:
> https://lore.kernel.org/linux-perf-users/YrwY3SP+jsTwrRBw@krava/
>
> jirka

Thanks Jirka,

Was there a comment in particular? My reply was here:
https://lore.kernel.org/linux-perf-users/CAP-5=fU=BpP4OT2axZLSfRnKxQxmv-HXj8khBgmx3XQMS+abgA@mail.gmail.com/
I double checked, everyone of your comments was answered.

Thanks,
Ian
