Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3AF585EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiGaMh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiGaMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:37:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8CDF83;
        Sun, 31 Jul 2022 05:37:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r4so2899776edi.8;
        Sun, 31 Jul 2022 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=8KDJgdOghTf5YMJOSTb51Tk9SBCdsaIf+xw5hxG4mmc=;
        b=LaJijLLH0bdWS+tn+3nVzYWSKs8xkHmuP/nAIRxDfCSAJyNgyyp2u3XLUTRWIHuEXL
         eZlUPZsqTY29fgUmvSYPBt5JE4ZO0jfMOwbm9BB23GKKsLXfQHBMSSxjHymAnN+6iKJ6
         ZeTm3pXZcX/bJ9csdp3xlQvJZy0WEptShPWMJrfQckBvLZnu3PB1Q4Fbu3fsAfUwjHHv
         AexhTosccdx+yqdu0ThLHOujAfvjzkWmPouu6Qqi7h5ynk2qySddTmAUvdCzAWyNv6Un
         PLE5QpmG0JOwEAxnNNlhEphFEJ1DtggIcqJ5yzgJ39/F6Ywt4iA9f68BLIJYoXIbTQ0O
         i5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=8KDJgdOghTf5YMJOSTb51Tk9SBCdsaIf+xw5hxG4mmc=;
        b=Q3bOet9MCAsit605Mgfn+GcFq7wf4QGrJZ0EyaeltYaD6+V7YILrIzbdoRUJXxAqmG
         QfU7CC0IxkjDTCeL2QrxlhQk046YkNWoCt45IruXpoe9Tq+j5rf5D2SK0X8z6jvs0PxH
         GJxxEVtEQ026jvvQJZZhSGrVPeqIOc4+CLWPVScNKNaMJ4fGD0IXZwJL4Gs9vXZv3YaT
         VX59S90m7SyJ/WHJzFCKSijgxLqpRxW3GdsyDRROa2amw5ZGVLCZlTHvpUuBRwEvJJAW
         gknNoT9evO2s1Iz/ENy/cXmo/2vzp6vIRMW+YYVCWcYbfiUIY5Wttx8R8cUuzBAnQpoC
         C99A==
X-Gm-Message-State: AJIora9FN5jRDJ0ztqH7xpZxKXtgo0W8aAkVGc6qZdw5S/FQlEdM4pO8
        ZGW9TOYG9NTnIVYPSmMVNsY=
X-Google-Smtp-Source: AGRyM1uJGX7/RiiWjsV5MPu684vws2kkAhJXewaLAocuqmhO49EPntsQM/kVC9UlPSw9PkGl89vxRA==
X-Received: by 2002:a05:6402:510c:b0:43a:e041:a371 with SMTP id m12-20020a056402510c00b0043ae041a371mr11268794edd.424.1659271071319;
        Sun, 31 Jul 2022 05:37:51 -0700 (PDT)
Received: from krava ([83.240.61.175])
        by smtp.gmail.com with ESMTPSA id f5-20020a056402160500b0043cd06bef33sm5256110edv.97.2022.07.31.05.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 05:37:50 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 31 Jul 2022 14:37:48 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v2 0/6] Corrections to cpu map event encoding
Message-ID: <YuZ3nOawc2kW3Sv3@krava>
References: <20220614143353.1559597-1-irogers@google.com>
 <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
 <CAP-5=fVyyj4nwam3grTAw94w8Ad+qZP6LDxYZv17vP2ph6pXwA@mail.gmail.com>
 <YuPGFNZNF+hAGWOa@krava>
 <CAP-5=fUTX37VS949zKKkXA+a8rtWY_fSjZG+J2gRcqd6uhCw8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUTX37VS949zKKkXA+a8rtWY_fSjZG+J2gRcqd6uhCw8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 07:28:36AM -0700, Ian Rogers wrote:
> On Fri, Jul 29, 2022 at 4:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 07:01:09PM -0700, Ian Rogers wrote:
> > > On Fri, Jul 15, 2022 at 10:01 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Tue, Jun 14, 2022 at 7:33 AM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > A mask encoding of a cpu map is laid out as:
> > > > >   u16 nr
> > > > >   u16 long_size
> > > > >   unsigned long mask[];
> > > > > However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> > > > > after long_size. This means 32-bit and 64-bit builds see the mask as
> > > > > being at different offsets. On top of this the structure is in the byte
> > > > > data[] encoded as:
> > > > >   u16 type
> > > > >   char data[]
> > > > > This means the mask's struct isn't the required 4 or 8 byte aligned, but
> > > > > is offset by 2. Consequently the long reads and writes are causing
> > > > > undefined behavior as the alignment is broken.
> > > > >
> > > > > These changes do minor clean up with const, visibility of functions
> > > > > and using the constant time max function. It then adds 32 and 64-bit
> > > > > mask encoding variants, packed to match current alignment. Taking the
> > > > > address of a packed struct leads to unaligned data, so function
> > > > > arguments are altered to be passed the packed struct. To compact the
> > > > > mask encoding further and drop the padding, the 4-byte variant is
> > > > > preferred. Finally a new range encoding is added, that reduces the
> > > > > size of the common case of a range of CPUs to a single u64.
> > > > >
> > > > > On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> > > > > 0x9a98 [0x28]: event: 74
> > > > > .
> > > > > . ... raw event: size 40 bytes
> > > > > .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
> > > > > .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
> > > > > .  0020:  00 00 00 00 00 00 00 00                          ........
> > > > >
> > > > > 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
> > > > >
> > > > > Using the 4-byte encoding it is:
> > > > > 0x9a98@pipe [0x20]: event: 74
> > > > > .
> > > > > . ... raw event: size 32 bytes
> > > > > .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
> > > > > .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................
> > > > >
> > > > > 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
> > > > >
> > > > > Finally, with the range encoding it is:
> > > > > 0x9ab8@pipe [0x10]: event: 74
> > > > > .
> > > > > . ... raw event: size 16 bytes
> > > > > .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.
> > > > >
> > > > > 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
> > > > >
> > > > > v2. Fixes a bug in the size computation of the update header
> > > > >     introduced by the last patch (Add range data encoding) and caught
> > > > >     by address sanitizer.
> > > > >
> > > > > Ian Rogers (6):
> > > > >   perf cpumap: Const map for max
> > > > >   perf cpumap: Synthetic events and const/static
> > > > >   perf cpumap: Compute mask size in constant time
> > > > >   perf cpumap: Fix alignment for masks in event encoding
> > > > >   perf events: Prefer union over variable length array
> > > > >   perf cpumap: Add range data encoding
> > > >
> > > > Ping. There was some feedback on this change but nothing to create a
> > > > v3. Feedback/acked-by/reviewed-by appreciated.
> > >
> > > Ping. Feedback appreciated.
> >
> > hi,
> > there's some unanswered feedback:
> > https://lore.kernel.org/linux-perf-users/YrwY3SP+jsTwrRBw@krava/
> >
> > jirka
> 
> Thanks Jirka,
> 
> Was there a comment in particular? My reply was here:
> https://lore.kernel.org/linux-perf-users/CAP-5=fU=BpP4OT2axZLSfRnKxQxmv-HXj8khBgmx3XQMS+abgA@mail.gmail.com/
> I double checked, everyone of your comments was answered.

ugh sorry, seems it did not get into my inbox for some reason

jirka
